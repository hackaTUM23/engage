from fastapi import APIRouter, HTTPException
from models.matchmaker import Matchmaker
from persistence.mock_db import matchmaker_data
from typing import List
import time

router = APIRouter()

# --- Matchmaker Routes ---
@router.get("/", response_model=List[Matchmaker])
def get_matchmakers():
    return matchmaker_data

@router.post("/accept_match")
def accept_match(users: List[int], activity_id:int):
    id = int(time.time())
    if any(m.matchmaker_id == id for m in matchmaker_data):
        raise HTTPException(status_code=400, detail="Matchmaker ID already exists")
    matchmaker_data.append(Matchmaker(matchmaker_id=id, users=users, activity_id=activity_id))
    return id

@router.delete("/{matchmaker_id}")
def delete_match(matchmaker_id: int):
    global matchmaker_data
    matchmaker_data = [m for m in matchmaker_data if m.matchmaker_id != matchmaker_id]
    return {"message": "Matchmaker deleted successfully"}
