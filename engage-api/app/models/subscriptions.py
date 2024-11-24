from typing import List, Optional
from pydantic import BaseModel, Field
from datetime import datetime
from models.users import User
from models.activities import Activity

# Subscription model
class Subscription(BaseModel):
    subscription_id: Optional[int]
    user: User
    activity: Activity
