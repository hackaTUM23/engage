from typing import List, Optional
from pydantic import BaseModel, Field
from datetime import datetime

# Matchmaker model
class Matchmaker(BaseModel):
    matchmaker_id: int
    user_id: int
    activity_id: int
    time: datetime
    location: str
