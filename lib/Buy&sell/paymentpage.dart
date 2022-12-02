import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentPageInBuy extends StatefulWidget {
  const PaymentPageInBuy({Key? key}) : super(key: key);

  @override
  State<PaymentPageInBuy> createState() => _PaymentPageInBuyState();
}

class _PaymentPageInBuyState extends State<PaymentPageInBuy> {
  bool inStock = false;

  // bool tes=false;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          SizedBox(height: 60,),
          Padding(
            padding: const EdgeInsets.only(right: 70),
            child: Text("Confirm your payment section",style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              fontFamily: 'Urbanist'
            ),),
          ),
          //   Container(
          //   child: Switch(
          //     value: tes, onChanged: (bool value) {
          //       setState(() {
          //         tes=!tes;
          //         print(tes);
          //
          //       });},
          //     activeColor: Color(0xff02B558),
          //     activeTrackColor: Color(0xffD9D9D9),
          //     inactiveThumbColor: Color(0xffE54D3C),
          //     inactiveTrackColor: Color(0xffD9D9D9),
          //
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 25,top: 30),
            child: Container(
              height: 60,
              width: 316,
              decoration: BoxDecoration(
                  color: Color(0xffF3F3F3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],

                  borderRadius: BorderRadius.circular(20)
              ),
              child: Row(
                children: [
                  SizedBox(width:30,),
                  Text("Cash On Deliverey",style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      fontFamily: 'Urbanist'
                  ),),
                  SizedBox(width:70,),

                  Transform.scale(
                    scale: 0.8,
                    child: CupertinoSwitch(
                      thumbColor: inStock
                          ? Color(0xff02B558)
                          : Color(0xffE54D3C),
                      activeColor: Color(0xffD9D9D9),
                      trackColor: Color(0xffD9D9D9),
                      value: inStock,
                      onChanged: (value) {
                        setState(() {
                          inStock = !inStock;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),


        ],
      ),
    );

  }
}
