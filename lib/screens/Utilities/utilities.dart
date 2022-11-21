import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:threems/screens/splash_screen.dart';
import 'dart:io';

import '../../utils/themes.dart';

class Utilities extends StatefulWidget {
  const Utilities({Key? key}) : super(key: key);

  @override
  State<Utilities> createState() => _UtilitiesState();
}

class _UtilitiesState extends State<Utilities> {
  List _images = [];
  String? imgUrl;
  var imgFile;
  var uploadTask;
  var fileUrl;
  Future uploadImageToFirebase(BuildContext context) async {
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('deposits/${imgFile.path}');
    UploadTask uploadTask = firebaseStorageRef.putFile(imgFile);
    TaskSnapshot taskSnapshot = (await uploadTask);
    String value = await taskSnapshot.ref.getDownloadURL();

    // if(value!=null){
    //   imageList.add(value);
    // }
    setState(() {
      imgUrl = value;
    });
  }

  _pickImage() async {
    final imageFile =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    setState(() {
      _images.add(File(imageFile!.path));
      uploadImageToFirebase(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Container(
            height: 80,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount:
                    _images.length == 5 ? _images.length : _images.length + 1,
                itemBuilder: (context, index) {
                  return index == _images.length
                      ? InkWell(
                          onTap: () {
                            _pickImage();
                          },
                          child: Container(
                              height: scrHeight * 0.11,
                              width: scrWidth * 0.25,
                              decoration: BoxDecoration(
                                color: textFormFieldFillColor,
                                borderRadius:
                                    BorderRadius.circular(scrWidth * 0.04),
                              ),
                              child: Center(
                                  child: SvgPicture.asset(
                                      "assets/icons/bigcamera.svg"))),
                        )
                      : Container(
                          height: scrHeight * 0.11,
                          width: scrWidth * 0.25,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(_images[index]),
                                // FileImage(imgFile!) as ImageProvider,
                                fit: BoxFit.fill),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Color(0xffDADADA),
                            ),
                          ),
                        );
                }),
          ),
        ],
      ),
    );
  }
}
