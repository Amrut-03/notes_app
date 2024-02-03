import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class demo extends StatefulWidget {
  @override
  _demoState createState() => _demoState();
}

class _demoState extends State<demo> {
  File? _image;

  // Function to open the image picker and select an image
  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _setProfilePhoto() {
    // Implement your logic to save or use the selected image
    // For example, you can upload it to a server or save it locally.
    // You can also update the UI to display the profile photo.
    // For now, let's just print the file path.
    if (_image != null) {
      print("Selected image path: ${_image!.path}");
    } else {
      print("No image selected");
    }
  }

  // ... (rest of the code remains the same)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: _getImage,
              child: CircleAvatar(
                radius: 60,
                backgroundImage: _image != null ? FileImage(_image!) : null,
                child: _image == null
                    ? Icon(
                  Icons.camera_alt,
                  size: 40,
                )
                    : null,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _setProfilePhoto,
              child: Text("Set as Profile Photo"),
            ),
          ],
        ),
      ),
    );
  }

// ... (rest of the code remains the same)
}
