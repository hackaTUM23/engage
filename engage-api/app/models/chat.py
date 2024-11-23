from typing import List, Optional
from pydantic import BaseModel, Field
from datetime import datetime

# Chat model
class Chat(BaseModel):
    chat_id: int
    matchmaker_id: int
    user_id: int
    timestamp: datetime
    message: str
