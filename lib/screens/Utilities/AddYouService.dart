import 'dart:io';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:threems/Authentication/root.dart';

import '../../model/servicesModel.dart';
import '../../utils/themes.dart';
import '../charity/verification_details.dart';
import '../splash_screen.dart';
import 'details.dart';
class AddServicePage extends StatefulWidget {
  final String subCategoryName;
  final String Category;
  final ServiceDetails? serviceItems;
  const AddServicePage({Key? key, this.serviceItems, required this.subCategoryName, required this.Category, }) : super(key: key);

  @override
  State<AddServicePage> createState() => _AddServicePageState();
}

class _AddServicePageState extends State<AddServicePage>  with TickerProviderStateMixin{
  ServiceDetails? serviceItems;
  Stream<List<ServiceDetails>>getServices() => FirebaseFirestore.instance
      .collection('services').where('userId',isEqualTo: currentuserid).
      where('serviceCategory',isEqualTo: widget.Category.toString()).
       where('subCategory',isEqualTo:widget.subCategoryName).
      snapshots()
      .map((snapshot)=>
      snapshot.docs.map((doc) => ServiceDetails.fromJson(doc.data()) ).toList());

  bool photo = false;
  String imgUrl='';
  String catgoryId='';
  late File imgFile;
  Map<String,dynamic>categoryIdByName={};
  List<String> serviceCategory=[""];
  List<String> serviceSubCategory=[""];
  List<String> serviceUnit=[""];
  List<String> serviceCity=[""];
  String selectedCategory='';
  String selectedCategory1='';
  String selectedSubCategory='';
  String selectedUnit='';
  String selectedCity='';
  String selectedCity2='';

  String fileName = '';
  String fileUrl = '';
  // late File pickFile;
  UploadTask ?uploadTask;
  PlatformFile ?pickFile;
  Future uploadFileToFireBase(fileBytes) async {
    print(fileBytes);
    uploadTask= FirebaseStorage.instance.ref('uploads/${DateTime.now()}').putData(fileBytes);
    final snapshot= await  uploadTask?.whenComplete((){});

    final urlDownlod = await  snapshot?.ref.getDownloadURL();

    print(urlDownlod);

    // FirebaseFirestore.instance.collection('candidates').doc(widget.id).update({
    //   'documents.$name':urlDownlod,
    // });

    showUploadMessage(context, ' Uploaded Successfully...');


    setState(() {
      fileUrl=urlDownlod!;

    });

  }
  _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      withData: true,
    );

    if(result==null) return;

    pickFile=result.files.first;
    final fileBytes = pickFile!.bytes;
    fileName = result.files.first.name;

    showUploadMessage(context, 'Uploading...',showLoading: true);

    // print("File1234");
    // print(pickFile);
    // print(fileBytes);
    uploadFileToFireBase(fileBytes);
    setState(() {

    });


  }
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
      showUploadMessage(context, 'Upload Success',
      );
    });
  }
  _pickImage() async {
    final imageFile = await ImagePicker.platform.pickImage(
        source: ImageSource.gallery);
    setState(() {
      imgFile = File(imageFile!.path);
      uploadImageToFirebase(context);
      showUploadMessage(context, 'Uploading', showLoading: true,);
    });
  }
  getServiceCategory(){
    FirebaseFirestore.instance.collection('serviceCategory').snapshots().listen((event) {
      for(DocumentSnapshot doc in event.docs){
        serviceCategory.add(doc.get('serviceCategory'));
        categoryIdByName[doc.get('serviceCategory')]=doc.get('categoryId');
      }

      if(mounted){
        setState(() {

        });
      }
    });

  }

  getServiceUnit(){
    FirebaseFirestore.instance.collection('serviceUnit').snapshots().listen((event) {
      for(DocumentSnapshot doc in event.docs){
        serviceUnit.add(doc.get('unit'));
      }
      if(mounted){
        setState(() {

        });
      }
    });

  }

  getServiceCity(){
    FirebaseFirestore.instance.collection('serviceCity').snapshots().listen((event) {
      for(DocumentSnapshot doc in event.docs){
        serviceCity.add(doc.get('serviceCity'));
      }
      if(mounted){
        setState(() {

        });
      }
    });

  }

  getSubCategories(){
    FirebaseFirestore.instance.collection('serviceCategory').doc(catgoryId).
    snapshots().listen((event) {
      for(var a in event.get('subCategory')){
        serviceSubCategory.add(a['sub']);
        print(serviceSubCategory);
      }
      if(mounted){
        setState(() {

        });
      }
    }
    );

  }
  TabController? _tabController;
  TextEditingController? name;
  TextEditingController? phoneNumber;
  TextEditingController? email;
  TextEditingController? whatsappNumber;
  TextEditingController? address;
  TextEditingController? sevicesProvided;
  TextEditingController? aboutService;
  // TextEditingController? city;
  TextEditingController? userId;
  TextEditingController? wage;
  TextEditingController category = TextEditingController(text: '');
  TextEditingController subCategory = TextEditingController(text: '');
  TextEditingController category2 = TextEditingController(text: '');
  TextEditingController unit = TextEditingController(text: '');
  TextEditingController city = TextEditingController(text: '');
  TextEditingController city2 = TextEditingController(text: '');
  @override
  void initState() {
    serviceItems=widget.serviceItems;
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);

    getServiceCategory();
    getServiceUnit();
    getServiceCity();
    controller.stream.listen((event) {
      setState(() {

      });
      //   calculate();
    });


    // TODO: implement initState
    name = TextEditingController(text:serviceItems?.name??'');
    // category = TextEditingController(text:serviceItems?.serviceCategory??'');
    // subCategory = TextEditingController(text:serviceItems?.subCategory??'');
    phoneNumber = TextEditingController(text:serviceItems?.phoneNumber??'');
    email = TextEditingController(text:serviceItems?.emailId??'');
    whatsappNumber = TextEditingController(text:serviceItems?.whatsappNo??'');
    category = TextEditingController(text:widget.Category??'');
    subCategory = TextEditingController(text:widget.subCategoryName??'');
    address = TextEditingController(text:serviceItems?.address??'');
    // city = TextEditingController(text:'');
    userId = TextEditingController(text:serviceItems?.userId??'');
    wage = TextEditingController(text:serviceItems?.wage!.toString()??'');


    sevicesProvided = TextEditingController(text:serviceItems?.servicesProvided.toString()??'');
    aboutService = TextEditingController(text:serviceItems?.aboutService.toString()??'');

    selectedCategory=widget.Category??'';
    selectedSubCategory=widget.subCategoryName??'';
    selectedUnit=serviceItems?.serviceUnit??'';
    selectedCity=serviceItems?.city??'';
    imgUrl=serviceItems?.image??'';
    fileUrl=serviceItems?.documents??'';
    fileName=serviceItems?.documents??'';

  }
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.close();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: primarycolor,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        title: Text('Add new service',
          style: GoogleFonts.urbanist(
            color: primarycolor,
            fontWeight: FontWeight.w600,
            fontSize: FontSize17,
          ),),
        // bottom: TabBar(
        //     unselectedLabelColor: primarycolor,
        //     indicatorSize: TabBarIndicatorSize.label,
        //     indicator: BoxDecoration(
        //         borderRadius: BorderRadius.circular(50),
        //         color: primarycolor),
        //     tabs: [
        //       Tab(
        //         child: Container(
        //           decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(50),
        //               border: Border.all(color: primarycolor, width: 1)),
        //           child: Align(
        //             alignment: Alignment.center,
        //             child: Text("Add"),
        //           ),
        //         ),
        //       ),
        //       Tab(
        //         child: Container(
        //           decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(50),
        //               border: Border.all(color:primarycolor, width: 1)),
        //           child: Align(
        //             alignment: Alignment.center,
        //             child: Text("Edit"),
        //           ),
        //         ),
        //       ),
        //
        //     ]),
      ),
      body:Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: scrWidth * 0.035, right: scrWidth * 0.035,top: scrWidth * 0.03),
            child: Container(
              height: scrHeight * 0.05,
              decoration: BoxDecoration(
                color: primarycolor,
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
              ),
              child: TabBar(
                controller: _tabController,
                // give the indicator a decoration (color and border radius)
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                  color: Color(0xff02B558),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white,
                tabs: [
                  Text("Create your Service", style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: scrWidth*0.03,
                      fontWeight: FontWeight.w700
                  ),),
                  Text("Edit your Service", style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize:scrWidth*0.03 ,
                      fontWeight: FontWeight.w700
                  ),),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
                controller: _tabController,
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: scrWidth * 0.08,
                          ),
                          Container(
                            width: scrWidth,
                            height: textFormFieldHeight45,
                            padding: EdgeInsets.symmetric(
                              horizontal: scrWidth * 0.015,
                              vertical:scrHeight*0.002,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xffDADADA),
                              ),
                              color: textFormFieldFillColor,
                              borderRadius: BorderRadius.circular(scrWidth * 0.026),
                            ),
                            child:  TextFormField(
                              controller:  name,
                              cursorHeight: scrWidth * 0.055,
                              cursorWidth: 1,
                              cursorColor: Colors.black,
                              style: GoogleFonts.urbanist(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: FontSize15,
                              ),
                              keyboardType: TextInputType.text,
                              decoration:  InputDecoration(
                                labelText: 'Enter name',
                                labelStyle: TextStyle(
                                  color: textFormUnFocusColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: FontSize15,
                                  fontFamily: 'Urbanist',
                                ),
                                fillColor: textFormFieldFillColor,
                                filled: true,
                                contentPadding: EdgeInsets.only(
                                    left: scrWidth*0.03, top: scrHeight*0.006, bottom: scrWidth * 0.02),
                                disabledBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                border: InputBorder.none,
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: primarycolor,
                                    width: 2,
                                  ),
                                ),

                                floatingLabelStyle: TextStyle(
                                    color:primarycolor),
                                focusColor: Color(0xff034a82),
                                // border: OutlineInputBorder(),
                                // focusedBorder: OutlineInputBorder(
                                //     borderSide: BorderSide(color: Color(0xff034a82),width: 2)
                                // ),
                              ),
                            ),

                          ),
                          SizedBox(
                            height: scrWidth * 0.04,
                          ),
                          TextFormField(
                            autovalidateMode: AutovalidateMode.always,
                            keyboardType: TextInputType.emailAddress,
                            validator: (email) {
                              if (email!.isEmpty) {
                                return "";
                              } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                                  .hasMatch(email)) {
                                return "Email not valid";
                              } else {
                                return null;
                              }
                            },
                            controller:  email,
                            cursorHeight: scrWidth * 0.055,
                            cursorWidth: 1,
                            cursorColor: Colors.black,
                            style: GoogleFonts.urbanist(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: FontSize15,
                            ),
                            decoration:  InputDecoration(
                              labelText: 'Enter emailId',
                              labelStyle: TextStyle(
                                color: textFormUnFocusColor,
                                fontWeight: FontWeight.w500,
                                fontSize: FontSize15,
                                fontFamily: 'Urbanist',
                              ),
                              fillColor: textFormFieldFillColor,
                              filled: true,
                              contentPadding: EdgeInsets.only(
                                  left: scrWidth*0.03, top: scrHeight*0.006, bottom: scrWidth * 0.02),
                              disabledBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              border: InputBorder.none,
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: primarycolor,
                                  width: 2,
                                ),
                              ),

                              floatingLabelStyle: TextStyle(
                                  color:primarycolor),
                              focusColor: Color(0xff034a82),
                              // border: OutlineInputBorder(),
                              // focusedBorder: OutlineInputBorder(
                              //     borderSide: BorderSide(color: Color(0xff034a82),width: 2)
                              // ),
                            ),
                          ),
                          SizedBox(
                            height: scrWidth * 0.03,
                          ),
                          TextFormField(
                            autovalidateMode: AutovalidateMode.always,
                            keyboardType: TextInputType.phone,
                            validator: (phno) {
                              if (phno!.isEmpty) {
                                return "";
                              } else if (phoneNumber?.text.length!=10)
                              {
                                return "Number is not valid";
                              } else {
                                return null;
                              }
                            },
                            controller:  phoneNumber,
                            cursorHeight: scrWidth * 0.055,
                            cursorWidth: 1,
                            cursorColor: Colors.black,
                            style: GoogleFonts.urbanist(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: FontSize15,
                            ),
                            decoration:  InputDecoration(
                              labelText: 'Enter phone Number',
                              labelStyle: TextStyle(
                                color: textFormUnFocusColor,
                                fontWeight: FontWeight.w500,
                                fontSize: FontSize15,
                                fontFamily: 'Urbanist',
                              ),
                              fillColor: textFormFieldFillColor,
                              filled: true,
                              contentPadding: EdgeInsets.only(
                                  left: scrWidth*0.03, top: scrHeight*0.006, bottom: scrWidth * 0.02),
                              disabledBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              border: InputBorder.none,
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: primarycolor,
                                  width: 2,
                                ),
                              ),

                              floatingLabelStyle: TextStyle(
                                  color:primarycolor),
                              focusColor: Color(0xff034a82),
                              // border: OutlineInputBorder(),
                              // focusedBorder: OutlineInputBorder(
                              //     borderSide: BorderSide(color: Color(0xff034a82),width: 2)
                              // ),
                            ),
                          ),
                          SizedBox(
                            height: scrWidth * 0.03,
                          ),
                          TextFormField(
                            autovalidateMode: AutovalidateMode.always,
                            keyboardType: TextInputType.phone,
                            validator: (phno) {
                              if (phno!.isEmpty) {
                                return "";
                              } else if (whatsappNumber?.text.length!=10)
                              {
                                return "Number is not valid";
                              } else {
                                return null;
                              }
                            },
                            controller:  whatsappNumber,
                            cursorHeight: scrWidth * 0.055,
                            cursorWidth: 1,
                            cursorColor: Colors.black,
                            style: GoogleFonts.urbanist(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: FontSize15,
                            ),
                            decoration:  InputDecoration(
                              labelText: 'Enter whatsapp Number',
                              labelStyle: TextStyle(
                                color: textFormUnFocusColor,
                                fontWeight: FontWeight.w500,
                                fontSize: FontSize15,
                                fontFamily: 'Urbanist',
                              ),
                              fillColor: textFormFieldFillColor,
                              filled: true,
                              contentPadding: EdgeInsets.only(
                                  left: scrWidth*0.03, top: scrHeight*0.006, bottom: scrWidth * 0.02),
                              disabledBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              border: InputBorder.none,
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: primarycolor,
                                  width: 2,
                                ),
                              ),

                              floatingLabelStyle: TextStyle(
                                  color:primarycolor),
                              focusColor: Color(0xff034a82),
                              // border: OutlineInputBorder(),
                              // focusedBorder: OutlineInputBorder(
                              //     borderSide: BorderSide(color: Color(0xff034a82),width: 2)
                              // ),
                            ),
                          ),
                          SizedBox(
                            height: scrWidth * 0.03,
                          ),
                          Container(
                            width: scrWidth,
                            height: textFormFieldHeight45,
                            padding: EdgeInsets.symmetric(
                              horizontal: scrWidth * 0.015,
                              vertical:scrHeight*0.002,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xffDADADA),
                              ),
                              color: textFormFieldFillColor,
                              borderRadius: BorderRadius.circular(scrWidth * 0.026),
                            ),
                            child:  TextFormField(
                              controller:  address,
                              cursorHeight: scrWidth * 0.055,
                              cursorWidth: 1,
                              cursorColor: Colors.black,
                              style: GoogleFonts.urbanist(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: FontSize15,
                              ),
                              keyboardType: TextInputType.text,
                              decoration:  InputDecoration(
                                labelText: 'Enter address',
                                labelStyle: TextStyle(
                                  color: textFormUnFocusColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: FontSize15,
                                  fontFamily: 'Urbanist',
                                ),
                                fillColor: textFormFieldFillColor,
                                filled: true,
                                contentPadding: EdgeInsets.only(
                                    left: scrWidth*0.03, top: scrHeight*0.006, bottom: scrWidth * 0.02),
                                disabledBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                border: InputBorder.none,
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: primarycolor,
                                    width: 2,
                                  ),
                                ),

                                floatingLabelStyle: TextStyle(
                                    color:primarycolor),
                                focusColor: Color(0xff034a82),
                                // border: OutlineInputBorder(),
                                // focusedBorder: OutlineInputBorder(
                                //     borderSide: BorderSide(color: Color(0xff034a82),width: 2)
                                // ),
                              ),
                            ),

                          ),
                          SizedBox(
                            height: scrWidth * 0.04,
                          ),
                          Container( width: scrWidth,
                            height: textFormFieldHeight45,
                            padding: EdgeInsets.symmetric(
                              horizontal: scrWidth * 0.015,
                              vertical: scrWidth*0.002,                ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xffDADADA),
                              ),
                              color: textFormFieldFillColor,
                              borderRadius: BorderRadius.circular(scrWidth * 0.026),
                            ),

                            child:
                            CustomDropdown.search(
                              hintText: selectedCity == '' ?'Select City ' : selectedCity,
                              items: serviceCity,
                              controller: city,
                              excludeSelected: false,
                              onChanged: (value){
                                selectedCity=value;
                                // print( userMap[selectedUser]);
                              },
                            ),
                          ),
                          SizedBox(
                            height: scrWidth * 0.04,
                          ),
                          Container( width: scrWidth,
                            height: textFormFieldHeight45,
                            padding: EdgeInsets.symmetric(
                              horizontal: scrWidth * 0.015,
                              vertical: scrWidth*0.002,                ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xffDADADA),
                              ),
                              color: textFormFieldFillColor,
                              borderRadius: BorderRadius.circular(scrWidth * 0.026),
                            ),

                            child:TextFormField(
                              enabled: false,
                              controller:  category,
                              cursorHeight: scrWidth * 0.055,
                              cursorWidth: 1,
                              cursorColor: Colors.black,
                              style: GoogleFonts.urbanist(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: FontSize15,
                              ),
                              keyboardType: TextInputType.text,
                              decoration:  InputDecoration(
                                labelText: 'Category',
                                labelStyle: TextStyle(
                                  color: textFormUnFocusColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: FontSize15,
                                  fontFamily: 'Urbanist',
                                ),
                                fillColor: textFormFieldFillColor,
                                filled: true,
                                contentPadding: EdgeInsets.only(
                                    left: scrWidth*0.03, top: scrHeight*0.006, bottom: scrWidth * 0.02),
                                disabledBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                border: InputBorder.none,
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: primarycolor,
                                    width: 2,
                                  ),
                                ),

                                floatingLabelStyle: TextStyle(
                                    color:primarycolor),
                                focusColor: Color(0xff034a82),
                                // border: OutlineInputBorder(),
                                // focusedBorder: OutlineInputBorder(
                                //     borderSide: BorderSide(color: Color(0xff034a82),width: 2)
                                // ),
                              ),
                            ),
                            // CustomDropdown.search(
                            //   hintText: selectedCategory == '' ?'Select category ' : selectedCategory,
                            //   items: serviceCategory,
                            //   controller: category,
                            //   excludeSelected: false,
                            //   onChanged: (value){
                            //     selectedCategory=value;
                            //     catgoryId=categoryIdByName[selectedCategory];
                            //     getSubCategories();
                            //     // print( userMap[selectedUser]);
                            //   },
                            // ),
                          ),
                          SizedBox(
                            height: scrWidth * 0.04,
                          ),
                          Container( width: scrWidth,
                            height: textFormFieldHeight45,
                            padding: EdgeInsets.symmetric(
                              horizontal: scrWidth * 0.015,
                              vertical: scrWidth*0.002,                ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xffDADADA),
                              ),
                              color: textFormFieldFillColor,
                              borderRadius: BorderRadius.circular(scrWidth * 0.026),
                            ),

                            child:TextFormField(
                              enabled: false,
                              controller:  subCategory,
                              cursorHeight: scrWidth * 0.055,
                              cursorWidth: 1,
                              cursorColor: Colors.black,
                              style: GoogleFonts.urbanist(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: FontSize15,
                              ),
                              keyboardType: TextInputType.text,
                              decoration:  InputDecoration(
                                labelText: 'Sub category',
                                labelStyle: TextStyle(
                                  color: textFormUnFocusColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: FontSize15,
                                  fontFamily: 'Urbanist',
                                ),
                                fillColor: textFormFieldFillColor,
                                filled: true,
                                contentPadding: EdgeInsets.only(
                                    left: scrWidth*0.03, top: scrHeight*0.006, bottom: scrWidth * 0.02),
                                disabledBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                border: InputBorder.none,
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: primarycolor,
                                    width: 2,
                                  ),
                                ),

                                floatingLabelStyle: TextStyle(
                                    color:primarycolor),
                                focusColor: Color(0xff034a82),
                                // border: OutlineInputBorder(),
                                // focusedBorder: OutlineInputBorder(
                                //     borderSide: BorderSide(color: Color(0xff034a82),width: 2)
                                // ),
                              ),
                            ),
                            // CustomDropdown.search(
                            //   hintText: selectedSubCategory == '' ?'Select Sub category ' : selectedSubCategory,
                            //   items:serviceSubCategory,
                            //   controller: subCategory,
                            //   excludeSelected: false,
                            //   onChanged: (value){
                            //     selectedSubCategory=value;
                            //     // print( userMap[selectedUser]);
                            //   },
                            // ),
                          ),
                          SizedBox(
                            height: scrWidth * 0.04,
                          ),


                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: scrWidth*0.4,
                                height: textFormFieldHeight45,
                                padding: EdgeInsets.symmetric(
                                  horizontal: scrWidth * 0.015,
                                  vertical:scrHeight*0.002,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xffDADADA),
                                  ),
                                  color: textFormFieldFillColor,
                                  borderRadius: BorderRadius.circular(scrWidth * 0.026),
                                ),
                                child:  TextFormField(
                                  controller:  wage,
                                  cursorHeight: scrWidth * 0.055,
                                  cursorWidth: 1,
                                  cursorColor: Colors.black,
                                  style: GoogleFonts.urbanist(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: FontSize15,
                                  ),
                                  keyboardType: TextInputType.text,
                                  decoration:  InputDecoration(
                                    labelText: 'Enter wage',
                                    labelStyle: TextStyle(
                                      color: textFormUnFocusColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: FontSize15,
                                      fontFamily: 'Urbanist',
                                    ),
                                    fillColor: textFormFieldFillColor,
                                    filled: true,
                                    contentPadding: EdgeInsets.only(
                                        left: scrWidth*0.03, top: scrHeight*0.006, bottom: scrWidth * 0.02),
                                    disabledBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: primarycolor,
                                        width: 2,
                                      ),
                                    ),

                                    floatingLabelStyle: TextStyle(
                                        color:primarycolor),
                                    focusColor: Color(0xff034a82),
                                    // border: OutlineInputBorder(),
                                    // focusedBorder: OutlineInputBorder(
                                    //     borderSide: BorderSide(color: Color(0xff034a82),width: 2)
                                    // ),
                                  ),
                                ),

                              ),
                              Text(
                                "Per",
                                style: GoogleFonts.urbanist(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(  width: scrWidth*0.4,
                                height: textFormFieldHeight45,
                                padding: EdgeInsets.symmetric(
                                  horizontal: scrWidth * 0.015,
                                  vertical: scrWidth*0.002,                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xffDADADA),
                                  ),
                                  color: textFormFieldFillColor,
                                  borderRadius: BorderRadius.circular(scrWidth * 0.026),
                                ),

                                child:
                                CustomDropdown.search(
                                  hintText: selectedUnit == '' ?'Select ' : selectedUnit,
                                  items: serviceUnit,
                                  controller: unit,
                                  excludeSelected: false,
                                  onChanged: (value){
                                    selectedUnit=value;
                                    // print( userMap[selectedUser]);
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: scrWidth * 0.04,
                          ),

                          Container(
                            width: scrWidth,
                            height: textFormFieldHeight45,
                            padding: EdgeInsets.symmetric(
                              horizontal: scrWidth * 0.015,
                              vertical:scrHeight*0.002,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xffDADADA),
                              ),
                              color: textFormFieldFillColor,
                              borderRadius: BorderRadius.circular(scrWidth * 0.026),
                            ),
                            child:  TextFormField(
                              controller:  sevicesProvided,
                              cursorHeight: scrWidth * 0.055,
                              cursorWidth: 1,
                              cursorColor: Colors.black,
                              style: GoogleFonts.urbanist(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: FontSize15,
                              ),
                              keyboardType: TextInputType.text,
                              decoration:  InputDecoration(
                                labelText: 'Enter your Services',
                                labelStyle: TextStyle(
                                  color: textFormUnFocusColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: FontSize15,
                                  fontFamily: 'Urbanist',
                                ),
                                fillColor: textFormFieldFillColor,
                                filled: true,
                                contentPadding: EdgeInsets.only(
                                    left: scrWidth*0.03, top: scrHeight*0.006, bottom: scrWidth * 0.02),
                                disabledBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                border: InputBorder.none,
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: primarycolor,
                                    width: 2,
                                  ),
                                ),

                                floatingLabelStyle: TextStyle(
                                    color:primarycolor),
                                focusColor: Color(0xff034a82),
                                // border: OutlineInputBorder(),
                                // focusedBorder: OutlineInputBorder(
                                //     borderSide: BorderSide(color: Color(0xff034a82),width: 2)
                                // ),
                              ),
                            ),

                          ),
                          SizedBox(
                            height: scrWidth * 0.04,
                          ),

                          Container(
                            width: scrWidth,
                            height: textFormFieldHeight45,
                            padding: EdgeInsets.symmetric(
                              horizontal: scrWidth * 0.015,
                              vertical:scrHeight*0.002,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xffDADADA),
                              ),
                              color: textFormFieldFillColor,
                              borderRadius: BorderRadius.circular(scrWidth * 0.026),
                            ),
                            child:  TextFormField(
                              controller:  aboutService,
                              cursorHeight: scrWidth * 0.055,
                              cursorWidth: 1,
                              cursorColor: Colors.black,
                              style: GoogleFonts.urbanist(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: FontSize15,
                              ),
                              keyboardType: TextInputType.text,
                              decoration:  InputDecoration(
                                labelText: 'Enter about your Services',
                                labelStyle: TextStyle(
                                  color: textFormUnFocusColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: FontSize15,
                                  fontFamily: 'Urbanist',
                                ),
                                fillColor: textFormFieldFillColor,
                                filled: true,
                                contentPadding: EdgeInsets.only(
                                    left: scrWidth*0.03, top: scrHeight*0.006, bottom: scrWidth * 0.02),
                                disabledBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                border: InputBorder.none,
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: primarycolor,
                                    width: 2,
                                  ),
                                ),

                                floatingLabelStyle: TextStyle(
                                    color:primarycolor),
                                focusColor: Color(0xff034a82),
                                // border: OutlineInputBorder(),
                                // focusedBorder: OutlineInputBorder(
                                //     borderSide: BorderSide(color: Color(0xff034a82),width: 2)
                                // ),
                              ),
                            ),

                          ),
                          SizedBox(
                            height: scrWidth * 0.04,
                          ),


                          Row(
                            mainAxisAlignment:
                            photo ? MainAxisAlignment.end : MainAxisAlignment.start,
                            children: [
                              Text(
                                "Upload Photo",
                                style: GoogleFonts.urbanist(
                                  fontSize: FontSize15,
                                  fontWeight: FontWeight.w500,
                                  color: photo ? primarycolor : Color(0xff8391A1),
                                ),
                              ),
                              // SizedBox(
                              //   child: SvgPicture.asset(
                              //     'assets/images/upload.svg',
                              //     color: primarycolor,
                              //   ),
                              // )

                            ],
                          ),
                          SizedBox(
                            height: scrWidth * 0.02,
                          ),
                          imgUrl !=''
                              ? Column(
                            children: [
                              Container(
                                height:scrHeight*0.16,
                                width: scrWidth*0.5,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: CachedNetworkImage(imageUrl: imgUrl ,fit: BoxFit.cover,)
                                ),
                              ),
                              SizedBox(height: 10,),
                             editService==false? InkWell(
                                onTap: ()=>_pickImage(),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    height:scrHeight*0.04,
                                    width: scrWidth*0.3,

                                    child: Center(child: Text('Edit image'))
                                ),
                              ):Container(),
                            ],
                          )
                              : Container(
                            height:scrHeight*0.16,
                            width: scrWidth*0.5,
                            decoration: BoxDecoration(
                              color: Color(0xffF7F8F9),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Color(0xffDADADA),
                              ),
                            ),
                            child: Center(
                              child: InkWell(
                                onTap: ()=>_pickImage(),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/upload.svg',
                                      color: Color(0xff8391A1),
                                    ),
                                    SizedBox(
                                      width: scrWidth * 0.04,
                                    ),
                                    Text(
                                      'Upload photo',
                                      style: TextStyle(
                                        fontSize: FontSize15,
                                        fontFamily: 'Urbanist',
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff8391A1),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: scrWidth * 0.02,
                          ),
                          Row(
                            mainAxisAlignment:
                            photo ? MainAxisAlignment.end : MainAxisAlignment.start,
                            children: [
                              Text(
                                "Upload Document",
                                style: GoogleFonts.urbanist(
                                  fontSize: FontSize15,
                                  fontWeight: FontWeight.w500,
                                  color: photo ? primarycolor : Color(0xff8391A1),
                                ),
                              ),
                              // SizedBox(
                              //   child: SvgPicture.asset(
                              //     'assets/images/upload.svg',
                              //     color: primarycolor,
                              //   ),
                              // )

                            ],
                          ),
                          SizedBox(
                            height: scrWidth * 0.02,
                          ),
                          fileName==''?
                          InkWell(
                            onTap: () async {
                              _pickFile();
                            },
                            child: Container(
                              width: scrWidth,
                              height: textFormFieldHeight45,
                              padding: EdgeInsets.symmetric(
                                horizontal: scrWidth * 0.015,
                                vertical: scrHeight*0.002,
                              ),
                              decoration: BoxDecoration(
                                color: textFormFieldFillColor,
                                border: Border.all(
                                  color: Color(0xffDADADA),
                                ),
                                borderRadius: BorderRadius.circular(scrWidth * 0.026),
                              ),
                              child: Padding(
                                padding:  EdgeInsets.symmetric(horizontal: scrHeight*0.03),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Upload Documents",
                                      style: TextStyle(
                                        color: Color(0xff8391A1),
                                        fontWeight: FontWeight.w500,
                                        fontSize: FontSize15,
                                        fontFamily: 'Urbanist',
                                      ),
                                    ),
                                    // SvgPicture.asset(
                                    //   'assets/images/camera.svg',
                                    //   color: Color(0xff8391A1),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ):
                          Column(
                            children: [
                              Container(
                                width: scrWidth,
                                height: textFormFieldHeight45,
                                padding: EdgeInsets.symmetric(
                                  horizontal: scrWidth * 0.015,
                                  vertical: scrHeight*0.002,
                                ),
                                decoration: BoxDecoration(
                                  color: textFormFieldFillColor,
                                  border: Border.all(
                                    color: Color(0xffDADADA),
                                  ),
                                  borderRadius: BorderRadius.circular(scrWidth * 0.026),
                                ),
                                child: Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: scrHeight*0.03),
                                  child: Center(
                                    child: Text(
                                      fileName.toString(),
                                      style: TextStyle(
                                        color: Color(0xff8391A1),
                                        fontWeight: FontWeight.w500,
                                        fontSize: FontSize15,
                                        fontFamily: 'Urbanist',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              editService==false?InkWell(
                                onTap: (){
                                  _pickFile();
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    height:scrHeight*0.04,
                                    width: scrWidth*0.3,

                                    child: Center(child: Text('Edit file'))
                                ),
                              ):Container()
                            ],
                          ),
                          SizedBox(
                            height: scrWidth * 0.02,
                          ),
                          editService==false?  InkWell(
                              onTap: () {
                                if(name?.text!='' &&phoneNumber?.text!='' &&email?.text!=''&&whatsappNumber?.text!=''
                                    &&address?.text!=''&&selectedCity!=''&& selectedCategory!=''&& selectedSubCategory!=''&& selectedUnit!=''
                                    &&sevicesProvided!.text!=''&&aboutService!.text!=''&& imgUrl!=''&& fileUrl!=''){
                                  showDialog(context: context,
                                      builder: (buildcontext)
                                      {
                                        return AlertDialog(
                                          title: const Text('Add service'),
                                          content: const Text('Do you want to Add?'),
                                          actions: [
                                            TextButton(onPressed: (){
                                              Navigator.pop(context);
                                            },
                                                child: const Text('Cancel')),
                                            TextButton(onPressed: (){
                                              final service=ServiceDetails(
                                                  name:name?.text,
                                                  phoneNumber:phoneNumber?.text,
                                                  whatsappNo:whatsappNumber?.text,
                                                  emailId:email?.text,
                                                  address:address?.text,
                                                  city:selectedCity,
                                                  wage:double.tryParse(wage!.text.toString()),
                                                  userId:currentuserid,
                                                  serviceCategory:selectedCategory,
                                                  serviceUnit:selectedUnit,
                                                  addedDate:DateTime.now(),
                                                  image:imgUrl,
                                                  documents:fileUrl,
                                                  subCategory:selectedSubCategory,
                                                  servicesProvided:sevicesProvided!.text,
                                                  aboutService:aboutService!.text
                                              );
                                              addService(service);
                                              showUploadMessage(context, 'service added succesfully');
                                              Navigator.pop(context);
                                              name?.clear();
                                              phoneNumber?.clear();
                                              whatsappNumber?.clear();
                                              email?.clear();
                                              address?.clear();
                                              wage?.clear();
                                              userId?.clear();
                                              category.clear();
                                              unit.clear();
                                              city.clear();
                                              subCategory.clear();
                                              imgUrl='';
                                              fileUrl='';
                                              sevicesProvided!.clear();
                                              aboutService!.clear();
                                              setState(() {

                                              });

                                              // Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => CharityCatogoryPage(),), (route) => false);
                                            },
                                                child: const Text('Yes')),
                                          ],
                                        );

                                      });

                                }
                                else{
                                  name?.text==''? showUploadMessage(context,'Please enter  name'):
                                  email?.text==''?showUploadMessage(context,'Please enter emailId'):
                                  phoneNumber?.text==''?showUploadMessage(context,'Please enter phone number'):
                                  whatsappNumber?.text==''?showUploadMessage(context,'Please enter whatsappNumber'):
                                  address?.text==''?showUploadMessage(context,'Please enter address'):
                                  selectedCity==''?showUploadMessage(context,'Please choose your city'):
                                  selectedCategory==''?showUploadMessage(context,'Please choose service category'):
                                  selectedSubCategory==''?showUploadMessage(context,'Please choose sub category'):
                                  userId==''?showUploadMessage(context,'Please enter userId'):
                                  wage?.text==''?showUploadMessage(context,'Please choose your wage'):
                                  serviceUnit==''?showUploadMessage(context,'Please choose service unit'):
                                  sevicesProvided?.text==''?showUploadMessage(context,'Please enter your services'):
                                  aboutService?.text==''?showUploadMessage(context,'Please enter about your services'):

                                  imgUrl==''? showUploadMessage(context,'Please upload image'):
                                  showUploadMessage(context,'Please upload Id proof');
                                }

                              },
                              child: Container(
                                height: scrHeight*0.065,
                                decoration: BoxDecoration(
                                    color: primarycolor,
                                    borderRadius: BorderRadius.circular(17)),
                                margin: EdgeInsets.symmetric(vertical: scrWidth*0.03, horizontal: scrHeight*0.06),
                                child: Center(
                                    child: Text(
                                      "ADD",
                                      style: TextStyle(color: Colors.white),
                                    )),
                              )
                          ):
                          InkWell(
                              onTap: () {
                                if(name?.text!='' &&phoneNumber?.text!='' &&email?.text!=''&&whatsappNumber?.text!=''
                                    &&address?.text!=''&&selectedCity!=''&& selectedCategory!=''&&  selectedSubCategory!=''&&
                                    selectedUnit!=''&& sevicesProvided!.text!=''
                                    &&aboutService!.text!=''&& imgUrl!=''&& fileUrl!=''){
                                  showDialog(context: context,
                                      builder: (buildcontext)
                                      {
                                        return AlertDialog(
                                          title: const Text('Update service'),
                                          content: const Text('Do you want to update?'),
                                          actions: [
                                            TextButton(onPressed: (){
                                              Navigator.pop(context);
                                            },
                                                child: const Text('Cancel')),
                                            TextButton(onPressed: (){
                                              final service=ServiceDetails(
                                                  name:name?.text,
                                                  phoneNumber:phoneNumber?.text,
                                                  whatsappNo:whatsappNumber?.text,
                                                  emailId:email?.text,
                                                  address:address?.text,
                                                  city:selectedCity,
                                                  wage:double.tryParse(wage!.text.toString()),
                                                  userId:currentuserid,
                                                  serviceCategory:selectedCategory,
                                                  serviceUnit:selectedUnit,
                                                  addedDate:DateTime.now(),
                                                  image:imgUrl,
                                                  documents:fileUrl,
                                                  serviceId: serviceItems!.serviceId,
                                                  subCategory:selectedSubCategory??'',
                                                  servicesProvided:sevicesProvided!.text,
                                                  aboutService:aboutService!.text

                                              );
                                              EditService(service);
                                              showUploadMessage(context, 'service updated succesfully');
                                              Navigator.pop(context);
                                              name?.clear();
                                              phoneNumber?.clear();
                                              whatsappNumber?.clear();
                                              email?.clear();
                                              address?.clear();
                                              wage?.clear();
                                              userId?.clear();
                                              category.clear();
                                              subCategory.clear();
                                              unit.clear();
                                              city.clear();
                                              imgUrl='';
                                              fileUrl='';
                                              sevicesProvided!.clear();
                                              aboutService!.clear();
                                              controller.sink.add(1);
                                              setState(() {

                                              });

                                              // Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => CharityCatogoryPage(),), (route) => false);
                                            },
                                                child: const Text('Yes')),
                                          ],
                                        );
                                      });
                                }
                                else{
                                  name?.text==''? showUploadMessage(context,'Please enter  name'):
                                  email?.text==''?showUploadMessage(context,'Please enter emailId'):
                                  phoneNumber?.text==''?showUploadMessage(context,'Please enter phone number'):
                                  whatsappNumber?.text==''?showUploadMessage(context,'Please enter whatsappNumber'):
                                  address?.text==''?showUploadMessage(context,'Please enter address'):
                                  selectedCity==''?showUploadMessage(context,'Please choose your city'):
                                  serviceCategory==''?showUploadMessage(context,'Please choose service category'):
                                  selectedSubCategory==''?showUploadMessage(context,'Please choose service sub category'):
                                  userId==''?showUploadMessage(context,'Please enter userId'):
                                  wage?.text==''?showUploadMessage(context,'Please choose your wage'):
                                  serviceUnit==''?showUploadMessage(context,'Please choose service unit'):
                                  sevicesProvided?.text==''?showUploadMessage(context,'Please enter your services'):
                                  aboutService?.text==''?showUploadMessage(context,'Please enter about your services'):

                                  imgUrl==''? showUploadMessage(context,'Please upload image'):
                                  showUploadMessage(context,'Please upload Id proof');
                                }
                              },
                              child: Container(
                                height: scrHeight*0.065,
                                decoration: BoxDecoration(
                                    color: primarycolor,
                                    borderRadius: BorderRadius.circular(17)),
                                margin: EdgeInsets.symmetric(vertical: scrWidth*0.03, horizontal: scrHeight*0.06),
                                child: Center(
                                    child: Text(
                                      "Update",
                                      style: TextStyle(color: Colors.white),
                                    )),
                              )
                          )




                        ],
                      ),
                    ),

                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //     children: [
                        //       Container(
                        //         width: scrWidth*0.45,
                        //         height: textFormFieldHeight45,
                        //         padding: EdgeInsets.symmetric(
                        //           horizontal: scrWidth * 0.015,
                        //           vertical: scrWidth*0.002,                ),
                        //         decoration: BoxDecoration(
                        //           border: Border.all(
                        //             color: Color(0xffDADADA),
                        //           ),
                        //           color: textFormFieldFillColor,
                        //           borderRadius: BorderRadius.circular(scrWidth * 0.026),
                        //         ),
                        //         child:
                        //         CustomDropdown.search(
                        //           hintText: selectedCategory1 == '' ?'Category ' : selectedCategory1,
                        //           items: serviceCategory,
                        //           controller: category2,
                        //           excludeSelected: false,
                        //           onChanged: (value){
                        //             setState(() {
                        //               selectedCategory1=value;
                        //             });
                        //             // print( userMap[selectedUser]);
                        //           },
                        //         ),
                        //       ),
                        //       Container(
                        //         width: scrWidth*0.44,
                        //         // width: scrWidth,
                        //         height: textFormFieldHeight45,
                        //         padding: EdgeInsets.symmetric(
                        //           horizontal: scrWidth * 0.015,
                        //           vertical: scrWidth*0.002,                ),
                        //         decoration: BoxDecoration(
                        //           border: Border.all(
                        //             color: Color(0xffDADADA),
                        //           ),
                        //           color: textFormFieldFillColor,
                        //           borderRadius: BorderRadius.circular(scrWidth * 0.026),
                        //         ),
                        //
                        //         child:
                        //         CustomDropdown.search(
                        //           hintText: selectedCity2 == '' ?'City ' : selectedCity2,
                        //           items: serviceCity,
                        //           controller: city2,
                        //           excludeSelected: false,
                        //           onChanged: (value){
                        //             setState(() {
                        //               selectedCity2=value;
                        //             });
                        //             // print( userMap[selectedUser]);
                        //           },
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Container(
                          height: MediaQuery.of(context).size.height,
                          child:StreamBuilder<List<ServiceDetails>>(
                              stream: getServices(),
                              builder: (context, snapshot) {
                                if(!snapshot.hasData){
                                  return  Container(child: Center(child: CircularProgressIndicator()));
                                }
                                var  data=snapshot.data!.toList();
                                return data.length==0?
                                Center(
                                  child: Text('No list Found'),
                                ):
                                ListView.builder(
                                  padding: EdgeInsets.all( MediaQuery.of(context).size.width*0.05,),
                                  itemCount: data.length,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final serviceItems=data[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 15.0,right: 15,bottom: 10,),
                                      child: InkWell(
                                        onTap: (){
                                          editService=true;
                                          // name!.text=serviceItems.name!;
                                          // email!.text=serviceItems.emailId!;
                                          // phoneNumber!.text=serviceItems.phoneNumber!;
                                          // whatsappNumber!.text=serviceItems.whatsappNo!;
                                          // address!.text=serviceItems.address!;
                                          // selectedCity=serviceItems.city!;
                                          // selectedUnit=serviceItems.serviceUnit!;
                                          // city.text=serviceItems.city!;
                                          // unit.text=serviceItems.serviceUnit!;
                                          // sevicesProvided!.text=serviceItems.servicesProvided!;
                                          // aboutService!.text=serviceItems.aboutService!;
                                          // imgUrl=serviceItems.image!.toString();
                                          // wage!.text=serviceItems.wage.toString();
                                          // fileUrl=serviceItems.documents!;
                                          // fileName=serviceItems.documents!;
                                          // _tabController!.animateTo(0);
                                          // if(mounted) {
                                          //   setState(() {
                                          //
                                          //   });
                                          // };

                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddServicePage(
                                              serviceItems:serviceItems,
                                              subCategoryName: widget.subCategoryName,
                                               Category: widget.Category

                                          )));
                                          if(mounted) {
                                            setState(() {

                                            });
                                          };
                                        },
                                        onLongPress: (){
                                          showDialog(context: context, builder:(buildcontext)
                                          {
                                            return AlertDialog(
                                              title: Text('Delete'),
                                              content: Text('Are you sure?'),
                                              actions: [
                                                TextButton(onPressed: () {

                                                  Navigator.pop(context);
                                                },
                                                    child: Text('Cancel')),
                                                TextButton(onPressed: ()  {

                                                  // FirebaseFirestore.instance.collection('services').doc(data![index].id).delete();


                                                  Navigator.pop(context);
                                                  showUploadMessage(context, "Deleted");


                                                },

                                                    child: Text('Delete')),

                                              ],
                                            );
                                          });
                                        },
                                        child: Material(
                                          color: Colors.transparent,
                                          elevation: 4,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Container(
                                            width: double.infinity,

                                            decoration: BoxDecoration(
                                              color: Color(0xFFE3F2FD),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 100,
                                                  width: 100,

                                                  child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(8),
                                                      child: CachedNetworkImage(imageUrl:serviceItems.image.toString() ,fit: BoxFit.cover,)
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(10,0,0,0),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,

                                                    children: [
                                                      Text(
                                                        'Name : ${serviceItems.name.toString()}',
                                                        style:
                                                        GoogleFonts.urbanist(
                                                            fontSize: 14
                                                        ),

                                                      ),
                                                      Text(
                                                        'Phone Number : ${serviceItems.phoneNumber.toString()}',
                                                        style:
                                                        GoogleFonts.urbanist(
                                                            fontSize: 14
                                                        ),

                                                      ),
                                                      Text(
                                                        'Email Id : ${serviceItems.emailId.toString()}',
                                                        style:
                                                        GoogleFonts.urbanist(
                                                            fontSize: 14
                                                        ),

                                                      ),
                                                      Container(
                                                        width: scrWidth*0.50,
                                                        child: Text(
                                                          'Service : ${serviceItems.serviceCategory.toString()}',
                                                          style:
                                                          GoogleFonts.urbanist(
                                                              fontSize: 14
                                                          ),

                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );

                                  },
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                  // IncomeFirstPage(),
                  // AddExpensesPage(),

                ]
            ),

          )
        ],
      )

    );
  }
}
addService(ServiceDetails service){
  FirebaseFirestore.instance.collection('services').add(service.toJson()).then((value){
    value.update({
      "serviceId":value.id,
    }
    );
  });
}
EditService(ServiceDetails service){
  FirebaseFirestore.instance.collection('services').doc(service.serviceId?.trim()).update(service.toJson());

}


