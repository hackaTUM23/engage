from fastapi import APIRouter, HTTPException
from models.chat import Chat
from persistence.mock_db import chat_data
from typing import List

router = APIRouter()

# --- Chat Routes ---
@router.get("/", response_model=List[Chat])
def get_chats():
    return chat_data

@router.post("/", response_model=Chat)
def create_chat(chat: Chat):
    if any(c.chat_id == chat.chat_id for c in chat_data):
        raise HTTPException(status_code=400, detail="Chat ID already exists")
    chat_data.append(chat)
    return chat

@router.delete("/{chat_id}")
def delete_chat(chat_id: int):
    global chat_data
    chat_data = [c for c in chat_data if c.chat_id != chat_id]
    return {"message": "Chat deleted successfully"}
