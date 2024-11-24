from fastapi import APIRouter, HTTPException
from models.chat import Chat
from persistence.mock_db import chat_data
from typing import List

router = APIRouter()

# --- Chat Routes ---
@router.get("/{matchmaker_id}", response_model=List[Chat])
def get_messages(matchmaker_id: int):
    return sorted([c for c in chat_data if c.matchmaker_id == matchmaker_id], key=lambda chat: chat.timestamp)

@router.post("/send_message", response_model=Chat)
def send_message(chat: Chat):
    chat_data.append(chat)
    return chat
