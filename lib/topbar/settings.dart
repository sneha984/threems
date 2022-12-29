import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:threems/topbar/privacypolicy.dart';
import 'package:threems/topbar/subscriptionpage.dart';
import 'package:threems/topbar/trems&conditions.dart';

import '../utils/themes.dart';
import 'faqQuestions.dart';
import 'howtouse.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50,bottom: 29),
            child: Row(
              children: [
                IconButton(onPressed: (){
                  Navigator.pop(context);
                }, icon: Icon(Icons.arrow_back_ios_rounded,size: 18,)),
                Text(
                  "Settings",
                  style: TextStyle(
                      fontSize: FontSize17,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SubscriptionPage()));
                },
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Subscription',style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w500,
                        color: Colors.black),),
                    IconButton(onPressed: (){

                    }, icon: Icon(Icons.arrow_forward_ios,size: 15,))
                  ],
                ),
              ),
            ),
          ),
          Divider(
            thickness: 2,
            color: Color(0xfff2f2f2),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Terms()));

              },
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Terms & Conditions',style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w500,
                        color: Colors.black),),
                    IconButton(onPressed: (){

                    }, icon: Icon(Icons.arrow_forward_ios,size: 15,))
                  ],
                ),
              ),
            ),
          ),
          Divider(
            thickness: 2,
            color: Color(0xfff2f2f2),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>FAQuestions()));


              },
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('FAQs',style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w500,
                        color: Colors.black),),
                    IconButton(onPressed: (){

                    }, icon: Icon(Icons.arrow_forward_ios,size: 15,))
                  ],
                ),
              ),
            ),
          ),
          Divider(
            thickness: 2,
            color: Color(0xfff2f2f2),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>HowToUse()));


              },
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('How To Use',style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w500,
                        color: Colors.black),),
                    IconButton(onPressed: (){

                    }, icon: Icon(Icons.arrow_forward_ios,size: 15,))
                  ],
                ),
              ),
            ),
          ),
          Divider(
            thickness: 2,
            color: Color(0xfff2f2f2),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PrivacyPolicy()));

              },
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Privacy Policy',style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w500,
                        color: Colors.black),),
                    IconButton(onPressed: (){

                    }, icon: Icon(Icons.arrow_forward_ios,size: 15,))
                  ],
                ),
              ),
            ),
          ),
          Divider(
            thickness: 2,
            color: Color(0xfff2f2f2),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: InkWell(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Benifit',style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w500,
                        color: Colors.black),),
                    IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios,size: 15,))
                  ],
                ),
              ),
            ),
          ),
          Divider(
            thickness: 2,
            color: Color(0xfff2f2f2),
          ),

        ],
      )
    );
  }
}

