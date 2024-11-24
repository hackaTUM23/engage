from typing import List, Optional
from pydantic import BaseModel, Field
from datetime import datetime
from typing import Tuple

# User model
class User(BaseModel):
    user_id: Optional[int]
    prename: str
    surname: str
    gender: str
    home_location_lat_long: Tuple[float, float]
    age: int
    interests: List[str]
    experiences: List[str]
    previous_activities: List[str]