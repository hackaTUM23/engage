from fastapi import APIRouter, HTTPException, Query
from models.activities import Activity
from persistence.mock_db import activities_data
from typing import List

router = APIRouter()

category_keywords = {
    "Fitness": ["Fitness", "Fatburn", "Functional Training", "Step Power", "HIIT", "Outdoor-Cross-Training"],
    "Ball Sports": ["Basketball", "Volleyball"],
    "Dancing": ["Dance", "ZUMBA", "Silent Disco"],
    "Woman Only": ["Frauen", "Female"],
    "Health": ["Yoga", "Pilates", "Qi Gong", "Rücken", "Mobility"],
    "Conversations": ["Eltern-Kind-Turnen", "Ratschen", "Ratschbank"],
    "Board Games": ["Schach"],
    "Fighting": ["Kickbox"],
    "Other": []  # Default for anything not matched
}

# Function to map each item to a category
def map_to_category(item, category_keywords, default_category="Other"):
    # Find the best matching category based on keywords
    matched_category = default_category
    for category, keywords in category_keywords.items():
        if any(keyword in item for keyword in keywords):
            matched_category = category
            break
    return matched_category

# --- Activity Routes ---
@router.get("/", response_model=List[Activity])
def get_activities(categories: List[str] = Query(None)):
    if not categories:
        return activities_data  # If no categories are provided, return all activities
    return list(filter(lambda a: map_to_category(a.activity_desc, category_keywords) in categories, activities_data))

@router.get("/{activity_id}", response_model=Activity)
def get_activity(activity_id: int):
    activity = next((activity for activity in activities_data if activity.id == activity_id), None)
    if not activity:
        raise HTTPException(status_code=404, detail="Activity not found")
    return activity

@router.post("/", response_model=Activity)
def create_activity(activity: Activity):
    if any(a.id == activity.id for a in activities_data):
        raise HTTPException(status_code=400, detail="Activity ID already exists")
    activities_data.append(activity)
    return activity

@router.delete("/{activity_id}")
def delete_activity(activity_id: int):
    global activities_data
    activities_data = [activity for activity in activities_data if activity.id != activity_id]
    return {"message": "Activity deleted successfully"}