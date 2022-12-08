import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:threems/utils/themes.dart';

import '../../model/charitymodel.dart';


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
      body: Column(
crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 36,),
          Container(height: 70,color: primarycolor,),
          Text("Payment ScreenShort",style: TextStyle(
            fontSize: 20,fontWeight: FontWeight.w600,fontFamily: 'Urbanist'
          ),),
          Container(
            height: 100,
            width: 200,
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(widget.payments[widget.index].screenShotUrl??''))
            ),
          ),

        ],
      ),


    );
  }
}
