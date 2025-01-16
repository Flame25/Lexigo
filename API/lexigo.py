from supabase import create_client
from flask import Flask, request, jsonify
from flask_cors import CORS
from dotenv import load_dotenv
import requests
import base64
import os
import json

# Initialize Flask app
app = Flask(__name__)

CORS(app, origins=["*"])

# SUPABASE Setup

load_dotenv()

SUPABASE_URL = os.getenv("SUPABASE_URL")
SUPABASE_KEY = os.getenv("SUPABASE_KEY")

supabase = create_client(SUPABASE_URL, SUPABASE_KEY)

@app.route('/upload_image', methods=['POST'])
def upload_image():
    try:
        # Get the userId and base64 image string from the request
        data = request.json
        user_id = data.get('user_id')
        base64_image = data.get('image')

        if not user_id or not base64_image:
            return jsonify({"message": "userId and image are required"}), 400

        print("AAAA")

        # Decode the base64 string
        image_data = base64.b64decode(base64_image)

        # Create a filename (e.g., a unique ID or timestamp)
        file_name = f"{user_id}_image.jpg"


        # Save the image to a file on the server (optional step)
        image_path = f"./{file_name}"
        with open(image_path, "wb") as image_file:
            image_file.write(image_data)


        # Upload the image to Supabase Storage
        with open(image_path, "rb") as image_file:
            response_upload = supabase.storage.from_('user_profile_images').upload(f"images/{file_name}", image_file, {'upsert':'true'})

        if(not response_upload):
            return jsonify({"status": "Failed", "message": "Failed to Upload Images"})

        print("BBBB")

        # Get the image URL (from Supabase Storage)
        image_url = f"{SUPABASE_URL}/storage/v1/object/public/user_profile_images/images/{file_name}"

        # Check if the user already has an entry in the user_images table
        print(user_id)
        user_image_entry = supabase.table('user_data').select('*').eq('user_id', user_id).execute()

        if user_image_entry.data:  # If the entry exists, update the image URL
            supabase.table('user_data').update({
                "profile_images": image_url
            }).eq("user_id", user_id).execute()
            return jsonify({"Status": "Sucess", "message": "Image URL updated successfully", "image_url": image_url}), 200

    except Exception as e:
        print(e)
        return jsonify({"Status": "Failed", "message": "Failed to upload image"}), 400

@app.route("/user/update", methods=["POST"])
def update_account():
    """
    Input : user_id, JSON(user_info)
    """
    try:
        data = request.get_json()
        response = supabase.table("user_data").select("*").eq("user_id", data["user_id"]).execute()
        response_update = supabase.table('user_data').update({
            "username": data["username"],
            "password": data["password"],
            "email": data["email"]
        }).eq("user_id", data["user_id"]).execute()

        if(response_update.data):
            return jsonify({"Status": "Sucess", "message": "User account updated successfully"}), 200
        else:
            return jsonify({"Status": "Failed", "message": "Server error try again later"}), 200
    except Exception as e:
        print(e)
        return jsonify({"Status": "Failed", "message": "Failed to update user account"}), 400

@app.route("/auth/signup", methods= ["POST"])
def signup():
    try:
        data = request.get_json()
        if "username" not in data or data["username"] == "":
            return jsonify({"status": "Failed", "message": "Username is required"}),200
        if "password" not in data or data["password"] == "":
            return jsonify({"status": "Failed", "message": "Password is required"}),200
        if "email" not in data or data["email"] == "":
            return jsonify({"status": "Failed", "message": "Email is required"}), 200

        response = supabase.table("user_data").select("*").eq("username", data["username"]).execute()

        if response.data:
            return jsonify({"status": "Failed", "message": "Username found. Please Login!"}),200

        response = supabase.table("user_data").select("*").eq("email", data["email"]).execute()

        if response.data:
            return jsonify({"status": "Failed", "message": "Email found. Please Login!"}),200

        data_reg = {
            "username": data["username"],
            "password": data["password"],
            "email": data["email"]
        }

        response_register = supabase.table("user_data").insert(data_reg).execute()

        # Check the response
        if response_register.data:
            return jsonify({"status": "Success", "message": "Welcome"}), 200
        else:
            return jsonify({"status": "Failed", "message": "Try again later"}), 200
    except Exception as e:
        return jsonify({"status": "Failed", "message": f"{str(e)}"}), 200

@app.route("/auth/login", methods=["POST"])
def login():
    try:
        data = request.get_json()

        if "username" not in data:
            return jsonify({"status": "Failed", "message": "Username is required"}),200
        if "password" not in data:
            return jsonify({"status": "Failed", "message": "Password is required"}),200

        response = supabase.table("user_data").select("*").eq("username", data["username"]).execute()

        if not response.data:
            return jsonify({"status": "Failed", "message": "Username not found. Please register first!"}),200

        if response.data[0]["password"] != data["password"]:
            return jsonify({"status": "Failed", "message": "Wrong password"}),200

        # TODO: Add last login session in database
        return jsonify({"status": "Success", "user_id": response.data[0]["user_id"]}),200
    except Exception as e:
        return jsonify({"status": "Failed", "message": f"{str(e)}"}),400


@app.route("/user/profile", methods=["POST"])
def get_profile():
    try:
        data = request.get_json()

        if "user_id" not in data:
            return jsonify({"status": "Failed", "message": "User not recognized. Please login first"}),200

        response = supabase.table("user_data").select("*").eq("user_id", data["user_id"]).execute()

        if not response.data:
            return jsonify({"status": "Failed", "message": "User not recognized. Please register first"}),200

        return jsonify({"status": "Success", "user_info": response.data[0]}),200
    except Exception as e:
        return jsonify({"status": "Failed", "message": f"{str(e)}"}),400

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
