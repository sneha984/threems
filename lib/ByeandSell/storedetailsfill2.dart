import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:threems/ByeandSell/succesfullyadded.dart';

import '../screens/splash_screen.dart';
import '../utils/themes.dart';

class StoreDetailsFill2 extends StatefulWidget {
  const StoreDetailsFill2({Key? key}) : super(key: key);

  @override
  State<StoreDetailsFill2> createState() => _StoreDetailsFill2State();
}

class _StoreDetailsFill2State extends State<StoreDetailsFill2> {
  bool finished=false;
  final List<String> item = [
    "Kirana Store,Grocery",
    "Fashion Apparels,Garments,CLothing",
    "Home Decoration,Electronics",
    "Mobile,Computers & Accessories",
    "Fruits,Vegetables & Agricultural Products",
    "Pharmacy & Medical Care",
    "Pann Shop",
    "Books & Stationery"
  ];
  String? selectedValuee;
  final List<String> items = [
    "kg",
    "gm",
    "ml",
    "liter",
    "mm",
    "ft",
    "meter",
    "sq. ft.",
    "sq. meter",
    "km",
    "set",
    "hour",
    "day",
    "bunch",
    "bundle",
    "month",
    "year",
    "service",
    "work",
    "packet",
    "box",
    "pound",
    "dozen",
    "gunta",
    "pair",
    "minute",
    "quintal",
    "ton",
    "capsule",
    "tablet",
    "plate",
    "inch"
  ];
  FocusNode payableAmountNode = FocusNode();
  @override
  void dispose() {
    payableAmountNode.dispose();
    super.dispose();
  }

  void categoryAdd() {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, setState) {
          payableAmountNode.addListener(() {
            setState(() {});
          });
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            title: Text('Add New Category'),
            titleTextStyle: TextStyle(
                fontSize: 15,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w700,
                color: Color(0xff2C2C2C)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: scrWidth,
                  height: textFormFieldHeight45,
                  padding: EdgeInsets.symmetric(
                    horizontal: scrWidth * 0.015,
                    vertical: scrHeight*0.002,
                  ),
                  decoration: BoxDecoration(
                    color: textFormFieldFillColor,
                    borderRadius: BorderRadius.circular(scrWidth * 0.026),
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    focusNode: payableAmountNode,
                    cursorHeight: scrWidth * 0.055,
                    cursorWidth: 1,
                    cursorColor: Colors.black,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: FontSize15,
                      fontFamily: 'Urbanist',
                    ),
                    decoration: InputDecoration(
                      labelText: 'Category Name',
                      labelStyle: TextStyle(
                        color: payableAmountNode.hasFocus
                            ? primarycolor
                            : textFormUnFocusColor,
                        fontWeight: FontWeight.w600,
                        fontSize: FontSize15,
                        fontFamily: 'Urbanist',
                      ),
                      fillColor: textFormFieldFillColor,
                      filled: true,
                      contentPadding: EdgeInsets.only(
                          top: scrHeight*0.01,
                          bottom: scrWidth * 0.033,
                          left: scrWidth * 0.033),
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      border: InputBorder.none,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: primarycolor,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: scrWidth * 0.03,
                ),

                Container(
                  width: scrWidth,
                  height: textFormFieldHeight45,
                  decoration: BoxDecoration(
                      color: primarycolor,
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>ChitSucessPaidPage()));
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(
                            fontSize: FontSize16,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  String? selectedValue;
  final FocusNode productNameFocus= FocusNode();
  final FocusNode productPriceFocus= FocusNode();
  final FocusNode productUnitFocus= FocusNode();
  final FocusNode productDetails=FocusNode();
  final  TextEditingController storeNameController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.only(left: scrWidth*0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: scrHeight*0.08,),
              Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child:SvgPicture.asset("assets/icons/arrowmark.svg",),
                  ),
                  SizedBox(width: scrWidth*0.04,),
                  Text(
                    "Add Product",
                    style: TextStyle(
                        fontSize: scrWidth*0.046,
                        color: Colors.black,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(height: scrHeight*0.03,),
              Container(
                  height:scrHeight*0.11,
                  width: scrWidth*0.25,
                  decoration: BoxDecoration(
                  color: textFormFieldFillColor,
                  borderRadius:
                  BorderRadius.circular(scrWidth * 0.04),
                ),
                child:Center(child:SvgPicture.asset("assets/icons/bigcamera.svg"),
                )
              ),
              SizedBox(height: scrHeight*0.01,),
              Text(
                "Add product images (upto 5)",
                style: TextStyle(
                    fontSize: 12,
                    color: Color(0xffB0B0B0),
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: scrHeight*0.036,),

              Padding(
                padding:  EdgeInsets.only(right: scrWidth*0.053),
                child: Container(
                  height: textFormFieldHeight45,
                  padding: EdgeInsets.symmetric(
                    horizontal: scrWidth * 0.015,
                    vertical: scrHeight*0.002,
                  ),
                  decoration: BoxDecoration(
                    color: textFormFieldFillColor,
                    borderRadius:
                    BorderRadius.circular(scrWidth * 0.026),
                  ),
                  child: TextFormField(
                    focusNode: productNameFocus,
                    cursorHeight: scrWidth * 0.055,
                    cursorWidth: 1,
                    cursorColor: Colors.black,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: FontSize15,
                      fontFamily: 'Urbanist',
                    ),
                    decoration: InputDecoration(
                      labelText: 'Product Name',
                      labelStyle: TextStyle(
                        color: productNameFocus.hasFocus
                            ? primarycolor
                            : Color(0xffB0B0B0),
                        fontWeight: FontWeight.w600,
                        fontSize: FontSize15,
                        fontFamily: 'Urbanist',
                      ),
                      prefixIcon: Container(
                        height: scrWidth * 0.045,
                        width: 10,
                        padding: EdgeInsets.all(
                            scrWidth * 0.033),
                        child: SvgPicture.asset(
                          'assets/icons/storename.svg',
                          fit: BoxFit.contain,
                          color: Color(0xffB0B0B0),
                        ),
                      ),
                      fillColor: textFormFieldFillColor,
                      filled: true,
                      contentPadding: EdgeInsets.only(
                          top: 5, bottom: scrWidth * 0.033),
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      border: InputBorder.none,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: primarycolor,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: scrHeight*0.02,),
              Container(
                width: scrWidth * 0.9,
                height: textFormFieldHeight45,
                decoration: BoxDecoration(
                  color: textFormFieldFillColor,
                  borderRadius:
                  BorderRadius.circular(scrWidth * 0.033),
                ),
                child: Row(
                  children: [
                    SizedBox(width: scrWidth*0.057,),
                    SvgPicture.asset(
                      'assets/icons/storecategory.svg',
                    ),
                    SizedBox(width: scrWidth*0.04,),
                    DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        isExpanded: true,
                        hint: Expanded(
                          child:  Text(
                            "Store Category",
                            style: TextStyle(
                                fontSize: FontSize15,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w600,
                                color: Color(0xffB0B0B0)
                            ),
                          ),
                        ),
                        items: item
                            .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child:  Flexible(
                            child: Container(
                              child: Text(
                                item.toString(),overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    fontFamily: 'Urbanist'
                                ),
                              ),
                            ),
                          ),
                        ))
                            .toList(),
                        value: selectedValuee,
                        onChanged: (value) {
                          setState(() {
                            selectedValuee = value as String;
                          });
                        },
                        icon: const Icon(
                          Icons.arrow_drop_down,
                        ),
                        iconSize: 18,
                        iconEnabledColor: Colors.black,
                        iconDisabledColor: Colors.blue,
                        buttonHeight: 50,
                        buttonWidth:247,
                        buttonPadding: const EdgeInsets.only(right: 10),
                        buttonDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: textFormFieldFillColor,
                        ),
                        // buttonElevation: 2,
                        itemHeight: 40,
                        itemPadding: const EdgeInsets.only(),
                        dropdownMaxHeight: 260,
                        dropdownWidth: 300,
                        dropdownPadding: EdgeInsets.only(left: 30,top: 15,bottom: 25,right: 30),
                        dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        dropdownElevation: 0,

                        scrollbarRadius:  Radius.circular(10),
                        scrollbarThickness: 3,
                        scrollbarAlwaysShow: true,
                        offset: const Offset(-20, 0),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  categoryAdd();
                  },
                child: Padding(
                  padding:  EdgeInsets.only(left: scrWidth*0.62,top: scrHeight*0.01),
                  child: Text(
                    "Add new category",textAlign: TextAlign.end,
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w600,
                        color:primarycolor
                    ),
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(right: scrWidth*0.053,top: scrHeight*0.02),
                child: Container(
                  height: textFormFieldHeight45,
                  padding: EdgeInsets.symmetric(
                    horizontal: scrWidth * 0.015,
                    vertical: scrHeight*0.002,
                  ),
                  decoration: BoxDecoration(
                    color: textFormFieldFillColor,
                    borderRadius:
                    BorderRadius.circular(scrWidth * 0.026),
                  ),
                  child: TextFormField(
                    focusNode: productPriceFocus,
                    cursorHeight: scrWidth * 0.055,
                    cursorWidth: 1,
                    cursorColor: Colors.black,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: FontSize15,
                      fontFamily: 'Urbanist',
                    ),
                    decoration: InputDecoration(
                      labelText: 'Price',
                      labelStyle: TextStyle(
                        color: productPriceFocus.hasFocus
                            ? primarycolor
                            : Color(0xffB0B0B0),
                        fontWeight: FontWeight.w600,
                        fontSize: FontSize15,
                        fontFamily: 'Urbanist',
                      ),
                      prefixIcon: Container(
                        height: scrWidth * 0.045,
                        width: 10,
                        padding: EdgeInsets.all(
                            scrWidth * 0.033),
                        child: SvgPicture.asset(
                          'assets/icons/priceicons.svg',
                          fit: BoxFit.contain,
                          color: Color(0xffB0B0B0),
                        ),
                      ),
                      fillColor: textFormFieldFillColor,
                      filled: true,
                      contentPadding: EdgeInsets.only(
                          top: 5, bottom: scrWidth * 0.033),
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      border: InputBorder.none,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: primarycolor,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(right: scrWidth*0.053,top: scrHeight*0.02),
                child: Row(
                  children: [
                    Container(
                      height: textFormFieldHeight45,
                      width: scrWidth*0.42,
                      padding: EdgeInsets.symmetric(
                        horizontal: scrWidth * 0.015,
                        vertical: scrHeight*0.002,
                      ),
                      decoration: BoxDecoration(
                        color: textFormFieldFillColor,
                        borderRadius:
                        BorderRadius.circular(scrWidth * 0.026),
                      ),
                      child: TextFormField(
                        focusNode: productUnitFocus,
                        cursorHeight: scrWidth * 0.055,
                        cursorWidth: 1,
                        cursorColor: Colors.black,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: FontSize15,
                          fontFamily: 'Urbanist',
                        ),
                        decoration: InputDecoration(
                          labelText: 'Product Unit',
                          labelStyle: TextStyle(
                            color: productUnitFocus.hasFocus
                                ? primarycolor
                                : Color(0xffB0B0B0),
                            fontWeight: FontWeight.w600,
                            fontSize: FontSize15,
                            fontFamily: 'Urbanist',
                          ),
                          prefixIcon: Container(
                            height: scrWidth * 0.045,
                            width: 10,
                            padding: EdgeInsets.all(
                                scrWidth * 0.033),
                            child: SvgPicture.asset(
                              'assets/icons/priceicons.svg',
                              fit: BoxFit.contain,
                              color: Color(0xffB0B0B0),
                            ),
                          ),
                          fillColor: textFormFieldFillColor,
                          filled: true,
                          contentPadding: EdgeInsets.only(
                              top: 5, bottom: scrWidth * 0.033),
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          border: InputBorder.none,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: primarycolor,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: scrWidth*0.0478,),
                    Container(
                      width: scrWidth * 0.425,
                      height: textFormFieldHeight45,
                      decoration: BoxDecoration(
                        color: textFormFieldFillColor,
                        borderRadius:
                        BorderRadius.circular(scrWidth * 0.033),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                             width: scrWidth*0.057,
                          ),
                          SvgPicture.asset(
                            'assets/icons/storecategory.svg',
                          ),
                           SizedBox(width: scrWidth*0.06,),
                          DropdownButtonHideUnderline(
                            child: DropdownButton2(
                               isExpanded: true,
                              hint: Text(
                                "Piece",
                                style: TextStyle(
                                    fontSize: FontSize15,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black
                                ),
                              ),
                              items: items
                                  .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child:  Flexible(
                                  child: Container(
                                    child: Text(
                                      item.toString(),overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          fontFamily: 'Urbanist'
                                      ),
                                    ),
                                  ),
                                ),
                              ))
                                  .toList(),
                              value: selectedValue,
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value as String;
                                });
                              },
                              icon: const Icon(
                                Icons.arrow_drop_down,
                              ),
                              iconSize: 18,
                              iconEnabledColor: Colors.black,
                              iconDisabledColor: Colors.blue,
                              buttonHeight: 50,
                              buttonWidth:70,
                              // buttonPadding: const EdgeInsets.only(right: 10),
                              buttonDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: textFormFieldFillColor,
                              ),
                              // buttonElevation: 2,
                              itemHeight: 40,
                              itemPadding: const EdgeInsets.only(),
                              dropdownMaxHeight: 200,
                              dropdownWidth: 100,
                               dropdownPadding: EdgeInsets.only(left: 10,top: 15,bottom: 25,right: 30),
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              dropdownElevation: 0,

                              scrollbarRadius:  Radius.circular(10),
                              scrollbarThickness: 3,
                              scrollbarAlwaysShow: true,
                              offset: const Offset(-20, 0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Text("Unit : per 2 piece",style: TextStyle(
                fontFamily: 'Urbanist',fontWeight: FontWeight.w600,color: primarycolor,fontSize: 12
              ),),
              Padding(
                padding:  EdgeInsets.only(right: scrWidth*0.053,top: scrHeight*0.02),
                child: Container(
                  height: textFormFieldHeight45,
                  padding: EdgeInsets.symmetric(
                    horizontal: scrWidth * 0.015,
                    vertical: scrHeight*0.002,
                  ),
                  decoration: BoxDecoration(
                    color: textFormFieldFillColor,
                    borderRadius:
                    BorderRadius.circular(scrWidth * 0.026),
                  ),
                  child: TextFormField(
                    focusNode: productDetails,
                    cursorHeight: scrWidth * 0.055,
                    cursorWidth: 1,
                    cursorColor: Colors.black,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: FontSize15,
                      fontFamily: 'Urbanist',
                    ),
                    decoration: InputDecoration(
                      labelText: 'Details',
                      labelStyle: TextStyle(
                        color: productDetails.hasFocus
                            ? primarycolor
                            : Color(0xffB0B0B0),
                        fontWeight: FontWeight.w600,
                        fontSize: FontSize15,
                        fontFamily: 'Urbanist',
                      ),
                      prefixIcon: Container(
                        height: scrWidth * 0.045,
                        width: 10,
                        padding: EdgeInsets.all(
                            scrWidth * 0.033),
                        child: SvgPicture.asset(
                          'assets/icons/storename.svg',
                          fit: BoxFit.contain,
                          color: Color(0xffB0B0B0),
                        ),
                      ),
                      fillColor: textFormFieldFillColor,
                      filled: true,
                      contentPadding: EdgeInsets.only(
                          top: 5, bottom: scrWidth * 0.033),
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      border: InputBorder.none,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: primarycolor,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
               SizedBox(height: scrHeight*0.195,),
              finished?Padding(
                padding:  EdgeInsets.only(right: scrWidth*0.053),
                child: Container(
                  height: textFormFieldHeight45,
                  width: scrWidth,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 128, 54, 0.33),
                      borderRadius: BorderRadius.circular(21.5)),
                  child: Center(
                    child: Text(
                      "Add Product",
                      style: TextStyle(color: Colors.white,
                          fontFamily: 'Urbanist',
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ) :GestureDetector(
                onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>SuccesfullyAdded()));
                },
                child: Padding(
                  padding:  EdgeInsets.only(right: scrWidth*0.053),
                  child: Container(
                    height: textFormFieldHeight45,
                    width: scrWidth,
                    decoration: BoxDecoration(
                        color: primarycolor,
                        borderRadius: BorderRadius.circular(21.5)),
                    child: Center(
                      child: Text(
                        "Add Product",
                        style: TextStyle(color: Colors.white,
                            fontFamily: 'Urbanist',
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
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
