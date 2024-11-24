from fastapi import FastAPI
from routes import activity_routes, chat_routes, user_routes, matchmaker_routes, subscription_routes
from fastapi.concurrency import asynccontextmanager
from services.llm.vertexai import VertexAI_LLM

app = FastAPI()

app.include_router(user_routes.router, prefix="/users", tags=["Users"])
app.include_router(activity_routes.router, prefix="/activities", tags=["Activities"])
app.include_router(chat_routes.router, prefix="/chats", tags=["Chats"])
app.include_router(matchmaker_routes.router, prefix="/matchmaker", tags=["MatchMaker"])
app.include_router(subscription_routes.router, prefix="/subscriptions", tags=["Subscriptions"])

@asynccontextmanager
async def lifespan(app: FastAPI):
    try:
        yield
    finally:
        pass
