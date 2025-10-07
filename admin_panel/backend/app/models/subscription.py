"""
Subscription and payment models.
"""
from datetime import datetime
from typing import Optional
from sqlalchemy import String, Integer, Boolean, DateTime, ForeignKey, Float, Enum as SQLEnum
from sqlalchemy.orm import Mapped, mapped_column, relationship
from sqlalchemy.sql import func
import enum

from app.core.database import Base


class PaymentStatus(str, enum.Enum):
    """Payment status enumeration"""
    PENDING = "pending"
    COMPLETED = "completed"
    FAILED = "failed"
    REFUNDED = "refunded"
    CANCELLED = "cancelled"


class PaymentProvider(str, enum.Enum):
    """Payment provider enumeration"""
    TELEBIRR = "telebirr"
    CBE = "cbe"
    MANUAL = "manual"
    STRIPE = "stripe"


class Subscription(Base):
    """Subscription model for permanent access"""
    
    __tablename__ = "subscriptions"
    
    id: Mapped[int] = mapped_column(primary_key=True, index=True)
    user_id: Mapped[int] = mapped_column(ForeignKey("users.id", ondelete="CASCADE"), nullable=False, index=True)
    
    # Payment details
    amount: Mapped[float] = mapped_column(Float, default=300.0)  # 300 ETB
    currency: Mapped[str] = mapped_column(String(3), default="ETB")
    
    # Payment provider
    provider: Mapped[PaymentProvider] = mapped_column(SQLEnum(PaymentProvider), nullable=False)
    provider_transaction_id: Mapped[Optional[str]] = mapped_column(String(255), index=True)
    provider_reference: Mapped[Optional[str]] = mapped_column(String(255))
    
    # Status
    status: Mapped[PaymentStatus] = mapped_column(
        SQLEnum(PaymentStatus),
        default=PaymentStatus.PENDING,
        nullable=False
    )
    
    # Timestamps
    created_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True),
        server_default=func.now(),
        nullable=False
    )
    paid_at: Mapped[Optional[datetime]] = mapped_column(DateTime(timezone=True))
    expires_at: Mapped[Optional[datetime]] = mapped_column(DateTime(timezone=True))  # NULL = permanent
    
    # Metadata
    metadata: Mapped[Optional[dict]] = mapped_column(String)  # JSON string for payment details
    notes: Mapped[Optional[str]] = mapped_column(String)
    
    # Relationships
    user = relationship("User", back_populates="subscriptions")
    
    def __repr__(self) -> str:
        return f"<Subscription(id={self.id}, user_id={self.user_id}, status='{self.status}')>"
    
    @property
    def is_active(self) -> bool:
        """Check if subscription is active"""
        return self.status == PaymentStatus.COMPLETED
