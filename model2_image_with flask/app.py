# Import necessary libraries
import re
import os
import json
from werkzeug.utils import secure_filename
from flask import Flask, request, jsonify
from flask_cors import CORS
from keras.models import load_model # type: ignore
import numpy as np
from keras.preprocessing import image # type: ignore

# Create the Flask app
app = Flask(__name__)
CORS(app)

# Define the upload folder and secret key
UPLOAD_FOLDER = 'static/uploads/'
app.secret_key = 'Autism detection'
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

# Define the allowed file extensions
ALLOWED_EXTENSIONS = set(['png', 'jpg', 'jpeg'])

# Function to check if the file extension is allowed
def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

# Define the route for the homepage
@app.route('/', methods=['GET', 'POST'])
def index():
    return jsonify({'done': 'done'})

# Define the route for uploading an image
@app.route('/upload_image', methods=['POST'])
def upload_image():
    # Check if the file is in the request
    if 'file' not in request.files:
        return jsonify({'result': 'Please try again. The Image doesn\'t exist'})
    
    # Print the keys of request.files
    print(request.files.keys())

    # Load the model
    model_path = '40epochs.h5'
    saved_model = load_model(model_path)
    print("*******model loaded successfully*******")

    # Get the file from the request
    file = request.files['file']
    print("Received file:", file.filename)  # Print the filename
    print(file)

    # Save the file to the upload folder
    filename = secure_filename(file.filename)
    file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
    image_uri = 'static/uploads/{}'.format(str(filename))

    # Image preprocessing
    img = image.load_img(image_uri, target_size=(224, 224))
    img = np.asarray(img)
    img = np.expand_dims(img, axis=0)

    # Predict
    output = saved_model.predict(img)
    finalpredict = output[0][0]
    print(finalpredict)
    print(np.round(finalpredict))

    threshold = 0.5
    if finalpredict >= threshold:
        probability = format(finalpredict * 100, '.2f')
        return jsonify('Your child is autistic')
    else:
        return jsonify('Congratulations, your child is Non-Autistic')

# Run the Flask app
if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=3000)
