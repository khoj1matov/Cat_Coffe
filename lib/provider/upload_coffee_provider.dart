import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireapp3/service/firebase_servoce.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UploadCoffeeProvider extends ChangeNotifier {
  Future uploadToDB(name, price, context) async {
    await FireService.store.collection('coffee').doc(name).set(
      {
        "name": name,
        "price": price,
        "img_url": "",
        "create_at": FieldValue.serverTimestamp(),
      },
    );
    Navigator.pop(context);
  }

  Future uploadImageToStorage(XFile file, name) async {
    var image = FireService.storage
        .ref()
        .child("coffee")
        .child("images")
        .child(name)
        .putFile(File(file.path));

    String downloadURL = await image.storage.ref().getDownloadURL();
    await FireService.store.collection("coffee").doc(name).set(
      {"img_url": downloadURL},
      SetOptions(
        merge: true,
      ),
    );
  }
}
