import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Authentication/root.dart';
import '../../model/Buy&sell.dart';
import '../../screens/splash_screen.dart';
import '../../utils/themes.dart';

class BottomSheetPage extends StatefulWidget {
  final StoreDetailsModel storeDetailsModel;
  final String category;
  const BottomSheetPage({Key? key, required this.storeDetailsModel, required this.category}) : super(key: key);

  @override
  _BottomSheetPageState createState() => _BottomSheetPageState();
}

class _BottomSheetPageState extends State<BottomSheetPage> {
  final FocusNode reasonFocusNode=FocusNode();
  final TextEditingController reasonController = TextEditingController();
  List reasons=[];
  String settingsid='settings';
  bool isVisible=false;

  getReasons() async {
    DocumentSnapshot doc=await FirebaseFirestore.instance.collection('settings').doc(settingsid).get();
    reasons=doc['reportReasons'];

    if(mounted){
      setState(() {

      });
    }
  }
  @override
  void initState() {
    getReasons();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      //so you don't have to change MaterialApp canvasColor
      child:  Container(
          height: 200,
          decoration:  BoxDecoration(
              color: Colors.white,
              borderRadius:  BorderRadius.only(
                  topLeft:  Radius.circular(30),
                  topRight:  Radius.circular(30))),
          child: Padding(
            padding:  EdgeInsets.only(left: scrWidth*0.02,right: scrWidth*0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                Center(
                  child: Text("Report",
                    style: TextStyle(
                        fontSize: scrWidth * 0.065,
                        color: Colors.black,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(height: 25,),

                Padding(
                  padding:  EdgeInsets.only(left:scrWidth*0.05, ),
                  child: Text("Why are you reporting this ?",
                    style: TextStyle(
                        fontSize: scrWidth * 0.04,
                        color: Colors.black,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: scrHeight*0.02,),

                // SizedBox(height: scrHeight*0.02,),
                // Container(
                //   height: 40,
                //   width: 100,
                //   // color: Colors.blue,
                //   child: Text("Other",style: TextStyle(
                //       fontWeight: FontWeight.w300,
                //       fontFamily: 'Urbanist',
                //       color: Colors.black
                //
                //   )),
                //
                // ),

                //  isClicked==1?Padding(
                //    padding:  EdgeInsets.only(left: 65,top: 10,bottom: 10),
                //    child: Text("----------------------Or-------------------------"),
                //  ):SizedBox(),
                // isClicked==1? SizedBox(height: scrHeight*0.02,):SizedBox(),

                Padding(
                  padding:  EdgeInsets.only(left: 15,right: 15),
                  child: Container(
                    height: 200,
                    // color: Colors.red,
                    child: ListView.builder(
                        itemCount: reasons.length,
                        itemBuilder: (context,index){
                          return InkWell(
                            onTap: (){
                              Navigator.pop(context);
                              _doneBottomSheet();
                              FirebaseFirestore.instance
                                  .collection('reportReasons')
                                  .add({
                                'storeId':widget.storeDetailsModel.storeId,
                                'reason':reasons[index],
                                'date': DateTime.now(),
                                'reportUserId': currentuserid,
                              }).then((value) => value.update(
                                  {'reportId': value.id}));
                            },
                            child: Padding(
                              padding: EdgeInsets.only(top: 15),
                              child: Row(

                                children: [
                                  Container(
                                    height: 13,
                                    width: 13,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwQc8CJ2ZWQjxOYem_HOJVtj6BYXb54VRdjCRGJbOpafX90W_qHV6kPoYpY0icbhPv154&usqp=CAU"))),
                                  ),
                                  SizedBox(width: 10,),
                                  Text(reasons[index],style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontFamily: 'Urbanist',
                                      color: Colors.black,fontSize:15

                                  )),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                )
                // Padding(
                //   padding:  EdgeInsets.only(left: scrWidth*0.03),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       SizedBox(height: scrHeight*0.02,),
                //
                //       Text("I just dont't like it",
                //         style: TextStyle(
                //             fontSize: scrWidth * 0.04,
                //             color: Colors.black,
                //             fontFamily: 'Urbanist',
                //             fontWeight: FontWeight.w500),
                //       ),
                //       SizedBox(height: scrHeight*0.02,),
                //
                //       Text("fraud",
                //         style: TextStyle(
                //             fontSize: scrWidth * 0.04,
                //             color: Colors.black,
                //             fontFamily: 'Urbanist',
                //             fontWeight: FontWeight.w500),
                //       ),
                //       SizedBox(height: scrHeight*0.02,),
                //
                //       Text("Illegal Product",
                //         style: TextStyle(
                //             fontSize: scrWidth * 0.04,
                //             color: Colors.black,
                //             fontFamily: 'Urbanist',
                //             fontWeight: FontWeight.w500),
                //       ),
                //     ],
                //   ),
                // ),
                ,
                Padding(
                  padding:  EdgeInsets.only(left: 10,bottom: 5),
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        isVisible=true;
                      });
                    },
                    child: Container(
                      height: 20,width: 100,
                      child: Text(
                        "Other",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
                isVisible?Padding(
                  padding:  EdgeInsets.only(left: 13,right: 13),
                  child: TextField(
                    controller: reasonController,

                    maxLines: null,
                    //expands: true,
                    keyboardType: TextInputType.multiline,
                    //cursorHeight: scrWidth * 0.055,
                    cursorWidth: 1,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      hintText: 'Enter a Reason',
                      hintStyle: TextStyle(color: Color(0xffB0B0B0)),
                      fillColor: textFormFieldFillColor,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(scrWidth * 0.026),
                          borderSide: BorderSide(
                            color: Color(0xffDADADA),
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(scrWidth * 0.026),
                          borderSide: BorderSide(
                            color: Color(0xffDADADA),
                          )),
                      contentPadding: EdgeInsets.only(
                          left: scrWidth * 0.03,
                          top: scrHeight * 0.006,
                          bottom: scrWidth * 0.033),
                    ),
                    // maxLines: null,
                    // //expands: true,
                    // keyboardType: TextInputType.multiline,
                  ),
                ):SizedBox(),
                isVisible? Padding(
                  padding:  EdgeInsets.only(left: scrWidth*0.18,top: scrHeight*0.05),
                  child: InkWell(
                    onTap: (){

                      Navigator.pop(context);
                      _doneBottomSheet();
                      FirebaseFirestore.instance
                          .collection('reportReasons')
                          .add({
                        'storeId':widget.storeDetailsModel.storeId,
                        'reason':reasonController.text,
                        'date': DateTime.now(),
                        'reportUserId': currentuserid,
                      }).then((value) => value.update(
                          {'reportId': value.id}));
                      // if(reasonController.text.isEmpty){

                      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      //   content: Text('Test'),
                      //   behavior: SnackBarBehavior.floating,
                      // ));
                      // }

                    },
                    child: Container(
                      height: scrHeight*0.06,
                      width: scrWidth * 0.6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: primarycolor,
                      ),
                      child: Center(
                        child: Text(
                          "Done",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: CreateChitFont,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                ):SizedBox()





              ],
            ),
          )
      ),
    );
  }
  void _doneBottomSheet(){
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        builder: (BuildContext context) {
          // return your layout

          return  Container(
            height: 270,
            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child:  Container(
                decoration:  BoxDecoration(
                    color: Colors.white,
                    borderRadius:  BorderRadius.only(
                        topLeft:  Radius.circular(30),
                        topRight:  Radius.circular(30))),
                child: Padding(
                  padding:  EdgeInsets.only(left: scrWidth*0.02,right: scrWidth*0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage("assets/icon/tickimage.png"))
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Center(
                        child: Text("Thanks for letting us know",
                          style: TextStyle(
                              fontSize: scrWidth * 0.065,
                              color: Colors.black,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding:  EdgeInsets.only(left: scrWidth*0.18,top: scrHeight*0.05),
                        child: InkWell(
                          onTap: (){
                            Navigator.pop(context);
                            // if(reasonController.text.isEmpty){

                            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            //   content: Text('Test'),
                            //   behavior: SnackBarBehavior.floating,
                            // ));
                            // }

                          },
                          child: Container(
                            height: scrHeight*0.06,
                            width: scrWidth * 0.6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: primarycolor,
                            ),
                            child: Center(
                              child: Text(
                                "Next",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: CreateChitFont,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ),
                      )








                    ],
                  ),
                )
            ),
          );
        }
    );
  }
}
