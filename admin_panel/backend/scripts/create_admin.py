"""
Script to create an admin user.
Run this after database migrations.
"""
import asyncio
import sys
from pathlib import Path

# Add parent directory to path
sys.path.insert(0, str(Path(__file__).parent.parent))

from sqlalchemy import select
from app.core.database import AsyncSessionLocal
from app.core.config import settings
from app.core.security import hash_password
from app.models.user import User, UserRole, UserStatus


async def create_admin_user():
    """Create the admin user if it doesn't exist"""
    
    async with AsyncSessionLocal() as session:
        # Check if admin already exists
        result = await session.execute(
            select(User).where(User.email == settings.ADMIN_EMAIL)
        )
        existing_user = result.scalar_one_or_none()
        
        if existing_user:
            print(f"Admin user already exists: {settings.ADMIN_EMAIL}")
            print(f"User ID: {existing_user.id}")
            print(f"Role: {existing_user.role}")
            return
        
        # Create admin user
        admin_user = User(
            email=settings.ADMIN_EMAIL,
            hashed_password=hash_password(settings.ADMIN_PASSWORD),
            full_name="System Administrator",
            role=UserRole.ADMIN,
            status=UserStatus.ACTIVE,
            is_subscribed=True
        )
        
        session.add(admin_user)
        await session.commit()
        await session.refresh(admin_user)
        
        print("=" * 50)
        print("Admin user created successfully!")
        print("=" * 50)
        print(f"Email: {admin_user.email}")
        print(f"Password: {settings.ADMIN_PASSWORD}")
        print(f"User ID: {admin_user.id}")
        print(f"Role: {admin_user.role}")
        print("=" * 50)
        print("⚠️  IMPORTANT: Change the password after first login!")
        print("=" * 50)


if __name__ == "__main__":
    asyncio.run(create_admin_user())
