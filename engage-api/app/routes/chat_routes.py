from fastapi import APIRouter, HTTPException
from models.chat import Chat
from persistence.mock_db import chat_data
from typing import List

router = APIRouter()

# --- Chat Routes ---   
@router.get("/", response_model=List[Chat])
def get_messages():
    return chat_data

@router.get("/{matchmaker_id}", response_model=List[Chat])
def get_messages(matchmaker_id: int):
    return [c for c in chat_data if c.matchmaker_id == matchmaker_id]

@router.post("/send_message", response_model=List[Chat])
def send_message(chat: Chat):
    chat_data.append(chat)
    return [c for c in chat_data if c.matchmaker_id == chat.matchmaker_id]
