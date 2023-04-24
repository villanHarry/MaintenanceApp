import '../Constants/AppImports.dart';

class AppImageHandler {
  AppImageHandler._();

  static Future<File> getImage(BuildContext context, ImageSource value) async {
    late String filepath = "";
    final picker = ImagePicker();
    File? file;
    final pickedFile = await picker.getImage(source: value);
    if (pickedFile != null) {
      filepath = pickedFile.path;
    } else {
      filepath = "";
      AppNavigation.showSnackBar(
          context: context, content: "No image selected");
    }
    file = File(filepath);
    return file;
  }

  static Future<String> generate(BuildContext context, File file) async {
    final cloudinary = CloudinaryPublic(
      'dioqlku8g',
      'cvnze0fz',
    );

    late String url = "";

    try {
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(file.path,
            resourceType: CloudinaryResourceType.Image, folder: "uploads"),
      );

      url = response.secureUrl;
      return url;
    } on CloudinaryException catch (e) {
      AppNavigation.showSnackBar(context: context, content: e.message!);
      return url;
    }
  }
}
