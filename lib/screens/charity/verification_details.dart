
import 'dart:ui';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:threems/kuri/createkuri.dart';
import 'package:threems/model/usermodel.dart';
import 'package:threems/screens/charity/donatenowpage.dart';
import 'package:threems/screens/charity/fpayment.dart';
import '../../model/charitymodel.dart';
import '../../utils/themes.dart';
import '../../widgets/percentage_widget.dart';
import '../home_screen.dart';
import '../splash_screen.dart';
import 'dart:io';
import 'basic_details.dart';
void showUploadMessage(BuildContext context, String message,
    {bool showLoading = false}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        duration: showLoading?Duration(minutes: 30):Duration(seconds: 4),
        content: Row(
          children: [
            if (showLoading)
              Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: CircularProgressIndicator(),
              ),
            Text(message),
          ],
        ),
      ),
    );
}
List userdetails=[];
var fileName;
var docName;



class VerificationDetails extends StatefulWidget {
  const VerificationDetails({super.key});

  @override
  State<VerificationDetails> createState() => _VerificationDetailsState();
}

class _VerificationDetailsState extends State<VerificationDetails> {


  final TextEditingController youtubecontroller=TextEditingController();
  final TextEditingController videoLinkController=TextEditingController();
  String? imgUrl;
  var imgFile;
  var uploadTask;
  var fileUrl;
  var docUrl;
  var uploadTasks;
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
    final imageFile = await ImagePicker.platform.pickImage(
        source: ImageSource.gallery);
    setState(() {
      imgFile = File(imageFile!.path);
      uploadImageToFirebase(context);
    });
  }
  var pickFile;
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
      fileUrl=urlDownlod!;

    });

  }
  _pickFile() async {
    print('      PICK FILE      ');
    final result = await FilePicker.platform.pickFiles(
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
  var pickFiles;
  Future uploadFileToFireBases(fileBytes) async {
    print(fileBytes);
    uploadTasks = FirebaseStorage.instance.ref('documents/${DateTime.now()}')
        .putData(fileBytes);
    final snapshot= await  uploadTask?.whenComplete((){});
    final urlDownlods = await  snapshot?.ref.getDownloadURL();
    print("--------------------------------------------------------------------------------");

    print(urlDownlods);

    // FirebaseFirestore.instance.collection('candidates').doc(widget.id).update({
    //   'documents.$name':urlDownlod,
    // });

    setState(() {
      docUrl=urlDownlods!;

    });

  }
  _pickFiles() async {
    print('      PICK FILE      ');
    final result = await FilePicker.platform.pickFiles(
      withData: true,
    );

    if(result==null) return;

    // final fileBytes=result.files.first.bytes;

    pickFiles=result.files.first;
    final fileBytes = pickFiles!.bytes;
    docName = result.files.first.name;

    print(fileBytes);
    print('      PICK FILE      ');
    uploadFileToFireBases(fileBytes);
    setState(() {

    });

  }
  final FocusNode youtubeLinkNode = FocusNode();
  final FocusNode videoLinkNode=FocusNode();
  @override
  void initState() {
    youtubeLinkNode.addListener(() {
      setState(() {});
    });
    // image = null;
    super.initState();
  }

  @override
  void dispose() {
    videoLinkNode.dispose();
    youtubeLinkNode.dispose();
    super.dispose();
  }
  bool loading=false;
  refreshPage() {
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(charityDetails);
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await confirmQuitDialog(context);
        return shouldPop ?? false;
      },

      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: Offset(0, 4),
                  blurRadius: 25),
            ]),
            child: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.only(
                    // top: scrHeight * 0.09,
                    // left: scrWidth * 0.05,
                    // bottom: scrHeight * 0.02,
                      right: scrWidth * 0.04),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 25,
                  ),
                ),
              ),
              title: Text(
                "Create Charity",
                style: TextStyle(
                    fontSize: FontSize17,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(
            left: padding15, right: padding15, top: scrWidth * 0.025,
            // vertical: scrWidth * 0.05,
          ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "VERIFICATION DETAILS",
                      style: TextStyle(
                          fontSize: FontSize16,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    PercentageWidget(percent: 75),
                  ],
                ),
                SizedBox(
                  height: scrWidth * 0.08,
                ),
                Row(
                  mainAxisAlignment:
                  imgFile==null ?  MainAxisAlignment.start:MainAxisAlignment.end ,
                  children: [
                    Text(
                      "Upload Photos",
                      style: TextStyle(
                        fontSize: FontSize15,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w500,
                        color: imgFile==null ? Color(0xff8391A1): primarycolor ,
                      ),
                    ),
                    imgFile==null ?SizedBox(): SizedBox(width: scrWidth * 0.01)  ,
                    imgFile ==null?  SizedBox(
                      child: SvgPicture.asset(
                        'assets/icons/uploaded.svg',
                        color:Color(0xff8391A1) ,
                      ),
                    ):SizedBox(
                            child: SvgPicture.asset(
                              'assets/icons/uploaded.svg',
                              color: primarycolor,
                            ),
                          )


                  ],
                ),
                SizedBox(
                  height: scrWidth * 0.02,
                ),

                InkWell(
                  onTap: (){
                    _pickImage();
                  },
                  child: Container(
                    height:scrHeight*0.16,
                    width: scrWidth*1,
                          decoration: BoxDecoration(
                            color: Color(0xffF7F8F9),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Color(0xffDADADA),
                            ),
                          ),
                          child: Center(
                            child: imgFile==null?Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/camera2.svg',
                                  color: Color(0xff8391A1),
                                ),
                                SizedBox(
                                  width: scrWidth * 0.04,
                                ),
                                Text(
                                  'Upload Cover Photo',
                                  style: TextStyle(
                                    fontSize: FontSize15,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff8391A1),
                                  ),
                                )
                              ],
                            ):Container(
                              height:scrHeight*0.16,
                              width: scrWidth*1,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: FileImage(imgFile!) as ImageProvider,fit: BoxFit.fill),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Color(0xffDADADA),
                                ),
                              ),

                            )
                          ),
                        ),
                ),
                SizedBox(
                  height: scrWidth * 0.02,
                ),
                pickFile==null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Documents Uploaded",
                            style: TextStyle(
                              fontSize: FontSize15,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w500,
                              color: Color(0xff8391A1),
                            ),
                          ),
                          SizedBox(width: scrWidth * 0.01),
                          SizedBox(
                            child: SvgPicture.asset(
                              'assets/icons/uploaded.svg',
                              color: Color(0xff8391A1),
                            ),
                          )
                        ],
                      )
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Documents Uploaded",
                      style: TextStyle(
                        fontSize: FontSize15,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w500,
                        color: primarycolor,
                      ),
                    ),
                    SizedBox(width: scrWidth * 0.01),
                    SizedBox(
                      child: SvgPicture.asset(
                        'assets/icons/uploaded.svg',
                        color: primarycolor,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: scrWidth * 0.02,
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
                            "Upload Documents",
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
                  height: scrWidth * 0.06,
                ),
                pickFiles==null
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Documents Uploaded",
                      style: TextStyle(
                        fontSize: FontSize15,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w500,
                        color: Color(0xff8391A1),
                      ),
                    ),
                    SizedBox(width: scrWidth * 0.01),
                    SizedBox(
                      child: SvgPicture.asset(
                        'assets/icons/uploaded.svg',
                        color: Color(0xff8391A1),
                      ),
                    )
                  ],
                )
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Documents Uploaded",
                      style: TextStyle(
                        fontSize: FontSize15,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w500,
                        color: primarycolor,
                      ),
                    ),
                    SizedBox(width: scrWidth * 0.01),
                    SizedBox(
                      child: SvgPicture.asset(
                        'assets/icons/uploaded.svg',
                        color: primarycolor,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: scrWidth * 0.02,
                ),
                InkWell(
                  onTap: (){
                    _pickFiles();

                  },
                  child: pickFiles==null?  Container(
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
                    child: Text(docName!,style: TextStyle(
                      color: Color(0xff8391A1),
                      fontWeight: FontWeight.w500,
                      fontSize: FontSize15,
                      fontFamily: 'Urbanist',

                    ),),

                  ),
                ),
                SizedBox(
                  height: scrWidth * 0.06,
                ),
                Text(
                  'Tag the links of Videos for know more about the situation',
                  style: TextStyle(
                    color: Color(0xff8391A1),
                    fontWeight: FontWeight.w500,
                    fontSize: FontSize15,
                    fontFamily: 'Urbanist',
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
                    vertical: scrHeight*0.002,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xffDADADA),
                    ),
                    color: textFormFieldFillColor,
                    borderRadius: BorderRadius.circular(scrWidth * 0.026),
                  ),
                  child: TextFormField(
                    focusNode: youtubeLinkNode,
                    controller: youtubecontroller,
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
                      labelText: 'Paste the link',
                      labelStyle: TextStyle(
                        color: youtubeLinkNode.hasFocus
                            ? primarycolor
                            : textFormUnFocusColor,
                        fontWeight: FontWeight.w500,
                        fontSize: FontSize15,
                        fontFamily: 'Urbanist',
                      ),
                      fillColor: textFormFieldFillColor,
                      filled: true,
                      prefixIcon: SvgPicture.asset(
                        'assets/icons/youtube.svg',
                        width: scrWidth*0.03,
                        height: scrHeight*0.02,
                      ),
                      contentPadding: EdgeInsets.only(
                          left: scrWidth*0.03, top: scrHeight*0.006, bottom: scrWidth * 0.033),
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
                  height: scrWidth * 0.04,
                ),
                Container(
                  width: scrWidth,
                  height: textFormFieldHeight45,
                  padding: EdgeInsets.symmetric(
                    horizontal: scrWidth * 0.015,
                    vertical: scrHeight*0.002,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xffDADADA),
                    ),
                    color: textFormFieldFillColor,
                    borderRadius: BorderRadius.circular(scrWidth * 0.026),
                  ),
                  child: TextFormField(
                    focusNode: videoLinkNode,
                    controller: videoLinkController,
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
                      labelText: 'Paste Video link',
                      labelStyle: TextStyle(
                        color: videoLinkNode.hasFocus
                            ? primarycolor
                            : textFormUnFocusColor,
                        fontWeight: FontWeight.w500,
                        fontSize: FontSize15,
                        fontFamily: 'Urbanist',
                      ),
                      fillColor: textFormFieldFillColor,
                      filled: true,
                      // prefixIcon: SvgPicture.asset(
                      //   'assets/icons/youtube.svg',
                      //   width: scrWidth*0.03,
                      //   height: scrHeight*0.02,
                      // ),
                      contentPadding: EdgeInsets.only(
                          left: scrWidth*0.03,
                          top: scrHeight*0.006,
                          bottom: scrWidth * 0.02),
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
                  height: scrWidth * 0.04,
                ),

                GestureDetector(
                    onTap: () async{
                      setState(() {
                        loading=true;
                      });
                      if(imgFile==null){
                        refreshPage();
                        return showSnackbar(context,"Image Must Provide");
                      }
                      if(pickFile==null){
                        refreshPage();
                        return showSnackbar(context,"Please Provide Supporting Documents");
                      }


                    else {
                        charityDetails.add(
                            {
                              "youTubeLink": youtubecontroller.text,
                              "image": imgUrl,
                              "documents": fileUrl,
                              "fileNme": fileName,
                              "otherDocument":docUrl,
                              "videoLink":videoLinkController.text,
                              "docNme":docName
                            }

                        );
                      }
                    print(fileUrl);
                    print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
                    print(charityDetails);
                    print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
                    var char=CharityModel(
                      orgName: charityDetails[0]['orgName'],
                      charityDetailes: charityDetails[0]['charityDetailes'],
                      emailId: charityDetails[0]['emailId'],
                      phoneNumber: charityDetails[0]['phoneNumber'],
                      beneficiaryLocation: charityDetails[1]['beneficiaryLocation'],
                      endDate: charityDetails[1]['endDate'],
                      valueAmount: charityDetails[1]['valueAmount'],
                      beneficiaryName: charityDetails[1]['beneficiaryName'],
                      beneficiaryPhNumber: charityDetails[1]['beneficiaryPhNumber'],
                      accountNumber: charityDetails[2]['accountNumber'],
                      confirmAccountNumber: charityDetails[2]['confirmAccountNumber'],
                      accountHolderName: charityDetails[2]['accountHolderName'],
                      bankName: charityDetails[2]['bankName'],
                      ifscCode: charityDetails[2]['ifscCode'],
                      youTubeLink: charityDetails[3]['youTubeLink'],
                      image: charityDetails[3]['image'],
                      documents: charityDetails[3]['documents'],
                      otherDocument: charityDetails[3]['otherDocument'],
                      videoLink: charityDetails[3]['videoLink'],
                      status: 0,
                      docNme: charityDetails[3]['docNme'],
                      payments: [],
                      cause: charityDetails[0]['cause'],
                      reason: charityDetails[0]['reason'],
                      userId: currentuser?.userId,
                      userName:currentuser?.userName,
                      block:false,
                      qrImage: charityDetails[2]['qrImage'],
                      fileNme: charityDetails[3]['fileNme'],
                    );
                    createCharity(char);
                    print("------------------===========================-----------------========================================");
                    print(fileUrl);
                    print("------------------===========================-----------------========================================");
                    print(imgUrl);
                    print("===========================================================================================================");
                    print(youtubecontroller.text);

                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => PaymentSucessful(),
                        ));
                  },
                  child:Container(
                    height: scrHeight*0.065,
                    decoration: BoxDecoration(
                        color: primarycolor,
                        borderRadius: BorderRadius.circular(17)),
                    margin: EdgeInsets.symmetric(vertical: scrWidth*0.03, horizontal: scrHeight*0.06),
                    child: Center(
                        child: Text(
                          "Continue",
                          style: TextStyle(color: Colors.white),
                        )),
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  createCharity(CharityModel char)async{
    FirebaseFirestore.instance.collection('charity').add(char.toJson()).then((value) =>
    value.update({'charityId':value.id})
    );
  }
  // pickLogo() async {
  //   XFile? file = await _picker.pickImage(source: ImageSource.gallery);
  //   if (file != null) {
  //     image = File(file.path);
  //     setState(() {});
  //   }
  // }


}
