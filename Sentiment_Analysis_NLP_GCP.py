# --------------------STEPS:------------------------------
# Activate Google Cloud Platform account
# pip3 install --upgrade google-cloud-language
# Enable NLP API:
#    -> https://console.cloud.google.com/apis/library/language.googleapis.com?q=natural&id=223648f2-2e7c-4acd-b0ca-782f9021a541&project=ardent-oven-253616
#
#
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
# from google.cloud import vision
# Natural Lanaguage Processing Libraries (NLP)
from google.cloud import language
from google.cloud.language import enums
from google.cloud.language import types


def apiAccess():
    # ---------Load API Key to Access Google Cloud Platform----------
    #***IMPORTANT: make sure JSON file for service account key name is correct & that it's inside the authPath directory
    #serviceKey = "CloudVision-sandbox-366681a0e85d.json"  # Cloud Vision key
    #print("Service Key= " + serviceKey)
    serviceKey = "debias-253616-2ce80c5caea0.json" # NLP key
    with open(serviceKey, 'r') as myfile:
        json_authCred=myfile.read()
        # print(json_authCred)
    os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = serviceKey
    # print(os.environ["GOOGLE_APPLICATION_CREDENTIALS"])


# ------------NATURAL LANGUAGE API EXAMPLE-----------
def nlpSentimentExample():
    # Instantiates a client
    client = language.LanguageServiceClient()

    # The text to analyze
    text = u'Hello, world!'
    document = types.Document(
        content=text,
        type=enums.Document.Type.PLAIN_TEXT)

    # Detects the sentiment of the text
    sentiment = client.analyze_sentiment(document=document).document_sentiment

    print('Text: {}'.format(text))
    print('Sentiment: {}, {}'.format(sentiment.score, sentiment.magnitude))



if __name__ == '__main__':
    apiAccess()
    nlpSentimentExample()



# ------------CLOUD VISION API EXAMPLE-----------

""" URLlink = "https://www.epiloglaser.com/resources/sample-club/images/baby-blocks/baby-blocks-thumb.jpg"

client = vision.ImageAnnotatorClient() # Instantiate a client to use the vision method 
image = vision.types.Image()
image.source.image_uri = URLlink

# Perform label detection on the image file
response = client.label_detection(image=image)
labels = response.label_annotations

for label in labels:
    labelList = []
    labelList = label.description
    print(labelList) """



