import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gMap;
import 'package:google_maps_place_picker/google_maps_place_picker.dart' as gMapPlacePicker;
// import 'package:geo_firestore_flutter/geo_firestore_flutter.dart';
import 'package:getwidget/components/dropdown/gf_multiselect.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';
import 'package:image_picker/image_picker.dart';
import 'package:threems/Authentication/root.dart';
import 'package:threems/kuri/createkuri.dart';
import 'package:threems/model/usermodel.dart';
import 'package:threems/screens/home_screen.dart';
import 'package:image_cropper/image_cropper.dart';


import '../model/Buy&sell.dart';
import '../screens/Utilities/AddYouService.dart';
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
  String serviceLocation='';
  TextEditingController? latitude;
  TextEditingController? longitude;
   gMapPlacePicker.PickResult? result;
  bool trackedlocation = false;
  List categoryList=[];
  List<String> selectCategory=[];
  List cate=[];
  List givenCategory=[];

  // geoLocation(String id)async{
  //   GeoFirestore geoFirestore = GeoFirestore(FirebaseFirestore.instance.collection('stores'));
  //   await geoFirestore.setLocation(id, GeoPoint(lat!, long!));
  //   final queryLocation = GeoPoint(lat!, long!);
  //   // creates a new query around [37.7832, -122.4056] with a radius of 0.6 kilometers
  //   final List<DocumentSnapshot> documents = await geoFirestore.getAtLocation(queryLocation, 0.6);
  //   documents.forEach((doc) {
  //     print("111111111111111111111111111111111111111111111111111111");
  //     print(doc.data());
  //     print("111111111111111111111111111111111111111111111111111111");
  //   });
  // }
  Map<String,dynamic> categoryListAll={};

  Map<String,dynamic> categoryNames={};
  getCategory(){
    FirebaseFirestore.instance.collection('storeCategory').snapshots().listen((event) {
      categoryList=[];
      categoryNames={};
      categoryListAll={};
      cate=[];


      for(DocumentSnapshot <Map<String,dynamic>> doc in event.docs){
        cate.add(doc);
        print("---====--=--9022222222222222222222222222222222222222222222222222222222222222222");
        print('${doc['categoryName']}');
        print('${event.docs[1]['categoryName']}');

        // categoryListAll.add(doc.data()!);
        categoryNames[doc.get('categoryId')] = doc.get('categoryName');
        categoryList.add(doc.get('categoryName'));
        // categoryListAll[doc.get('categoryName')]=doc.id;

      }
      givenCategory=[];
      for(int i=0;i<cate.length; i++){
        givenCategory.add({
          'categoryId':cate[i]['categoryId']??"",
          'categoryName':cate[i]['categoryName']??"",
          'categoryImage':Image(image:NetworkImage(cate[i]['categoryImage']??'')),
        });
      }
      print(categoryList);
      if(mounted){
        setState(() {

        });
      }
    });
    
  }
  ////////////////////////////////////////

  var pickFile;
  var fileName;

  Future uploadFileToFireBase(fileBytes) async {
    print(fileBytes);
    uploadTask = FirebaseStorage.instance.ref('uploads/${DateTime.now()}')
        .putData(fileBytes);
    final snapshot= await  uploadTask?.whenComplete((){});
    final urlDownlod = await  snapshot?.ref.getDownloadURL();
    print("--------------------------------------------------------------------------------");

    print(urlDownlod);

    // FirebaseFirestore.instance.collection('candidates').doc(widget.id).update({
    //   'documents.$name':urlDownlod,
    // });

    setState(() {
      loading=false;

      fileUrl=urlDownlod!;

    });

  }
  _pickFile() async {
    loading=true;

    print('      PICK FILE      ');
    final result = await FilePicker.platform.pickFiles(
      // allowedExtensions: ['pdf'],
      // type: FileType.custom,
      withData: true,
    );

    if(result==null) return;

    // final fileBytes=result.files.first.bytes;

    pickFile=result.files.first;
    final fileBytes = pickFile!.bytes;
    fileName = result.files.first.name;

    print(fileBytes);
    print('      PICK FILE      ');
    uploadFileToFireBase(fileBytes);
    setState(() {

    });

  }
  ///////////////////////////////////////

  String? imgUrls;
  var imgFiles;
  var uploadTasks;
  var fileUrls;
  Future uploadImageToFirebases(BuildContext context) async {
    Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('deposits/${imgFiles.path}');
    UploadTask uploadTask = firebaseStorageRef.putFile(imgFiles);
    TaskSnapshot taskSnapshot = (await uploadTask);
    String value = await taskSnapshot.ref.getDownloadURL();
    print(value);

    // if(value!=null){
    //   imageList.add(value);
    // }
    setState(() {
      loading=false;

      imgUrls = value;

    });
  }
  _pickImages() async {
    loading=true;
    final imageFile = await ImagePicker.platform.pickImage(
        source: ImageSource.gallery);
    setState(() {
      imgFiles = File(imageFile!.path);
      uploadImageToFirebases(context);
    });
  }
  ////////////////////////////

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
      loading=false;

      imgUrl = value;

    });
  }
  _pickImage() async {
    loading=true;

    final imageFile = await ImagePicker.platform.pickImage(
        source: ImageSource.gallery);
    setState(() {
      imgFile = File(imageFile!.path);
      // imgFile=_cropImage(imageFile: imgFile);
      uploadImageToFirebase(context);
    });
  }
  set(){
    setState(() {

    });
  }
  String? selectedValue;
  final FocusNode storeNameFocus = FocusNode();
  final FocusNode storeAddressFocus = FocusNode();
  final FocusNode delivereyChargeFocus=FocusNode();
  final FocusNode localBodyFocus=FocusNode();
  final FocusNode stateFocus=FocusNode();
  final FocusNode districtFocus=FocusNode();
  final FocusNode wardFocus=FocusNode();
  final TextEditingController storeNameController = TextEditingController();
  final TextEditingController storeAddressController = TextEditingController();
  final TextEditingController deliveryChargeController=TextEditingController();
  final TextEditingController localBodyController=TextEditingController();
  final TextEditingController stateController=TextEditingController();
  final TextEditingController districtController=TextEditingController();
  final TextEditingController wardController=TextEditingController();
  bool loading=false;
  refreshPage() {
    setState(() {
      loading = false;
    });
  }
//   Future<File?> _cropImage({required File imageFile}) async {
//     CroppedFile? croppedImage=await ImageCropper().cropImage(sourcePath: imageFile.path);
//     if(croppedImage == null) return null;
//     return File(croppedImage.path);
//
// }
  // bool loading=false;
  // refreshPage() {
  //   setState(() {
  //     loading = false;
  //   });
  // }
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
    delivereyChargeFocus.addListener(() {
      setState(() {});
    });
    latitude = TextEditingController(text:'0');
    longitude = TextEditingController(text:'0');
    super.initState();
  }

  @override
  void dispose() {
    storeNameFocus.dispose();
    storeAddressFocus.dispose();
    delivereyChargeFocus.dispose();
    stateFocus.dispose();
    districtFocus.dispose();
    wardFocus.dispose();

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
              top: scrHeight * 0.02,
              left: scrWidth * 0.05,
              // bottom: scrHeight * 0.02,
              right: scrWidth * 0.09),
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 25,
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
        body:loading?Center(child: CircularProgressIndicator()): SingleChildScrollView(
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
                  decoration: BoxDecoration(
                      color: textFormFieldFillColor,
                      borderRadius: BorderRadius.circular(scrWidth * 0.026)),
                  child: GFMultiSelect(
                    items: categoryList,
                    // initialSelectedItemsIndex: [0, 1],
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
                    keyboardType: TextInputType.number,
                    controller: deliveryChargeController,
                    focusNode: delivereyChargeFocus,
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
                      labelText: 'Delivery Charge',
                      labelStyle: TextStyle(
                        color: delivereyChargeFocus.hasFocus
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
                Row(
                  children: [
                    Container(
                      width: scrWidth*0.88,
                      height: textFormFieldHeight45,
                      // padding: EdgeInsets.symmetric(
                      //   horizontal: scrWidth * 0.015,
                      //   vertical:scrHeight*0.002,
                      // ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xffDADADA),
                        ),
                        color: textFormFieldFillColor,
                        borderRadius: BorderRadius.circular(scrWidth * 0.026),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Location: '+serviceLocation.toString(),style: GoogleFonts.outfit(),)
                              // Text('Lattitude:'+latitude!.text),
                              // Text('Longitude:'+longitude!.text),
                            ],
                          ),

                          InkWell(
                              onTap: ()  async {
                                Position location = await Geolocator.getCurrentPosition(
                                    desiredAccuracy: LocationAccuracy.high
                                );

                                await   Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        gMapPlacePicker.PlacePicker(
                                          apiKey: "AIzaSyCUZFUZ1yMpkzh6QUnKj54Q2N4L2iT4tBY",
                                          initialPosition: gMap.LatLng(
                                              location.latitude,location.longitude
                                          ),
                                          // Put YOUR OWN KEY here.
                                          searchForInitialValue: false,
                                          selectInitialPosition: true,
                                          // initialPosition: LatLng(currentLoc==null?0:currentLoc!.latitude,currentLoc==null?0:currentLoc!.longitude),
                                          onPlacePicked: (res) async {
                                            Navigator.of(context).pop();
                                            // GeoCode geoCode = GeoCode();
                                            // Address address=await geoCode.reverseGeocoding(latitude: res.geometry!.location.lat,longitude: res.geometry!.location.lng);
                                            result=res;
                                            latitude!.text=res.geometry!.location.lat.toString();
                                            longitude!.text=res.geometry!.location.lng.toString();
                                            List<Placemark> placemarks = await placemarkFromCoordinates(
                                                res.geometry!.location.lat, res.geometry!.location.lng);
                                            Placemark place = placemarks[0];
                                            serviceLocation = place.locality!;
                                            // longitude!.text=res.geometry!.location.lng.toString();
                                            // lat=result.geometry!.location.lat;
                                            // long=result.geometry!.location.lng;
                                            set();
                                          },
                                          useCurrentLocation: true,
                                        ),
                                  ),
                                );
                              },
                              child: Icon(Icons.location_on,color: Colors.red,size: 30,)),

                        ],
                      ),
                    ),

                  ],
                ),
                SizedBox(
                  height: scrHeight * 0.02,
                ),
                Text("Upload QRcode"),
                SizedBox(
                  height: scrHeight * 0.005,
                ),
                InkWell(
                  onTap: (){
                    _pickImages();
                  },
                  child: Container(
                    height: scrHeight * 0.2,
                    width: scrWidth * 0.56,
                    decoration: BoxDecoration(
                      color: textFormFieldFillColor,
                      borderRadius: BorderRadius.circular(scrWidth * 0.04),
                    ),
                    child: Center(
                        child: imgFiles==null?Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                                child: SvgPicture.asset(
                                    "assets/icons/bigcamera.svg"))
                          ],
                        ):Container(
                          height: scrHeight * 0.2,
                          width: scrWidth * 0.56,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(imgFiles!) as ImageProvider,fit: BoxFit.fill),
                            borderRadius: BorderRadius.circular(8),
                            // border: Border.all(
                            //   color: Color(0xffDADADA),
                            // ),
                          ),

                        )
                    ),
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
                    controller: stateController,
                    focusNode: stateFocus,
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
                      labelText: 'State',
                      labelStyle: TextStyle(
                        color: stateFocus.hasFocus
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
                    controller: districtController,
                    focusNode: districtFocus,
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
                      labelText: 'District',
                      labelStyle: TextStyle(
                        color: districtFocus.hasFocus
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
                    controller: localBodyController,
                    focusNode: localBodyFocus,
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
                      labelText: 'Local body',
                      labelStyle: TextStyle(
                        color: localBodyFocus.hasFocus
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
                Text("Upload Document"),
                SizedBox(
                  height: scrHeight * 0.02,
                ),
                InkWell(
                  onTap: (){
                    _pickFile();

                  },
                  child: pickFile==null?  Container(
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
                            "Upload Pdf Document",
                            style: TextStyle(
                              color: Color(0xff8391A1),
                              fontWeight: FontWeight.w500,
                              fontSize: FontSize15,
                              fontFamily: 'Urbanist',
                            ),
                          ),
                          SvgPicture.asset(
                            'assets/icons/camera2.svg',
                            color: Color(0xff8391A1),
                          ),
                        ],
                      ),
                    ),
                  ):Container(
                    width: scrWidth,
                    height: textFormFieldHeight45,
                    padding: EdgeInsets.symmetric(
                      horizontal: scrWidth * 0.04,
                      vertical: scrHeight*0.015,
                    ),
                    decoration: BoxDecoration(
                      color: textFormFieldFillColor,
                      border: Border.all(
                        color: Color(0xffDADADA),
                      ),
                      borderRadius: BorderRadius.circular(scrWidth * 0.026),
                    ),
                    child: Text(fileName!,style: TextStyle(
                      color: Color(0xff8391A1),
                      fontWeight: FontWeight.w500,
                      fontSize: FontSize15,
                      fontFamily: 'Urbanist',

                    ),),

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
                    controller: wardController,
                    focusNode: wardFocus,
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
                      labelText: 'ward',
                      labelStyle: TextStyle(
                        color: wardFocus.hasFocus
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

                SizedBox(
                  height: scrHeight * 0.065,
                ),
                GestureDetector(
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
                    }if(deliveryChargeController.text.isEmpty){
                      refreshPage();
                      return showSnackbar(context,"Must Provide Delivery Charge");}
                    if(storeAddressController.text.isEmpty){
                      refreshPage();
                      return showSnackbar(context,"Must Provide StoreAddress");}
                    if(imgFile==null){
                      refreshPage();
                      return showSnackbar(context,"Must Provide QR code image");
                    }if(stateController.text.isEmpty){
                      refreshPage();
                      return showSnackbar(context,"Must Provide State");
                    }if(districtController.text.isEmpty){
                      refreshPage();
                      return showSnackbar(context,"Must Provide District");
                    }
                    if(localBodyController.text.isEmpty){
                      refreshPage();
                      return showSnackbar(context,"Must Provide localBody");
                    }if(pickFile==null){
                      refreshPage();
                      return showSnackbar(context,"Must Provide local Body Document");
                    }if(wardController.text.isEmpty){
                      refreshPage();
                      return showSnackbar(context,"Must Provide Ward");
                    }else{
                      GeoFirePoint myLocation =
                      geo.point(latitude:double.tryParse(latitude!.text)??0,
                          longitude: double.tryParse(longitude!.text)??0);

                      // List<String> ids=[];
                      // for(var item in selectCategory){
                      //   ids.add(categoryListAll[item]);
                      // }
                      // print(ids);
                      final strDat = StoreDetailsModel(
                        online:false,
                        storeImage: imgUrl??'',
                        latitude: lat??0,
                        longitude:long ??0,
                        localBodyDoc:fileUrl??'',
                        productCategory: [],
                        localBodyName:localBodyController.text??'' ,
                        deliveryCharge: double.tryParse(deliveryChargeController.text)??0,
                        // categoryId:,
                        storeVerification: false,
                        block:false,
                        blockedReason: '',
                        district: districtController.text??'',
                        state: stateController.text??'',
                        ward: wardController.text??'',
                          status: 0,
                        contactNumber:currentuser?.phone ?? '',
                        rejected: false,
                        rejectedReason: '',
                        userId: currentuserid??'',
                        storeQR: imgUrls??'',
                        storeName: storeNameController.text,
                        storeCategory: selectCategory,
                        storeAddress: storeAddressController.text??'',
                        storeLocation: serviceLocation,
                        position: myLocation.data,
                        localBodyDocName: fileName??'',
                        totalSales: 0


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
                    width: scrWidth*0.9,
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
                SizedBox(
                  height: scrHeight * 0.1,
                ),




              ],
            ),
          ),
        ),
        // floatingActionButton:
        // finish
        //     ? Container(
        //   height: textFormFieldHeight45,
        //   width: scrWidth,
        //   decoration: BoxDecoration(
        //       color: Color.fromRGBO(0, 128, 54, 0.33),
        //       borderRadius: BorderRadius.circular(21.5)),
        //   child: Center(
        //     child: Text(
        //       "Finish",
        //       style: TextStyle(
        //           color: Colors.white,
        //           fontFamily: 'Urbanist',
        //           fontSize: 16,
        //           fontWeight: FontWeight.w700),
        //     ),
        //   ),
        // )
        //     :

      ),
    );
  }

  createStore(StoreDetailsModel strDat) async {
    String? id;
    FirebaseFirestore.instance
        .collection('stores')
        .add(strDat.toJson())
        .then((value) {
          // geoLocation(value.id);

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
