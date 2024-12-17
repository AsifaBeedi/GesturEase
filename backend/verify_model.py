import pathlib
from fastai.vision.all import load_learner

# Fix PosixPath for Windows
temp = pathlib.PosixPath
pathlib.PosixPath = pathlib.WindowsPath

# Load the model
model_path = r'C:\Users\Asifa Bandulal Beed\Downloads\isl_model (1).pkl'  # Replace with your actual path
try:
    learn = load_learner(model_path)
    print("Model loaded successfully!")
except Exception as e:
    print(f"Error loading model: {e}")

# Restore PosixPath (optional, for safety)
pathlib.PosixPath = temp