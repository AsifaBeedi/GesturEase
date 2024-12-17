from fastapi import FastAPI, File, UploadFile
from fastapi.responses import JSONResponse
from fastai.vision.all import load_learner, PILImage
import pathlib
import io

app = FastAPI()

# Fix PosixPath for Windows
temp = pathlib.PosixPath
pathlib.PosixPath = pathlib.WindowsPath

# Load the pre-trained model (assuming you have a model saved as 'isl_model.pkl')
try:
    model_path = r'C:\Users\Asifa Bandulal Beed\Downloads\isl_model (1).pkl'
    learn = load_learner(model_path)
except Exception as e:
    print(f"Error loading model: {e}")
    learn = None

# Restore PosixPath (optional, for safety)
pathlib.PosixPath = temp

# Define the route for image prediction
@app.post("/predict/")
async def predict(file: UploadFile = File(...)):
    if learn is None:
        return JSONResponse(content={"error": "Model not loaded"}, status_code=500)
    
    try:
        # Read the image
        image_data = await file.read()
        image = PILImage.create(io.BytesIO(image_data))
        
        # Make prediction
        prediction, _, probs = learn.predict(image)
        
        # Return the result
        return JSONResponse(content={"predicted_class": str(prediction), "probabilities": probs.tolist()})
    except Exception as e:
        return JSONResponse(content={"error": str(e)}, status_code=500)

if __name__ == '__main__':
    import uvicorn
    uvicorn.run(app, host='0.0.0.0', port=8000)