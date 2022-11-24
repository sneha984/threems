import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:threems/Buy&sell/storepage.dart';

import '../screens/splash_screen.dart';
import '../utils/themes.dart';
import 'checkout2.dart';
import 'checkoutpage3.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  var currencyConvert = NumberFormat.currency(
    locale: 'HI',
    symbol: '₹ ',
  );
  bool isAddress = false;
  @override
  Widget build(BuildContext context) {
    double sum=0;
    double deliverycharge=12;
    double grandtotal=0;
    List totalprice=[];
    for(int i=0;i<cartlist.length;i++){
      double x=cartlist[i]['price']*cartlist[i]['quantity'];
      totalprice.add(x);
      sum=sum+x;
      grandtotal=sum+deliverycharge;

    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: scrWidth * 0.06,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: scrHeight * 0.08,
                      // left: scrWidth * 0.07,
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/arrow.svg",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60, left: 20),
                  child: Text(
                    "Cart Checkout",
                    style: TextStyle(
                        fontSize: scrWidth * 0.046,
                        color: Colors.black,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 26,
            ),
            Container(
              height: 50,
              width: scrWidth,
              color: Color(0xffF3F3F3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "${cartlist.length} Items",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    "Total : ₹$sum",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Expanded(
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount:cartlist.length ,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(left: 10, bottom: 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CheckOutPage()));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(),
                                child: Container(
                                  height: 80,
                                  width: 88,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(cartlist[index]['img'])),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          color: Color(0xffECECEC), width: 1)),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Container(
                                width: 70,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      cartlist[index]['name'],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'Urbanist',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff0E0E0E)),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      cartlist[index]['unit'].toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'Urbanist',
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff818181)),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      currencyConvert.format(cartlist[index]['price']).toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'Urbanist',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xffF10000)),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 40),
                              child: Container(
                                width: 120,
                                height: 30,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color(0xff02B558)),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          color: Color(0xff02B558),
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(8),
                                              bottomLeft:Radius.circular(8) )

                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 8),
                                        child: InkWell(
                                            onTap:(){
                                              if( cartlist[index]['quantity']==1)
                                              {
                                                cartlist.removeAt(index);
                                                setState(() {});

                                              }
                                              else {
                                                cartlist[index]['quantity']--;
                                                setState(() {});
                                              }
                                              // setState(() {
                                              //   if(eachstore[index].counter <2)
                                              //   {
                                              //     eachstore[index].ShouldVisible = !eachstore[index].ShouldVisible;
                                              //   }else{
                                              //     eachstore[index].counter--;
                                              //   }
                                              //
                                              // });
                                            },
                                            child: Padding(
                                              padding: cartlist[index]['quantity']==1? EdgeInsets.only(top: 8): EdgeInsets.only(),
                                              child: Icon(cartlist[index]['quantity']==1?Icons.delete_outline_outlined:Icons.minimize_outlined,size: 15,color: Colors.white,),
                                            )),
                                      ),
                                    ),
                                    Container(
                                      height: 30,
                                      width: 35,
                                      decoration: BoxDecoration(
                                        color: Color(0xff9FFFCD),
                                      ),
                                      child: Center(child: Text(
                                          // '${eachstore[index].counter}'
                                        '${cartlist[index]['quantity']}'
                                      )),
                                    ),
                                    Container(
                                      height: 26,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          color: Color(0xff02B558),
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(8),
                                              bottomLeft:Radius.circular(8) )

                                      ),
                                      child: InkWell(
                                          onTap:(){
                                            setState(() {
                                              setState((){
                                                cartlist[index]['quantity']=cartlist[index]['quantity']+1;

                                              });
                                              // eachstore[index].counter++;
                                            });
                                          },
                                          child: Icon(Icons.add,size: 15,color: Colors.white,)),
                                    ),
                                  ],
                                )
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 18,
              color: Color(0xffF3F3F3),
            ),
            Padding(
              padding: EdgeInsets.only(left: 21, right: 21),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Item total",
                        style: TextStyle(
                            fontSize: 12,
                            color: Color(0xff0E0E0E),
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        "₹$sum",
                        style: TextStyle(
                            fontSize: 12,
                            color: Color(0xff0E0E0E),
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 9,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Delivery Charge",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        "₹$deliverycharge",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 9,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 11, right: 11, top: 3, bottom: 3),
                    child: DottedLine(
                      dashColor: Colors.grey,
                      lineThickness: 0.8,
                    ),
                  ),
                  SizedBox(
                    height: 9,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Grand Total",
                            style: TextStyle(
                                fontSize: 12,
                                color: Color(0xff0E0E0E),
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            "Inclusive of all taxes",
                            style: TextStyle(
                                fontSize: 10,
                                color: Color(0xff818181),
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        "₹$grandtotal",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff0E0E0E),
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 17, right: 17, top: 10, bottom: 10),
                    child: DottedLine(
                      dashColor: Colors.grey,
                      lineThickness: 0.8,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Delivery time",
                        style: TextStyle(
                            fontSize: 12,
                            color: Color(0xff0E0E0E),
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        "5 hour",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff0E0E0E),
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),

            Divider(
              thickness: 18,
              color: Color(0xffF3F3F3),
            ),
            SizedBox(
              height: 20,
            ),

            isAddress == true
                ? Container(
                    height: 100,
                    width: 310,
                    decoration: BoxDecoration(
                        // color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Color(0xffD2D2D2), width: 1)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Asif Ali",
                            style: TextStyle(
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "7034847868",
                            style: TextStyle(
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Flat 50 Manathumangalam, Perintalmanna",
                            style: TextStyle(
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Work",
                            style: TextStyle(
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  )
                : InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddAddressPage()));
                    },
                    child: Container(
                      height: 40,
                      width: 310,
                      decoration: BoxDecoration(
                          // color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Color(0xffD2D2D2), width: 1)),
                      child: Center(
                        child: Text(
                          "Add Address",
                          style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ),
            isAddress==false?SizedBox(height: 120,) :SizedBox(height: 150,) ,
            isAddress == false
                ? InkWell(
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (context)=>CheckOutPage3()));
              },
                  child: Container(
                      height: 40,
                      width: 310,
                      decoration: BoxDecoration(
                        color: primarycolor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          "Place Order",
                          style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Colors.white),
                        ),
                      ),
                    ),
                )
                : Container(
                    height: 40,
                    width: 310,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 128, 54, 0.33),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        "Place Order",
                        style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Colors.white),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
