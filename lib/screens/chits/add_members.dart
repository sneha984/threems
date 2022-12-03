import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:threems/screens/chits/add_members_search.dart';

import '../../Authentication/root.dart';
import '../../kuri/add_members_kuri.dart';
import '../../kuri/createkuri.dart';
import '../../layouts/screen_layout.dart';
import '../../model/ChitModel.dart';
import '../../model/usermodel.dart';
import '../../utils/dummy.dart';
import '../../utils/themes.dart';
import '../home_screen.dart';
import '../splash_screen.dart';

class AddMembers extends StatefulWidget {
  final ChitModel chit;
  final String size;
  final String ext;
  final String fileName;
  final dynamic bytes;
  const AddMembers(
      {super.key,
      required this.chit,
      required this.size,
      required this.ext,
      this.bytes,
      required this.fileName});

  @override
  State<AddMembers> createState() => _AddMembersState();
}

class _AddMembersState extends State<AddMembers> {
  FocusNode userNameFocus = FocusNode();
  String? userSelected;
  TextEditingController userNameController = TextEditingController();

  bool loading = false;
  List<UserModel> userList = [];
  List<String> userNumberList = [];

  addMembers() {
    addMember = [];

    print('hereeeeeeeeee');
    for (int j = 0; j < widget.chit.members!.length; j++) {
      addMember.add(widget.chit.members![j]);
    }

    for (int i = 0; i < addFriend.length; i++) {
      if (widget.chit.members!.contains(useridByPhone[addFriend[i]])) {
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

  getUsers() {
    FirebaseFirestore.instance.collection('users').snapshots().listen((event) {
      userList = [];
      // savedContacts = [];
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
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: Offset(0, 4),
                blurRadius: 25),
          ]),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                // color: Colors.red,
                width: 13,
                height: 12,
                padding: EdgeInsets.all(scrWidth * 0.056),
                child: SvgPicture.asset(
                  'assets/icons/back.svg',
                  width: 13,
                  height: 11,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            title: Text(
              "Add Members",
              style: TextStyle(
                  fontSize: FontSize17,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  addFriend = [];
                  for (int i = 0; i < addMember.length; i++) {
                    addFriend.add(userPhoneById[addMember[i]]);
                  }
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => AddMembersSearch(
                  //               contacts: contacts,
                  //               numberList: userNumberList,
                  //               chit: widget.chit,
                  //               size: widget.size,
                  //               ext: widget.ext,
                  //               bytes: widget.bytes,
                  //               fileName: widget.fileName,
                  //             )));
                },
                child: Container(
                  width: 47,
                  height: 29,
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          offset: Offset(0, 4),
                          blurRadius: 4,
                        ),
                      ],
                      color: primarycolor,
                      borderRadius: BorderRadius.circular(16)),
                  child: SvgPicture.asset(
                    "assets/icons/connected.svg",
                    width: scrWidth * 0.059,
                    height: scrWidth * 0.055,
                    fit: BoxFit.contain,
                    // width: 19,
                    // height: 20,
                  ),
                ),
              ),
              SizedBox(
                width: scrWidth * 0.03,
                // width: 16,
              ),
              Container(
                width: 47,
                height: 29,
                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                padding: EdgeInsets.all(7),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        offset: Offset(0, 4),
                        blurRadius: 4,
                      ),
                    ],
                    color: primarycolor,
                    borderRadius: BorderRadius.circular(16)),
                child: SvgPicture.asset(
                  "assets/icons/contacts.svg",
                  width: scrWidth * 0.059,
                  height: scrWidth * 0.055,
                  fit: BoxFit.contain,
                  // width: 19,
                  // height: 20,
                ),
              ),
              SizedBox(
                width: scrWidth * 0.059,
                // width: 21,
              ),
            ],
          ),
        ),
      ),
      body: contacts.isEmpty || loading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: scrWidth * 0.059, vertical: scrWidth * 0.05),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: scrHeight * 0.74,
                      // color: Colors.yellow,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Added",
                                style: TextStyle(
                                    fontSize: FontSize16,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              Container(
                                // margin: EdgeInsets.symmetric(vertical: 15),
                                width: 60,
                                height: 20,
                                // color: Colors.red,
                                child: Center(
                                  child: RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: addMember.length.toString(),
                                          style: TextStyle(
                                              fontSize: FontSize16,
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.w600,
                                              color: primarycolor),
                                        ),
                                        TextSpan(
                                          text: '/',
                                          style: TextStyle(
                                              fontSize: FontSize16,
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                        ),
                                        TextSpan(
                                          text: widget.chit.membersCount!
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: FontSize16,
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: scrWidth * 0.04,
                          ),
                          ListView.builder(
                            // // reverse: true,
                            // separatorBuilder: (context, index) => SizedBox(
                            //   height: scrWidth * 0.02,
                            // ),
                            physics: BouncingScrollPhysics(),
                            itemCount: addMember.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => Padding(
                              padding: EdgeInsets.only(top: scrWidth * 0.02),
                              child: Container(
                                width: 328,
                                height: textFormFieldHeight45,
                                padding: EdgeInsets.symmetric(
                                  horizontal: scrWidth * 0.015,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color(0xffDADADA),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        scrWidth * 0.026)),
                                child: Center(
                                    child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(left: 8),
                                      child: CircleAvatar(
                                        radius: 15,
                                        backgroundColor: Colors.grey,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Icon(
                                            Icons.person,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        userNameById[addMember[index]],
                                        style: TextStyle(
                                            fontSize: FontSize16,
                                            fontFamily: 'Urbanist',
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: (() {
                                        addMember.removeAt(index);
                                        setState(() {});
                                      }),
                                      child: Container(
                                        margin: EdgeInsets.only(right: 10),
                                        child: SvgPicture.asset(
                                          'assets/icons/delete.svg',
                                          fit: BoxFit.contain,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: scrWidth * 0.04,
                          ),
                          Container(
                            width: 328,
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
                            child: TypeAheadField(
                              minCharsForSuggestions: 1,
                              suggestionsCallback: (pattern) {
                                return Users.getSuggestions(pattern);
                              },
                              textFieldConfiguration: TextFieldConfiguration(
                                controller: userNameController,
                                focusNode: userNameFocus,
                                decoration: InputDecoration(
                                  prefixIcon: Container(
                                    height: scrWidth * 0.045,
                                    width: 10,
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
                                      top: scrWidth * 0.02,
                                      bottom: scrWidth * 0.033),
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
                                  height: 50,
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
                              suggestionsBoxDecoration:
                                  SuggestionsBoxDecoration(
                                      // hasScrollbar: false,
                                      elevation: 0,
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(8)),
                              itemBuilder: (context, suggestion) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    left: 80,
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: Color(0xff02B558),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 8),
                                              child: CircleAvatar(
                                                radius: 15,
                                                backgroundColor: Colors.grey,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
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
                                                margin:
                                                    EdgeInsets.only(right: 8),
                                                // padding: EdgeInsets.all(1),
                                                width: 50,
                                                height: 32,
                                                decoration: BoxDecoration(
                                                  color: Color(0xffF3F3F3),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Center(
                                                    child: Text(
                                                  "+ Add",
                                                  style: TextStyle(
                                                      fontSize: FontSize13,
                                                      fontFamily: 'Urbanist',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black),
                                                )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
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
                    Text(
                      "Will create after the completion of 10 members. Otherwise the chit is saved as draft.",
                      style: TextStyle(
                          fontSize: FontSize10,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          loading = true;
                        });

                        ChitModel local = widget.chit;
                        if (local.chitId == '' || local.chitId == null) {
                          final chit = ChitModel(
                            createdDate: DateTime.now(),
                            userId: currentuserid,
                            chitDate: local.chitDate,
                            private: local.private,
                            payableAmount: local.subscriptionAmount,
                            chitName: local.chitName,
                            amount: local.amount,
                            chitTime: local.chitTime,
                            members: addMember,
                            chitType: local.chitType,
                            commission: local.commission,
                            dividendAmount: local.dividendAmount,
                            document: local.document,
                            drawn: local.drawn,
                            duration: local.duration,
                            membersCount: local.membersCount,
                            profile: local.profile,
                            status: local.status,
                            subscriptionAmount: local.subscriptionAmount,
                            winners: [],
                            accountNumber: local.accountNumber,
                            bankName: local.bankName,
                            phone: local.phone,
                            upiApps: local.upiApps,
                            accountHolderName: local.accountHolderName,
                            ifsc: local.ifsc,
                            fileName: widget.fileName,
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
                                  MaterialPageRoute(
                                      builder: (context) => ScreenLayout()),
                                  (route) => false);
                            });
                          });
                        } else if (local.chitId != '' || local.chitId != null) {
                          final chit = ChitModel(
                              createdDate: DateTime.now(),
                              userId: currentuserid,
                              chitDate: local.chitDate,
                              private: local.private,
                              chitName: local.chitName,
                              amount: local.amount,
                              chitTime: local.chitTime,
                              members: addMember,
                              chitType: local.chitType,
                              commission: local.commission,
                              dividendAmount: local.dividendAmount,
                              document: local.document,
                              drawn: local.drawn,
                              duration: local.duration,
                              membersCount: local.membersCount,
                              profile: local.profile,
                              status: local.status,
                              subscriptionAmount: local.subscriptionAmount,
                              winners: [],
                              chitId: local.chitId,
                              accountNumber: local.accountNumber,
                              bankName: local.bankName,
                              phone: local.phone,
                              upiApps: local.upiApps,
                              payableAmount: local.subscriptionAmount,
                              accountHolderName: local.accountHolderName,
                              ifsc: local.ifsc);

                          FirebaseFirestore.instance
                              .collection('chit')
                              .doc(local.chitId)
                              .set(chit.toJson())
                              .then((value) {
                            showSnackbar(context, 'Kuri successfully Updated');
                            setState(() {
                              loading = false;
                              Navigator.pop(context);
                            });
                          });
                        }
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: primarycolor,
                            borderRadius: BorderRadius.circular(17)),
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                        child: Center(
                            child: Text(
                          widget.chit.chitId == '' || widget.chit.chitId == null
                              ? "Create New Chit"
                              : 'Update',
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

// TextFormField(
//                 focusNode: userNameFocus,
//                 cursorHeight: scrWidth * 0.055,
//                 cursorWidth: 1,
//                 cursorColor: Colors.black,
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.w600,
//                   fontSize: FontSize15,
//                   fontFamily: 'Urbanist',
//                 ),
//                 decoration: InputDecoration(
//                   labelText: 'User Name',
//                   labelStyle: TextStyle(
//                     color: userNameFocus.hasFocus
//                         ? primarycolor
//                         : Color(0xffB0B0B0),
//                     fontWeight: FontWeight.w600,
//                     fontSize: FontSize15,
//                     fontFamily: 'Urbanist',
//                   ),
//                   prefixIcon: Container(
//                     height: scrWidth * 0.045,
//                     width: 10,
//                     padding: EdgeInsets.all(scrWidth * 0.033),
//                     child: SvgPicture.asset(
//                       'assets/icons/chitname.svg',
//                       fit: BoxFit.contain,
//                       color: userNameFocus.hasFocus
//                           ? primarycolor
//                           : Color(0xffB0B0B0),
//                     ),
//                   ),
//                   fillColor: textFormFieldFillColor,
//                   filled: true,
//                   contentPadding: EdgeInsets.only(
//                       top: scrWidth * 0.02, bottom: scrWidth * 0.033),
//                   disabledBorder: InputBorder.none,
//                   enabledBorder: InputBorder.none,
//                   errorBorder: InputBorder.none,
//                   border: InputBorder.none,
//                   focusedBorder: InputBorder.none,
//                 ),
//               ),
