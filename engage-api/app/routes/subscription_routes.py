from fastapi import APIRouter, HTTPException, Query
from models.subscriptions import Subscription
from models.activities import Activity
from persistence.mock_db import subscription_data
from typing import List
import time

router = APIRouter()

# --- Subscription Routes ---
@router.get("/", response_model=List[Subscription])
def get_subscriptions():
    return subscription_data

@router.post("/subscribe", response_model=Subscription)
def subscribe(subscription: Subscription):
    subscription.id = int(time.time())
    if any(m.subscription_id == subscription.subscription_id for m in subscription_data):
        raise HTTPException(status_code=400, detail="Subscription ID already exists")
    subscription_data.append(subscription)
    return subscription

@router.get("/find_matching_subscription/", response_model=Subscription)
def find_matching_subscription(user_id: int = Query(None), preferences: List[str] = Query(None)):
    
    #TODO logic

    match = [s for s in subscription_data if s.user != None][0]
    return match

@router.delete("/{subscription_id}")
def delete_subscription(subscription_id: int):
    global subscription_data
    subscription_data = [m for m in subscription_data if m.subscription_id != subscription_id]
    return {"message": "Subscription deleted successfully"}
