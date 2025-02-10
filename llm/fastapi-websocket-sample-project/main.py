import asyncio
from fastapi import FastAPI, WebSocket, WebSocketDisconnect

app = FastAPI()

@app.websocket("/ws/ai")
async def ai_agent_ws(websocket: WebSocket):
    await websocket.accept()
    try:
        # Simulated steps of the AI agent "thinking"
        steps = [
            "Agent: Initializing...",
            "Agent: Gathering data...",
            "Agent: Processing information...",
            "Agent: Analyzing results...",
            "Agent: Finalizing output..."
        ]
        
        # Send each step with a delay to simulate processing time
        for step in steps:
            await asyncio.sleep(2)  # simulate delay (2 seconds)
            await websocket.send_text(step)
        
        # Send a final message indicating completion
        await websocket.send_text("Agent: Processing complete!")
    except WebSocketDisconnect:
        print("Client disconnected")

# if __name__ == "__main__":
#     import uvicorn
#     uvicorn.run(app, host="127.0.0.1", port=8000)
