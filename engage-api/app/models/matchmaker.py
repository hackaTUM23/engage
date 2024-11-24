from typing import List, Optional
from pydantic import BaseModel, Field
from datetime import datetime

# Matchmaker model
class Matchmaker(BaseModel):
    matchmaker_id: Optional[int]
    users: List[int]
    activity_id: int
