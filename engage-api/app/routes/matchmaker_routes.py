from fastapi import APIRouter, HTTPException, Query
from models.matchmaker import Matchmaker
from persistence.mock_db import matchmaker_data, users_data, activities_data
from services.llm.vertexai import VertexAI_LLM
from typing import List
import time

router = APIRouter()

# --- Matchmaker Routes ---
@router.get("/", response_model=List[Matchmaker])
def get_matchmakers():
    return matchmaker_data

@router.get("/get_summary/{matchmaker_id}")
def get_match_summary(matchmaker_id: int):
    matchmaker = next((matchmaker for matchmaker in matchmaker_data if matchmaker.matchmaker_id == matchmaker_id), None)
    if not matchmaker:
        raise HTTPException(status_code=404, detail="Matchmaker not found")
    
    users = []
    for id in matchmaker.users:
        user = next((user for user in users_data if user.user_id == id), None)
        users.append(user)

    activity = next((activity for activity in activities_data if activity.id == matchmaker.activity_id), None)

    prompt = "Write a short but exciting greeting to two Munich citizens, that plan to meet for an upcoming activity event." \
             "Shortly mention a few of their interests and experiences, especially those similar between both." \
             "Lastly very shortly introduce the upcoming activity.\n\n" \
             f"Users: {users}\n" \
             f"Activity: {activity}"
    
    return VertexAI_LLM(model="gemini-pro").invoke(prompt=prompt)

@router.post("/accept_match")
def accept_match(users: List[int] = Query(...), activity_id:int = Query(...)):
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
