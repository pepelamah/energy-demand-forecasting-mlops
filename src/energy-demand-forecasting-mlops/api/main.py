from fastapi import FastAPI

app = FastAPI(title="Energy Demand Forecasting - API")

@app.get("/")
async def root():
    return {"message": "Energy Demand Forecasting API - healthy"}

@app.get("/health")
async def health():
    return {"status": "ok"}

