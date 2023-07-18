
import os
from deepface import DeepFace

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
    print(os.getcwd())
# #face verification
#     result = DeepFace.verify(img1_path = "img20.jpg", 
#       img2_path = "img21.jpg", 
#       model_name = models[1]
# )

# #face recognition
    df = DeepFace.find(img_path = os.path.join(os.getcwd(),'apps','static', 'reportedPeople','input.jpg'),db_path =os.path.join(os.getcwd(),'apps','static', 'lostPeopleImage'),model_name = models[1])
    #print(df)
#embeddings
    #embedding = DeepFace.represent(img_path = "img20.jpg", model_name = models[1])
    
    #print(type(df))

    for i in df :
        print(type(i))
        dictionary = i.to_dict(orient="index")
        print(dictionary[0]["identity"])
     
    




checkInImageDB()