import pandas as pd
import random
import uvicorn
import pickle
from fastapi import FastAPI, HTTPException, Request
import socket
import sys

app = FastAPI()

hostname = socket.gethostname()

version = f"{sys.version_info.major}.{sys.version_info.minor}"

# Define the home page
@app.get("/")
async def read_root():
    return {
        "name": "my-app",
        "host": hostname,
        "version": f"Hello world! From FastAPI running on Uvicorn. Using Python {version}"
    }


# Load default model pickle
model = pickle.load(open('model.pkl', 'rb'))


# Preprocess the input features
def preprocess(features):
    columns = ['model_key', 'mileage', 'engine_power', 'fuel', 'paint_color',
        'car_type', 'private_parking_available', 'has_gps',
        'has_air_conditioning', 'automatic_car', 'has_getaround_connect',
        'has_speed_regulator', 'winter_tires']
    print(columns)
    # X dataframe
    X = pd.DataFrame(columns=columns)
    print(X)
    id = random.randint(0, 1000000)
    X.loc[id] = features
    print(X)
    
    # Features into a dataframe
    features = pd.DataFrame([features], columns=X.columns)
    
    # Identify categorical and numerical columns
    categorical_cols = [col for col in features.columns if features[col].dtype == 'object']
    numerical_cols = [col for col in features.columns if features[col].dtype in ['int64', 'float64']]
    print(categorical_cols)
    print(numerical_cols)
    
    return features


@app.post('/predict')
async def predict(request: Request):
    try:
        # Get the input data from the request
        data = await request.json()
        features = data['features']
        features = preprocess(features)

        # Predict using the loaded model
        prediction = model.predict(features)

        # Return the prediction as a JSON response
        return {'prediction': prediction.tolist()}
    
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


if __name__ == '__main__':
    import uvicorn
    # Use the PORT environment variable if available, otherwise default to 8502
    uvicorn.run(app, host="0.0.0.0", port=5000)
