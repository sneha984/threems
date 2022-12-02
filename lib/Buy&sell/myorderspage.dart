import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:threems/Authentication/root.dart';
import 'package:threems/Buy&sell/Orders/Orders.dart';

import '../model/OrderModel.dart';
import '../screens/splash_screen.dart';
List <OrderModel> allOrders=[];


class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({Key? key}) : super(key: key);

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  getAllOrders(){
    print(currentuserid);
    FirebaseFirestore
        .instance
        .collectionGroup('orders')
        .where("userId",isEqualTo: currentuserid)
        .snapshots().listen((event) {
          print(event.docs.length);
          print('-------------------------------------------------');
          allOrders=[];
          for(DocumentSnapshot <Map<String,dynamic>> doc in event.docs){
            allOrders.add(OrderModel.fromJson(doc.data()!));
          }
          if(mounted){
            setState(() {
              print('hereeeeeeeee');
              print(allOrders.length);
            });
          }
    });
  }
  @override
  void initState() {
    getAllOrders();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        toolbarHeight: 84,
        shadowColor: Colors.grey,
        centerTitle: false,
        elevation: 0.1,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.only(
                top: scrHeight * 0.03,
                left: scrWidth * 0.05,
                bottom: scrHeight * 0.01,
                right: scrWidth * 0.05),
            child: SvgPicture.asset(
              "assets/icons/arrow.svg",
            ),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: scrHeight * 0.02),
          child: Text(
            "My Orders",
            style: TextStyle(
                fontSize: scrWidth * 0.047,
                color: Colors.black,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w700),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 500,
            child: ListView.builder(
              itemCount: allOrders.length,
                itemBuilder: (context,index){
                return Column(
                  children: [
                    SizedBox(height: 10,),
                    Container(
                      height: 150,
                      width: scrWidth,
                      child: Column(
                        children: [
                          SizedBox(height: 5,),
                          Padding(
                            padding:  EdgeInsets.only(right:250 ),
                            child:allOrders[index].status==0
                                ?Text("Pending")
                                :allOrders[index].status==1
                                ?Text("Accepted")
                                :allOrders[index].status==2
                                ?Text("Delivered"):
                                Text("Cancelled"),
                          ),
                          SizedBox(height: 5,),
                          Container(
                            height: 100,
                            color: Colors.grey.withOpacity(0.1),
                            child: Row(
                              children: [
                                SizedBox(width: 10,),
                                Container(
                                  height: 95,
                                    width: 85,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      
                                        image: NetworkImage(
                                            allOrders[index].itemImage!),fit: BoxFit.fill)
                                  ),
                                ),
                                SizedBox(width: 30,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 16,),
                                    Text(allOrders[index].item!),
                                    SizedBox(height: 10,),
                                    Text("1 kg"),

                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 230,top: 5),
                            child: Text("Total:${allOrders[index].amount}"),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Divider(
                        // height: 30,
                        thickness: 12,
                        color: Colors.grey.withOpacity(0.15),
                      ),
                    ),

                  ],
                );
              }),
          )
        ],
      ),



    );
  }
}
