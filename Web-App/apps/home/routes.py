
from twilio.rest import Client
import os, json, uuid
from flask import Flask, request, json ,jsonify
from apps.home import blueprint
from flask import render_template, request
from flask_login import login_required
from jinja2 import TemplateNotFound

import yagmail
from flask import Flask, request, json
from flask import render_template
from flask import Flask, render_template, request,json
from werkzeug.utils import secure_filename
import os
import base64
import requests
import json
import pandas as pd
import numpy as np

from deepface import DeepFace
from flask import Flask, render_template, request, url_for, redirect, flash, jsonify, make_response, url_for
from flask import send_file

UPLOAD_FOLDER = os.path.join(os.getcwd(),'apps','static', 'lostPeopleImage')

IMAGE_DB = os.path.join( os.getcwd(),'apps','static', 'lostPeopleImage')
# # Define allowed files
ALLOWED_EXTENSIONS = {'txt', 'pdf', 'png', 'jpg', 'jpeg', 'gif'}


def write_json(new_data,idLen, filename=str(os.path.join(os.getcwd(),'apps','home' , 'missingPerson.json'))  ):
    with open(filename,'r+') as file:
          # First we load existing data into a dict.
        file_data = json.load(file)
        
        file_data.update(new_data)

        print(file_data)

        # Sets file's current position at offset.
        file.seek(0)
        # convert back to json.
        json.dump(file_data, file, indent = 4)



@blueprint.route("/addrecord" , methods=['POST', 'GET'])
@login_required

#@app.route("/addrecord" , methods=['POST', 'GET'])
def addrecord():
    name =  request.form.get('name')
    description =  request.form.get('description')
  
    Height = request.form.get('Height')
    Missing_From = request.form.get('Missing_From')
    #sex = request.form.get('optionsRadios')
    sex = request.form['optionsRadios']
    categrorydata = request.form['Category']
    age = request.form.get('Age')
    image = request.form.get('image')
    uploaded_img = request.files['uploaded-file']

    street_address = request.form.get('street-address')
    zip = request.form.get('postal-code')
    city = request.form.get('city')
    country = request.form.get('street-address')
    mobile_Number =  request.form.get('mobile_number')
    emailid =  request.form.get('emailid')

    address_record = {
        "street_address" : street_address,
        "zip" : zip,
        "city" : city ,
        "country" : country

    }
    

        # Extracting uploaded data file name
    img_filename = secure_filename(uploaded_img.filename)
        # Upload file to database (defined uploaded folder in static path)
      
    
    print( )

    missingPersonDetails = open(os.path.join(os.getcwd(),'apps','home' , 'missingPerson.json'))
    ObjectsInFile = json.load(missingPersonDetails)
    values = ObjectsInFile.keys()
    print(values)
    idLen = len(values) + 1
    print(idLen)

    with open(os.path.join(os.getcwd(),'apps','static', 'lostPeopleImage' ,str(idLen) +".jpg"), "wb") as fp: 
        for itm in uploaded_img: 
            fp.write(itm) 
    #uploaded_img.save("C:\checkimages", )

    addToJson = { str(idLen) : {
        "name" :name,
        "description" : description,
        "Age" : age ,
        "Sex" : sex,
        "Missing_From" :Missing_From,
         "Height" : Height, 
         "imgPath" : "/static/lostPeopleImage/"+str(idLen) +".jpg",
        "MatchesFound" : "No",
        "address_record" : address_record,
        "Category":categrorydata,
        "Mobile_number" : mobile_Number,
        "email" : emailid

    }
  }

    write_json(addToJson,idLen)


    # valuesforUpdate = getMissingPersonDetails()
    missingPeopleStat = getmissingpeoplestat() 
    # return render_template('home/index2.html', segment='index2' , missingPeopleStat=missingPeopleStat)
    return redirect(url_for('home_blueprint.index'))



def read_json(filename=str(os.path.join(os.getcwd(),'apps','home' , 'missingPerson.json'))  ):
    file_data = None
    with open(filename,'r+') as file:
          # First we load existing data into a dict.
        file_data = json.load(file)
        
    
    return file_data



def recentusersregistered():
    
    file_data = read_json()
    valuesoffile = file_data.values()
    recentjoinedusers = []

    for i in range(len(valuesoffile),len(valuesoffile)-5,-1):
        recentjoinedusers.append(file_data[str(i)])


    


     
    return recentjoinedusers

def updateFoundPersonData(id_image):
    
    fileData= read_json()

    fileData[id_image]["MatchesFound"] = "Yes"
    filename = "missingPerson.json"
    tempfile = os.path.join(os.getcwd(),"apps","home" ,"missingPerson.json" )
    print(tempfile)
    with open(tempfile, 'w') as f:
        json.dump(fileData, f, indent=4)
    
    #os.rename(os.path.join(os.getcwd(),"apps","home" ,"missingPersontemp.json" ) , os.path.join(os.getcwd(),"apps","home" ,"missingPerson.json" ))


    return

def getmissingpeoplestat():

    getUpdatedFileData = read_json()
    reportedUsers = int(len(getUpdatedFileData.keys()))

    print(getUpdatedFileData)

    foundPeopleCount = 0

    for i in getUpdatedFileData:
        print(i)

        if getUpdatedFileData[i]["MatchesFound"] == "Yes":
            foundPeopleCount = foundPeopleCount+1
            
    

    missingPeopleStat = {

        "reported_people" : str(reportedUsers),
        "found_users" : str(foundPeopleCount),
        "lost_users" : str(int(reportedUsers) - int(foundPeopleCount))
    }

    #print(missingPeopleStat)

    return missingPeopleStat



# @blueprint.route('/index')
# @login_required
# def index():

#     return render_template('home/index.html', segment='index')

@blueprint.route('/index')
@login_required
def index():

    missingPeopleStat = getmissingpeoplestat() 
    recentuser = recentusersregistered()
    print(recentuser)
    

  


    return render_template('home/index.html', segment='index' , recentusersregistered=recentuser, missingPeopleStat=missingPeopleStat)


@blueprint.route('/informationData')
@login_required
def informationData():

    missingPeopeleData = read_json() 

    renderDataStrcuture = missingPeopeleData.values()
    


    

  


    return render_template('home/informationData.html', segment='informationData' , missingPeopleData=renderDataStrcuture)

def checkInImageDB():
    # result = DeepFace.verify(img1_path = "img20.jpg", img2_path = "img21.jpg")
    # print(result)
    models = [
  "VGG-Face", 
  "Facenet", 
  "Facenet512", 
  "OpenFace", 
  "DeepFace", 
  "DeepID", 
  "ArcFace", 
  "Dlib", 
  "SFace",
]

# #face verification
#     result = DeepFace.verify(img1_path = "img20.jpg", 
#       img2_path = "img21.jpg", 
#       model_name = models[1]
# )

# #face recognition
    os.remove(os.path.join(os.getcwd(),"apps" ,"static","lostPeopleImage","representations_facenet.pkl"))
    df = DeepFace.find(img_path = os.path.join(os.getcwd(),'apps','static', 'reportedPeople','input.jpg'),db_path =os.path.join(os.getcwd(),'apps','static', 'lostPeopleImage'),model_name = models[1])

    dictionary = None
    for i in df :
        print(type(i))
        dictionary = i.to_dict(orient="index")
        print(dictionary)
     

    return  dictionary

def updateFoundUserMsg(id_image,address,aloneStatus,image,contact):

    fileData= read_json()

    PersonDetails = fileData[id_image]
    ''' {
        "Age": "23",
        "Height": "179",
        "MatchesFound": "No",
        "Missing_From": "2023-02-10",
        "Sex": "male",
        "address_record": {
            "city": "Pune",
            "country": "B801 , Celestial City Phase I",
            "street_address": "B801 , Celestial City Phase I",
            "zip": "411044"
        },
        "description": "B801 , Celestial City Phase I",
        "imgPath": "/static/lostPeopleImage/1.jpg",
        "name": "Rushikesh Bhandare"
    }'''
    account_sid = 'AC02eba941155f14b587867a0f0f765e92'
    auth_token = '0acdd8761156dbb42c1763fa071b6a34'
    client = Client(account_sid, auth_token)
    imagePath = os.path.join( os.getcwd(),'apps','static', 'lostPeopleImage',str(id_image)+ ".jpg" )
    
    print( PersonDetails)
    from_whatsapp_number = 'whatsapp:+14155238886'
    to_whatsapp_number = "whatsapp:+91"+str(PersonDetails["Mobile_number"])
    print(from_whatsapp_number , "to" ,to_whatsapp_number)
    imageP = "https://d073-2409-40c2-1037-da64-29e6-e64d-6279-ba6d.in.ngrok.io/getimagere?id="+str(id_image)+".jpg" 
    print(imageP)

    msgBody = "*Missing Person Found !*\n\nProbable Sighting of the Missing Person with the following details was reported at the following Location\n\n Name : " + str(PersonDetails["name"]) + "\nLost on Date : " + str(PersonDetails["Missing_From"]) + "\nSighting Location : " + address + "\nReporting Person Number : " + contact +"\nImage Link : - "+ imageP+"\nRequest you to reach the sighting location as soon as possible"
    print(msgBody)
    message = client.messages.create(body=msgBody,
                       
                       from_=from_whatsapp_number,
                       to=to_whatsapp_number)
    print(message.sid)


    user = 'erenyaeger0711@gmail.com'
    app_password = 'lddmhuvcbadaehfh' # a token for gmail
    to = PersonDetails["email"]

    subject = 'Missing Person ' + str(PersonDetails["name"]) + " Found !"
    content = [msgBody]

    with yagmail.SMTP(user, app_password) as yag:
        yag.send(to, subject, content)
        print('Email Sent Successfully')


    return

@blueprint.route('/report_sighting', methods=['POST'])

def report_desc():

    fileData = read_json()

    if request.method == 'POST':
        request_data = request.get_json()
        aloneStatus = None
        address = None
        contact = None
        image = None

        if "address" in request_data:
            address = request_data["address"]
        else:
            return jsonify(
                status="error",
                message="address must be provided",
            )
        if "aloneStatus" in request_data:
            aloneStatus = request_data["aloneStatus"]
        else:
            return jsonify(
                status="error",
                message="alone status must be provided",
            )
        if "contact" in request_data:
            contact = request_data["contact"]

        if "image" in request_data:
            # try:
            image = request_data["image"]
            image = base64.b64decode(image)

            filename = os.path.join(os.getcwd(),'apps','static', 'reportedPeople','input.jpg')  # I assume you have a way of picking unique filenames

            with open(filename, 'wb') as f:
                f.write(image)

            print(filename)

        processedResult = checkInImageDB()
        print(processedResult)


        if int(len(processedResult)) == 0 :

            return jsonify(status="error", message="No face detected")

        baseLogicalPath = processedResult[0]["identity"]
        print("Base logical Path ",baseLogicalPath)
        slashRemoval  = baseLogicalPath.replace("/","")
        print("Base slashRemoval Path ",slashRemoval)
        fslashRemoval = slashRemoval.replace("\\","")
        print("Base fslashRemoval Path ",fslashRemoval)


        file_name = fslashRemoval.split("staticlostPeopleImage")[1]
        print("Base file_name Path ",file_name)

        id_image = str(os.path.splitext(file_name)[0])
        print("Base id_image Path ",id_image)

        with open(os.path.join( os.getcwd(),'apps','static', 'lostPeopleImage',str(id_image)+ ".jpg" ) , "rb") as img_file:
            image_64_encode = base64.b64encode(img_file.read())
            image_64_encode = str(image_64_encode)[2:-1]     

        missingChild = {
                "Name" :fileData[id_image]["name"],
                "Age" : fileData[id_image]["Age"],
                "Sex" : fileData[id_image]["Sex"],
                "Missing_date" :fileData[id_image]["Missing_From"],
                "Missing_From" : fileData[id_image]["Missing_From"]

                
            }

        updateFoundPersonData(id_image)

        updateFoundUserMsg(id_image,address,aloneStatus,image,contact)      

        return jsonify(
                status="success",
                message="Face detected",
                image=str(image_64_encode),
                match_percent="80",
                missing_child=missingChild
               
            )    

  

@blueprint.route("/viewrecords" , methods=['POST', 'GET'])

#@app.route("/addrecord" , methods=['POST', 'GET'])
def viewrecords():

    fileData= read_json()
    listData =[]
    for key, value in fileData.items():
        print(key, value)
        value["id"] = str(key)
        listData.append(value)

   

    return jsonify(listData)


@blueprint.route("/getimage" , methods=['POST', 'GET'])

#@app.route("/addrecord" , methods=['POST', 'GET'])
def getimage():

    request_data = request.args.get("id")
    print(request_data)
    filename="C:\\Project\\flask-atlantis-dark-master_Email\\apps\\static\\lostPeopleImage\\"+request_data+".jpg"

    return send_file(filename, mimetype='image/gif')

    


@blueprint.route("/getimagere" , methods=['POST', 'GET'])

#@app.route("/addrecord" , methods=['POST', 'GET'])
def getimagere():

    request_data = request.args.get("id")
    print(request_data)
    filename="C:\\Project\\flask-atlantis-dark-master_Email\\apps\\static\\lostPeopleImage\\"+request_data

    return send_file(filename, mimetype='image/gif')

    


@blueprint.route('/<template>')
@login_required
def route_template(template):

    try:

        if not template.endswith('.html'):
            template += '.html'

        # Detect the current page
        segment = get_segment(request)

        # Serve the file (if exists) from app/templates/home/FILE.html
        return render_template("home/" + template, segment=segment)

    except TemplateNotFound:
        return render_template('home/page-404.html'), 404

    except:
        return render_template('home/page-500.html'), 500


# Helper - Extract current page name from request
def get_segment(request):

    try:

        segment = request.path.split('/')[-1]

        if segment == '':
            segment = 'index'

        return segment

    except:
        return None
