import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileSetupController extends GetxController {
  File? pickedImage;
  RxString imageDownloadLnk = RxString("");

  Future imagePicker() async {
    try {
      //pic Image from gallery
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;
      //get the image path & convert it in file type
      final tempImage = File(image.path);
      //store it
      pickedImage = tempImage;

      final storage = FirebaseStorage.instance.ref().child(
          "${DateTime.now().millisecondsSinceEpoch.toString()}_profilepicture");
      await storage.putFile(File(tempImage.path));

      imageDownloadLnk.value = await storage.getDownloadURL();
      update();
    } on SocketException catch (e) {
      Get.snackbar("Error", "No Internet Connection!");
      // ignore: avoid_print
      return print(e);
    } catch (e) {
      Get.snackbar("Error", "Unexpected Error");
      // ignore: avoid_print
      return print("Unexpected Error:$e");
    }
  }
}
