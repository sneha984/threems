// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
//
// class CropImage extends StatefulWidget {
//   const CropImage({Key? key}) : super(key: key);
//
//   @override
//   State<CropImage> createState() => _CropImageState();
// }
//
// class _CropImageState extends State<CropImage> {
//   String imagePath = "";
//   final picker = ImagePicker();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Image Picker & Image Cropper"),
//         backgroundColor: Colors.green[700],
//         centerTitle: true,
//       ),
//       body: Container(
//         child: Column(
//           children: [
//             Container(
//               padding: EdgeInsets.all(15),
//               width: double.infinity,
//               child: ElevatedButton(
//                 style: ButtonStyle(
//                   backgroundColor:
//                   MaterialStateProperty.all<Color>(Colors.green.shade700),
//                 ),
//                 onPressed: () async {
//                   final pickedFile =
//                   await picker.getImage(source: ImageSource.gallery);
//                   if (pickedFile != null) {
//                     CroppedFile? croppedFile = await ImageCropper().cropImage(
//                       sourcePath: pickedFile.path,
//                       aspectRatioPresets: [
//                         CropAspectRatioPreset.square,
//                         CropAspectRatioPreset.ratio3x2,
//                         CropAspectRatioPreset.original,
//                         CropAspectRatioPreset.ratio4x3,
//                         CropAspectRatioPreset.ratio16x9
//                       ],
//                       uiSettings: [
//                         AndroidUiSettings(
//                             toolbarTitle: 'Cropper',
//                             toolbarColor: Colors.deepOrange,
//                             toolbarWidgetColor: Colors.white,
//                             initAspectRatio: CropAspectRatioPreset.original,
//                             lockAspectRatio: false),
//                         IOSUiSettings(
//                           title: 'Cropper',
//                         ),
//                         WebUiSettings(
//                           context: context,
//                         ),
//                       ],
//                     );
//                     if (croppedFile != null){
//                       setState(() {
//                         imagePath = croppedFile.path;
//                       });
//                     }
//                   }
//                 },
//                 child: Text("Select Image"),
//               ),
//             ),
//             imagePath != ""
//                 ? Container(
//               padding: EdgeInsets.symmetric(horizontal: 15),
//               child: Image.file(File(imagePath)),
//             )
//                 : Container(),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  /// Variables
  late File imageFile;

  /// Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0XFF307777),
          title: Text("Image Cropper"),
        ),
        body: Container(
            child: imageFile == null
                ? Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(

                    onPressed: () {
                      _getFromGallery();
                    },
                    child: Text(
                      "PICK FROM GALLERY",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
                : Container(
              child: Image.file(
                imageFile,
                fit: BoxFit.cover,
              ),
            )));
  }

  /// Get from gallery
  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    _cropImage(pickedFile?.path);
  }

  /// Crop Image
  _cropImage(filePath) async {
    CroppedFile? croppedImage  = await ImageCropper().cropImage(
                      sourcePath: filePath.path,
                      aspectRatioPresets: [
                        CropAspectRatioPreset.square,
                        CropAspectRatioPreset.ratio3x2,
                        CropAspectRatioPreset.original,
                        CropAspectRatioPreset.ratio4x3,
                        CropAspectRatioPreset.ratio16x9
                      ],
                      uiSettings: [
                        AndroidUiSettings(
                            toolbarTitle: 'Cropper',
                            toolbarColor: Colors.deepOrange,
                            toolbarWidgetColor: Colors.white,
                            initAspectRatio: CropAspectRatioPreset.original,
                            lockAspectRatio: false),
                        IOSUiSettings(
                          title: 'Cropper',
                        ),
                        WebUiSettings(
                          context: context,
                        ),
                      ],
                    );
    if (croppedImage != null) {
      imageFile = croppedImage as File;
      setState(() {});
    }
  }
}