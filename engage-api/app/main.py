from fastapi import FastAPI
#from app.persistence.db import database
from routes import activity_routes, chat_routes, user_routes, matchmaker_routes
from fastapi.concurrency import asynccontextmanager

app = FastAPI()

app.include_router(user_routes.router, prefix="/users", tags=["Users"])
app.include_router(activity_routes.router, prefix="/activities", tags=["Activities"])
app.include_router(chat_routes.router, prefix="/chats", tags=["Chats"])
app.include_router(matchmaker_routes.router, prefix="/matchmaker", tags=["MatchMaker"])

@asynccontextmanager
async def lifespan(app: FastAPI):
    try:
        #await database.connect()
        yield
    finally:
        pass
        #await database.disconnect()
