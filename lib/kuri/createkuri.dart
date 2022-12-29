import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:threems/Authentication/root.dart';

import '../customPackage/date_picker.dart';
import '../model/Kuri/kuriModel.dart';
import '../screens/home_screen.dart';
import '../screens/splash_screen.dart';
import '../utils/themes.dart';
import '../widgets/list.dart';
import 'add_member_search_kuri.dart';
import 'add_members_kuri.dart';

class CreateKuriPage extends StatefulWidget {
  const CreateKuriPage({Key? key}) : super(key: key);

  @override
  State<CreateKuriPage> createState() => _CreateKuriPageState();
}

class _CreateKuriPageState extends State<CreateKuriPage> {
  bool private = false;

  List<MultiSelect> multiselect = [
    MultiSelect(
      image: "assets/icons/gpay.svg",
      payname: "Google Pay",
      type: 'svg',
      isSelected: false,
    ),
    MultiSelect(
      image: "assets/images/whatsapp.png",
      payname: "Whatsapp Pay",
      isSelected: false,
      type: 'png',
    ),
    MultiSelect(
      image: "assets/icons/paytmimage.svg",
      payname: "Paytm",
      isSelected: false,
      type: 'svg',
    ),
    MultiSelect(
      image: "assets/images/phonepe.svg",
      payname: "Phonepe",
      isSelected: false,
      type: 'svg',
    ),
    MultiSelect(
      image: "assets/images/amazon pe.svg",
      payname: "Amazon Pay",
      isSelected: false,
      type: 'svg',
    ),
  ];
  List<MultiSelect> selectedPayments = [];

  int kuriTabBarIndex = 0;
  int selectedIndex = 0;
  final PageController _privateOrPublicKuriPageController =
      PageController(keepPage: true);

  final FocusNode phonenumberfocus = FocusNode();
  final FocusNode kuriNameFocus = FocusNode();
  final FocusNode valueAmountFocus = FocusNode();
  final FocusNode fixedDeadLineFocus = FocusNode();
  final FocusNode accountnumberfocus = FocusNode();
  final FocusNode confirmaccountnumberfocus = FocusNode();
  final FocusNode accountholdernamefocus = FocusNode();
  final FocusNode banknamefocus = FocusNode();
  final FocusNode ifsccodefocus = FocusNode();

//KURI ADDING CONTROLLERS
  DateTime? selectedDate;
  TextEditingController kuriName = TextEditingController();
  TextEditingController amount = TextEditingController();
  String purpose = 'Hospital';
  TextEditingController phone = TextEditingController();
  List<String> upiApps = [];

  TextEditingController accountNumber = TextEditingController();
  TextEditingController confirmAccountNumber = TextEditingController();
  TextEditingController accountHolderName = TextEditingController();
  TextEditingController bankName = TextEditingController();
  TextEditingController ifsc = TextEditingController();

//DatePick
  Future<void> _selectedDate(BuildContext context) async {
    final DateTime? datePicked = await showDatePickerCustom(
        cancelText: 'Cancel',
        confirmText: 'Select',
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 2),
        initialDate: DateTime.now(),
        builder: (context, child) => Theme(
            data: ThemeData(
                colorScheme: ColorScheme.light(primary: Colors.green)),
            child: child!));
    if (datePicked != null && datePicked != selectedDate) {
      setState(() {
        selectedDate = datePicked;

        print('-------------SELECTED DATE-----------------');
        print(selectedDate);
      });
    }
  }

  @override
  void initState() {
    kuriNameFocus.addListener(() {
      setState(() {});
    });
    valueAmountFocus.addListener(() {
      setState(() {});
    });
    fixedDeadLineFocus.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _privateOrPublicKuriPageController.dispose();
    valueAmountFocus.dispose();
    kuriNameFocus.dispose();
    fixedDeadLineFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await confirmQuitDialog(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 84,
          shadowColor: Colors.grey,
          centerTitle: false,
          elevation: 0.1,
          backgroundColor: Colors.white,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.only(
                  top: scrHeight * 0.04,
                  left: scrWidth * 0.07,
                  bottom: scrHeight * 0.02,
                  right: scrWidth * 0.05),
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 25,
              ),
            ),
          ),
          title: Padding(
            padding: EdgeInsets.only(top: scrHeight * 0.02),
            child: Text(
              "Create New Kuri",
              style: TextStyle(
                  fontSize: scrWidth * 0.046,
                  color: Colors.black,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(
              left: scrWidth * 0.05,
              right: scrWidth * 0.05,
              top: scrHeight * 0.03),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      right: scrWidth * 0.7, bottom: scrHeight * 0.01),
                  child: Text(
                    "About Kuri",
                    style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  width: scrWidth,
                  height: scrWidth * 0.15,
                  // color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            kuriTabBarIndex = 0;
                            private = false;
                          });
                          _privateOrPublicKuriPageController
                              .jumpToPage(kuriTabBarIndex);
                        },
                        child: Container(
                          width: scrWidth * 0.42,
                          // width: 160,
                          height: scrWidth * 0.09,
                          decoration: BoxDecoration(
                            color: kuriTabBarIndex == 0
                                ? tabBarColor
                                : Colors.white.withOpacity(0),
                            borderRadius:
                                BorderRadius.circular(scrWidth * 0.052),
                            border: Border.all(
                              color: kuriTabBarIndex == 0
                                  ? Colors.black.withOpacity(0)
                                  : Colors.black.withOpacity(0.06),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Public Chit",
                              style: TextStyle(
                                color: kuriTabBarIndex == 0
                                    ? Colors.white
                                    : Color(0xffB3B3B3),
                                fontSize: FontSize14,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            kuriTabBarIndex = 1;
                            private = true;
                          });
                          _privateOrPublicKuriPageController
                              .jumpToPage(kuriTabBarIndex);
                        },
                        child: Container(
                          width: scrWidth * 0.42,
                          // width: 160,
                          height: scrWidth * 0.09,
                          decoration: BoxDecoration(
                            color: kuriTabBarIndex == 1
                                ? tabBarColor
                                : Colors.white.withOpacity(0),
                            borderRadius:
                                BorderRadius.circular(scrWidth * 0.052),
                            border: Border.all(
                              color: kuriTabBarIndex == 1
                                  ? Colors.black.withOpacity(0)
                                  : Colors.black.withOpacity(0.06),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Private Chit",
                              style: TextStyle(
                                color: kuriTabBarIndex == 1
                                    ? Colors.white
                                    : Color(0xffB3B3B3),
                                fontSize: FontSize14,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: scrHeight * 0.01,
                ),
                Container(
                  // color: Colors.grey[200],
                  height: scrWidth * 5,
                  width: scrWidth,
                  child: PageView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _privateOrPublicKuriPageController,
                    children: [
                      //PublicKuri
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: textFormFieldHeight45,
                            padding: EdgeInsets.symmetric(
                              horizontal: scrWidth * 0.015,
                              vertical: scrHeight * 0.002,
                            ),
                            decoration: BoxDecoration(
                              color: textFormFieldFillColor,
                              borderRadius:
                                  BorderRadius.circular(scrWidth * 0.026),
                            ),
                            child: TextFormField(
                              controller: kuriName,
                              focusNode: kuriNameFocus,
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
                                labelText: 'Kuri Name',
                                labelStyle: TextStyle(
                                  color: kuriNameFocus.hasFocus
                                      ? primarycolor
                                      : Color(0xffB0B0B0),
                                  fontWeight: FontWeight.w600,
                                  fontSize: FontSize15,
                                  fontFamily: 'Urbanist',
                                ),
                                prefixIcon: Container(
                                  height: scrWidth * 0.045,
                                  width: 10,
                                  padding: EdgeInsets.all(scrWidth * 0.033),
                                  child: SvgPicture.asset(
                                    'assets/icons/chitname.svg',
                                    fit: BoxFit.contain,
                                    color: kuriNameFocus.hasFocus
                                        ? primarycolor
                                        : Color(0xffB0B0B0),
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
                          SizedBox(
                            height: scrWidth * 0.04,
                          ),
                          Container(
                            height: textFormFieldHeight45,
                            padding: EdgeInsets.symmetric(
                              horizontal: scrWidth * 0.015,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: textFormFieldFillColor,
                              borderRadius:
                                  BorderRadius.circular(scrWidth * 0.026),
                            ),
                            child: TextFormField(
                              controller: amount,
                              focusNode: valueAmountFocus,
                              cursorHeight: scrWidth * 0.055,
                              cursorWidth: 1,
                              keyboardType: TextInputType.number,
                              cursorColor: Colors.black,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: FontSize15,
                                fontFamily: 'Urbanist',
                              ),
                              decoration: InputDecoration(
                                labelText: 'Value Amount',
                                labelStyle: TextStyle(
                                  color: valueAmountFocus.hasFocus
                                      ? primarycolor
                                      : Color(0xffB0B0B0),
                                  fontWeight: FontWeight.w600,
                                  fontSize: FontSize15,
                                  fontFamily: 'Urbanist',
                                ),
                                prefixIcon: Container(
                                  height: scrWidth * 0.045,
                                  width: 10,
                                  padding: EdgeInsets.all(scrWidth * 0.033),
                                  child: SvgPicture.asset(
                                    'assets/icons/value.svg',
                                    fit: BoxFit.contain,
                                    color: valueAmountFocus.hasFocus
                                        ? primarycolor
                                        : Color(0xffB0B0B0),
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
                          SizedBox(
                            height: scrWidth * 0.04,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _selectedDate(context);
                                },
                                child: Container(
                                    width: scrWidth * 0.7,
                                    height: textFormFieldHeight45,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: scrWidth * 0.015,
                                      // vertical: scrHeight*0.01,
                                    ),
                                    decoration: BoxDecoration(
                                        color: textFormFieldFillColor,
                                        borderRadius: BorderRadius.circular(
                                            scrWidth * 0.026)),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: scrWidth * 0.03,
                                        ),
                                        SvgPicture.asset(
                                            'assets/icons/durationiconsvg.svg',
                                            fit: BoxFit.contain,
                                            color: Color(0xffB0B0B0)),
                                        SizedBox(
                                          width: scrWidth * 0.03,
                                        ),
                                        Text(
                                          selectedDate == null
                                              ? "Fixed Deadline"
                                              : DateFormat.yMMMd()
                                                  .format(selectedDate!),
                                          style: TextStyle(
                                            color: selectedDate == null
                                                ? Color(0xffB0B0B0)
                                                : Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: FontSize15,
                                            fontFamily: 'Urbanist',
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  print("hiii");
                                  _selectedDate(context);
                                },
                                child: Container(
                                  height: scrHeight * 0.055,
                                  width: scrWidth * 0.16,
                                  decoration: BoxDecoration(
                                      color: primarycolor,
                                      borderRadius: BorderRadius.circular(
                                          scrWidth * 0.03)),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: scrHeight * 0.01,
                                        bottom: scrHeight * 0.01),
                                    child: SvgPicture.asset(
                                        "assets/icons/calenderimage.svg"),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: scrWidth * 0.0009,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: scrWidth * 0.05,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: scrWidth * 0.5,
                                bottom: scrHeight * 0.017),
                            child: Text(
                              "Choose your purpose",
                              style: TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = 1;
                                    purpose = 'Marriage';
                                  });
                                },
                                child: Column(
                                  children: [
                                    Container(
                                        width: scrWidth * 0.18,
                                        height: scrHeight * 0.08,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey.shade100,
                                          border: selectedIndex == 1
                                              ? Border.all(
                                                  color: primarycolor,
                                                  width: 3,
                                                )
                                              : Border.all(
                                                  color: Colors.transparent),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child: SvgPicture.asset(
                                              "assets/icons/marriageimage.svg"),
                                        )),
                                    SizedBox(
                                      height: scrHeight * 0.01,
                                    ),
                                    Text("Marriage",
                                        style: TextStyle(
                                            color: Color(0xffB0B0B0),
                                            fontFamily: 'Urbanist',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10)),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = 0;
                                    purpose = 'Hospital';
                                  });
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: scrWidth * 0.18,
                                      height: scrHeight * 0.08,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey.shade100,
                                        border: selectedIndex == 0
                                            ? Border.all(
                                                color: primarycolor,
                                                width: 3,
                                              )
                                            : Border.all(
                                                color: Colors.transparent),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(19.0),
                                        child: SvgPicture.asset(
                                            "assets/icons/hospitalimage.svg"),
                                      ),
                                    ),
                                    SizedBox(
                                      height: scrHeight * 0.01,
                                    ),
                                    Text("Hospital",
                                        style: TextStyle(
                                            color: Color(0xffB0B0B0),
                                            fontFamily: 'Urbanist',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10)),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = 2;
                                    purpose = 'Other';
                                  });
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: scrWidth * 0.18,
                                      height: scrHeight * 0.08,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey.shade100,
                                        border: selectedIndex == 2
                                            ? Border.all(
                                                color: primarycolor,
                                                width: 3,
                                              )
                                            : Border.all(
                                                color: Colors.transparent),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(19.0),
                                        child: SvgPicture.asset(
                                            "assets/icons/otherimage.svg"),
                                      ),
                                    ),
                                    SizedBox(
                                      height: scrHeight * 0.01,
                                    ),
                                    Text("Other",
                                        style: TextStyle(
                                            color: Color(0xffB0B0B0),
                                            fontFamily: 'Urbanist',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10)),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: scrWidth * 0.7,
                                top: scrHeight * 0.016,
                                bottom: scrHeight * 0.01),
                            child: Text(
                              "Payment",
                              style: TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            height: textFormFieldHeight45,
                            padding: EdgeInsets.symmetric(
                              horizontal: scrWidth * 0.015,
                              vertical: scrHeight * 0.002,
                            ),
                            decoration: BoxDecoration(
                              color: textFormFieldFillColor,
                              borderRadius:
                                  BorderRadius.circular(scrWidth * 0.026),
                            ),
                            child: TextFormField(
                              controller: phone,
                              focusNode: phonenumberfocus,
                              keyboardType: TextInputType.number,
                              // maxLength: 10,
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
                                prefixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/indflag.svg',
                                      height: scrHeight * 0.03,
                                      width: scrWidth * 0.02,
                                    ),
                                    SizedBox(
                                      width: scrWidth * 0.02,
                                    ),
                                    Text(
                                      "+91",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: FontSize17,
                                        fontFamily: 'Outfit',
                                      ),
                                    ),
                                    VerticalDivider(
                                      endIndent: 6,
                                      indent: 6,
                                      color: Color(0xffDADADA),
                                      thickness: 1,
                                    ),
                                  ],
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
                          Padding(
                            padding: EdgeInsets.only(
                                right: scrWidth * 0.6,
                                top: scrHeight * 0.025,
                                bottom: scrHeight * 0.02),
                            child: Text(
                              "Choose UPI apps",
                              style: TextStyle(
                                  color: Color(0xffB0B0B0),
                                  fontFamily: 'Urbanist',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                              height: 90,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: multiselect.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return PayItem(
                                      multiselect[index].image,
                                      multiselect[index].payname,
                                      multiselect[index].isSelected,
                                      index,
                                      multiselect[index].type,
                                    );
                                  })),
                          Padding(
                            padding: EdgeInsets.only(
                                right: scrWidth * 0.65,
                                top: scrHeight * 0.026,
                                bottom: scrHeight * 0.01),
                            child: Text(
                              "Bank Details",
                              style: TextStyle(
                                  color: Color(0xffB0B0B0),
                                  fontFamily: 'Urbanist',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          Container(
                            height: textFormFieldHeight45,
                            padding: EdgeInsets.symmetric(
                              horizontal: scrWidth * 0.015,
                              vertical: scrHeight * 0.002,
                            ),
                            decoration: BoxDecoration(
                              color: textFormFieldFillColor,
                              borderRadius:
                                  BorderRadius.circular(scrWidth * 0.026),
                            ),
                            child: TextFormField(
                              focusNode: accountnumberfocus,
                              controller: accountNumber,
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
                                labelText: 'Account Number',
                                labelStyle: TextStyle(
                                  color: accountnumberfocus.hasFocus
                                      ? primarycolor
                                      : Color(0xffB0B0B0),
                                  fontWeight: FontWeight.w600,
                                  fontSize: FontSize15,
                                  fontFamily: 'Urbanist',
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
                          SizedBox(
                            height: 14,
                          ),
                          Container(
                            height: textFormFieldHeight45,
                            padding: EdgeInsets.symmetric(
                              horizontal: scrWidth * 0.015,
                              vertical: scrHeight * 0.002,
                            ),
                            decoration: BoxDecoration(
                              color: textFormFieldFillColor,
                              borderRadius:
                                  BorderRadius.circular(scrWidth * 0.026),
                            ),
                            child: TextFormField(
                              focusNode: confirmaccountnumberfocus,
                              controller: confirmAccountNumber,
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
                                labelText: 'Confirm Account Number',
                                labelStyle: TextStyle(
                                  color: confirmaccountnumberfocus.hasFocus
                                      ? primarycolor
                                      : Color(0xffB0B0B0),
                                  fontWeight: FontWeight.w600,
                                  fontSize: FontSize15,
                                  fontFamily: 'Urbanist',
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
                          SizedBox(
                            height: 14,
                          ),
                          Container(
                            height: textFormFieldHeight45,
                            padding: EdgeInsets.symmetric(
                              horizontal: scrWidth * 0.015,
                              vertical: scrHeight * 0.002,
                            ),
                            decoration: BoxDecoration(
                              color: textFormFieldFillColor,
                              borderRadius:
                                  BorderRadius.circular(scrWidth * 0.026),
                            ),
                            child: TextFormField(
                              focusNode: accountholdernamefocus,
                              controller: accountHolderName,
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
                                labelText: 'Account Holder Name',
                                labelStyle: TextStyle(
                                  color: accountholdernamefocus.hasFocus
                                      ? primarycolor
                                      : Color(0xffB0B0B0),
                                  fontWeight: FontWeight.w600,
                                  fontSize: FontSize15,
                                  fontFamily: 'Urbanist',
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
                          SizedBox(
                            height: 14,
                          ),
                          Container(
                            height: textFormFieldHeight45,
                            padding: EdgeInsets.symmetric(
                              horizontal: scrWidth * 0.015,
                              vertical: scrHeight * 0.002,
                            ),
                            decoration: BoxDecoration(
                              color: textFormFieldFillColor,
                              borderRadius:
                                  BorderRadius.circular(scrWidth * 0.026),
                            ),
                            child: TextFormField(
                              focusNode: banknamefocus,
                              controller: bankName,
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
                                labelText: 'Bank Name',
                                labelStyle: TextStyle(
                                  color: banknamefocus.hasFocus
                                      ? primarycolor
                                      : Color(0xffB0B0B0),
                                  fontWeight: FontWeight.w600,
                                  fontSize: FontSize15,
                                  fontFamily: 'Urbanist',
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
                          SizedBox(
                            height: 14,
                          ),
                          Container(
                            height: textFormFieldHeight45,
                            padding: EdgeInsets.symmetric(
                              horizontal: scrWidth * 0.015,
                              vertical: scrHeight * 0.002,
                            ),
                            decoration: BoxDecoration(
                              color: textFormFieldFillColor,
                              borderRadius:
                                  BorderRadius.circular(scrWidth * 0.026),
                            ),
                            child: TextFormField(
                              focusNode: ifsccodefocus,
                              controller: ifsc,
                              textCapitalization: TextCapitalization.characters,
                              // inputFormatters: [UpperCaseTextFormatter()],
                              onChanged: ((val) {
                                ifsc.value = TextEditingValue(
                                    text: val.toUpperCase(),
                                    selection: ifsc.selection);
                              }),
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
                                labelText: 'IFSC Code',
                                labelStyle: TextStyle(
                                  color: ifsccodefocus.hasFocus
                                      ? primarycolor
                                      : Color(0xffB0B0B0),
                                  fontWeight: FontWeight.w600,
                                  fontSize: FontSize15,
                                  fontFamily: 'Urbanist',
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
                        ],
                      ),
                      //Private Kuri
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: textFormFieldHeight45,
                            padding: EdgeInsets.symmetric(
                              horizontal: scrWidth * 0.015,
                              vertical: scrHeight * 0.002,
                            ),
                            decoration: BoxDecoration(
                              color: textFormFieldFillColor,
                              borderRadius:
                                  BorderRadius.circular(scrWidth * 0.026),
                            ),
                            child: TextFormField(
                              controller: kuriName,
                              focusNode: kuriNameFocus,
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
                                labelText: 'Kuri Name',
                                labelStyle: TextStyle(
                                  color: kuriNameFocus.hasFocus
                                      ? primarycolor
                                      : Color(0xffB0B0B0),
                                  fontWeight: FontWeight.w600,
                                  fontSize: FontSize15,
                                  fontFamily: 'Urbanist',
                                ),
                                prefixIcon: Container(
                                  height: scrWidth * 0.045,
                                  width: 10,
                                  padding: EdgeInsets.all(scrWidth * 0.033),
                                  child: SvgPicture.asset(
                                    'assets/icons/chitname.svg',
                                    fit: BoxFit.contain,
                                    color: kuriNameFocus.hasFocus
                                        ? primarycolor
                                        : Color(0xffB0B0B0),
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
                          SizedBox(
                            height: scrWidth * 0.04,
                          ),
                          Container(
                            height: textFormFieldHeight45,
                            padding: EdgeInsets.symmetric(
                              horizontal: scrWidth * 0.015,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: textFormFieldFillColor,
                              borderRadius:
                                  BorderRadius.circular(scrWidth * 0.026),
                            ),
                            child: TextFormField(
                              controller: amount,
                              focusNode: valueAmountFocus,
                              cursorHeight: scrWidth * 0.055,
                              cursorWidth: 1,
                              keyboardType: TextInputType.number,
                              cursorColor: Colors.black,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: FontSize15,
                                fontFamily: 'Urbanist',
                              ),
                              decoration: InputDecoration(
                                labelText: 'Value Amount',
                                labelStyle: TextStyle(
                                  color: valueAmountFocus.hasFocus
                                      ? primarycolor
                                      : Color(0xffB0B0B0),
                                  fontWeight: FontWeight.w600,
                                  fontSize: FontSize15,
                                  fontFamily: 'Urbanist',
                                ),
                                prefixIcon: Container(
                                  height: scrWidth * 0.045,
                                  width: 10,
                                  padding: EdgeInsets.all(scrWidth * 0.033),
                                  child: SvgPicture.asset(
                                    'assets/icons/value.svg',
                                    fit: BoxFit.contain,
                                    color: valueAmountFocus.hasFocus
                                        ? primarycolor
                                        : Color(0xffB0B0B0),
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
                          SizedBox(
                            height: scrWidth * 0.04,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // _selectedDate(context);
                                },
                                child: Container(
                                    width: scrWidth * 0.7,
                                    height: textFormFieldHeight45,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: scrWidth * 0.015,
                                      // vertical: scrHeight*0.01,
                                    ),
                                    decoration: BoxDecoration(
                                        color: textFormFieldFillColor,
                                        borderRadius: BorderRadius.circular(
                                            scrWidth * 0.026)),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: scrWidth * 0.03,
                                        ),
                                        SvgPicture.asset(
                                            'assets/icons/durationiconsvg.svg',
                                            fit: BoxFit.contain,
                                            color: Color(0xffB0B0B0)),
                                        SizedBox(
                                          width: scrWidth * 0.03,
                                        ),
                                        Text(
                                          selectedDate == null
                                              ? "Fixed Deadline"
                                              : DateFormat.yMMMd()
                                                  .format(selectedDate!),
                                          style: TextStyle(
                                            color: selectedDate == null
                                                ? Color(0xffB0B0B0)
                                                : Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: FontSize15,
                                            fontFamily: 'Urbanist',
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  print("hiii");
                                  _selectedDate(context);
                                },
                                child: Container(
                                  height: scrHeight * 0.055,
                                  width: scrWidth * 0.16,
                                  decoration: BoxDecoration(
                                      color: primarycolor,
                                      borderRadius: BorderRadius.circular(
                                          scrWidth * 0.03)),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: scrHeight * 0.01,
                                        bottom: scrHeight * 0.01),
                                    child: SvgPicture.asset(
                                        "assets/icons/calenderimage.svg"),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: scrWidth * 0.0009,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: scrWidth * 0.05,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: scrWidth * 0.5,
                                bottom: scrHeight * 0.017),
                            child: Text(
                              "Choose your purpose",
                              style: TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = 1;
                                    purpose = 'Marriage';
                                  });
                                },
                                child: Column(
                                  children: [
                                    Container(
                                        width: scrWidth * 0.18,
                                        height: scrHeight * 0.08,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey.shade100,
                                          border: selectedIndex == 1
                                              ? Border.all(
                                                  color: primarycolor,
                                                  width: 3,
                                                )
                                              : Border.all(
                                                  color: Colors.transparent),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(19.0),
                                          child: SvgPicture.asset(
                                              "assets/icons/marriageimage.svg"),
                                        )),
                                    SizedBox(
                                      height: scrHeight * 0.01,
                                    ),
                                    Text("Marriage",
                                        style: TextStyle(
                                            color: Color(0xffB0B0B0),
                                            fontFamily: 'Urbanist',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10)),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = 0;
                                    purpose = 'Hospital';
                                  });
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: scrWidth * 0.18,
                                      height: scrHeight * 0.08,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey.shade100,
                                        border: selectedIndex == 0
                                            ? Border.all(
                                                color: primarycolor,
                                                width: 3,
                                              )
                                            : Border.all(
                                                color: Colors.transparent),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(19.0),
                                        child: SvgPicture.asset(
                                            "assets/icons/hospitalimage.svg"),
                                      ),
                                    ),
                                    SizedBox(
                                      height: scrHeight * 0.01,
                                    ),
                                    Text("Hospital",
                                        style: TextStyle(
                                            color: Color(0xffB0B0B0),
                                            fontFamily: 'Urbanist',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10)),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = 2;
                                    purpose = 'Other';
                                  });
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: scrWidth * 0.18,
                                      height: scrHeight * 0.08,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey.shade100,
                                        border: selectedIndex == 2
                                            ? Border.all(
                                                color: primarycolor,
                                                width: 3,
                                              )
                                            : Border.all(
                                                color: Colors.transparent),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(19.0),
                                        child: SvgPicture.asset(
                                            "assets/icons/otherimage.svg"),
                                      ),
                                    ),
                                    SizedBox(
                                      height: scrHeight * 0.01,
                                    ),
                                    Text("Other",
                                        style: TextStyle(
                                            color: Color(0xffB0B0B0),
                                            fontFamily: 'Urbanist',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10)),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: scrWidth * 0.7,
                                top: scrHeight * 0.016,
                                bottom: scrHeight * 0.01),
                            child: Text(
                              "Payment",
                              style: TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            height: textFormFieldHeight45,
                            padding: EdgeInsets.symmetric(
                              horizontal: scrWidth * 0.015,
                              vertical: scrHeight * 0.002,
                            ),
                            decoration: BoxDecoration(
                              color: textFormFieldFillColor,
                              borderRadius:
                                  BorderRadius.circular(scrWidth * 0.026),
                            ),
                            child: TextFormField(
                              controller: phone,
                              focusNode: phonenumberfocus,
                              keyboardType: TextInputType.number,
                              // maxLength: 10,
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
                                prefixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/indflag.svg',
                                      height: scrHeight * 0.03,
                                      width: scrWidth * 0.02,
                                    ),
                                    SizedBox(
                                      width: scrWidth * 0.02,
                                    ),
                                    Text(
                                      "+91",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: FontSize17,
                                        fontFamily: 'Outfit',
                                      ),
                                    ),
                                    VerticalDivider(
                                      endIndent: 6,
                                      indent: 6,
                                      color: Color(0xffDADADA),
                                      thickness: 1,
                                    ),
                                  ],
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
                          Padding(
                            padding: EdgeInsets.only(
                                right: scrWidth * 0.6,
                                top: scrHeight * 0.025,
                                bottom: scrHeight * 0.02),
                            child: Text(
                              "Choose UPI apps",
                              style: TextStyle(
                                  color: Color(0xffB0B0B0),
                                  fontFamily: 'Urbanist',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                              height: 90,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: multiselect.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return PayItem(
                                      multiselect[index].image,
                                      multiselect[index].payname,
                                      multiselect[index].isSelected,
                                      index,
                                      multiselect[index].type,
                                    );
                                  })),
                          Padding(
                            padding: EdgeInsets.only(
                                right: scrWidth * 0.65,
                                top: scrHeight * 0.026,
                                bottom: scrHeight * 0.01),
                            child: Text(
                              "Bank Details",
                              style: TextStyle(
                                  color: Color(0xffB0B0B0),
                                  fontFamily: 'Urbanist',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          Container(
                            height: textFormFieldHeight45,
                            padding: EdgeInsets.symmetric(
                              horizontal: scrWidth * 0.015,
                              vertical: scrHeight * 0.002,
                            ),
                            decoration: BoxDecoration(
                              color: textFormFieldFillColor,
                              borderRadius:
                                  BorderRadius.circular(scrWidth * 0.026),
                            ),
                            child: TextFormField(
                              focusNode: accountnumberfocus,
                              controller: accountNumber,
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
                                labelText: 'Account Number',
                                labelStyle: TextStyle(
                                  color: accountnumberfocus.hasFocus
                                      ? primarycolor
                                      : Color(0xffB0B0B0),
                                  fontWeight: FontWeight.w600,
                                  fontSize: FontSize15,
                                  fontFamily: 'Urbanist',
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
                          SizedBox(
                            height: 14,
                          ),
                          Container(
                            height: textFormFieldHeight45,
                            padding: EdgeInsets.symmetric(
                              horizontal: scrWidth * 0.015,
                              vertical: scrHeight * 0.002,
                            ),
                            decoration: BoxDecoration(
                              color: textFormFieldFillColor,
                              borderRadius:
                                  BorderRadius.circular(scrWidth * 0.026),
                            ),
                            child: TextFormField(
                              focusNode: confirmaccountnumberfocus,
                              controller: confirmAccountNumber,
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
                                labelText: 'Confirm Account Number',
                                labelStyle: TextStyle(
                                  color: confirmaccountnumberfocus.hasFocus
                                      ? primarycolor
                                      : Color(0xffB0B0B0),
                                  fontWeight: FontWeight.w600,
                                  fontSize: FontSize15,
                                  fontFamily: 'Urbanist',
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
                          SizedBox(
                            height: 14,
                          ),
                          Container(
                            height: textFormFieldHeight45,
                            padding: EdgeInsets.symmetric(
                              horizontal: scrWidth * 0.015,
                              vertical: scrHeight * 0.002,
                            ),
                            decoration: BoxDecoration(
                              color: textFormFieldFillColor,
                              borderRadius:
                                  BorderRadius.circular(scrWidth * 0.026),
                            ),
                            child: TextFormField(
                              focusNode: accountholdernamefocus,
                              controller: accountHolderName,
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
                                labelText: 'Account Holder Name',
                                labelStyle: TextStyle(
                                  color: accountholdernamefocus.hasFocus
                                      ? primarycolor
                                      : Color(0xffB0B0B0),
                                  fontWeight: FontWeight.w600,
                                  fontSize: FontSize15,
                                  fontFamily: 'Urbanist',
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
                          SizedBox(
                            height: 14,
                          ),
                          Container(
                            height: textFormFieldHeight45,
                            padding: EdgeInsets.symmetric(
                              horizontal: scrWidth * 0.015,
                              vertical: scrHeight * 0.002,
                            ),
                            decoration: BoxDecoration(
                              color: textFormFieldFillColor,
                              borderRadius:
                                  BorderRadius.circular(scrWidth * 0.026),
                            ),
                            child: TextFormField(
                              focusNode: banknamefocus,
                              controller: bankName,
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
                                labelText: 'Bank Name',
                                labelStyle: TextStyle(
                                  color: banknamefocus.hasFocus
                                      ? primarycolor
                                      : Color(0xffB0B0B0),
                                  fontWeight: FontWeight.w600,
                                  fontSize: FontSize15,
                                  fontFamily: 'Urbanist',
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
                          SizedBox(
                            height: 14,
                          ),
                          Container(
                            height: textFormFieldHeight45,
                            padding: EdgeInsets.symmetric(
                              horizontal: scrWidth * 0.015,
                              vertical: scrHeight * 0.002,
                            ),
                            decoration: BoxDecoration(
                              color: textFormFieldFillColor,
                              borderRadius:
                                  BorderRadius.circular(scrWidth * 0.026),
                            ),
                            child: TextFormField(
                              focusNode: ifsccodefocus,
                              controller: ifsc,
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
                                labelText: 'IFSC Code',
                                labelStyle: TextStyle(
                                  color: ifsccodefocus.hasFocus
                                      ? primarycolor
                                      : Color(0xffB0B0B0),
                                  fontWeight: FontWeight.w600,
                                  fontSize: FontSize15,
                                  fontFamily: 'Urbanist',
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
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: GestureDetector(
          onTap: () {
            if (kuriName.text != '' &&
                amount.text != '' &&
                selectedDate != null &&
                phone.text != '' &&
                upiApps.length != 0 &&
                accountNumber.text != '' &&
                confirmAccountNumber.text == accountNumber.text) {
              final kuri = KuriModel(
                  accountNumber: accountNumber.text,
                  amount: double.tryParse(amount.text),
                  bankName: bankName.text,
                  deadLine: selectedDate,
                  holderName: accountHolderName.text,
                  iFSC: ifsc.text,
                  kuriName: kuriName.text,
                  phone: phone.text,
                  private: private,
                  purpose: purpose,
                  upiApps: upiApps,
                  members: [],
                  payments: [],
                  totalReceived: 0,
                  userID: currentuserid);

              FirebaseFirestore.instance
                  .collection('kuri')
                  .add(kuri.toJson())
                  .then((value) {
                print('========Current User=========');
                print(currentuserid);
                value.update({'kuriId': value.id});
              }).then((value) {
                showSnackbar(context, 'Kuri successfully added');
                setState(() {
                  Navigator.pop(context);
                });
              });
            } else {
              kuriName.text == ''
                  ? showSnackbar(context, 'Please Enter Kuri Name')
                  : amount.text == ''
                      ? showSnackbar(context, 'Please Enter amount')
                      : selectedDate == null
                          ? showSnackbar(context, 'Please Choose Date')
                          : phone.text == ''
                              ? showSnackbar(
                                  context, 'Please Enter Phone Number')
                              : upiApps.length == 0
                                  ? showSnackbar(context,
                                      'Please Choose Available UPI Apps')
                                  : accountNumber.text == ''
                                      ? showSnackbar(context,
                                          'Please Enter Account Number')
                                      : showSnackbar(context,
                                          ' Confirm Account Number is must be same as account number');
            }
          },
          child: Container(
              width: 285,
              height: 47,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17),
                color: primarycolor,
              ),
              child: Center(
                child: Text(
                  "Create Kuri",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: FontSize15,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Widget PayItem(
      String image, String payname, bool isSelected, int index, String type) {
    return GestureDetector(
      onTap: () {
        setState(() {
          multiselect[index].isSelected = !multiselect[index].isSelected;
          if (multiselect[index].isSelected == true) {
            selectedPayments.add(MultiSelect(
                image: image, payname: payname, isSelected: true, type: type));
            upiApps.add(multiselect[index].payname);
          } else if (multiselect[index].isSelected == false) {
            selectedPayments.removeWhere(
                (element) => element.image == multiselect[index].image);
            upiApps.removeWhere(
                (element) => element == multiselect[index].payname);
          }

          print('==============================');
          print(upiApps);
        });
      },
      child: Row(
        children: [
          SizedBox(
            width: 3,
          ),
          Column(
            children: [
              Container(
                width: scrWidth * 0.17,
                height: scrHeight * 0.07,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade200,
                    border: isSelected == true
                        ? Border.all(color: primarycolor, width: 1.5)
                        : Border.all(color: Colors.transparent)),
                child: Padding(
                  padding: EdgeInsets.all(13.0),
                  child: type == 'svg'
                      ? SvgPicture.asset(image)
                      : Image(image: AssetImage(image)),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                payname,
                style: TextStyle(
                    color: Color(0xffB0B0B0),
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w500,
                    fontSize: 10),
              )
            ],
          ),
        ],
      ),
    );
  }
}

showSnackbar(BuildContext context, String content) {
  final snackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    content: Text(
      content,
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    backgroundColor: Colors.grey,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
