"""
RAG (Retrieval-Augmented Generation) models for knowledge base and embeddings.
"""
from datetime import datetime
from typing import Optional, List
from sqlalchemy import String, Text, Integer, DateTime, ForeignKey, Boolean
from sqlalchemy.orm import Mapped, mapped_column, relationship
from sqlalchemy.sql import func
from pgvector.sqlalchemy import Vector

from app.core.database import Base


class KnowledgeSource(Base):
    """Knowledge base source documents for RAG system"""
    
    __tablename__ = "kb_sources"
    
    id: Mapped[int] = mapped_column(primary_key=True, index=True)
    
    # Content
    title: Mapped[str] = mapped_column(String(500), nullable=False)
    content: Mapped[str] = mapped_column(Text, nullable=False)
    summary: Mapped[Optional[str]] = mapped_column(Text)
    
    # Categorization
    category: Mapped[Optional[str]] = mapped_column(String(100), index=True)
    tags: Mapped[Optional[str]] = mapped_column(String(500))  # Comma-separated tags
    language: Mapped[str] = mapped_column(String(5), default="am", index=True)  # Amharic by default
    
    # Source information
    source_type: Mapped[str] = mapped_column(String(50), default="manual")  # manual, pdf, web, etc.
    source_url: Mapped[Optional[str]] = mapped_column(String(1000))
    
    # Status
    is_active: Mapped[bool] = mapped_column(Boolean, default=True)
    is_indexed: Mapped[bool] = mapped_column(Boolean, default=False)
    
    # Metadata
    created_by: Mapped[int] = mapped_column(ForeignKey("users.id"), nullable=False)
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
    
    # Relationships
    embeddings = relationship("KnowledgeEmbedding", back_populates="source", cascade="all, delete-orphan")
    
    def __repr__(self) -> str:
        return f"<KnowledgeSource(id={self.id}, title='{self.title}')>"


class KnowledgeEmbedding(Base):
    """Vector embeddings for knowledge sources"""
    
    __tablename__ = "kb_embeddings"
    
    id: Mapped[int] = mapped_column(primary_key=True, index=True)
    source_id: Mapped[int] = mapped_column(ForeignKey("kb_sources.id", ondelete="CASCADE"), nullable=False, index=True)
    
    # Text chunk
    chunk_text: Mapped[str] = mapped_column(Text, nullable=False)
    chunk_index: Mapped[int] = mapped_column(Integer, default=0)
    
    # Vector embedding (1536 dimensions for OpenAI text-embedding-3-small)
    embedding: Mapped[Vector] = mapped_column(Vector(1536))
    
    # Metadata
    model_name: Mapped[str] = mapped_column(String(100), default="text-embedding-3-small")
    created_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True),
        server_default=func.now(),
        nullable=False
    )
    
    # Relationships
    source = relationship("KnowledgeSource", back_populates="embeddings")
    
    def __repr__(self) -> str:
        return f"<KnowledgeEmbedding(id={self.id}, source_id={self.source_id})>"


class RAGQuery(Base):
    """Log of RAG queries for analytics and improvement"""
    
    __tablename__ = "rag_queries"
    
    id: Mapped[int] = mapped_column(primary_key=True, index=True)
    
    # Query details
    query_text: Mapped[str] = mapped_column(Text, nullable=False)
    user_id: Mapped[Optional[int]] = mapped_column(ForeignKey("users.id", ondelete="SET NULL"))
    
    # Response
    response_text: Mapped[str] = mapped_column(Text, nullable=False)
    sources_used: Mapped[Optional[str]] = mapped_column(Text)  # JSON list of source IDs
    
    # Metrics
    response_time_ms: Mapped[Optional[int]] = mapped_column(Integer)
    tokens_used: Mapped[Optional[int]] = mapped_column(Integer)
    
    # Feedback
    is_flagged: Mapped[bool] = mapped_column(Boolean, default=False)
    flag_reason: Mapped[Optional[str]] = mapped_column(Text)
    user_feedback: Mapped[Optional[str]] = mapped_column(String(50))  # positive, negative, neutral
    
    # Timestamps
    created_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True),
        server_default=func.now(),
        nullable=False,
        index=True
    )
    
    def __repr__(self) -> str:
        return f"<RAGQuery(id={self.id}, query='{self.query_text[:50]}...')>"
