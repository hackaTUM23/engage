from fastapi import APIRouter, HTTPException
from app.models.matchmaker import Matchmaker
from app.persistence.mock_db import matchmaker_data
from typing import List

router = APIRouter()

# --- Matchmaker Routes ---
@router.get("/matchmakers", response_model=List[Matchmaker])
def get_matchmakers():
    return matchmaker_data

@router.post("/matchmakers", response_model=Matchmaker)
def create_matchmaker(matchmaker: Matchmaker):
    if any(m.matchmaker_id == matchmaker.matchmaker_id for m in matchmaker_data):
        raise HTTPException(status_code=400, detail="Matchmaker ID already exists")
    matchmaker_data.append(matchmaker)
    return matchmaker

@router.delete("/matchmakers/{matchmaker_id}")
def delete_matchmaker(matchmaker_id: int):
    global matchmaker_data
    matchmaker_data = [m for m in matchmaker_data if m.matchmaker_id != matchmaker_id]
    return {"message": "Matchmaker deleted successfully"}
