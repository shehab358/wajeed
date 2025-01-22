import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:developer';

class ImageFunctions {
  static Future<File?> galleryImage() async {
    PermissionStatus status;
    log('Requesting permission...');
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      log('Android SDK version: ${androidInfo.version.sdkInt}');
      if (androidInfo.version.sdkInt >= 33) {
        status = await Permission.photos.request();
      } else {
        status = await Permission.storage.request();
      }
    } else {
      status = await Permission.photos.request();
    }
    log('Permission status: $status');
    if (status.isGranted) {
      log('Permission granted. Picking image...');
      XFile? image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (image != null) {
        log('Image selected: ${image.path}');
        return File(image.path);
      } else {
        log('No image selected');
        return null;
      }
    } else {
      log('Permission denied');
      return null;
    }
  }
}