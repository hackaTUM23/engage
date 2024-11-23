from fastapi import APIRouter, HTTPException
from models.activities import Activity
from persistence.mock_db import activities_data
from typing import List

router = APIRouter()

# --- Activity Routes ---
@router.get("/activities", response_model=List[Activity])
def get_activities():
    return activities_data

@router.get("/activities/{activity_id}", response_model=Activity)
def get_activity(activity_id: int):
    activity = next((activity for activity in activities_data if activity.id == activity_id), None)
    if not activity:
        raise HTTPException(status_code=404, detail="Activity not found")
    return activity

@router.post("/activities", response_model=Activity)
def create_activity(activity: Activity):
    if any(a.id == activity.id for a in activities_data):
        raise HTTPException(status_code=400, detail="Activity ID already exists")
    activities_data.append(activity)
    return activity

@router.delete("/activities/{activity_id}")
def delete_activity(activity_id: int):
    global activities_data
    activities_data = [activity for activity in activities_data if activity.id != activity_id]
    return {"message": "Activity deleted successfully"}