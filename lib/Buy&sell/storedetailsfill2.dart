import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:threems/Buy&sell/storedetailsfill.dart';
import 'package:threems/Buy&sell/succesfullyadded.dart';

import 'package:threems/model/Buy&sell.dart';
import 'dart:io';


import '../kuri/createkuri.dart';
import '../layouts/screen_layout.dart';
import '../screens/home_screen.dart';
import '../screens/splash_screen.dart';
import '../utils/themes.dart';
List selectCategory=[];

class StoreDetailsFill2 extends StatefulWidget {
  final StoreDetailsModel data;

  const StoreDetailsFill2({Key? key,  required this.data,}) : super(key: key);

  @override
  State<StoreDetailsFill2> createState() => _StoreDetailsFill2State();
}

class _StoreDetailsFill2State extends State<StoreDetailsFill2> {
   String? selectedCategoryItem;
   String? productCategoryItem;
  bool finished=true;
  final FocusNode categoryFocusNode=FocusNode();
  final FocusNode productNameFocus= FocusNode();
  final FocusNode productPriceFocus= FocusNode();
  final FocusNode productUnitFocus= FocusNode();
  final FocusNode productDetails=FocusNode();
  final FocusNode productCategoryName=FocusNode();
  final TextEditingController productCategoryNameController=TextEditingController();
  final TextEditingController categoryNameController=TextEditingController();
  final  TextEditingController productNameController =TextEditingController();
  final  TextEditingController productPriceController =TextEditingController();
  final  TextEditingController productUnitController =TextEditingController();
  final  TextEditingController productDetailsController =TextEditingController();
  String? selectedValuee;
  String? selectedValue;
  
   bool loading=false;
   refreshPage() {
     setState(() {
       loading = false;
     });
   }
   List productUnit=[];
   List productCategory=[];
   getUnit(){
     FirebaseFirestore.instance.collection('productUnit').snapshots().listen((event) {
       productUnit=[];
       for(DocumentSnapshot <Map<String,dynamic>> doc in event.docs){
         print("---====--=--9022222222222222222222222222222222222222222222222222222222222222222");
         print('${doc['unit']}');
         print('${event.docs[1]['unit']}');
         // categoryListAll.add(doc.data()!);
         productUnit.add(doc['unit']);
       }
       print(productUnit);
       if(mounted){
         setState(() {

         });
       }
     });
   }
   getProductCat(){
     FirebaseFirestore
         .instance
         .collection('stores')
         .doc(widget.data.storeId)
         .snapshots().listen((event) {
       productCategory=event.get('productCategory');
       print(productCategory);
       if(mounted){
         setState(() {

         });
       }
     });
   }
   void _showToast(BuildContext context) {
     final scaffold = ScaffoldMessenger.of(context);
     scaffold.showSnackBar(
       SnackBar(
         content: const Text('Scuccesfully Added'),
         // action: SnackBarAction(
         //     label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
       ),
     );
   }
    
List productCategoryList=[];
  List _images=[];
  List<String> _imgurl=[];
  String? imgUrl;
  var imgFile;
  var uploadTask;
  var fileUrl;
  Future uploadImageToFirebase(BuildContext context) async {
    Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('deposits/$imgFile');
    UploadTask uploadTask = firebaseStorageRef.putFile(imgFile);
    TaskSnapshot taskSnapshot = (await uploadTask);
    String value = await taskSnapshot.ref.getDownloadURL();

  
    print("####################################################");
    print("####################################################");

    setState(() {
      _imgurl.add(value);
      print(_imgurl);
    });
  }
  _pickImage() async {
     imgFile = await ImagePicker.platform.pickImage(
        source: ImageSource.gallery);
    setState(() {
      imgFile = File(imgFile!.path);
      _images.add(File(imgFile!.path));

      uploadImageToFirebase(context);
    });
  }

  @override
  void initState() {
    getUnit();
    getProductCat();
    // TODO: implement initState
    selectCategory=widget.data.storeCategory!;
    super.initState();
  }
  @override
  void dispose() {
   categoryFocusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await confirmQuitDialog(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
        body:SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.only(left: scrWidth*0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: scrHeight*0.08,),
                Row(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                            ScreenLayout(index: 1,tabIndex: 1,),), (route) => false);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: scrHeight * 0.0,
                            left: scrWidth * 0.01,
                            // bottom: scrHeight * 0.02,
                            right: scrWidth * 0.02),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                          size: 25,
                        ),
                      ),
                    ),
                    SizedBox(width: scrWidth*0.04,),
                    Text(
                      "Add Product",
                      style: TextStyle(
                          fontSize: scrWidth*0.046,
                          color: Colors.black,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(height: scrHeight*0.03,),
                Container(
                  height:100,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount:_images.length==5?_images.length:_images.length+1 ,
                      itemBuilder: (context,index){
                        return index==_images.length?InkWell(
                          onTap: (){
                            _pickImage();
                          },
                          child: Padding(
                            padding:  EdgeInsets.only(left: 10),
                            child: Container(
                                height:scrHeight*0.11,
                                width: scrWidth*0.28,
                                decoration: BoxDecoration(
                                  color: textFormFieldFillColor,
                                  borderRadius:
                                  BorderRadius.circular(scrWidth * 0.04),
                                ),
                                child:  Center(
                                    child: SvgPicture.asset(
                                        "assets/icons/bigcamera.svg"))),
                          ),
                        ):Padding(
                          padding:  EdgeInsets.only(left: 10),
                          child: Container(
                            height:scrHeight*0.11,
                            width: scrWidth*0.28,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:FileImage(_images[index]),
                                  // FileImage(imgFile!) as ImageProvider,
                                  fit: BoxFit.fill),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Color(0xffDADADA),
                              ),
                            ),
                          ),
                        );
                      }),

                ),

                SizedBox(height: scrHeight*0.01,),
                Text(
                  "Add product images (upto 5)",
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xffB0B0B0),
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: scrHeight*0.036,),
                Padding(
                  padding:  EdgeInsets.only(right: scrWidth*0.053),
                  child: Container(
                    height: textFormFieldHeight45,
                    padding: EdgeInsets.symmetric(
                      horizontal: scrWidth * 0.015,
                      vertical: scrHeight*0.002,
                    ),
                    decoration: BoxDecoration(
                      color: textFormFieldFillColor,
                      borderRadius:
                      BorderRadius.circular(scrWidth * 0.026),
                    ),
                    child: TextFormField(
                      controller: productNameController,
                      focusNode: productNameFocus,
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
                        labelText: 'Product Name',
                        labelStyle: TextStyle(
                          color: productNameFocus.hasFocus
                              ? primarycolor
                              : Color(0xffB0B0B0),
                          fontWeight: FontWeight.w600,
                          fontSize: FontSize15,
                          fontFamily: 'Urbanist',
                        ),
                        prefixIcon: Container(
                          height: scrWidth * 0.045,
                          width: 10,
                          padding: EdgeInsets.all(
                              scrWidth * 0.033),
                          child: SvgPicture.asset(
                            'assets/icons/storename.svg',
                            fit: BoxFit.contain,
                            color: Color(0xffB0B0B0),
                          ),
                        ),
                        fillColor: textFormFieldFillColor,
                        filled: true,
                        contentPadding: EdgeInsets.only(
                            top: 5, bottom: scrWidth * 0.033),
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
                ),
                SizedBox(height: scrHeight*0.02,),

                Container(
                  width: scrWidth * 0.9,
                  height: textFormFieldHeight45,
                  decoration: BoxDecoration(
                    color: textFormFieldFillColor,
                    borderRadius: BorderRadius.circular(scrWidth * 0.033),
                  ),

                  child: Row(
                    children: [
                      SizedBox(
                        width: scrWidth * 0.057,
                      ),
                      SvgPicture.asset(
                        'assets/icons/storecategory.svg',
                        // fit: BoxFit.contain,
                      ),
                      SizedBox(
                        width: scrWidth * 0.04,
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          hint: Text(
                            "Store Category",
                            style: TextStyle(
                                fontSize: FontSize15,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w600,
                                color: Color(0xffB0B0B0)),
                          ),
                          items: selectCategory
                              .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item.toString(),
                              // overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  fontFamily: 'Urbanist'),
                            ),
                          ))
                              .toList(),
                          value: selectedCategoryItem,
                          onChanged: (value) {
                            setState(() {
                              selectedCategoryItem = value as String;

                            });
                          },
                          icon:  Icon(
                            Icons.arrow_drop_down,
                          ),
                          iconSize: 18,
                          iconEnabledColor: Colors.black,
                          iconDisabledColor: Colors.blue,
                          buttonHeight: 50,
                          buttonWidth: 247,
                          // buttonPadding: const EdgeInsets.only(),
                          buttonDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: textFormFieldFillColor,
                          ),
                          // buttonElevation: 2,
                          itemHeight: 40,
                          itemPadding: const EdgeInsets.only(),
                          dropdownMaxHeight: 260,
                          dropdownWidth: 300,
                          dropdownPadding: EdgeInsets.only(
                              left: 30, top: 15, bottom: 25, right: 30),
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          dropdownElevation: 0,
                          scrollbarRadius: Radius.circular(10),
                          scrollbarThickness: 3,
                          scrollbarAlwaysShow: true,
                          offset: const Offset(-20, 0),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: scrHeight*0.02,),
                Container(
                  width: scrWidth * 0.9,
                  height: textFormFieldHeight45,
                  decoration: BoxDecoration(
                    color: textFormFieldFillColor,
                    borderRadius: BorderRadius.circular(scrWidth * 0.033),
                  ),

                  child: Row(
                    children: [
                      SizedBox(
                        width: scrWidth * 0.057,
                      ),
                      SvgPicture.asset(
                        'assets/icons/storecategory.svg',
                        // fit: BoxFit.contain,
                      ),
                      SizedBox(
                        width: scrWidth * 0.04,
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          hint: Text(
                            "Product Category",
                            style: TextStyle(
                                fontSize: FontSize15,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w600,
                                color: Color(0xffB0B0B0)),
                          ),
                          items: productCategory
                              .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item.toString(),
                              // overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  fontFamily: 'Urbanist'),
                            ),
                          ))
                              .toList(),
                          value: productCategoryItem,
                          onChanged: (value) {
                            setState(() {
                              productCategoryItem  = value as String;

                            });
                          },
                          icon:  Icon(
                            Icons.arrow_drop_down,
                          ),
                          iconSize: 18,
                          iconEnabledColor: Colors.black,
                          iconDisabledColor: Colors.blue,
                          buttonHeight: 50,
                          buttonWidth: 247,
                          // buttonPadding: const EdgeInsets.only(),
                          buttonDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: textFormFieldFillColor,
                          ),
                          // buttonElevation: 2,
                          itemHeight: 40,
                          itemPadding: const EdgeInsets.only(),
                          dropdownMaxHeight: 260,
                          dropdownWidth: 300,
                          dropdownPadding: EdgeInsets.only(
                              left: 30, top: 15, bottom: 25, right: 30),
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          dropdownElevation: 0,
                          scrollbarRadius: Radius.circular(10),
                          scrollbarThickness: 3,
                          scrollbarAlwaysShow: true,
                          offset: const Offset(-20, 0),
                        ),
                      ),
                    ],
                  ),
                ),
                // Padding(
                //   padding:  EdgeInsets.only(right: scrWidth*0.053),
                //   child: Container(
                //     height: textFormFieldHeight45,
                //     padding: EdgeInsets.symmetric(
                //       horizontal: scrWidth * 0.015,
                //       vertical: scrHeight*0.002,
                //     ),
                //     decoration: BoxDecoration(
                //       color: textFormFieldFillColor,
                //       borderRadius:
                //       BorderRadius.circular(scrWidth * 0.026),
                //     ),
                //     child: TextFormField(
                //       controller: categoryNameController,
                //       focusNode: categoryFocusNode,
                //       cursorHeight: scrWidth * 0.055,
                //       cursorWidth: 1,
                //       cursorColor: Colors.black,
                //       style: TextStyle(
                //         color: Colors.black,
                //         fontWeight: FontWeight.w600,
                //         fontSize: FontSize15,
                //         fontFamily: 'Urbanist',
                //       ),
                //       decoration: InputDecoration(
                //         labelText: 'Product Category',
                //         labelStyle: TextStyle(
                //           color: categoryFocusNode.hasFocus
                //               ? primarycolor
                //               : Color(0xffB0B0B0),
                //           fontWeight: FontWeight.w600,
                //           fontSize: FontSize15,
                //           fontFamily: 'Urbanist',
                //         ),
                //         prefixIcon: Container(
                //           height: scrWidth * 0.045,
                //           width: 10,
                //           padding: EdgeInsets.all(
                //               scrWidth * 0.033),
                //           child: SvgPicture.asset(
                //             'assets/icons/storename.svg',
                //             fit: BoxFit.contain,
                //             color: Color(0xffB0B0B0),
                //           ),
                //         ),
                //         fillColor: textFormFieldFillColor,
                //         filled: true,
                //         contentPadding: EdgeInsets.only(
                //             top: 5, bottom: scrWidth * 0.033),
                //         disabledBorder: InputBorder.none,
                //         enabledBorder: InputBorder.none,
                //         errorBorder: InputBorder.none,
                //         border: InputBorder.none,
                //         focusedBorder: UnderlineInputBorder(
                //           borderSide: BorderSide(
                //             color: primarycolor,
                //             width: 2,
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),

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
                //             "Product category",
                //             style: TextStyle(
                //                 fontSize: FontSize15,
                //                 fontFamily: 'Urbanist',
                //                 fontWeight: FontWeight.w600,
                //                 color: Color(0xffB0B0B0)),
                //           ),
                //           items: selectCategory
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
                //           value: selectedCategoryItem,
                //           onChanged: (value) {
                //             setState(() {
                //               selectedCategoryItem = value as String;
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
            GestureDetector(
                onTap: (){
                  pay();
                  },
                child: Padding(
                  padding:  EdgeInsets.only(left: scrWidth*0.62,top: scrHeight*0.01),
                  child: Text(
                    "Add new category",textAlign: TextAlign.end,
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w600,
                        color:primarycolor
                    ),
                  ),
                ),
              ),
               SizedBox(height: scrHeight*0.02,),

                Padding(
                  padding:  EdgeInsets.only(right: scrWidth*0.053,),
                  child: Container(
                    height: textFormFieldHeight45,
                    padding: EdgeInsets.symmetric(
                      horizontal: scrWidth * 0.015,
                      vertical: scrHeight*0.002,
                    ),
                    decoration: BoxDecoration(
                      color: textFormFieldFillColor,
                      borderRadius:
                      BorderRadius.circular(scrWidth * 0.026),
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: productPriceController,
                      focusNode: productPriceFocus,
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
                        labelText: 'Price',
                        labelStyle: TextStyle(
                          color: productPriceFocus.hasFocus
                              ? primarycolor
                              : Color(0xffB0B0B0),
                          fontWeight: FontWeight.w600,
                          fontSize: FontSize15,
                          fontFamily: 'Urbanist',
                        ),
                        prefixIcon: Container(
                          height: scrWidth * 0.045,
                          width: 10,
                          padding: EdgeInsets.all(
                              scrWidth * 0.033),
                          child: SvgPicture.asset(
                            'assets/icons/priceicons.svg',
                            fit: BoxFit.contain,
                            color: Color(0xffB0B0B0),
                          ),
                        ),
                        fillColor: textFormFieldFillColor,
                        filled: true,
                        contentPadding: EdgeInsets.only(
                            top: 5, bottom: scrWidth * 0.033),
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
                ),

                Padding(
                  padding:  EdgeInsets.only(right: scrWidth*0.053,top: scrHeight*0.02),
                  child: Row(
                    children: [
                      Container(
                        height: textFormFieldHeight45,
                        width: scrWidth*0.42,
                        padding: EdgeInsets.symmetric(
                          horizontal: scrWidth * 0.015,
                          vertical: scrHeight*0.002,
                        ),
                        decoration: BoxDecoration(
                          color: textFormFieldFillColor,
                          borderRadius:
                          BorderRadius.circular(scrWidth * 0.026),
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: productUnitController,
                          focusNode: productUnitFocus,
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
                            labelText: 'Quantity',
                            labelStyle: TextStyle(
                              color: productUnitFocus.hasFocus
                                  ? primarycolor
                                  : Color(0xffB0B0B0),
                              fontWeight: FontWeight.w600,
                              fontSize: FontSize15,
                              fontFamily: 'Urbanist',
                            ),
                            prefixIcon: Container(
                              height: scrWidth * 0.045,
                              width: 10,
                              padding: EdgeInsets.all(
                                  scrWidth * 0.033),
                              child: SvgPicture.asset(
                                'assets/icons/priceicons.svg',
                                fit: BoxFit.contain,
                                color: Color(0xffB0B0B0),
                              ),
                            ),
                            fillColor: textFormFieldFillColor,
                            filled: true,
                            contentPadding: EdgeInsets.only(
                                top: 5, bottom: scrWidth * 0.033),
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
                      SizedBox(width: scrWidth*0.0478,),
                      Container(
                        width: scrWidth * 0.425,
                        height: textFormFieldHeight45,
                        decoration: BoxDecoration(
                          color: textFormFieldFillColor,
                          borderRadius:
                          BorderRadius.circular(scrWidth * 0.033),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                               width: scrWidth*0.057,
                            ),
                            SvgPicture.asset(
                              'assets/icons/storecategory.svg',
                            ),
                             SizedBox(width: scrWidth*0.06,),
                            DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                 isExpanded: true,
                                hint: Text(
                                  "Unit",
                                  style: TextStyle(
                                      fontSize: FontSize15,
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.w600,
                                      color:Color(0xffB0B0B0)
                                  ),
                                ),
                                items: productUnit
                                    .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child:  Text(
                                    item.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        fontFamily: 'Urbanist'
                                    ),
                                  ),
                                ))
                                    .toList(),
                                value: selectedValue,
                                onChanged: (value) {
                                  setState(() {
                                    selectedValue = value as String;
                                  });
                                },
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                ),
                                iconSize: 18,
                                iconEnabledColor: Colors.black,
                                iconDisabledColor: Colors.blue,
                                buttonHeight: 50,
                                buttonWidth:70,
                                // buttonPadding: const EdgeInsets.only(right: 10),
                                buttonDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: textFormFieldFillColor,
                                ),
                                // buttonElevation: 2,
                                itemHeight: 40,
                                itemPadding: const EdgeInsets.only(),
                                dropdownMaxHeight: 200,
                                dropdownWidth: 100,
                                 dropdownPadding: EdgeInsets.only(left: 10,top: 15,bottom: 25,right: 30),
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                ),
                                dropdownElevation: 0,

                                scrollbarRadius:  Radius.circular(10),
                                scrollbarThickness: 3,
                                scrollbarAlwaysShow: true,
                                offset: const Offset(-20, 0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Text("Unit : per ${productUnitController.text} ${selectedValue}",style: TextStyle(
                //   fontFamily: 'Urbanist',fontWeight: FontWeight.w600,color: primarycolor,fontSize: 12
                // ),),
                Padding(
                  padding:  EdgeInsets.only(right: scrWidth*0.053,top: scrHeight*0.02),
                  child: Container(
                    height: textFormFieldHeight45,
                    padding: EdgeInsets.symmetric(
                      horizontal: scrWidth * 0.015,
                      vertical: scrHeight*0.002,
                    ),
                    decoration: BoxDecoration(
                      color: textFormFieldFillColor,
                      borderRadius:
                      BorderRadius.circular(scrWidth * 0.026),
                    ),
                    child: TextFormField(
                      controller: productDetailsController,
                      focusNode: productDetails,
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
                        labelText: 'Details',
                        labelStyle: TextStyle(
                          color: productDetails.hasFocus
                              ? primarycolor
                              : Color(0xffB0B0B0),
                          fontWeight: FontWeight.w600,
                          fontSize: FontSize15,
                          fontFamily: 'Urbanist',
                        ),
                        prefixIcon: Container(
                          height: scrWidth * 0.045,
                          width: 10,
                          padding: EdgeInsets.all(
                              scrWidth * 0.033),
                          child: SvgPicture.asset(
                            'assets/icons/storename.svg',
                            fit: BoxFit.contain,
                            color: Color(0xffB0B0B0),
                          ),
                        ),
                        fillColor: textFormFieldFillColor,
                        filled: true,
                        contentPadding: EdgeInsets.only(
                            top: 5, bottom: scrWidth * 0.033),
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
                ),
                 SizedBox(height: scrHeight*0.1,),
                finished==false?Padding(
                  padding:  EdgeInsets.only(right: scrWidth*0.053),
                  child: Container(
                    height: textFormFieldHeight45,
                    width: scrWidth,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(0, 128, 54, 0.33),
                        borderRadius: BorderRadius.circular(21.5)),
                    child: Center(
                      child: Text(
                        "Add Product",
                        style: TextStyle(color: Colors.white,
                            fontFamily: 'Urbanist',
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ) :GestureDetector(
                  onTap: ()async{
                    setState(() {
                      loading=true;
                    });
                    // if(imgUrl==null){
                    //   refreshPage();
                    //   return showSnackbar(context,"add product images upto 5");
                    // }
                    if(productNameController.text.isEmpty){
                      refreshPage();
                      return showSnackbar(context,"Must Provide Product Name");
                    }
                    if(productPriceController.text.isEmpty){
                      refreshPage();
                      return showSnackbar(context,"Must Provide product price");
                    }
                    if(productUnitController.text.isEmpty){
                      refreshPage();
                      return showSnackbar(context,"Must Provide product unit");
                    }
                    // if(categoryNameController.text.isEmpty){
                    //   refreshPage();
                    //   return showSnackbar(context,"Must Provide category name");
                    // }
                    else{
                      final proDat=ProductModel(
                        available: true,
                        images:_imgurl,
                        productName: productNameController.text,
                         productCategory:productCategoryItem,
                        price:double.tryParse(productPriceController.text),
                        unit:selectedValue ,
                        quantity:int.tryParse(productUnitController.text) ,
                        details: productDetailsController.text,
                        storedCategorys: selectedCategoryItem,
                        storeId: widget.data.storeId,
                        delete: false,
                        // categoryName:categoryName,
                      );
                      FirebaseFirestore.instance.collection('stores').doc(widget.data.storeId)
                          .collection('products').add(proDat.toJson()).then((value) =>
                          value.update({'productId':value.id}));
                      print(proDat);
                      print(productPriceController.text);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SuccesfullyAdded(data: widget.data)));
                    }
                    // print(widget.id);
                  },
                  child: Padding(
                    padding:  EdgeInsets.only(right: scrWidth*0.053),
                    child: Container(
                      height: textFormFieldHeight45,
                      width: scrWidth,
                      decoration: BoxDecoration(
                          color: primarycolor,
                          borderRadius: BorderRadius.circular(21.5)),
                      child: Center(
                        child: Text(
                          "Add Product",
                          style: TextStyle(color: Colors.white,
                              fontFamily: 'Urbanist',
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
   void pay() {
       showDialog(
         context: context,
         builder: (context) => StatefulBuilder(
           builder: (BuildContext context, setState) {
             // payableAmountNode.addListener(() {
             //   setState(() {});
             // });
             return AlertDialog(
               shape:
                   RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
               title: Text("Add New Category"),
               titleTextStyle: TextStyle(
                   fontSize:17,
                   fontFamily: 'Urbanist',
                   fontWeight: FontWeight.w600,
                   color: Colors.black),
               content: Column(
                 mainAxisSize: MainAxisSize.min,
                 children: [
                   Container(
                     width: scrWidth,
                     height: textFormFieldHeight45,
                     padding: EdgeInsets.symmetric(
                       horizontal: scrWidth * 0.015,
                       vertical: 2,
                     ),
                     decoration: BoxDecoration(
                       color: textFormFieldFillColor,
                       borderRadius: BorderRadius.circular(scrWidth * 0.03),
                     ),
                     child: TextFormField(
                      focusNode: productCategoryName,
                       controller: productCategoryNameController,
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
                         labelText: 'Category Name',
                         labelStyle: TextStyle(
                           color: productCategoryName.hasFocus
                               ? primarycolor
                               : textFormUnFocusColor,
                           fontWeight: FontWeight.w600,
                           fontSize: FontSize15,
                           fontFamily: 'Urbanist',
                         ),
                         fillColor: textFormFieldFillColor,
                         filled: true,
                         contentPadding: EdgeInsets.only(
                             top: 5,
                             bottom: scrWidth * 0.033,
                             left: scrWidth * 0.033),
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
                     height: scrWidth * 0.03,
                   ),

                   InkWell(
                     onTap: () {
                       productCategoryList.add(productCategoryNameController.text);
                       FirebaseFirestore.instance.collection('stores').doc(widget.data.storeId).update({
                         'productCategory':FieldValue.arrayUnion(productCategoryList),
                       });
                       productCategoryNameController.text='';
                       Navigator.pop(context);
                       _showToast(context);
                     },
                     child: Container(
                       width: scrWidth,
                       height: textFormFieldHeight45,
                       decoration: BoxDecoration(
                           color: primarycolor,
                           borderRadius: BorderRadius.circular(12)),
                       child: Center(
                         child: GestureDetector(

                           child: Text(
                             "Save",
                             style: TextStyle(
                                 fontSize: FontSize16,
                                 fontFamily: 'Urbanist',
                                 fontWeight: FontWeight.w600,
                                 color: Colors.white),
                           ),
                         ),
                       ),
                     ),
                   ),
                 ],
               ),
             );
           },
         ),
       );
     }


}
