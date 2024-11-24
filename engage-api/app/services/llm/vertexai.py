from services.llm.llm import LLM
from langchain_google_vertexai import VertexAI

class VertexAI_LLM(LLM):
    def __init__(self, model: str) -> None:
        super().__init__(model)
        self.model = VertexAI(model=model)

    def invoke(self, prompt: str):
        return self.model.invoke(prompt)
    
    def stream(self, prompt: str):
        return self.model.astream(prompt)