import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../screens/splash_screen.dart';
import '../../utils/themes.dart';

class QRBottomsheetPage extends StatefulWidget {
  final String img;
  const QRBottomsheetPage({Key? key, required this.img}) : super(key: key);

  @override
  State<QRBottomsheetPage> createState() => _QRBottomsheetPageState();
}

class _QRBottomsheetPageState extends State<QRBottomsheetPage> {
  String settingsid='settings';
  String? reason;

  getReasons() async {
    DocumentSnapshot doc=await FirebaseFirestore.instance.collection('settings').doc(settingsid).get();
    reason=doc['desclimer'];

    if(mounted){
      setState(() {

      });
    }
  }
  bool _remainder =false;
  @override
  void initState() {
    getReasons();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 500,
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 16,),
                Text(
                  "Scan QR Code",
                  style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                      color: Colors.black),
                ),

                SizedBox(height: 28,),
                Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: CachedNetworkImageProvider(widget.img??''),fit: BoxFit.fill)
                  ),
                ),
                 SizedBox(height: 5,),
                Padding(
                  padding:  EdgeInsets.only(left: scrWidth*0.12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: _remainder, onChanged: (bool? value) {
                        setState(() {
                          _remainder=value!;
                          print(_remainder);

                        });
                      },

                      ),
                      Container(
                        width: 200,
                          child: Text(reason.toString(),style: TextStyle(
                            fontWeight: FontWeight.w600,fontFamily: 'Urbanist',fontSize: 12
                          ),)),
                    ],
                  ),
                ),
                SizedBox(height: 5,),
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40,
                    width: 260,
                    decoration: BoxDecoration(
                      color: primarycolor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        "Done",
                        style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Colors.white),
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
}
