import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../Authentication/auth.dart';
import '../screens/splash_screen.dart';
import '../utils/themes.dart';
import 'otppage.dart';

class GetOtpPage extends StatefulWidget {
  const GetOtpPage({Key? key}) : super(key: key);

  @override
  State<GetOtpPage> createState() => _GetOtpPageState();
}

class _GetOtpPageState extends State<GetOtpPage> {
  final _formkey = GlobalKey<FormState>();
  bool loading=false;

  final TextEditingController _phonecontroller=TextEditingController();
  late FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }
  final Authentication _auth = Authentication();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading:GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child:  Padding(
            padding: EdgeInsets.only(top: scrHeight*0.03,
                left: scrWidth*0.07,bottom: scrHeight*0.02,right: scrWidth*0.05),
            child:SvgPicture.asset("assets/icons/arrow.svg",),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: (){
          behavior: HitTestBehavior.opaque;

          FocusScope.of(context).requestFocus(new FocusNode());

        },
        child: Padding(
          padding:  EdgeInsets.only(left: scrWidth*0.07),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               SizedBox(height: scrHeight*0.008,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Enter your mobile number",style: TextStyle(fontFamily: 'Outfit',
                      fontWeight: FontWeight.w600,
                      fontSize: scrWidth*0.05
                  ),),
                   SizedBox(height: scrHeight*0.008,),

                  Text("We'll send you a 6 digit OTP on your \nsmobile number for verification",style: TextStyle(
                      fontFamily: 'Outfit',fontWeight: FontWeight.w400,fontSize: scrWidth*0.035,color: Color(0xff000000).withOpacity(0.5)
                  ),),

                ],
              ),
              SizedBox(height: scrHeight*0.048,),
              Container(
                height: scrHeight*0.055,
                width: scrWidth*0.87,
                decoration: BoxDecoration(
                    color: Color(0xffEEEEEE),
                    borderRadius: BorderRadius.circular(8)
                ),
                child: Row(
                  children: [
                    SizedBox(width: scrWidth*0.029,),
                    Container(
                      height: 20,
                      width: 30,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/icons/Flag_of_India 1.png"),fit: BoxFit.fill)
                      ),
                    ),
                    SizedBox(width: scrWidth*0.011,),
                    Text("+91",style: TextStyle(fontSize: 18,fontFamily: 'Outfit',fontWeight: FontWeight.w400),),
                    SizedBox(width: scrWidth*0.011,),

                    Container(
                     width:scrWidth*0.005,
                     height: scrHeight*0.055,
                     color: Colors.white,
                   ),
                    SizedBox(width: scrWidth*0.011,),

                    Form(
                      key: _formkey,
                      child: Container(
                        height: 50,
                        width: 200,
                        child: TextFormField(
                          validator:  (value){
                            String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                          RegExp regExp = new RegExp(patttern);
                          if (value!.length == 0) {
                          return 'Please enter mobile number';
                          }
                          else if (!regExp.hasMatch(value!)) {
                          return 'Please enter valid mobile  number';
                          }
                          return null;
                          },
                          keyboardType: TextInputType.phone,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          autofocus: false,
                          controller: _phonecontroller,
                          decoration:  InputDecoration(
                            contentPadding: EdgeInsets.only(left: 11, right: 3,bottom: 5 ),
                            errorStyle: TextStyle(fontSize: 9, height: 0.3),
                              border: InputBorder.none,
                              hintText: "9072318094",
                              hintStyle: TextStyle(
                                fontFamily: 'Outfit',fontWeight: FontWeight.w400,
                                fontSize: 18,
                                  color: Colors.grey,
                              ),


                          ),

                          cursorColor: Colors.black,
                          cursorHeight: 20,
                          cursorWidth: 0.5,),
                      ),
                    )
                  ],
                ),

              ),
              SizedBox(height: scrHeight*0.009,),
              Padding(
                padding:  EdgeInsets.only(left: scrWidth*0.03),
                child: Text("don't worry your number will not share to anyone! ", style:TextStyle(
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                  color: Color(0xff000000).withOpacity(0.4),
                )),
              ),
              SizedBox(height: scrHeight*0.047,),
              GestureDetector(
                onTap: (){
                  if (_formkey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('get otp')
                      ),
                    );
                  }
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpPage()));
                },
                child: Container(

                  height: scrHeight*0.055,
                  width: scrWidth*0.87,
                  decoration: BoxDecoration(
                      color:primarycolor,
                      borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      "GET OTP",
                      style: style,
                    ),
                  ),
                ),
              ),
              SizedBox(height: scrHeight*0.03,),


              GestureDetector(
                onTap: (){
                  _auth.signInWithGoogle(context);

                  },
                child: Container(
                  height: scrHeight*0.055,
                  width: scrWidth*0.87,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: Color.fromRGBO(0, 0, 0, 0.12)),
                  ),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(),
                        child:SvgPicture.asset("assets/icons/google_logos.svg",),),
                      SizedBox(width: 8,),
                      Text(
                        "Continue with Google",
                        style:googlelogin
                      ),
                    ],
                  ),
                ),
              ),



            ],
          ),
        ),
      ),

    );
  }
}
