import joblib
from flask import Flask, request, jsonify

model = joblib.load('random_forest_model.pkl')
app = Flask(__name__)

@app.route('/')
def home():
    return "Hello world"

@app.route('/predict', methods=['POST'])
def predict():
    d = {0: 'no', 1: 'yes'}

    input_columns = ['A1', 'A2', 'A3', 'A4', 'A5', 'A6', 'A7', 'A8', 'A9',
                     'A10_Autism_Spectrum_Quotient', 'Age_Years', 'Qchat_10_Score', 'Sex',
                     'Jaundice', 'Family_mem_with_ASD', 'Ethnicity_Black',
                     'Ethnicity_Hispanic', 'Ethnicity_Latino', 'Ethnicity_Middle Eastern',
                     'Ethnicity_Mixed', 'Ethnicity_Native Indian', 'Ethnicity_Others',
                     'Ethnicity_Pacifica', 'Ethnicity_South Asian',
                     'Ethnicity_White European',
                     'Who_completed_the_test_Health Care Professional',
                     'Who_completed_the_test_Others',
                     'Who_completed_the_test_School and NGO', 'Who_completed_the_test_Self']

    # Get the input data from the request form
    input_data = request.json
    print(input_data)

    # Handle NaN values by replacing them with 0
    #input_data = {k: v if v is not None and v != 'NaN' else 0 for k, v in input_data.items()}

    # Perform prediction using the model
    prediction = model.predict([list(input_data.values())])

    # Map the prediction to the corresponding outcome
    outcome = d[prediction[0]]
    

    # Return the predicted outcome as JSON
    response_data = outcome
    if(outcome=="no"): response_data= "Congratulations, Your child is non autistic"
    else: response_data= "Your child is autistic"
    print('Response Data:', response_data)  # Print the response data
    return jsonify(response_data)

if __name__ =='__main__':
    app.run(debug=True, host='0.0.0.0')
