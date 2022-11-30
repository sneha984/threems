import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geo_firestore_flutter/geo_firestore_flutter.dart';
import 'package:getwidget/components/dropdown/gf_multiselect.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';
import 'package:image_picker/image_picker.dart';
import 'package:threems/Authentication/root.dart';
import 'package:threems/kuri/createkuri.dart';
import 'package:threems/screens/home_screen.dart';

import '../model/Buy&sell.dart';
import '../screens/splash_screen.dart';


import '../utils/themes.dart';
import 'congratspage.dart';
import 'dart:io';

class StoreDetails extends StatefulWidget {
  const StoreDetails({Key? key}) : super(key: key);

  @override
  State<StoreDetails> createState() => _StoreDetailsState();
}

class _StoreDetailsState extends State<StoreDetails> {
  bool finish = false;
  bool trackedlocation = false;
  List categoryList=[];
  List categoryListAll=[];
  List<String> selectCategory=[];
  geoLocation(String id)async{
    GeoFirestore geoFirestore = GeoFirestore(FirebaseFirestore.instance.collection('stores'));
    await geoFirestore.setLocation(id, GeoPoint(lat!, long!));
    final queryLocation = GeoPoint(lat!, long!);
    // creates a new query around [37.7832, -122.4056] with a radius of 0.6 kilometers
    final List<DocumentSnapshot> documents = await geoFirestore.getAtLocation(queryLocation, 0.6);
    documents.forEach((doc) {
      print("111111111111111111111111111111111111111111111111111111");
      print(doc.data());

      print("111111111111111111111111111111111111111111111111111111");

    });
  }

  getCategory(){
    FirebaseFirestore.instance.collection('storeCategory').snapshots().listen((event) {
      categoryList=[];
      categoryListAll=[];

      for(DocumentSnapshot <Map<String,dynamic>> doc in event.docs){
        print("---====--=--9022222222222222222222222222222222222222222222222222222222222222222");
        print('${doc['categoryName']}');
        print('${event.docs[1]['categoryName']}');
        // categoryListAll.add(doc.data()!);
        categoryList.add(doc['categoryName']);
      }
      print(categoryList);
      if(mounted){
        setState(() {

        });
      }
    });
    
  }

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
    print(value);

    // if(value!=null){
    //   imageList.add(value);
    // }
    setState(() {
      imgUrl = value;

    });
  }
  _pickImage() async {
    final imageFile = await ImagePicker.platform.pickImage(
        source: ImageSource.gallery);
    setState(() {
      imgFile = File(imageFile!.path);
      uploadImageToFirebase(context);
    });
  }

  String? selectedValue;
  final FocusNode storeNameFocus = FocusNode();
  final FocusNode storeAddressFocus = FocusNode();
  final TextEditingController storeNameController = TextEditingController();
  final TextEditingController storeAddressController = TextEditingController();
  bool loading=false;
  refreshPage() {
    setState(() {
      loading = false;
    });
  }
  @override
  void initState() {
    // getShopCategory();
    getCategory();
    storeNameFocus.addListener(() {
      setState(() {});
    });
    storeAddressFocus.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    storeNameFocus.dispose();
    storeAddressFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 84,
        shadowColor: Colors.grey,
        leadingWidth: 35,
        centerTitle: false,
        elevation: 0.1,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
                  },
          child: Padding(
            padding: EdgeInsets.only(
                top: scrHeight * 0.03,
                left: scrWidth * 0.045,
                bottom: scrHeight * 0.01,
                right: scrWidth * 0.0),
            child: SvgPicture.asset(
              "assets/icons/arrowmark.svg",
            ),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: scrHeight * 0.02),
          child: Text(
            "Enter Store Details",
            style: TextStyle(
                fontSize: scrWidth * 0.046,
                color: Colors.black,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(left: scrWidth * 0.06, right: scrWidth * 0.06),
          child: Column(
            children: [
              Padding(
                padding:  EdgeInsets.only(right: 220,top: 18),
                child: InkWell(
                  onTap: (){
                    _pickImage();
                  },
                  child: Container(
                    height: scrHeight * 0.11,
                    width: scrWidth * 0.25,
                    decoration: BoxDecoration(
                      color: textFormFieldFillColor,
                      borderRadius: BorderRadius.circular(scrWidth * 0.04),
                    ),
                    child: Center(
                        child: imgFile==null?Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                                child: SvgPicture.asset(
                                    "assets/icons/bigcamera.svg"))
                          ],
                        ):Container(
                          height:scrHeight*0.11,
                          width: scrWidth*0.28,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(imgFile!) as ImageProvider,fit: BoxFit.fill),
                            borderRadius: BorderRadius.circular(8),
                            // border: Border.all(
                            //   color: Color(0xffDADADA),
                            // ),
                          ),

                        )
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: scrHeight * 0.03,
              ),
              Container(
                height: textFormFieldHeight45,
                padding: EdgeInsets.symmetric(
                  horizontal: scrWidth * 0.015,
                  vertical: scrHeight * 0.002,
                ),
                decoration: BoxDecoration(
                  color: textFormFieldFillColor,
                  borderRadius: BorderRadius.circular(scrWidth * 0.026),
                ),
                child: TextFormField(
                  controller: storeNameController,
                  focusNode: storeNameFocus,
                  cursorHeight: scrWidth * 0.055,
                  cursorWidth: 1,
                  cursorColor: Colors.black,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: FontSize15,
                    fontFamily: 'Urbanist',
                  ),
                  decoration: InputDecoration(
                    labelText: 'Store Name',
                    labelStyle: TextStyle(
                      color: storeNameFocus.hasFocus
                          ? primarycolor
                          : Color(0xffB0B0B0),
                      fontWeight: FontWeight.w600,
                      fontSize: FontSize15,
                      fontFamily: 'Urbanist',
                    ),
                    prefixIcon: Container(
                      height: scrWidth * 0.045,
                      width: 10,
                      padding: EdgeInsets.all(scrWidth * 0.033),
                      child: SvgPicture.asset(
                        'assets/icons/storename.svg',
                        fit: BoxFit.contain,
                        color: Color(0xffB0B0B0),
                      ),
                    ),
                    fillColor: textFormFieldFillColor,
                    filled: true,
                    contentPadding:
                        EdgeInsets.only(top: 5, bottom: scrWidth * 0.033),
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
                  ),
                ),
              ),
              SizedBox(
                height: scrHeight * 0.02,
              ),
              // Container(
              //   width: scrWidth * 0.9,
              //   height: textFormFieldHeight45,
              //   decoration: BoxDecoration(
              //     color: textFormFieldFillColor,
              //     borderRadius: BorderRadius.circular(scrWidth * 0.033),
              //   ),
              //
              //   child: Row(
              //     children: [
              //       SizedBox(
              //         width: scrWidth * 0.057,
              //       ),
              //       SvgPicture.asset(
              //         'assets/icons/storecategory.svg',
              //         // fit: BoxFit.contain,
              //       ),
              //       SizedBox(
              //         width: scrWidth * 0.04,
              //       ),
              //       DropdownButtonHideUnderline(
              //         child: DropdownButton2(
              //           isExpanded: true,
              //           hint: Text(
              //             "Store Category",
              //             style: TextStyle(
              //                 fontSize: FontSize15,
              //                 fontFamily: 'Urbanist',
              //                 fontWeight: FontWeight.w600,
              //                 color: Color(0xffB0B0B0)),
              //           ),
              //           items: categoryList
              //               .map((item) => DropdownMenuItem<String>(
              //                     value: item,
              //                     child: Text(
              //                       item.toString(),
              //                       // overflow: TextOverflow.ellipsis,
              //                       style: TextStyle(
              //                           fontWeight: FontWeight.w600,
              //                           fontSize: 14,
              //                           fontFamily: 'Urbanist'),
              //                     ),
              //                   ))
              //               .toList(),
              //           value: selectedValue,
              //           onChanged: (value) {
              //             setState(() {
              //               selectedValue = value as String;
              //
              //             });
              //           },
              //           icon:  Icon(
              //             Icons.arrow_drop_down,
              //           ),
              //           iconSize: 18,
              //           iconEnabledColor: Colors.black,
              //           iconDisabledColor: Colors.blue,
              //           buttonHeight: 50,
              //           buttonWidth: 247,
              //           // buttonPadding: const EdgeInsets.only(),
              //           buttonDecoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(14),
              //             color: textFormFieldFillColor,
              //           ),
              //           // buttonElevation: 2,
              //           itemHeight: 40,
              //           itemPadding: const EdgeInsets.only(),
              //           dropdownMaxHeight: 260,
              //           dropdownWidth: 300,
              //           dropdownPadding: EdgeInsets.only(
              //               left: 30, top: 15, bottom: 25, right: 30),
              //           dropdownDecoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(8),
              //             color: Colors.white,
              //           ),
              //           dropdownElevation: 0,
              //           scrollbarRadius: Radius.circular(10),
              //           scrollbarThickness: 3,
              //           scrollbarAlwaysShow: true,
              //           offset: const Offset(-20, 0),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Container(
                width: scrWidth*27,
                decoration: BoxDecoration(                color: textFormFieldFillColor,
                    borderRadius: BorderRadius.circular(scrWidth * 0.026)),
                child: GFMultiSelect(
                  items: categoryList,
                  onSelect: (value) {
                    selectedValue=value.toString();
                    selectCategory=[];
                    for(int i=0;i<value.length;i++){
                      selectCategory.add(categoryList[value[i]].toString());
                    }
                    print('selected $value ');
                    print(selectCategory);
                  },

                  dropdownTitleTileText: 'Store Category',
                  // dropdownTitleTileHintText: 'Store Category',
                  // dropdownTitleTileHintTextStyle: TextStyle(
                  //  color: Color(0xffB0B0B0),
                  //   fontWeight: FontWeight.w600,
                  //   fontSize: FontSize15,
                  //   fontFamily: 'Urbanist',
                  //
                  // ),
                  dropdownTitleTileColor: textFormFieldFillColor,
                   dropdownTitleTilePadding: EdgeInsets.only(left: 9),
                  dropdownTitleTileMargin: EdgeInsets.only(
                      top: 22, left: 18, right: 18, bottom: 14),
                  //  dropdownTitleTilePadding: EdgeInsets.all(10),
                  dropdownUnderlineBorder: const BorderSide(
                      color: Colors.transparent, width: 2),
                  // dropdownTitleTileBorder:
                  // Border.all(color:Colors.red, width: 1),
                  dropdownTitleTileBorderRadius: BorderRadius.circular(10),
                  expandedIcon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                  ),
                  collapsedIcon: const Icon(
                    Icons.arrow_drop_up,
                    color: Colors.black,
                  ),
                  submitButton: Text('OK'),

                  dropdownTitleTileTextStyle:  TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      fontFamily: 'Urbanist'),
                  padding: const EdgeInsets.all(6),
                  margin: const EdgeInsets.all(6),
                  type: GFCheckboxType.square,
                  activeBgColor: Colors.green.withOpacity(0.5),
                  inactiveBorderColor:primarycolor,
                ),
              ),
              SizedBox(
                height: scrHeight * 0.02,
              ),
              Container(
                height: textFormFieldHeight45,
                padding: EdgeInsets.symmetric(
                  horizontal: scrWidth * 0.015,
                  vertical: scrHeight * 0.002,
                ),
                decoration: BoxDecoration(
                  color: textFormFieldFillColor,
                  borderRadius: BorderRadius.circular(scrWidth * 0.026),
                ),
                child: TextFormField(
                  controller: storeAddressController,
                  focusNode: storeAddressFocus,
                  cursorHeight: scrWidth * 0.055,
                  cursorWidth: 1,
                  cursorColor: Colors.black,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: FontSize15,
                    fontFamily: 'Urbanist',
                  ),
                  decoration: InputDecoration(
                    labelText: 'Store Address',
                    labelStyle: TextStyle(
                      color: storeAddressFocus.hasFocus
                          ? primarycolor
                          : Color(0xffB0B0B0),
                      fontWeight: FontWeight.w600,
                      fontSize: FontSize15,
                      fontFamily: 'Urbanist',
                    ),
                    prefixIcon: Container(
                      height: scrWidth * 0.045,
                      width: 10,
                      padding: EdgeInsets.all(scrWidth * 0.033),
                      child: SvgPicture.asset(
                        'assets/icons/storename.svg',
                        fit: BoxFit.contain,
                        color: Color(0xffB0B0B0),
                      ),
                    ),
                    fillColor: textFormFieldFillColor,
                    filled: true,
                    contentPadding:
                        EdgeInsets.only(top: 5, bottom: scrWidth * 0.033),
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
                  ),
                ),
              ),

              SizedBox(
                height: scrHeight * 0.02,
              ),
              // trackedlocation == false
              //     ? Container(
              //         height: textFormFieldHeight45,
              //         width: scrWidth,
              //         decoration: BoxDecoration(
              //             color: primarycolor,
              //             borderRadius: BorderRadius.circular(8)),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             SvgPicture.asset("assets/icons/crtlocation.svg"),
              //             SizedBox(
              //               width: scrWidth * 0.03,
              //             ),
              //             Text(
              //               "Set Store Location",
              //               style: TextStyle(
              //                   color: Colors.white,
              //                   fontFamily: 'Urbanist',
              //                   fontSize: 16,
              //                   fontWeight: FontWeight.w600),
              //             ),
              //           ],
              //         ),
              //       )
              //     : Padding(
              //         padding: EdgeInsets.only(right: scrWidth * 0.2),
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             SizedBox(
              //               height: scrHeight * 0.003,
              //             ),
              //             Text(
              //               "Tracked location",
              //               style: TextStyle(
              //                   color: Color(0xffB0B0B0),
              //                   fontFamily: 'Urbanist',
              //                   fontSize: 14,
              //                   fontWeight: FontWeight.w600),
              //             ),
              //             SizedBox(
              //               height: scrHeight * 0.008,
              //             ),
              //             Text(
              //               "Angadippuram, Perintalmanna",
              //               style: TextStyle(
              //                   color: Color(0xff232323),
              //                   fontFamily: 'Urbanist',
              //                   fontSize: 16,
              //                   fontWeight: FontWeight.w600),
              //             ),
              //           ],
              //         ),
              //       ),

              SizedBox(
                height: scrHeight * 0.25,
              ),
              finish
                  ? Container(
                      height: textFormFieldHeight45,
                      width: scrWidth,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 128, 54, 0.33),
                          borderRadius: BorderRadius.circular(21.5)),
                      child: Center(
                        child: Text(
                          "Finish",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Urbanist',
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () async {
                        setState(() {
                          loading=true;
                        });
                        if(imgFile==null){
                          refreshPage();
                          return showSnackbar(context,"Must Provide  image");
                        }
                        if(storeNameController.text.isEmpty){
                          refreshPage();
                          return showSnackbar(context,"Must Provide StoreName");
                        }
                        if(selectCategory.isEmpty){
                          refreshPage();
                          return showSnackbar(context,"Must select category");
                        }
                        if(storeAddressController.text.isEmpty){
                          refreshPage();
                          return showSnackbar(context,"Must Provide StoreAddress");
                        }else{
                          final strDat = StoreDetailsModel(
                            storeImage: imgUrl,
                            latitude: lat,
                            longitude:long ,
                            // categoryId:,
                            userId: currentuserid,
                            storeName: storeNameController.text,
                            storeCategory: selectCategory,
                            storeAddress: storeAddressController.text,
                            storeLocation: "ncsunuscns",
                          );
                          await createStore(strDat);
                        }
                        print("---------------------------------------------------------");
                        print(imgUrl);
                        print("---------------------------------------------------------");
                        // print('eferjnferngirjtgurj${strDat.storeId}');
                        
                        },
                      child: Container(
                        height: textFormFieldHeight45,
                        width: scrWidth,
                        decoration: BoxDecoration(
                            color: primarycolor,
                            borderRadius: BorderRadius.circular(21.5)),
                        child: Center(
                          child: Text(
                            "Finish",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Urbanist',
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  createStore(StoreDetailsModel strDat) async {
    String? id;
    FirebaseFirestore.instance
        .collection('stores')
        .add(strDat.toJson())
        .then((value) {
          geoLocation(value.id);
      value.update({'storeId': value.id});
      id=value.id;
    }).then((value) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CongratsPage(
                    id: id!, status: 0,
                  )));
    });
  }
}
