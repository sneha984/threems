import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:threems/Authentication/root.dart';
import 'package:threems/Buy&sell/reportBottomsheet/qrcodebottomsheet.dart';
import 'package:threems/Buy&sell/storepage.dart';
import 'package:threems/kuri/createkuri.dart';

import '../model/OrderModel.dart';
import '../model/usermodel.dart';
import '../screens/splash_screen.dart';
import '../utils/themes.dart';
import 'addressUpdate.dart';
import 'checkout2.dart';
import 'checkoutpage3.dart';
import 'dart:io';


class CheckOutPage extends StatefulWidget {
  // final String id;
  const CheckOutPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {

  String cartKey = 'cart';

  Future storeData() async {
    final prefs = await SharedPreferences.getInstance();
    final myItemsAsJsonString = json.encode(cartlist);
    await prefs.setString(cartKey, myItemsAsJsonString);
  }

  List<Address>? addressList;
  bool shopAvailable = false;
  bool placeOrder=true;
  String? image;
  bool prd=false;
  getAddress() {
    print('1234');
    print(cartlist.length);
    if(cartlist.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('stores')
          .doc(cartlist[0]['storeId'])
          .snapshots()
          .listen((event) {
        shopAvailable = event['online'];
        image=event['storeQR'];
        if (mounted) {
          setState(() {
            print(cartlist[0]['storeId']);
            print(cartlist[0]['storeName']);

          });
        }
      });

      FirebaseFirestore
          .instance
          .collection('stores')
          .doc(cartlist[0]['storeId'])
          .collection('products')
          .doc(cartlist[0]['productId'])
          .snapshots()
          .listen((event) {
        prd = event['available'];
        if (mounted) {
          setState(() {

          });
        }
      });
    }

    FirebaseFirestore.instance
        .collection('users')
        .doc(currentuserid)
        .snapshots()
        .listen((event) {
      addressList = [];
      List names = event.get('address');
      print(names);
      for (var doc in names) {
        print(doc);
        addressList!.add(Address.fromJson(doc));
      }
      if (mounted) {
        setState(() {});
      }
    });
  }
  bool loading=false;

  String groupValue='Cash On Delivery';
  int index=0;
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
    double sum = 0;
    double deliverycharge = 12;
    double grandtotal = 0;
    List totalprice = [];
    for (int i = 0; i < cartlist.length; i++) {
      double x = cartlist[i]['price'] * cartlist[i]['count'];
      totalprice.add(x);
      sum = sum + x;

      grandtotal = sum +cartlist[i]['deliveryCharge'];
    }
    return Scaffold(
      body:
      cartlist.isEmpty?Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: scrWidth * 0.06,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.only(
                     top: scrHeight * 0.08,
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
              Padding(
                padding:  EdgeInsets.only(top: scrHeight*0.08, left: scrWidth*0.03),
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
          SizedBox(
            height: 150,
          ),
          SvgPicture.asset("assets/icons/Group 173.svg"),
          SizedBox(
            height: 90,
          ),
          Text(
            "Cart is Empty",
            style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 16,
                fontWeight: FontWeight.w500),
          )
        ],
      )
          :Column(
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
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                             top: scrHeight * 0.08,
                            // left: scrWidth * 0.05,
                            // bottom: scrHeight * 0.02,
                              right: scrWidth * 0.02),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                            size: 25,
                          ),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only( top: scrHeight * 0.08, left: 20),
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
                        itemCount: cartlist.length,
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
                                          // image: DecorationImage(
                                          //     image: NetworkImage(
                                          //         cartlist[index]['img'])),
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              color: Color(0xffECECEC),
                                              width: 1)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(scrWidth * 0.09),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl:cartlist[index]['img'],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Container(
                                    width: 70,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          currencyConvert
                                              .format(cartlist[index]['price'])
                                              .toString(),
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    IconButton(onPressed: (){
                                      // Navigator.pop(context);
                                      showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                        content:
                                        const Text("Do You Want to Delete this Item from cart?"),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("No"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              storeData();
                                              if (cartlist[index]
                                              ['count'] ==
                                                  1) {
                                                cartlist.removeAt(index);
                                                setState(() {});
                                              } else {
                                                cartlist[index]
                                                ['count']--;
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
                                            child: const Text(
                                              "Yes",
                                              style: TextStyle(color: primarycolor),
                                            ),
                                          ),
                                        ],
                                      ));

                                    }, icon: Icon(Icons.delete)),
                                    SizedBox(height: 10,),
                                    shopAvailable==true&&prd==true?Padding(
                                      padding: EdgeInsets.only(left: 40),
                                      child: Container(
                                          width: 120,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(8),
                                              color: Color(0xff02B558)),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 30,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                    color: Color(0xff02B558),
                                                    borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(8),
                                                        bottomLeft:
                                                        Radius.circular(8))),
                                                child: Padding(
                                                  padding: const EdgeInsets.only(
                                                      bottom: 8),
                                                  child: InkWell(
                                                      onTap: () {
                                                        storeData();
                                                        if (cartlist[index]
                                                        ['count'] ==
                                                            1) {
                                                          cartlist.removeAt(index);
                                                          setState(() {});
                                                        } else {
                                                          cartlist[index]
                                                          ['count']--;
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
                                                        padding: cartlist[index]
                                                        ['count'] ==
                                                            1
                                                            ? EdgeInsets.only(
                                                            top: 8)
                                                            : EdgeInsets.only(),
                                                        child: Icon(
                                                          cartlist[index]
                                                          ['count'] ==
                                                              1
                                                              ? Icons
                                                              .delete_outline_outlined
                                                              : Icons
                                                              .minimize_outlined,
                                                          size: 15,
                                                          color: Colors.white,
                                                        ),
                                                      )),
                                                ),
                                              ),
                                              Container(
                                                height: 30,
                                                width: 35,
                                                decoration: BoxDecoration(
                                                  color: Color(0xff9FFFCD),
                                                ),
                                                child: Center(
                                                    child: Text(
                                                      // '${eachstore[index].counter}'
                                                        cartlist[index]['count']
                                                            .toString())),
                                              ),
                                              Container(
                                                height: 26,
                                                width: 30,
                                                decoration: BoxDecoration(
                                                    color: Color(0xff02B558),
                                                    borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(8),
                                                        bottomLeft:
                                                        Radius.circular(8))),
                                                child: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        cartlist[index]['count'] =
                                                            cartlist[index]
                                                            ['count'] +
                                                                1;
                                                      });
                                                      storeData();

                                                      // eachstore[index].counter++;
                                                    },
                                                    child: Icon(
                                                      Icons.add,
                                                      size: 15,
                                                      color: Colors.white,
                                                    )),
                                              ),
                                            ],
                                          )),
                                    ):Padding(
                                      padding:  EdgeInsets.only(left: 15),
                                      child: Container(
                                        height: 50,
                                        width: 120,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius: BorderRadius.circular(17),
                                        ),
                                        child: Center(child: Text("Not Available",style: TextStyle(color: Colors.white),)),
                                      ),
                                    )
                                  ],
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
                              "₹${cartlist[0]['deliveryCharge']}",
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
                          padding: EdgeInsets.only(
                              left: 11, right: 11, top: 3, bottom: 3),
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
                        // Padding(
                        //   padding: EdgeInsets.only(
                        //       left: 17, right: 17, top: 10, bottom: 10),
                        //   child: DottedLine(
                        //     dashColor: Colors.grey,
                        //     lineThickness: 0.8,
                        //   ),
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Text(
                        //       "Delivery time",
                        //       style: TextStyle(
                        //           fontSize: 12,
                        //           color: Color(0xff0E0E0E),
                        //           fontFamily: 'Urbanist',
                        //           fontWeight: FontWeight.w600),
                        //     ),
                        //     SizedBox(
                        //       width: 30,
                        //     ),
                        //     Text(
                        //       "5 hour",
                        //       style: TextStyle(
                        //           fontSize: 14,
                        //           color: Color(0xff0E0E0E),
                        //           fontFamily: 'Urbanist',
                        //           fontWeight: FontWeight.w600),
                        //     ),
                        //   ],
                        // ),
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
                    height: 15,
                  ),
                  addressList == null || addressList!.isEmpty
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
                                border: Border.all(
                                    color: Color(0xffD2D2D2), width: 1)),
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
                        )
                      : InkWell(
                    onTap: (){
                      // Navigator.push(context, MaterialPageRoute(
                      //     builder: (context)=>AddressUpdate(
                      //       update: true, address: [addressList![0]],)));
                    },
                        child: Container(
                            height: 100,
                            width: 340,
                            decoration: BoxDecoration(
                                // color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: Color(0xffD2D2D2), width: 1)),
                            child: Padding(
                              padding: EdgeInsets.only(left: 15, top: 10),
                              child: Row(
                                children: [
                                  Container(
                                    width: 160,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          addressList == null ||
                                                  addressList!.isEmpty
                                              ? ''
                                              : addressList![0].name!,
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
                                          addressList == null ||
                                                  addressList!.isEmpty
                                              ? ''
                                              : addressList![0].phoneNumber!,
                                          style: const TextStyle(
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          addressList == null ||
                                                  addressList!.isEmpty
                                              ? ''
                                              : "Flat ${addressList![0].flatNo!},${addressList![0].locality!},"
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
                                        Text(
                                          addressList == null ||
                                                  addressList!.isEmpty
                                              ? ''
                                              : addressList![0].select!,
                                          style: TextStyle(
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 100,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                            title: const Text("Alert Dialog Box"),
                                            content: const Text("Do You Want To Delete This Address"),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(ctx).pop();
                                                },
                                                child: const Text("No"),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(ctx).pop();
                                                  setState(() {
                                                    addressList?.removeAt(0);
                                                  });
                                                  FirebaseFirestore.instance
                                                      .collection('users')
                                                      .doc(currentuserid)
                                                      .update({
                                                    'address': FieldValue.delete()
                                                  }).whenComplete(() {
                                                    print('Field Deleted');
                                                  });
                                                },
                                                child: const Text("Yes"),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      icon: Icon(Icons.delete))
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
                      ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding:  EdgeInsets.only(right: scrWidth*0.58),
                    child: Text(
                      "Payment Methods",
                      style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: scrWidth*0.06,right: scrWidth*0.02),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Container(
                            //     height: 50,
                            //     width: 50,
                            //     child: Image(
                            //         image: NetworkImage(
                            //             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQsjHTHD5T1mFOZsCqkNMfujHaX6BYxFxGkXQ&usqp=CAU"))),
                            // SizedBox(width: 10,),
                            Text("Cash On Delivery"),

                            Radio(
                              activeColor: primarycolor,
                              value: "Cash On Delivery",
                              groupValue:groupValue,
                              onChanged:( value){
                                setState((){
                                  print(groupValue);
                                  groupValue=value.toString();
                                  index=0;
                                });
                              },),



                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Container(
                            //     height: 50,
                            //     width: 50,
                            //     child: Image(
                            //         image: NetworkImage(
                            //             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3SGUreVD7pVxevpSTYkUDPhZsoFycafhxEA&usqp=CAU"))),
                            Text("QR Code Scan"),
                            Radio(
                              activeColor: primarycolor,

                              value: "QR Code Scan",
                              groupValue:groupValue,
                              onChanged:( value){
                                setState((){
                                  _modalBottomSheetMenu();

                                  groupValue=value.toString();
                                  index=1;
                                  print(index);
                                  print(groupValue);
                                });
                              },),


                          ],
                        ),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: scrHeight * 0.02,
                  ),
                  index==1?Text("Upload ScreenShot"):SizedBox(),
                  SizedBox(
                    height: scrHeight * 0.005,
                  ),
                  index==1?InkWell(
                    onTap: (){
                      loading=true;
                      _pickImages();
                    },
                    child: Container(
                      height: scrHeight * 0.2,
                      width: scrWidth * 0.9,
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
                            width: scrWidth * 0.9,
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
                  ):SizedBox(),
                  SizedBox(
                    height: scrHeight * 0.02,
                  ),


                ],
              ),
            ),
          ),
          addressList == null || addressList!.isEmpty
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
              : (shopAvailable==true&&prd==true)?InkWell(
                  onTap: () {
                    print(index);
                    print(imgFiles);
                    if(index==1){
                      if(imgFiles!=null){
                        if(loading==false){
                          List<OrderedItems> orders1 = [];
                          double total = 0;

                          for (int i = 0; i < cartlist.length; i++) {
                            total += cartlist[i]['count'] * cartlist[i]['price'];
                            orders1.add(OrderedItems(
                              item: cartlist[i]['name'],
                              count: cartlist[i]['count'],
                              amount: cartlist[i]['price'],
                              itemImage: cartlist[i]['img'],
                            ));
                          }
                          var ordr = OrderModel(
                              productId: cartlist[0]['productId'],

                              // item: cartlist[i]['name'],
                              // itemImage: cartlist[i]['img'],
                              // amount: cartlist[i]['price'],
                              time: DateTime.now(),
                              userId: currentuserid,
                              deliveryCharge: cartlist[0]['deliveryCharge'],
                              status: 0,
                              orderedItems: orders1,
                              total: total,
                              paymentMethod: index,
                              paymentScreenShort: imgUrls??'',
                              // count: cartlist[i]['count'],
                              storeId: cartlist[0]['storeId'],
                              address: Addresses(
                                  phoneNumber: addressList![0].phoneNumber!,
                                  flatNo: addressList![0].flatNo!,
                                  pincode: addressList![0].pinCode!,
                                  locality: addressList![0].locality!,
                                  locationType: addressList![0].select!,
                                  name: addressList![0].name!));
                          orderPlacing(ordr, cartlist[0]['storeId']);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CheckOutPage3()));
                        }else{
                          showSnackbar(context, " Screenshort Uploading.....");
                        }
                      }else{
                        showSnackbar(context, "Please Upload payment Proof");
                      }

                    }else{
                      if(loading==false){
                        List<OrderedItems> orders1 = [];
                        double total = 0;

                        for (int i = 0; i < cartlist.length; i++) {
                          total += cartlist[i]['count'] * cartlist[i]['price'];
                          orders1.add(OrderedItems(
                            item: cartlist[i]['name'],
                            count: cartlist[i]['count'],
                            amount: cartlist[i]['price'],
                            itemImage: cartlist[i]['img'],
                          ));
                        }
                        var ordr = OrderModel(
                            productId: cartlist[0]['productId'],

                            // item: cartlist[i]['name'],
                            // itemImage: cartlist[i]['img'],
                            // amount: cartlist[i]['price'],
                            time: DateTime.now(),
                            userId: currentuserid,
                            deliveryCharge: cartlist[0]['deliveryCharge'],
                            status: 0,
                            orderedItems: orders1,
                            total: total,
                            paymentMethod: index,
                            paymentScreenShort: imgUrls??'',
                            // count: cartlist[i]['count'],
                            storeId: cartlist[0]['storeId'],
                            address: Addresses(
                                phoneNumber: addressList![0].phoneNumber!,
                                flatNo: addressList![0].flatNo!,
                                pincode: addressList![0].pinCode!,
                                locality: addressList![0].locality!,
                                locationType: addressList![0].select!,
                                name: addressList![0].name!));
                        orderPlacing(ordr, cartlist[0]['storeId']);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CheckOutPage3()));
                      }else{
                        showSnackbar(context, " Screenshort Uploading.....");
                      }
                    }

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
                ):Container(
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
          SizedBox(
            height: 10,
          )
        ],
      )

    );
  }
  orderPlacing(OrderModel ordr, String id) {
    FirebaseFirestore.instance
        .collection('stores')
        .doc(id)
        .collection('orders')
        .add(ordr.toJson())
        .then((value) => value.update({
              'orderId': value.id,
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
      
            })).then((value) => cartlist=[]);
  }
  void _modalBottomSheetMenu(){
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        builder: (BuildContext context) {
          // return your layout
          return QRBottomsheetPage(img: image??'',) ;
        }
    );
  }
}
