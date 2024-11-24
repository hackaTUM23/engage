from fastapi import APIRouter, HTTPException
from models.users import User
from persistence.mock_db import users_data
from typing import List
import time

router = APIRouter()

# --- User Routes ---
@router.get("/", response_model=List[User])
def get_users():
    return users_data

@router.get("/{user_id}", response_model=User)
def get_user(user_id: int):
    user = next((user for user in users_data if user.user_id == user_id), None)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    return user

@router.post("/", response_model=User)
def create_user(user: User):
    user.user_id = int(time.time())
    if any(u.user_id == user.user_id for u in users_data):
        raise HTTPException(status_code=400, detail="User ID already exists")
    users_data.append(user)
    return user

@router.delete("/{user_id}")
def delete_user(user_id: int):
    global users_data
    users_data = [user for user in users_data if user.user_id != user_id]
    return {"message": "User deleted successfully"}
