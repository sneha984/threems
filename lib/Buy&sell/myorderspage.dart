import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:threems/Authentication/root.dart';
import 'package:threems/Buy&sell/Orders/Orders.dart';
import 'package:threems/Buy&sell/storepage.dart';

import '../model/OrderModel.dart';
import '../screens/splash_screen.dart';
import 'orderdetailspage.dart';
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
        .where('userId',isEqualTo: currentuserid)
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
    double sum=0;
    List sneha=[];
    for(int i=0;i<cartlist.length;i++){
      double x=cartlist[i]['price']*cartlist[i]['count'];
      sneha.add(x);
      sum=sum+x;
    }
    double tax=0;
    for(int j=0;j<cartlist.length;j++){
      double y=cartlist[j]['count']+0.0;
      tax=tax+y;
    }
    double total=0;
    total=tax+sum;

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
          Padding(
                padding:  EdgeInsets.only(left: 10,right: 10,top: 20),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderDetailsPage(orderModel: allOrders[0],)));
                  },
                  child: Container(
                    height: 300,
                    width: 360,
                    decoration: BoxDecoration(
                        color: Color(0xffF3F3F3),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.15),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(2, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            SizedBox(width: 20,),
                            Text(
                              "Order #1265365",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(width: 10,),

                            Container(
                              height: 15,
                              width: 30,
                              decoration: BoxDecoration(
                                color: Color(0xff02B558),
                                borderRadius: BorderRadius.circular(5)

                              ),
                              child: Center(
                                child: Text(
                                  "New",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            SizedBox(width: 80,),

                            Text(
                              "Today 05:00 PM",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff969696),
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w600),
                            ),

                          ],
                        ),
                        SizedBox(height: 30,),
                        Expanded(
                          child: ListView.builder(
                            itemCount: allOrders[0].orderedItems?.length??0,
                              itemBuilder: (context,index){
                              return Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  children: [
                                    SizedBox(width: 20,),

                                    Container(
                                      width: 150,
                                      child: Text(
                                        allOrders[0].orderedItems![index].item!,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontFamily: 'Urbanist',
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    // SizedBox(width: 80,),

                                    Text(
                                      "x",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontFamily: 'Urbanist',
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(width: 5,),

                                    Text(
                                  allOrders[0].orderedItems![index].count!.toString()
                                  ,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontFamily: 'Urbanist',
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(width: 73,),

                                    Text(
                                  allOrders[0].orderedItems![index].amount!.toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xffF10000),
                                          fontFamily: 'Urbanist',
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              );
                            }),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [



                            Padding(
                              padding: const EdgeInsets.only(right: 90),
                              child: Text(
                                "Total",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff969696),
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w600),
                              ),
                            ),

                          SizedBox(width: 40,),

                            Text(
                              "$sum",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff0E0E0E),
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        SizedBox(height: 15,),
                        Container(
                          height: 50,
                          width: 302,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xff02B558)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "Status",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(width: 10,),
                              allOrders[0].status==0?Text(
                                "Pending",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w600),
                              ):allOrders[0].status==1?
                              Text(
                                "Accepted",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w600)):
                                allOrders[0].status==2?
                                Text(
                                "Delivered",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w600)): Text(
                                "Cancelled",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w600))

                            ],
                          ),
                        ),
                        SizedBox(height: 15,),

                      ],
                    ),

                  ),
                ),

              //   Column(
              //   children: [
              //     SizedBox(height: 10,),
              //     Container(
              //       height: 150,
              //       width: scrWidth,
              //       child: Column(
              //         children: [
              //           SizedBox(height: 5,),
              //           Padding(
              //             padding:  EdgeInsets.only(right:250 ),
              //             child:allOrders[index].status==0
              //                 ?Text("Pending")
              //                 :allOrders[index].status==1
              //                 ?Text("Accepted")
              //                 :allOrders[index].status==2
              //                 ?Text("Delivered"):
              //                 Text("Cancelled"),
              //           ),
              //           SizedBox(height: 5,),
              //           Container(
              //             height: 100,
              //             color: Colors.grey.withOpacity(0.1),
              //             child: Row(
              //               children: [
              //                 SizedBox(width: 10,),
              //                 Container(
              //                   height: 95,
              //                     width: 85,
              //                   decoration: BoxDecoration(
              //                     borderRadius: BorderRadius.circular(10),
              //                     image: DecorationImage(
              //
              //                         image: NetworkImage(
              //                             allOrders[index].itemImage!),fit: BoxFit.fill)
              //                   ),
              //                 ),
              //                 SizedBox(width: 30,),
              //                 Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     SizedBox(height: 16,),
              //                     Text(allOrders[index].item!),
              //                     SizedBox(height: 10,),
              //                     Text("1 kg"),
              //
              //                   ],
              //                 )
              //               ],
              //             ),
              //           ),
              //           Padding(
              //             padding: EdgeInsets.only(left: 230,top: 5),
              //             child: Text("Total:${allOrders[index].amount}"),
              //           )
              //         ],
              //       ),
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.only(top: 10),
              //       child: Divider(
              //         // height: 30,
              //         thickness: 12,
              //         color: Colors.grey.withOpacity(0.15),
              //       ),
              //     ),
              //
              //   ],
              // );


          )],
      ),



    );
  }
}
