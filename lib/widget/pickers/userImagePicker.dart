//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserImagePicker extends StatefulWidget {
  final void Function(File imageChoisie) imagePickFn;
  UserImagePicker(
    this.imagePickFn,
  );
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _imageChoisie;

  void _choixImage() async {
    final fichierImageChoisie = await ImagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );

    setState(() {
      _imageChoisie = fichierImageChoisie;
    });
    widget.imagePickFn(fichierImageChoisie);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey,
          backgroundImage:
              _imageChoisie != null ? FileImage(_imageChoisie) : null,
        ),
        FlatButton.icon(
          textColor: Theme.of(context).primaryColor,
          onPressed: _choixImage,
          icon: Icon(Icons.add_photo_alternate),
          label: Text('Add Image'),
        ),
      ],
    );
  }
}
