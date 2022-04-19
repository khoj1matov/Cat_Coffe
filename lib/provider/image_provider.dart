import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class ImgProvider extends ChangeNotifier {
  XFile? image;
  final _picker = ImagePicker();

  void getImageGallery() async {
    image = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    notifyListeners();
  }
}
