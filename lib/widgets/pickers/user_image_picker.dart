import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {

  final void Function(File pickedImage) imagePickFn;

   UserImagePicker(this.imagePickFn) ;

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage;
  final ImagePicker _picker = ImagePicker();

  void _pickImage(ImageSource src) async {
    final pickedImageFile = await _picker.getImage(source: src,imageQuality: 50,maxWidth: 150);

    if (pickedImageFile != null) {
      setState(() {
        _pickedImage = File(pickedImageFile.path);
      });

      widget.imagePickFn(_pickedImage);

    } else {
      print('no image selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey,
          child: _pickedImage == null
              ? Icon(
                  Icons.camera_alt_outlined,
                  size: 50,
                )
              : null,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage) : null,
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FlatButton.icon(
              onPressed: () => _pickImage(ImageSource.camera),
              textColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.photo_camera_outlined),
              label: Text(
                'Add image \nfrom camera',
                textAlign: TextAlign.center,
              ),
            ),
            FlatButton.icon(
              onPressed: () => _pickImage(ImageSource.gallery),
              textColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.image_outlined),
              label: Text(
                'Add image \nfrom gallery',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        )
      ],
    );
  }
}
