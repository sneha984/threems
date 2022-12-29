import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:threems/screens/charity/paysszoom.dart';
import 'package:threems/screens/splash_screen.dart';
import 'package:threems/utils/themes.dart';

import '../../model/charitymodel.dart';
import '../../model/usermodel.dart';


class PaymentDetailsPage extends StatefulWidget {
  final List<Payments> payments;
  final int index;
  final String id;
  const PaymentDetailsPage({Key? key, required this.payments, required this.index, required this.id}) : super(key: key);

  @override
  State<PaymentDetailsPage> createState() => _PaymentDetailsPageState();
}

class _PaymentDetailsPageState extends State<PaymentDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 30,top: 30),
        child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 36,),
            InkWell(
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
            SizedBox(height: 20,),

            Row(
              children: [
                Text("Date:-",style: TextStyle(
                    fontSize: 20,fontWeight: FontWeight.w600,fontFamily: 'Urbanist'
                ),),
                SizedBox(width: 20,),
                Text(widget.payments[widget.index].date.toString())

              ],
            ),
            SizedBox(height: 20,),

            Text("Payment ScreenShort",style: TextStyle(
              fontSize: 20,fontWeight: FontWeight.w600,fontFamily: 'Urbanist'
            ),),
            SizedBox(height: 20,),

            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>
                    PayZoomPage(img:widget.payments[widget.index].screenShotUrl??'' )));
              },
              child: Container(
                height: 270,
                width: 400,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.payments[widget.index].screenShotUrl??''),fit: BoxFit.fill)
                ),
              ),
            ),
            SizedBox(height: 20,),

            Row(
              children: [
                Text("Amount:-",style: TextStyle(
                    fontSize: 20,fontWeight: FontWeight.w600,fontFamily: 'Urbanist'
                ),),
                SizedBox(width: 20,),
                Text("₹${widget.payments[widget.index].amount.toString()}")

              ],
            ),
            SizedBox(height: 40,),
            // InkWell(
            //   onTap: (){
            //     var indexData=widget.payments[widget.index];
            //     widget.payments.removeAt(widget.index);
            //     indexData.verified=true;
            //     widget.payments.insert(widget.index,indexData );
            //     print(widget.payments[0].verified);
            //     List data=[];
            //     for(var a in widget.payments){
            //       data.add({
            //         'amount':a.amount,
            //         'screenShotUrl':a.screenShotUrl,
            //         'userId':a.userId,
            //         'userName':a.userName,
            //         'verified':a.verified,
            //         'date':a.date,
            //       });
            //     }
            //      FirebaseFirestore.instance.collection('charity').doc(widget.id).update({
            //        'payments':data,
            //      });
            //     setState(() {
            //
            //     });
            //   },
            //   child: Padding(
            //     padding:  EdgeInsets.only(left:scrWidth*0.19 ),
            //     child: Container(
            //       height: 50,
            //       width: 190,
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(18),
            //         color: primarycolor
            //       ),
            //       child: Center(
            //           child: widget.payments[widget.index].verified==true?
            //       Text("Verified",style: TextStyle(
            //         color: Colors.white
            //       ),): Text("Verify",style: TextStyle(
            //           color: Colors.white
            //       ),)),
            //     ),
            //   ),
            // ),
            Row(
              children: [
                Text("Tap to verify:-",style: TextStyle(
                    fontSize: 20,fontWeight: FontWeight.w600,fontFamily: 'Urbanist'
                ),),

                Transform.scale(
                  scale: 0.7,
                  child: CupertinoSwitch(
                    thumbColor:widget.payments[widget.index].verified!
                        ? Color(0xff02B558)
                        : Color(0xffE54D3C),
                    activeColor: Color(0xffD9D9D9),
                    trackColor: Color(0xffD9D9D9),
                    value: widget.payments[widget.index].verified!,
                    onChanged: (value) {
                      // print(widget.storeId);

                      var indexData=widget.payments[widget.index];
                      widget.payments.removeAt(widget.index);
                      indexData.verified=true;
                      widget.payments.insert(widget.index,indexData );
                      print(widget.payments[0].verified);
                      List data=[];
                      for(var a in widget.payments){
                        data.add({
                          'amount':a.amount,
                          'screenShotUrl':a.screenShotUrl,
                          'userId':a.userId,
                          'userName':a.userName,
                          'verified':a.verified,
                          'date':a.date,
                        });
                      }
                      FirebaseFirestore.instance.collection('charity').doc(widget.id).update({
                        'payments':data,
                        'totalReceived':
                        FieldValue.increment(widget.payments[widget.index].amount!)
                      });
                      setState(() {

                      });
                    },
                  ),
                ),
              ],
            ),




          ],
        ),
      ),


    );
  }
}
