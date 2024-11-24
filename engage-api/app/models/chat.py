from typing import List, Optional
from pydantic import BaseModel, Field
from datetime import datetime

# Chat model
class Chat(BaseModel):
    matchmaker_id: int
    user_id: int
    timestamp: datetime
    message: str
