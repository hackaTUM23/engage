from typing import List, Optional
from pydantic import BaseModel, Field
from datetime import datetime
from typing import Tuple

# Activity model
class Activity(BaseModel):
    id: int
    activity_desc: str
    time: datetime
    location_desc: Optional[str]
    location_lat_long: Tuple[float, float]
    registered_people_count: int
    max_people_count: int