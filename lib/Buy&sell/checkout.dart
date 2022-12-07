import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:threems/Authentication/root.dart';
import 'package:threems/Buy&sell/storepage.dart';

import '../model/OrderModel.dart';
import '../model/usermodel.dart';
import '../screens/splash_screen.dart';
import '../utils/themes.dart';
import 'checkout2.dart';
import 'checkoutpage3.dart';

class CheckOutPage extends StatefulWidget {
   // final String id;
  const CheckOutPage({Key? key, }) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {



   String cartKey = 'cart';


  Future storeData()async{
    final prefs = await SharedPreferences.getInstance();
    final myItemsAsJsonString = json.encode(cartlist);
    await prefs.setString(cartKey, myItemsAsJsonString);


  }
  List<Address>?  addressList;
  getAddress(){
    FirebaseFirestore.instance.collection('users').doc(currentuserid).snapshots().listen((event) {
      addressList=[];
      List names=event.get('address');
      print(names);
      for(var doc in names){
        print(doc);
        addressList!.add(Address.fromJson(doc));
      }
      if(mounted){
        setState(() {

        });
      }
    });
  }
  @override
  void initState() {
    getAddress();
    // TODO: implement initState
    super.initState();
  }
  var currencyConvert = NumberFormat.currency(
    locale: 'HI',
    symbol: '₹ ',
  );

  bool isAddress = false;
  @override
  Widget build(BuildContext context) {
    print('addressList');
    print(addressList);
    double sum=0;
    double deliverycharge=12;
    double grandtotal=0;
    List totalprice=[];
    for(int i=0;i<cartlist.length;i++){
      double x=cartlist[i]['price']*cartlist[i]['count'];
      totalprice.add(x);
      sum=sum+x;
      grandtotal=sum+deliverycharge;

    }
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
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
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => CheckOutPage(id: widget.id,)));
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
                                          '${cartlist[index]['quantity']} ${cartlist[index]['unit']}',
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
                                                storeData();
                                                  if( cartlist[index]['count']==1)
                                                  {
                                                    cartlist.removeAt(index);
                                                    setState(() {});

                                                  }
                                                  else {
                                                    cartlist[index]['count']--;
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
                                                  padding: cartlist[index]['count']==1? EdgeInsets.only(top: 8): EdgeInsets.only(),
                                                  child: Icon(cartlist[index]['count']==1?
                                                  Icons.delete_outline_outlined:Icons.minimize_outlined,size:
                                                  15,color: Colors.white,),
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
                                            cartlist[index]['count'].toString()
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
                                                  setState((){
                                                    cartlist[index]['count']=cartlist[index]['count']+1;
                                                  });
                                                  storeData();

                                                // eachstore[index].counter++;
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

                  addressList ==null||addressList!.isEmpty
                      ? InkWell(
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
                        ):Container(
                    height: 100,
                    width: 340,
                    decoration: BoxDecoration(
                      // color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Color(0xffD2D2D2), width: 1)),
                    child: Padding(
                      padding:  EdgeInsets.only(left: 15, top: 10),
                      child: Row(
                        children: [
                          Container(
                            width: 160,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(addressList==null||addressList!.isEmpty ?'':
                                addressList![0].name!,
                                  style: TextStyle(
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(addressList==null||addressList!.isEmpty ?'':
                                addressList![0].phoneNumber!,
                                  style: const TextStyle(
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(addressList==null||addressList!.isEmpty ?'':
                                "Flat ${addressList![0].flatNo!},${addressList![0].locality!},"
                                    "${addressList![0].pinCode!}",
                                  style: TextStyle(
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(addressList==null||addressList!.isEmpty ?'':
                                addressList![0].select!,
                                  style: TextStyle(
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 100,),
                          IconButton(onPressed: (){
                            setState(() {
                              addressList?.removeAt(0);

                            });
                            FirebaseFirestore
                                .instance
                                .collection('users')
                                .doc(currentuserid)
                                .update({'address': FieldValue.delete()}).whenComplete((){
                              print('Field Deleted');
                            });
                          }, icon: Icon(Icons.delete))
                          // IconButton(
                          //   onPressed: () {
                          //     setState(() {
                          //       addressList?.removeAt(0);
                          //
                          //     });
                          //
                          //   },
                          //   icon: Icon(Icons.delete),
                          // ),


                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30,) ,

                ],
              ),
            ),
          ),
          addressList == null||addressList!.isEmpty
              ? Container(
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
          )
              :InkWell(
            onTap: (){
              List <OrderedItems> orders1=[];

              for(int i=0;i<cartlist.length;i++) {
                orders1.add(OrderedItems(
                  item:cartlist[i]['name'] ,
                  count:cartlist[i]['count'] ,
                  amount:cartlist[i]['price'] ,
                  itemImage:cartlist[i]['img'] ,
                ));
              }
                var ordr=OrderModel(

                    // item: cartlist[i]['name'],
                    // itemImage: cartlist[i]['img'],
                    // amount: cartlist[i]['price'],
                    time:DateTime.now(),
                    userId: currentuserid,
                    deliveryCharge: 30,
                    status: 0,
                    orderedItems: orders1,
                    // count: cartlist[i]['count'],

                    storeId: cartlist[0]['storeId'],
                    address: Addresses(
                        phoneNumber: addressList![0].phoneNumber!,
                        flatNo: addressList![0].flatNo!,
                        pincode: addressList![0].pinCode!,
                        locality: addressList![0].locality!,
                        locationType: addressList![0].select!,
                        name: addressList![0].name!
                    )
                );
                orderPlacing(ordr,cartlist[0]['storeId']);


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
          ),
          SizedBox(height: 10,)
        ],
      ),

    );
  }
   orderPlacing(OrderModel ordr,String id){

      FirebaseFirestore
          .instance
          .collection('stores')
          .doc(id)
          .collection('orders')
          .add(ordr.toJson()).then((value) =>
          value.update({
            'orderId':value.id,
            // 'orderedItems':FieldValue.arrayUnion(
            //   [
            //     {
            //       'item':cartlist[i]['name'],
            //       'count':cartlist[i]['count'],
            //       'itemImage':cartlist[i]['img'],
            //       'amount':cartlist[i]['price']
            //     }
            //   ]
            // )

          })
      );
    }



}
