"""
Lesson models for the Duolingo-style learning system.
"""
from datetime import datetime
from typing import Optional, List
from sqlalchemy import String, Text, Integer, Boolean, DateTime, ForeignKey, JSON, Enum as SQLEnum, Float
from sqlalchemy.orm import Mapped, mapped_column, relationship
from sqlalchemy.sql import func
import enum

from app.core.database import Base


class LanguagePair(str, enum.Enum):
    """Language pair enumeration"""
    EN_AM = "en_am"  # English to Amharic
    ZH_AM = "zh_am"  # Chinese to Amharic
    FR_AM = "fr_am"  # French to Amharic
    DE_AM = "de_am"  # German to Amharic
    ES_AM = "es_am"  # Spanish to Amharic
    AR_AM = "ar_am"  # Arabic to Amharic
    PT_AM = "pt_am"  # Portuguese to Amharic
    RU_AM = "ru_am"  # Russian to Amharic
    JA_AM = "ja_am"  # Japanese to Amharic
    IT_AM = "it_am"  # Italian to Amharic
    HI_AM = "hi_am"  # Hindi to Amharic


class LessonLevel(str, enum.Enum):
    """Lesson difficulty level"""
    BEGINNER = "beginner"
    ELEMENTARY = "elementary"
    INTERMEDIATE = "intermediate"
    ADVANCED = "advanced"
    EXPERT = "expert"


class LessonStatus(str, enum.Enum):
    """Lesson publication status"""
    DRAFT = "draft"
    PUBLISHED = "published"
    ARCHIVED = "archived"


class ExerciseType(str, enum.Enum):
    """Exercise type enumeration"""
    CONVERSATION = "conversation"
    VOCABULARY = "vocabulary"
    MULTIPLE_CHOICE = "multiple_choice"
    LISTENING = "listening"
    TYPING = "typing"
    TRANSLATION = "translation"
    MATCHING = "matching"
    FILL_BLANK = "fill_blank"
    SPEAKING = "speaking"


class Lesson(Base):
    """Lesson model - Duolingo-style learning units"""
    
    __tablename__ = "lessons"
    
    # Primary key
    id: Mapped[int] = mapped_column(primary_key=True, index=True)
    
    # Lesson metadata
    title: Mapped[str] = mapped_column(String(255), nullable=False)
    description: Mapped[Optional[str]] = mapped_column(Text)
    slug: Mapped[str] = mapped_column(String(255), unique=True, index=True, nullable=False)
    
    # Language and level
    language_pair: Mapped[LanguagePair] = mapped_column(SQLEnum(LanguagePair), nullable=False)
    level: Mapped[LessonLevel] = mapped_column(SQLEnum(LessonLevel), nullable=False)
    
    # Sequencing (for Duolingo tree structure)
    unit_number: Mapped[int] = mapped_column(Integer, default=1)
    lesson_number: Mapped[int] = mapped_column(Integer, default=1)
    skill_id: Mapped[Optional[int]] = mapped_column(ForeignKey("skills.id", ondelete="SET NULL"))
    order: Mapped[int] = mapped_column(Integer, default=0)
    
    # Gamification
    xp_reward: Mapped[int] = mapped_column(Integer, default=10)
    estimated_minutes: Mapped[int] = mapped_column(Integer, default=5)
    
    # Publication
    status: Mapped[LessonStatus] = mapped_column(
        SQLEnum(LessonStatus),
        default=LessonStatus.DRAFT,
        nullable=False
    )
    published_at: Mapped[Optional[datetime]] = mapped_column(DateTime(timezone=True))
    
    # Versioning
    version: Mapped[int] = mapped_column(Integer, default=1)
    created_by: Mapped[int] = mapped_column(ForeignKey("users.id"), nullable=False)
    updated_by: Mapped[Optional[int]] = mapped_column(ForeignKey("users.id"))
    
    # Metadata
    created_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True),
        server_default=func.now(),
        nullable=False
    )
    updated_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True),
        server_default=func.now(),
        onupdate=func.now(),
        nullable=False
    )
    
    # Additional metadata (JSON)
    metadata: Mapped[Optional[dict]] = mapped_column(JSON)
    
    # Relationships
    exercises = relationship("Exercise", back_populates="lesson", cascade="all, delete-orphan")
    skill = relationship("Skill", back_populates="lessons")
    
    def __repr__(self) -> str:
        return f"<Lesson(id={self.id}, title='{self.title}', status='{self.status}')>"


class Skill(Base):
    """Skill model - Group of related lessons (Duolingo tree structure)"""
    
    __tablename__ = "skills"
    
    id: Mapped[int] = mapped_column(primary_key=True, index=True)
    name: Mapped[str] = mapped_column(String(255), nullable=False)
    description: Mapped[Optional[str]] = mapped_column(Text)
    icon: Mapped[Optional[str]] = mapped_column(String(50))
    color: Mapped[Optional[str]] = mapped_column(String(20))
    order: Mapped[int] = mapped_column(Integer, default=0)
    
    language_pair: Mapped[LanguagePair] = mapped_column(SQLEnum(LanguagePair), nullable=False)
    level: Mapped[LessonLevel] = mapped_column(SQLEnum(LessonLevel), nullable=False)
    
    created_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True),
        server_default=func.now(),
        nullable=False
    )
    
    # Relationships
    lessons = relationship("Lesson", back_populates="skill")
    
    def __repr__(self) -> str:
        return f"<Skill(id={self.id}, name='{self.name}')>"


class Exercise(Base):
    """Exercise model - Individual learning activities within a lesson"""
    
    __tablename__ = "exercises"
    
    id: Mapped[int] = mapped_column(primary_key=True, index=True)
    lesson_id: Mapped[int] = mapped_column(ForeignKey("lessons.id", ondelete="CASCADE"), nullable=False)
    
    # Exercise content
    type: Mapped[ExerciseType] = mapped_column(SQLEnum(ExerciseType), nullable=False)
    question: Mapped[str] = mapped_column(Text, nullable=False)
    question_audio_url: Mapped[Optional[str]] = mapped_column(String(500))
    question_image_url: Mapped[Optional[str]] = mapped_column(String(500))
    
    # Answer data (JSON format for flexibility)
    answer_data: Mapped[dict] = mapped_column(JSON, nullable=False)
    # Example structures:
    # - Multiple choice: {"options": ["A", "B", "C"], "correct": 0}
    # - Typing: {"correct_answers": ["Hello", "hello"], "case_sensitive": false}
    # - Matching: {"pairs": [{"left": "Dog", "right": "ውሻ"}, ...]}
    
    # Additional content
    hint: Mapped[Optional[str]] = mapped_column(Text)
    explanation: Mapped[Optional[str]] = mapped_column(Text)
    
    # Ordering
    order: Mapped[int] = mapped_column(Integer, default=0)
    
    # Metadata
    created_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True),
        server_default=func.now(),
        nullable=False
    )
    
    # Relationships
    lesson = relationship("Lesson", back_populates="exercises")
    
    def __repr__(self) -> str:
        return f"<Exercise(id={self.id}, type='{self.type}', lesson_id={self.lesson_id})>"


class ConversationDialog(Base):
    """Conversation dialog for conversation-type exercises"""
    
    __tablename__ = "conversation_dialogs"
    
    id: Mapped[int] = mapped_column(primary_key=True, index=True)
    exercise_id: Mapped[int] = mapped_column(ForeignKey("exercises.id", ondelete="CASCADE"), nullable=False)
    
    # Dialog content
    speaker: Mapped[str] = mapped_column(String(100), nullable=False)
    speaker_avatar: Mapped[Optional[str]] = mapped_column(String(200))
    text: Mapped[str] = mapped_column(Text, nullable=False)
    translation: Mapped[Optional[str]] = mapped_column(Text)
    audio_url: Mapped[Optional[str]] = mapped_column(String(500))
    
    # Ordering
    order: Mapped[int] = mapped_column(Integer, default=0)
    
    def __repr__(self) -> str:
        return f"<ConversationDialog(id={self.id}, speaker='{self.speaker}')>"
