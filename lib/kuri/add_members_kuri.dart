import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:threems/kuri/add_member_search_kuri.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:threems/kuri/createkuri.dart';
import '../Authentication/root.dart';
import '../model/Kuri/kuriModel.dart';
import '../model/usermodel.dart';
import '../screens/home_screen.dart';
import '../screens/splash_screen.dart';
import '../utils/dummy.dart';
import '../utils/themes.dart';

Map<String, dynamic> useridByPhone = {};
Map<String, dynamic> userPhoneById = {};
Map<String, dynamic> userNameById = {};
Map<String, dynamic> userDataById = {};

class AddMembersKuri extends StatefulWidget {
  final KuriModel kuri;
  const AddMembersKuri({Key? key, required this.kuri}) : super(key: key);

  @override
  State<AddMembersKuri> createState() => _AddMembersKuriState();
}

class _AddMembersKuriState extends State<AddMembersKuri> {
  FocusNode userNameFocus = FocusNode();
  String? userSelected;
  TextEditingController userNameController = TextEditingController();

  bool loading = false;

  List<UserModel> savedContacts = [];
  List<UserModel> userList = [];
  List<String> userNumberList = [];

  addMembers() {
    addMember = [];

    print('hereeeeeeeeee');
    for (int j = 0; j < widget.kuri.members!.length; j++) {
      addMember.add(widget.kuri.members![j]);
    }

    for (int i = 0; i < addFriend.length; i++) {
      if (widget.kuri.members!.contains(useridByPhone[addFriend[i]])) {
      } else {
        addMember.add(useridByPhone[addFriend[i]]);
      }
    }
    // for (int i = 0; i < addMember.length; i++) {
    //   for (int j = 0; j < widget.kuri.members!.length; j++) {
    //     if (addMember[i].contains(widget.kuri.members![j].toString())) {
    //     } else {
    //       addMember.add(useridByPhone[addFriend[j]]);
    //     }
    //   }
    // }
    print(addMember.length);
    setState(() {
      addFriend = [];
    });
  }

  // getSavedContacts() {
  //   savedContacts = [];
  //   for (int i = 0; i < contacts.length; i++) {
  //     if (contacts[i].phones!.isNotEmpty) {
  //       for (int j = 0; j < userList.length; j++) {
  //         if (contacts[i].phones!.first.value == userList[j].phone) {
  //           savedContacts.add(userList[j]);
  //         }
  //       }
  //       // print(contacts[i].phones!.first.value);
  //       print(userList.length);
  //     }
  //   }
  //   print('================Saved Contact Length=================');
  //   print(savedContacts.length);
  //   setState(() {});
  // }

  getUsers() {
    FirebaseFirestore.instance.collection('users').snapshots().listen((event) {
      userList = [];
      savedContacts = [];
      for (var doc in event.docs) {
        userList.add(UserModel.fromJson(doc.data()));
        useridByPhone[doc['phone'].toString().trim().replaceAll(' ', '')] =
            doc.id;
        userPhoneById[doc.id] =
            doc['phone'].toString().trim().replaceAll(' ', '');
        userNameById[doc.id] = doc['userName'];
        userDataById[doc.id] = doc.data();
        userNumberList.add(doc['phone'].toString().trim().replaceAll(' ', ''));
      }
      if (mounted) {
        setState(() {
          // getSavedContacts();
        });
      }
    });
  }

  @override
  void initState() {
    getUsers();
    addMembers();
    userNameFocus.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    userNameFocus.dispose();
    userNameController.dispose();
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
                bottom: scrHeight * 0.015,
                right: scrWidth * 0.05),
            child: SvgPicture.asset(
              "assets/icons/arrow.svg",
            ),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: scrHeight * 0.02),
          child: Text(
            "Add Members",
            style: TextStyle(
                fontSize: scrWidth * 0.046,
                color: Colors.black,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w700),
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              addFriend = [];
              for (int i = 0; i < addMember.length; i++) {
                addFriend.add(userPhoneById[addMember[i]]);
              }
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => AddMembersearch(
              //               contacts: contacts,
              //               numberList: userNumberList,
              //               kuri: widget.kuri,
              //             )));
            },
            child: Padding(
              padding: EdgeInsets.only(
                  top: scrHeight * 0.04,
                  bottom: scrHeight * 0.03,
                  right: scrWidth * 0.025),
              child: Container(
                width: scrWidth * 0.13,
                height: scrHeight * 0.03,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        offset: Offset(0, 4),
                        blurRadius: 4,
                      ),
                    ],
                    color: primarycolor,
                    borderRadius: BorderRadius.circular(scrWidth * 0.04)),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: scrHeight * 0.007, bottom: scrHeight * 0.01),
                  child: SvgPicture.asset(
                    "assets/icons/connected.svg",

                    fit: BoxFit.contain,
                    // width: 19,
                    // height: 20,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: scrHeight * 0.04,
                bottom: scrHeight * 0.03,
                right: scrWidth * 0.025),
            child: Container(
              width: scrWidth * 0.13,
              height: scrHeight * 0.03,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      offset: Offset(0, 4),
                      blurRadius: 4,
                    ),
                  ],
                  color: primarycolor,
                  borderRadius: BorderRadius.circular(scrWidth * 0.04)),
              child: Padding(
                padding: EdgeInsets.only(
                    top: scrHeight * 0.007, bottom: scrHeight * 0.01),
                child: SvgPicture.asset(
                  "assets/icons/contacts.svg",
                  fit: BoxFit.contain,
                  // width: 19,
                  // height: 20,
                ),
              ),
            ),
          ),
        ],
      ),
      body: contacts.isEmpty || loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                height: scrHeight * 0.8,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: scrHeight * 0.02,
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(right: scrWidth * 0.7),
                    //   child: Text(
                    //     "Added",
                    //     style: TextStyle(
                    //         fontSize: FontSize16,
                    //         fontFamily: 'Urbanist',
                    //         fontWeight: FontWeight.w600,
                    //         color: Colors.black),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: scrWidth * 0.02,
                    // ),
                    // ListView.builder(
                    //   // // reverse: true,
                    //   // separatorBuilder: (context, index) => SizedBox(
                    //   //   height: scrWidth * 0.02,
                    //   // ),
                    //   physics: BouncingScrollPhysics(),
                    //   scrollDirection: Axis.vertical,
                    //   itemCount: addMember.length,
                    //   shrinkWrap: true,
                    //   itemBuilder: (context, index) => Padding(
                    //     padding: EdgeInsets.only(
                    //         top: scrWidth * 0.02,
                    //         left: scrWidth * 0.047,
                    //         right: scrWidth * 0.047),
                    //     child: Container(
                    //       width: scrWidth * 0.2,
                    //       height: textFormFieldHeight45,
                    //       padding: EdgeInsets.symmetric(
                    //         horizontal: scrWidth * 0.015,
                    //         vertical: scrHeight * 0.01,
                    //       ),
                    //       decoration: BoxDecoration(
                    //           border: Border.all(
                    //             color: Color(0xffDADADA),
                    //             width: scrWidth * 0.002,
                    //           ),
                    //           borderRadius:
                    //               BorderRadius.circular(scrWidth * 0.026)),
                    //       child: Center(
                    //           child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           // Container(
                    //           //   margin: EdgeInsets.only(left: scrWidth * 0.02),
                    //           //   child: CircleAvatar(
                    //           //     radius: 15,
                    //           //     backgroundColor: Colors.grey,
                    //           //     child: ClipRRect(
                    //           //       borderRadius:
                    //           //           BorderRadius.circular(scrWidth * 0.04),
                    //           //       child: CachedNetworkImage(
                    //           //         imageUrl:
                    //           //             'https://pbs.twimg.com/profile_images/1392793006877540352/ytVYaEBZ_400x400.jpg',
                    //           //       ),
                    //           //     ),
                    //           //   ),
                    //           // ),
                    //           Container(
                    //             margin: const EdgeInsets.only(left: 8),
                    //             child: CircleAvatar(
                    //               radius: 15,
                    //               backgroundColor: Colors.grey,
                    //               child: ClipRRect(
                    //                 borderRadius: BorderRadius.circular(15),
                    //                 child: Icon(
                    //                   Icons.person,
                    //                   color: Colors.white,
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //           Center(
                    //             child: Text(
                    //               userNameById[addMember[index]],
                    //               style: TextStyle(
                    //                   fontSize: FontSize16,
                    //                   fontFamily: 'Urbanist',
                    //                   fontWeight: FontWeight.w600,
                    //                   color: Colors.black),
                    //             ),
                    //           ),
                    //           GestureDetector(
                    //             onTap: (() {
                    //               addMember.removeAt(index);
                    //               setState(() {});
                    //             }),
                    //             child: Container(
                    //               margin:
                    //                   EdgeInsets.only(right: scrWidth * 0.03),
                    //               child: SvgPicture.asset(
                    //                 'assets/icons/delete.svg',
                    //                 fit: BoxFit.contain,
                    //                 color: Colors.black,
                    //               ),
                    //             ),
                    //           ),
                    //         ],
                    //       )),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: scrWidth * 0.04,
                    ),
                    Container(
                      width: scrWidth * 0.9,
                      height: textFormFieldHeight45,
                      padding: EdgeInsets.symmetric(
                        horizontal: scrWidth * 0.015,
                        vertical: scrWidth * 0.006,
                      ),
                      decoration: BoxDecoration(
                        color: textFormFieldFillColor,
                        borderRadius: BorderRadius.circular(scrWidth * 0.026),
                      ),
                      child: TypeAheadField(
                        minCharsForSuggestions: 1,
                        suggestionsCallback: (pattern) {
                          return User.getSuggestions(pattern);
                        },
                        textFieldConfiguration: TextFieldConfiguration(
                          controller: userNameController,
                          focusNode: userNameFocus,
                          decoration: InputDecoration(
                            prefixIcon: Container(
                              height: scrWidth * 0.045,
                              width: scrWidth * 0.02,
                              padding: EdgeInsets.all(scrWidth * 0.03),
                              child: SvgPicture.asset(
                                'assets/icons/chitname.svg',
                                fit: BoxFit.contain,
                                color: userNameFocus.hasFocus
                                    ? primarycolor
                                    : Color(0xffB0B0B0),
                              ),
                            ),
                            fillColor: textFormFieldFillColor,
                            filled: true,
                            labelText: 'User Name',
                            labelStyle: TextStyle(
                              color: userNameFocus.hasFocus
                                  ? primarycolor
                                  : Color(0xffB0B0B0),
                              fontWeight: FontWeight.w600,
                              fontSize: FontSize15,
                              fontFamily: 'Urbanist',
                            ),
                            contentPadding: EdgeInsets.only(
                                top: scrWidth * 0.02, bottom: scrWidth * 0.033),
                            disabledBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          style: TextStyle(
                              fontSize: FontSize16,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        noItemsFoundBuilder: (context) {
                          return SizedBox(
                            height: scrHeight * 0.03,
                            child: Center(
                              child: Text(
                                "No Users Found",
                                style: TextStyle(
                                    fontSize: FontSize16,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                            ),
                          );
                        },
                        suggestionsBoxDecoration: SuggestionsBoxDecoration(
                            // hasScrollbar: false,
                            elevation: 0,
                            color: Colors.transparent,
                            borderRadius:
                                BorderRadius.circular(scrWidth * 0.02)),
                        itemBuilder: (context, suggestion) {
                          return Padding(
                            padding: EdgeInsets.only(
                              left: scrWidth * 0.2,
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Color(0xff02B558),
                                    borderRadius:
                                        BorderRadius.circular(scrWidth * 0.03),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: scrWidth * 0.03),
                                        child: CircleAvatar(
                                          radius: 15,
                                          backgroundColor: Colors.grey,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                scrWidth * 0.05),
                                            child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://pbs.twimg.com/profile_images/1392793006877540352/ytVYaEBZ_400x400.jpg'),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          suggestion,
                                          style: TextStyle(
                                              fontSize: FontSize16,
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              right: scrWidth * 0.02),
                                          // padding: EdgeInsets.all(1),
                                          width: scrWidth * 0.15,
                                          height: scrHeight * 0.03,
                                          decoration: BoxDecoration(
                                            color: Color(0xffF3F3F3),
                                            borderRadius: BorderRadius.circular(
                                                scrWidth * 0.03),
                                          ),
                                          child: Center(
                                              child: Text(
                                            "+ Add",
                                            style: TextStyle(
                                                fontSize: FontSize13,
                                                fontFamily: 'Urbanist',
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                          )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: scrHeight * 0.01,
                                ),
                              ],
                            ),
                          );
                        },
                        onSuggestionSelected: (suggestion) {
                          setState(() {
                            userSelected = suggestion;
                            userNameController.clear();
                            print(userSelected);
                            addMember.add(userSelected!);
                            print(addMember);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: scrHeight * 0.01),
        child: Container(
          height: scrHeight * 0.09,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: scrWidth * 0.05),
                child: Text(
                  "Send the link via Whatsapp if the person is not install the app",
                  style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: scrWidth * 0.027,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff827E7E)),
                ),
              ),
              SizedBox(
                height: scrHeight * 0.009,
              ),
              Row(
                children: [
                  SizedBox(
                    width: scrWidth * 0.03,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        loading = true;
                      });

                      KuriModel local = widget.kuri;
                      if (local.kuriId == '' || local.kuriId == null) {
                        final kuri = KuriModel(
                            userID: currentuserid,
                            upiApps: local.upiApps,
                            purpose: local.purpose,
                            private: local.private,
                            phone: local.phone,
                            kuriName: local.kuriName,
                            iFSC: local.iFSC,
                            holderName: local.holderName,
                            deadLine: local.deadLine,
                            bankName: local.bankName,
                            amount: local.amount,
                            accountNumber: local.accountNumber,
                            members: addMember,
                            payments: [],
                            totalReceived: 0);
                      } else if (local.kuriId != '' || local.kuriId != null) {
                        final kuri = KuriModel(
                            userID: currentuserid,
                            upiApps: local.upiApps,
                            purpose: local.purpose,
                            private: local.private,
                            phone: local.phone,
                            kuriName: local.kuriName,
                            iFSC: local.iFSC,
                            holderName: local.holderName,
                            deadLine: local.deadLine,
                            bankName: local.bankName,
                            amount: local.amount,
                            accountNumber: local.accountNumber,
                            members: addMember,
                            payments: local.payments,
                            totalReceived: local.totalReceived,
                            kuriId: local.kuriId);

                        FirebaseFirestore.instance
                            .collection('kuri')
                            .doc(local.kuriId)
                            .set(kuri.toJson())
                            .then((value) {
                          showSnackbar(context, 'Kuri successfully Updated');
                          setState(() {
                            loading = false;
                            Navigator.pop(context);
                            Navigator.pop(context);
                          });
                        });
                      }
                    },
                    child: Container(
                      height: scrHeight * 0.058,
                      width: scrWidth * 0.67,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(scrWidth * 0.05),
                          color: primarycolor),
                      child: Center(
                        child: Text(
                          widget.kuri.kuriId == '' || widget.kuri.kuriId == null
                              ? "Create New Kuri"
                              : 'Update',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: scrWidth * 0.04,
                              fontFamily: 'Outfit',
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: scrWidth * 0.025,
                  ),
                  Container(
                    height: scrHeight * 0.058,
                    width: scrWidth * 0.24,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(17),
                        color: primarycolor),
                    child: Row(
                      children: [
                        SizedBox(
                          width: scrWidth * 0.025,
                        ),
                        SvgPicture.asset("assets/icons/share.svg"),
                        SizedBox(
                          width: scrWidth * 0.02,
                        ),
                        Text(
                          "Invite",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: scrWidth * 0.04,
                              fontFamily: 'Outfit',
                              color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
// void pay() {
//   showDialog(
//     context: context,
//     builder: (context) => StatefulBuilder(
//       builder: (BuildContext context, setState) {
//         payableAmountNode.addListener(() {
//           setState(() {});
//         });
//         return AlertDialog(
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//           title: Text('Pay the chit amount of September'),
//           titleTextStyle: TextStyle(
//               fontSize: FontSize10,
//               fontFamily: 'Urbanist',
//               fontWeight: FontWeight.w600,
//               color: Color(0xff827C7C)),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 width: scrWidth,
//                 height: textFormFieldHeight45,
//                 padding: EdgeInsets.symmetric(
//                   horizontal: scrWidth * 0.015,
//                   vertical: 2,
//                 ),
//                 decoration: BoxDecoration(
//                   color: textFormFieldFillColor,
//                   borderRadius: BorderRadius.circular(scrWidth * 0.026),
//                 ),
//                 child: TextFormField(
//                   keyboardType: TextInputType.number,
//                   inputFormatters: <TextInputFormatter>[
//                     CurrencyTextInputFormatter(
//                         locale: 'HI', decimalDigits: 0, symbol: '₹ '),
//                   ],
//                   focusNode: payableAmountNode,
//                   cursorHeight: scrWidth * 0.055,
//                   cursorWidth: 1,
//                   cursorColor: Colors.black,
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.w600,
//                     fontSize: FontSize15,
//                     fontFamily: 'Urbanist',
//                   ),
//                   decoration: InputDecoration(
//                     labelText: 'Payable Amount',
//                     labelStyle: TextStyle(
//                       color: payableAmountNode.hasFocus
//                           ? primarycolor
//                           : textFormUnFocusColor,
//                       fontWeight: FontWeight.w600,
//                       fontSize: FontSize15,
//                       fontFamily: 'Urbanist',
//                     ),
//                     fillColor: textFormFieldFillColor,
//                     filled: true,
//                     contentPadding: EdgeInsets.only(
//                         top: 5,
//                         bottom: scrWidth * 0.033,
//                         left: scrWidth * 0.033),
//                     disabledBorder: InputBorder.none,
//                     enabledBorder: InputBorder.none,
//                     errorBorder: InputBorder.none,
//                     border: InputBorder.none,
//                     focusedBorder: UnderlineInputBorder(
//                       borderSide: BorderSide(
//                         color: primarycolor,
//                         width: 2,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: scrWidth * 0.03,
//               ),
//               DottedBorder(
//                 padding: EdgeInsets.all(0),
//                 borderType: BorderType.RRect,
//                 radius: Radius.circular(8),
//                 color: Color(0xffDADADA),
//                 strokeWidth: 2,
//                 child: Container(
//                   height: 56,
//                   width: 256,
//                   decoration: BoxDecoration(
//                     color: Color(0xffF7F8F9),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SvgPicture.asset(
//                         "assets/icons/docCam.svg",
//                         height: scrWidth * 0.04,
//                         width: scrWidth * 0.05,
//                         color: Color(0xff8391A1),
//                         // height: 21,
//                         // width: 25,
//                       ),
//                       SizedBox(
//                         width: scrWidth * 0.02,
//                       ),
//                       Text(
//                         "Upload Screenshot",
//                         style: TextStyle(
//                           color: Color(0xffB0B0B0),
//                           fontSize: FontSize13,
//                           fontFamily: 'Urbanist',
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: scrWidth * 0.03,
//               ),
//               Container(
//                 width: scrWidth,
//                 height: textFormFieldHeight45,
//                 decoration: BoxDecoration(
//                     color: primarycolor,
//                     borderRadius: BorderRadius.circular(8)),
//                 child: Center(
//                   child: GestureDetector(
//                     onTap: () {},
//                     child: Text(
//                       "Confirm Pay",
//                       style: TextStyle(
//                           fontSize: FontSize16,
//                           fontFamily: 'Urbanist',
//                           fontWeight: FontWeight.w600,
//                           color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     ),
//   );
// }

// void joinChit() {
//   showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         titlePadding:
//             EdgeInsets.only(top: 29, bottom: 0, left: 20, right: 20),
//         contentPadding:
//             EdgeInsets.only(top: 5, bottom: 23, left: 20, right: 20),
//         title: Text(
//           "Are you sure want to join this Chit?",
//           style: TextStyle(
//             color: Color(0xff2C2C2C),
//             fontSize: FontSize15,
//             fontFamily: "Urbanist",
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//         content: Container(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Text(
//                 'You can join after the approvel of Admin',
//                 style: TextStyle(
//                   color: Color(0xff827C7C),
//                   fontSize: FontSize10,
//                   fontFamily: "Urbanist",
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               SizedBox(
//                 height: 17,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     width: 109,
//                     height: 44,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(34),
//                       color: Color(0xffDEDEDE),
//                       boxShadow: [
//                         //
//                         BoxShadow(
//                           blurRadius: 5,
//                           spreadRadius: -4,
//                           // offset: Offset(0, -4),
//                           color: Colors.black.withOpacity(0.15),
//                         ),
//                       ],
//                     ),
//                     child: Center(
//                       child: Text(
//                         "Cancel",
//                         style: TextStyle(
//                           color: Color(0xff2C2C2C),
//                           fontSize: FontSize16,
//                           fontFamily: "Urbanist",
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: 109,
//                     height: 44,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(34),
//                       color: primarycolor,
//                       boxShadow: [
//                         BoxShadow(
//                           blurRadius: 5,
//                           spreadRadius: -4,
//                           // offset: Offset(0, -4),
//                           color: Colors.black.withOpacity(0.15),
//                         ),
//                       ],
//                     ),
//                     child: Center(
//                       child: Text(
//                         "Confirm",
//                         style: TextStyle(
//                           color: Color(0xff2C2C2C),
//                           fontSize: FontSize16,
//                           fontFamily: "Urbanist",
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(34),
//         ),
//       );
//     },
//   );
// }

// void moveToVaccant() {
//   showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         contentPadding:
//             EdgeInsets.only(top: 29, bottom: 23, left: 21, right: 21),
//         content: Container(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Text(
//                 'Is this Chit is moving to Vacant Chit?',
//                 style: TextStyle(
//                   color: Color(0xff2C2C2C),
//                   fontSize: FontSize16,
//                   fontFamily: "Urbanist",
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//               SizedBox(
//                 height: 17,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     width: 109,
//                     height: 44,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(34),
//                       color: Color(0xffDEDEDE),
//                       boxShadow: [
//                         //
//                         BoxShadow(
//                           blurRadius: 5,
//                           spreadRadius: -4,
//                           // offset: Offset(0, -4),
//                           color: Colors.black.withOpacity(0.15),
//                         ),
//                       ],
//                     ),
//                     child: Center(
//                       child: Text(
//                         "Cancel",
//                         style: TextStyle(
//                           color: Color(0xff2C2C2C),
//                           fontSize: FontSize16,
//                           fontFamily: "Urbanist",
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: 109,
//                     height: 44,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(34),
//                       color: primarycolor,
//                       boxShadow: [
//                         BoxShadow(
//                           blurRadius: 5,
//                           spreadRadius: -4,
//                           // offset: Offset(0, -4),
//                           color: Colors.black.withOpacity(0.15),
//                         ),
//                       ],
//                     ),
//                     child: Center(
//                       child: Text(
//                         "Confirm",
//                         style: TextStyle(
//                           color: Color(0xff2C2C2C),
//                           fontSize: FontSize16,
//                           fontFamily: "Urbanist",
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(34),
//         ),
//       );
//     },
//   );
// }
// FocusNode dialogueAuctionAmountNode = FocusNode();
// FocusNode dialoguePayableAmountNode = FocusNode();
// FocusNode dialogueDividentNode = FocusNode();

// @override
// void dispose() {
//   dialogueAuctionAmountNode.dispose();
//   dialoguePayableAmountNode.dispose();
//   dialogueDividentNode.dispose();
//   super.dispose();
// }

// void payChitAmount() {
//   showDialog(
//     context: context,
//     builder: (context) => StatefulBuilder(
//       builder: (BuildContext context, setState) {
//         dialogueAuctionAmountNode.addListener(() {
//           setState(() {});
//         });
//         dialoguePayableAmountNode.addListener(() {
//           setState(() {});
//         });
//         dialogueDividentNode.addListener(() {
//           setState(() {});
//         });
//         return AlertDialog(
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//           title: Text('Pay the chit amount of September'),
//           titleTextStyle: TextStyle(
//               fontSize: FontSize10,
//               fontFamily: 'Urbanist',
//               fontWeight: FontWeight.w600,
//               color: Color(0xff827C7C)),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   CircleAvatar(
//                     backgroundColor: Colors.black,
//                     radius: 16,
//                   ),
//                   Container(
//                       margin: EdgeInsets.all(14),
//                       child: Text(
//                         "akhilgeorge",
//                         style: TextStyle(
//                             fontSize: FontSize16,
//                             fontFamily: 'Urbanist',
//                             fontWeight: FontWeight.w600,
//                             color: Colors.black),
//                       ))
//                 ],
//               ),
//               SizedBox(
//                 height: scrWidth * 0.05,
//               ),
//               Container(
//                 width: scrWidth,
//                 height: textFormFieldHeight45,
//                 padding: EdgeInsets.symmetric(
//                   horizontal: scrWidth * 0.015,
//                   vertical: 2,
//                 ),
//                 decoration: BoxDecoration(
//                   color: textFormFieldFillColor,
//                   borderRadius: BorderRadius.circular(scrWidth * 0.026),
//                 ),
//                 child: TextFormField(
//                   focusNode: dialogueAuctionAmountNode,
//                   cursorHeight: scrWidth * 0.055,
//                   cursorWidth: 1,
//                   cursorColor: Colors.black,
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.w600,
//                     fontSize: FontSize15,
//                     fontFamily: 'Urbanist',
//                   ),
//                   decoration: InputDecoration(
//                     labelText: 'Auction Amount',
//                     labelStyle: TextStyle(
//                       color: dialogueAuctionAmountNode.hasFocus
//                           ? primarycolor
//                           : textFormUnFocusColor,
//                       fontWeight: FontWeight.w600,
//                       fontSize: FontSize15,
//                       fontFamily: 'Urbanist',
//                     ),
//                     // prefixIcon: Container(
//                     //   height: scrWidth * 0.045,
//                     //   width: 10,
//                     //   padding: EdgeInsets.all(
//                     //       scrWidth * 0.033),
//                     //   child: SvgPicture.asset(
//                     //     'assets/icons/subscription.svg',
//                     //     fit: BoxFit.contain,
//                     //     color: textFormUnFocusColor,
//                     //   ),
//                     // ),
//                     fillColor: textFormFieldFillColor,
//                     filled: true,
//                     contentPadding: EdgeInsets.only(
//                         top: 5,
//                         bottom: scrWidth * 0.033,
//                         left: scrWidth * 0.033),
//                     disabledBorder: InputBorder.none,
//                     enabledBorder: InputBorder.none,
//                     errorBorder: InputBorder.none,
//                     border: InputBorder.none,
//                     focusedBorder: UnderlineInputBorder(
//                       borderSide: BorderSide(
//                         color: primarycolor,
//                         width: 2,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: scrWidth * 0.03,
//               ),
//               Container(
//                 width: scrWidth,
//                 height: textFormFieldHeight45,
//                 padding: EdgeInsets.symmetric(
//                   horizontal: scrWidth * 0.015,
//                   vertical: 2,
//                 ),
//                 decoration: BoxDecoration(
//                   color: textFormFieldFillColor,
//                   borderRadius: BorderRadius.circular(scrWidth * 0.026),
//                 ),
//                 child: TextFormField(
//                   focusNode: dialoguePayableAmountNode,
//                   cursorHeight: scrWidth * 0.055,
//                   cursorWidth: 1,
//                   cursorColor: Colors.black,
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.w600,
//                     fontSize: FontSize15,
//                     fontFamily: 'Urbanist',
//                   ),
//                   decoration: InputDecoration(
//                     labelText: 'Payable Amount',
//                     labelStyle: TextStyle(
//                       color: dialoguePayableAmountNode.hasFocus
//                           ? primarycolor
//                           : textFormUnFocusColor,
//                       fontWeight: FontWeight.w600,
//                       fontSize: FontSize15,
//                       fontFamily: 'Urbanist',
//                     ),
//                     // prefixIcon: Container(
//                     //   height: scrWidth * 0.045,
//                     //   width: 10,
//                     //   padding: EdgeInsets.all(
//                     //       scrWidth * 0.033),
//                     //   child: SvgPicture.asset(
//                     //     'assets/icons/subscription.svg',
//                     //     fit: BoxFit.contain,
//                     //     color: textFormUnFocusColor,
//                     //   ),
//                     // ),
//                     fillColor: textFormFieldFillColor,
//                     filled: true,
//                     contentPadding: EdgeInsets.only(
//                         top: 5,
//                         bottom: scrWidth * 0.033,
//                         left: scrWidth * 0.033),
//                     disabledBorder: InputBorder.none,
//                     enabledBorder: InputBorder.none,
//                     errorBorder: InputBorder.none,
//                     border: InputBorder.none,
//                     focusedBorder: UnderlineInputBorder(
//                       borderSide: BorderSide(
//                         color: primarycolor,
//                         width: 2,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: scrWidth * 0.03,
//               ),
//               Container(
//                 width: scrWidth,
//                 height: textFormFieldHeight45,
//                 padding: EdgeInsets.symmetric(
//                   horizontal: scrWidth * 0.015,
//                   vertical: 2,
//                 ),
//                 decoration: BoxDecoration(
//                   color: textFormFieldFillColor,
//                   borderRadius: BorderRadius.circular(scrWidth * 0.026),
//                 ),
//                 child: TextFormField(
//                   focusNode: dialogueDividentNode,
//                   cursorHeight: scrWidth * 0.055,
//                   cursorWidth: 1,
//                   cursorColor: Colors.black,
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.w600,
//                     fontSize: FontSize15,
//                     fontFamily: 'Urbanist',
//                   ),
//                   decoration: InputDecoration(
//                     labelText: 'Divident Amount',
//                     labelStyle: TextStyle(
//                       color: dialogueDividentNode.hasFocus
//                           ? primarycolor
//                           : textFormUnFocusColor,
//                       fontWeight: FontWeight.w600,
//                       fontSize: FontSize15,
//                       fontFamily: 'Urbanist',
//                     ),
//                     // prefixIcon: Container(
//                     //   height: scrWidth * 0.045,
//                     //   width: 10,
//                     //   padding: EdgeInsets.all(
//                     //       scrWidth * 0.033),
//                     //   child: SvgPicture.asset(
//                     //     'assets/icons/subscription.svg',
//                     //     fit: BoxFit.contain,
//                     //     color: textFormUnFocusColor,
//                     //   ),
//                     // ),
//                     fillColor: textFormFieldFillColor,
//                     filled: true,
//                     contentPadding: EdgeInsets.only(
//                         top: 5,
//                         bottom: scrWidth * 0.033,
//                         left: scrWidth * 0.033),
//                     disabledBorder: InputBorder.none,
//                     enabledBorder: InputBorder.none,
//                     errorBorder: InputBorder.none,
//                     border: InputBorder.none,
//                     focusedBorder: UnderlineInputBorder(
//                       borderSide: BorderSide(
//                         color: primarycolor,
//                         width: 2,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: scrWidth * 0.06,
//               ),
//               Container(
//                 width: scrWidth,
//                 height: textFormFieldHeight45,
//                 decoration: BoxDecoration(
//                     color: primarycolor,
//                     borderRadius: BorderRadius.circular(8)),
//                 child: Center(
//                   child: GestureDetector(
//                     onTap: () {},
//                     child: Text(
//                       "Save",
//                       style: TextStyle(
//                           fontSize: FontSize16,
//                           fontFamily: 'Urbanist',
//                           fontWeight: FontWeight.w600,
//                           color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     ),
//   );
// }
}
