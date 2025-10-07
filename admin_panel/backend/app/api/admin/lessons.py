"""
Admin lesson management endpoints.
"""
from typing import List, Optional
from datetime import datetime
from fastapi import APIRouter, Depends, HTTPException, status, UploadFile, File
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, func
from pydantic import BaseModel

from app.core.database import get_db
from app.core.security import verify_admin_token
from app.models.lesson import (
    Lesson, Exercise, Skill, ConversationDialog,
    LanguagePair, LessonLevel, LessonStatus, ExerciseType
)


router = APIRouter(prefix="/admin/lessons", tags=["Admin Lessons"])


# Schemas
class ExerciseCreate(BaseModel):
    type: ExerciseType
    question: str
    question_audio_url: Optional[str] = None
    question_image_url: Optional[str] = None
    answer_data: dict
    hint: Optional[str] = None
    explanation: Optional[str] = None
    order: int = 0


class LessonCreate(BaseModel):
    title: str
    description: Optional[str] = None
    language_pair: LanguagePair
    level: LessonLevel
    unit_number: int = 1
    lesson_number: int = 1
    skill_id: Optional[int] = None
    xp_reward: int = 10
    estimated_minutes: int = 5
    exercises: List[ExerciseCreate] = []


class LessonUpdate(BaseModel):
    title: Optional[str] = None
    description: Optional[str] = None
    level: Optional[LessonLevel] = None
    xp_reward: Optional[int] = None
    estimated_minutes: Optional[int] = None


class LessonResponse(BaseModel):
    id: int
    title: str
    description: Optional[str]
    slug: str
    language_pair: str
    level: str
    status: str
    xp_reward: int
    estimated_minutes: int
    exercise_count: int
    created_at: str
    published_at: Optional[str]


@router.get("/", response_model=List[LessonResponse])
async def list_lessons(
    skip: int = 0,
    limit: int = 50,
    status: Optional[LessonStatus] = None,
    language_pair: Optional[LanguagePair] = None,
    level: Optional[LessonLevel] = None,
    token_data: dict = Depends(verify_admin_token),
    db: AsyncSession = Depends(get_db)
):
    """List all lessons with filtering options."""
    query = select(Lesson)
    
    if status:
        query = query.where(Lesson.status == status)
    if language_pair:
        query = query.where(Lesson.language_pair == language_pair)
    if level:
        query = query.where(Lesson.level == level)
    
    query = query.offset(skip).limit(limit).order_by(Lesson.created_at.desc())
    
    result = await db.execute(query)
    lessons = result.scalars().all()
    
    response = []
    for lesson in lessons:
        # Count exercises
        exercise_count_query = select(func.count(Exercise.id)).where(
            Exercise.lesson_id == lesson.id
        )
        exercise_count_result = await db.execute(exercise_count_query)
        exercise_count = exercise_count_result.scalar()
        
        response.append(LessonResponse(
            id=lesson.id,
            title=lesson.title,
            description=lesson.description,
            slug=lesson.slug,
            language_pair=lesson.language_pair.value,
            level=lesson.level.value,
            status=lesson.status.value,
            xp_reward=lesson.xp_reward,
            estimated_minutes=lesson.estimated_minutes,
            exercise_count=exercise_count,
            created_at=lesson.created_at.isoformat(),
            published_at=lesson.published_at.isoformat() if lesson.published_at else None
        ))
    
    return response


@router.post("/", response_model=LessonResponse)
async def create_lesson(
    lesson_data: LessonCreate,
    token_data: dict = Depends(verify_admin_token),
    db: AsyncSession = Depends(get_db)
):
    """Create a new lesson with exercises."""
    from slugify import slugify
    
    user_id = int(token_data["sub"])
    
    # Generate slug
    slug = slugify(lesson_data.title)
    
    # Check if slug exists
    existing = await db.execute(
        select(Lesson).where(Lesson.slug == slug)
    )
    if existing.scalar_one_or_none():
        slug = f"{slug}-{datetime.now().timestamp()}"
    
    # Create lesson
    lesson = Lesson(
        title=lesson_data.title,
        description=lesson_data.description,
        slug=slug,
        language_pair=lesson_data.language_pair,
        level=lesson_data.level,
        unit_number=lesson_data.unit_number,
        lesson_number=lesson_data.lesson_number,
        skill_id=lesson_data.skill_id,
        xp_reward=lesson_data.xp_reward,
        estimated_minutes=lesson_data.estimated_minutes,
        status=LessonStatus.DRAFT,
        created_by=user_id,
        version=1
    )
    
    db.add(lesson)
    await db.flush()  # Get lesson ID
    
    # Create exercises
    for exercise_data in lesson_data.exercises:
        exercise = Exercise(
            lesson_id=lesson.id,
            type=exercise_data.type,
            question=exercise_data.question,
            question_audio_url=exercise_data.question_audio_url,
            question_image_url=exercise_data.question_image_url,
            answer_data=exercise_data.answer_data,
            hint=exercise_data.hint,
            explanation=exercise_data.explanation,
            order=exercise_data.order
        )
        db.add(exercise)
    
    await db.commit()
    await db.refresh(lesson)
    
    return LessonResponse(
        id=lesson.id,
        title=lesson.title,
        description=lesson.description,
        slug=lesson.slug,
        language_pair=lesson.language_pair.value,
        level=lesson.level.value,
        status=lesson.status.value,
        xp_reward=lesson.xp_reward,
        estimated_minutes=lesson.estimated_minutes,
        exercise_count=len(lesson_data.exercises),
        created_at=lesson.created_at.isoformat(),
        published_at=None
    )


@router.post("/{lesson_id}/publish")
async def publish_lesson(
    lesson_id: int,
    token_data: dict = Depends(verify_admin_token),
    db: AsyncSession = Depends(get_db)
):
    """Publish a lesson to make it available in the main app."""
    result = await db.execute(
        select(Lesson).where(Lesson.id == lesson_id)
    )
    lesson = result.scalar_one_or_none()
    
    if not lesson:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Lesson not found"
        )
    
    # Check if lesson has exercises
    exercise_count = await db.execute(
        select(func.count(Exercise.id)).where(Exercise.lesson_id == lesson_id)
    )
    if exercise_count.scalar() == 0:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Cannot publish lesson without exercises"
        )
    
    lesson.status = LessonStatus.PUBLISHED
    lesson.published_at = datetime.utcnow()
    lesson.updated_by = int(token_data["sub"])
    
    await db.commit()
    
    return {"message": "Lesson published successfully", "lesson_id": lesson.id}


@router.post("/{lesson_id}/unpublish")
async def unpublish_lesson(
    lesson_id: int,
    token_data: dict = Depends(verify_admin_token),
    db: AsyncSession = Depends(get_db)
):
    """Unpublish a lesson."""
    result = await db.execute(
        select(Lesson).where(Lesson.id == lesson_id)
    )
    lesson = result.scalar_one_or_none()
    
    if not lesson:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Lesson not found"
        )
    
    lesson.status = LessonStatus.DRAFT
    lesson.updated_by = int(token_data["sub"])
    
    await db.commit()
    
    return {"message": "Lesson unpublished successfully"}


@router.delete("/{lesson_id}")
async def delete_lesson(
    lesson_id: int,
    token_data: dict = Depends(verify_admin_token),
    db: AsyncSession = Depends(get_db)
):
    """Delete a lesson (admin only)."""
    result = await db.execute(
        select(Lesson).where(Lesson.id == lesson_id)
    )
    lesson = result.scalar_one_or_none()
    
    if not lesson:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Lesson not found"
        )
    
    await db.delete(lesson)
    await db.commit()
    
    return {"message": "Lesson deleted successfully"}
