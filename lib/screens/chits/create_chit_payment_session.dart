import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:threems/Authentication/root.dart';

import '../../customPackage/date_picker.dart';
import '../../kuri/createkuri.dart';
import '../../layouts/screen_layout.dart';
import '../../model/ChitModel.dart';
import '../../utils/themes.dart';
import '../../widgets/list.dart';
import '../splash_screen.dart';
import 'add_members.dart';

class PaymentDetails extends StatefulWidget {
  final ChitModel chit;
  final String size;
  final String ext;
  final String fileName;
  final dynamic bytes;
  const PaymentDetails(
      {Key? key,
      required this.chit,
      required this.size,
      required this.ext,
      this.bytes,
      required this.fileName})
      : super(key: key);

  @override
  State<PaymentDetails> createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  bool loading = false;

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
  TextEditingController phone = TextEditingController();
  List<String> upiApps = [];

  TextEditingController accountNumber = TextEditingController();
  TextEditingController confirmAccountNumber = TextEditingController();
  TextEditingController accountHolderName = TextEditingController();
  TextEditingController bankName = TextEditingController();
  TextEditingController ifsc = TextEditingController();

  getDatas() {
    phone.text = widget.chit.phone ?? '';
    upiApps =
        widget.chit.upiApps == null ? [] : widget.chit.upiApps as List<String>;
    accountNumber.text = widget.chit.accountNumber ?? '';
    confirmAccountNumber.text = widget.chit.accountNumber ?? '';
    accountHolderName.text = widget.chit.accountHolderName ?? '';
    bankName.text = widget.chit.bankName ?? '';
    ifsc.text = widget.chit.ifsc ?? '';
    print(upiApps);
    print(phone.text);

    for (int i = 0; i < multiselect.length; i++) {
      if (upiApps.contains(multiselect[i].payname)) {
        selectedPayments.add(MultiSelect(
            image: multiselect[i].image,
            payname: multiselect[i].payname,
            type: multiselect[i].type,
            isSelected: true));
        multiselect[i].isSelected = true;
        // upiApps.add(multiselect[index].payname);

      }
    }

    print(selectedPayments);
    setState(() {});
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
    getDatas();
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
    return Scaffold(
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
            "Add Payment Details",
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
            top: scrHeight * 0.01),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              //PAYMENT
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
                  borderRadius: BorderRadius.circular(scrWidth * 0.026),
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
                    contentPadding:
                        EdgeInsets.only(top: 5, bottom: scrWidth * 0.033),
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
                      itemBuilder: (BuildContext context, int index) {
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
                  borderRadius: BorderRadius.circular(scrWidth * 0.026),
                ),
                child: TextFormField(
                  focusNode: accountnumberfocus,
                  controller: accountNumber,
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
                    contentPadding:
                        EdgeInsets.only(top: 5, bottom: scrWidth * 0.033),
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
                  borderRadius: BorderRadius.circular(scrWidth * 0.026),
                ),
                child: TextFormField(
                  focusNode: confirmaccountnumberfocus,
                  controller: confirmAccountNumber,
                  cursorHeight: scrWidth * 0.055,
                  keyboardType: TextInputType.number,
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
                    contentPadding:
                        EdgeInsets.only(top: 5, bottom: scrWidth * 0.033),
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
                  borderRadius: BorderRadius.circular(scrWidth * 0.026),
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
                    contentPadding:
                        EdgeInsets.only(top: 5, bottom: scrWidth * 0.033),
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
                  borderRadius: BorderRadius.circular(scrWidth * 0.026),
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
                    contentPadding:
                        EdgeInsets.only(top: 5, bottom: scrWidth * 0.033),
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
                  borderRadius: BorderRadius.circular(scrWidth * 0.026),
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
                    contentPadding:
                        EdgeInsets.only(top: 5, bottom: scrWidth * 0.033),
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
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          ChitModel local = widget.chit;
          if (phone.text != '' &&
              upiApps.isNotEmpty &&
              accountNumber.text == confirmAccountNumber.text) {
            if (widget.chit.chitId != '') {
              final chit = ChitModel(
                  winners: local.winners,
                  membersCount: local.membersCount,
                  status: local.status,
                  subscriptionAmount: local.subscriptionAmount,
                  profile: local.profile,
                  duration: local.duration,
                  drawn: local.drawn,
                  document: local.document,
                  dividendAmount: local.dividendAmount,
                  createdDate: DateTime.now(),
                  commission: local.commission,
                  chitType: local.chitType,
                  chitTime: local.chitTime,
                  chitName: local.chitName,
                  fileName: local.fileName,
                  chitDate: local.chitDate,
                  private: local.private,
                  amount: local.amount,
                  members: local.members,
                  accountNumber: accountNumber.text,
                  bankName: bankName.text,
                  phone: phone.text,
                  upiApps: upiApps,
                  accountHolderName: accountHolderName.text,
                  userId: currentuserid,
                  ifsc: ifsc.text,
                  payableAmount: local.payableAmount,
                  chitId: local.chitId ?? '');

              FirebaseFirestore.instance
                  .collection('chit')
                  .doc(local.chitId)
                  .update(chit.toJson())
                  .then((value) {
                showSnackbar(context, 'Chit Update Successfully');
                Navigator.pop(context);
              });
            } else {
              final chit = ChitModel(
                winners: [],
                membersCount: local.membersCount,
                status: local.status,
                subscriptionAmount: local.subscriptionAmount,
                profile: local.profile,
                duration: local.duration,
                drawn: local.drawn,
                document: local.document,
                dividendAmount: local.dividendAmount,
                createdDate: DateTime.now(),
                commission: local.commission,
                chitType: local.chitType,
                chitTime: local.chitTime,
                chitName: local.chitName,
                chitDate: local.chitDate,
                private: local.private,
                amount: local.amount,
                members: [],
                accountNumber: accountNumber.text,
                bankName: bankName.text,
                phone: phone.text,
                upiApps: upiApps,
                accountHolderName: accountHolderName.text,
                userId: currentuserid,
                payableAmount: local.subscriptionAmount,
                chitId: local.chitId,
                fileName: widget.fileName,
                ifsc: ifsc.text,
              );

              FirebaseFirestore.instance
                  .collection('chit')
                  .add(chit.toJson())
                  .then((value) {
                value.update({'chitId': value.id});
                value.collection('chats').add({
                  "file": local.document!,
                  "fileName": 'PROOF',
                  "senderId": currentuserid,
                  "sendTime": DateTime.now(),
                  "readBy": [],
                  "type": "file",
                  "ext": widget.ext,
                  "size": widget.size,
                });
              }).then((value) {
                showSnackbar(context, 'Chit successfully added');
                setState(() {
                  loading = false;
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => ScreenLayout()),
                      (route) => false);
                });
              });
            }
          } else {
            phone.text == ''
                ? showSnackbar(context, 'Please Enter Phone Number')
                : upiApps.isEmpty
                    ? showSnackbar(context, 'Please Choose Available UPI Apps')
                    : showSnackbar(context,
                        'Confirm account number must be same as account number.');
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
                "Create Chit",
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
    );
  }

  Widget PayItem(
      String image, String payname, bool isSelected, int index, String type) {
    return InkWell(
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
                child: type == 'svg'
                    ? SvgPicture.asset(image)
                    : Image(image: AssetImage(image)),
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
