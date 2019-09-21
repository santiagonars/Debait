# --------------------STEPS:------------------------------
# Step 1: pip3 install --upgrade google-cloud-language

# --------------------NOTES:------------------------------
# NOTE: 


# --------------------BUGS:------------------------------
# BUG: 



import io
import os
#import json
#import pandas as pd


# ----------Imports the Google Cloud client library----------
# Cloud Vision Library
from google.cloud import vision
# Natural Lanaguage Processing Libraries (NLP)
from google.cloud import language
from google.cloud.language import enums
from google.cloud.language import types


# ---------Load API Key to Access Google Cloud Platform----------
#***IMPORTANT: make sure JSON file for service account key name is correct & that it's inside the authPath directory
serviceKey = "CloudVision-sandbox-366681a0e85d.json"  
#print("Service Key= " + serviceKey)

with open(serviceKey, 'r') as myfile:
    json_authCred=myfile.read()
    # print(json_authCred)

os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = serviceKey
#print(os.environ["GOOGLE_APPLICATION_CREDENTIALS"])



# ---------CLOUD VISION API EXAMPLE---------

URLlink = "https://www.epiloglaser.com/resources/sample-club/images/baby-blocks/baby-blocks-thumb.jpg"

client = vision.ImageAnnotatorClient() # Instantiate a client to use the vision method 
image = vision.types.Image()
image.source.image_uri = URLlink

# Perform label detection on the image file
response = client.label_detection(image=image)
labels = response.label_annotations

for label in labels:
    labelList = []
    labelList = label.description
    print(labelList)



