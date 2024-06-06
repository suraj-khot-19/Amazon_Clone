import 'package:amazon/utils/exports.dart';

class addProductImage {
  Future<List<File>> filePicker() async {
    List<File> addImgList = [];
    try {
      var imageFiles = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
      );
      if (imageFiles != null && imageFiles.files.isNotEmpty) {
        for (int i = 0; i < imageFiles.files.length; i++) {
          addImgList.add(File(imageFiles.files[i].path!));
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return addImgList;
  }
}
