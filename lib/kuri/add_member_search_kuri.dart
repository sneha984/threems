import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:threems/kuri/createkuri.dart';

import '../model/Kuri/kuriModel.dart';
import '../screens/home_screen.dart';
import '../screens/splash_screen.dart';
import '../utils/dummy.dart';
import '../utils/themes.dart';
import 'add_members_kuri.dart';

class AddMembersearch extends StatefulWidget {
  final List<Contact> contacts;
  final List numberList;
  final KuriModel kuri;
  const AddMembersearch({
    Key? key,
    required this.contacts,
    required this.numberList,
    required this.kuri,
  }) : super(key: key);

  @override
  State<AddMembersearch> createState() => _AddMembersearchState();
}

class _AddMembersearchState extends State<AddMembersearch> {
  List<Contact> totalContactsSearch = [];
  List<Contact> totalContacts = [];
  List numberList = [];
  TextEditingController search = TextEditingController();

  searchContacts(String txt) {
    print(totalContacts.length);
    print(totalContactsSearch.length);
    totalContactsSearch = [];
    for (int i = 0; i < totalContacts.length; i++) {
      if (totalContacts[i]
          .displayName!
          .toLowerCase()
          .contains(txt.toLowerCase())) {
        totalContactsSearch.add(totalContacts[i]);
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    totalContactsSearch = widget.contacts;
    totalContacts = widget.contacts;
    print(totalContacts.length);
    print(totalContactsSearch.length);
    numberList = widget.numberList;
    print(numberList.length);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(scrWidth * 0.34),
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.08),
                offset: Offset(0, 4),
                blurRadius: 25),
          ]),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsets.only(
                    top: scrHeight * 0.04,
                    left: scrWidth * 0.07,
                    right: scrWidth * 0.05),
                child: SvgPicture.asset(
                  "assets/icons/arrow.svg",
                ),
              ),
            ),
            title: Padding(
              padding: EdgeInsets.only(top: 30),
              child: Text(
                "Add Member Friend List",
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(100),
              child: Container(
                margin: EdgeInsets.only(
                    top: scrWidth * 0.015,
                    bottom: scrWidth * 0.06,
                    left: scrWidth * 0.059,
                    right: scrWidth * 0.059),
                child: Container(
                  // width: scrWidth,
                  // height: textFormFieldHeight45,
                  width: 324,
                  height: 35,
                  padding: EdgeInsets.symmetric(
                    horizontal: scrWidth * 0.03,
                    vertical: 2.5,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xffE9EEF3),
                    borderRadius: BorderRadius.circular(17),
                  ),
                  child: TextFormField(
                    // cursorHeight: scrWidth * 0.055,
                    // cursorWidth: 1,
                    // cursorColor: Colors.black,
                    controller: search,
                    showCursor: false,
                    onChanged: ((txt) {
                      print(search.text);
                      totalContactsSearch = [];
                      if (search.text == '') {
                        totalContactsSearch.addAll(totalContacts);
                      } else {
                        searchContacts(search.text);
                      }
                    }),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: FontSize15,
                      fontFamily: 'Urbanist',
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: scrWidth * 0.015,
                          vertical: scrWidth * 0.015,
                        ),
                        child: SvgPicture.asset('assets/icons/search.svg',
                            fit: BoxFit.contain, color: Color(0xff8391A1)),
                      ),
                      hintText: 'Search members',
                      hintStyle: TextStyle(
                        color: Color(0xff8391A1),
                        fontWeight: FontWeight.w500,
                        fontSize: FontSize15,
                        fontFamily: 'Urbanist',
                      ),
                      fillColor: Color(0xffE9EEF3),
                      filled: true,
                      contentPadding: EdgeInsets.only(
                          top: scrWidth * 0.03, bottom: scrWidth * 0.03),
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: scrWidth * 0.059, vertical: 5),
        child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(
            height: scrWidth * 0.02,
          ),
          physics: BouncingScrollPhysics(),
          itemCount: totalContactsSearch.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return totalContactsSearch[index].phones!.isEmpty
                ? SizedBox()
                : Container(
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
                        borderRadius: BorderRadius.circular(scrWidth * 0.026)),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.grey,
                            backgroundImage:
                                MemoryImage(totalContactsSearch[index].avatar!),
                          ),
                        ),
                        Center(
                          child: Text(
                            totalContactsSearch[index].displayName!,
                            style: TextStyle(
                                fontSize: FontSize16,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (numberList.contains(totalContactsSearch[index]
                                .phones!
                                .first
                                .value!
                                .trim()
                                .replaceAll(' ', ''))) {
                              if (addFriend.contains(totalContactsSearch[index]
                                  .phones!
                                  .first
                                  .value!
                                  .trim()
                                  .replaceAll(' ', ''))) {
                                setState(() {
                                  addFriend.remove(totalContactsSearch[index]
                                      .phones!
                                      .first
                                      .value!
                                      .trim()
                                      .replaceAll(' ', ''));
                                  print("hi: $addFriend");
                                });
                              } else {
                                setState(() {
                                  addFriend.add(totalContactsSearch[index]
                                      .phones!
                                      .first
                                      .value!
                                      .trim()
                                      .replaceAll(' ', ''));
                                  print("hi: $addFriend");
                                });
                              }
                            } else {
                              showSnackbar(context,
                                  'Invite ${totalContactsSearch[index].displayName}');
                            }
                          },
                          child: Container(
                            // width: 50,
                            height: 27,
                            margin: EdgeInsets.only(right: 8),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: addFriend.contains(
                                        totalContactsSearch[index]
                                            .phones!
                                            .first
                                            .value!
                                            .trim()
                                            .replaceAll(' ', ''))
                                    ? Color(0xff8391A1)
                                    : primarycolor,
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Text(
                                addFriend.contains(totalContactsSearch[index]
                                        .phones!
                                        .first
                                        .value!
                                        .trim()
                                        .replaceAll(' ', ''))
                                    ? "Added"
                                    : numberList.contains(
                                            totalContactsSearch[index]
                                                .phones!
                                                .first
                                                .value!
                                                .trim()
                                                .replaceAll(' ', ''))
                                        ? '+ Add'
                                        : 'Invite',
                                style: TextStyle(
                                    fontSize: FontSize14,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
                  );
            // StreamBuilder<QuerySnapshot>(
            //         stream: FirebaseFirestore.instance
            //             .collection('users')
            //             .where('phone',
            //                 isEqualTo: totalContacts[index]
            //                     .phones!
            //                     .first
            //                     .value!
            //                     .trim()
            //                     .replaceAll(' ', ''))
            //             .snapshots(),
            //         builder: (context, snapshot) {
            //           String value = '';
            //           if (snapshot.hasData) {
            //             value = '+ Add';
            //           } else {
            //             value = 'Invite';
            //           }
            //           return Container(
            //             width: 328,
            //             height: textFormFieldHeight45,
            //             padding: EdgeInsets.symmetric(
            //               horizontal: scrWidth * 0.015,
            //               vertical: 2,
            //             ),
            //             decoration: BoxDecoration(
            //                 border: Border.all(
            //                   color: Color(0xffDADADA),
            //                   width: 1,
            //                 ),
            //                 borderRadius:
            //                     BorderRadius.circular(scrWidth * 0.026)),
            //             child: Center(
            //                 child: Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 Container(
            //                   margin: const EdgeInsets.only(left: 8),
            //                   child: CircleAvatar(
            //                     radius: 15,
            //                     backgroundColor: Colors.grey,
            //                     child: ClipRRect(
            //                       borderRadius: BorderRadius.circular(15),
            //                       child: CachedNetworkImage(
            //                         imageUrl:
            //                             'https://pbs.twimg.com/profile_images/1392793006877540352/ytVYaEBZ_400x400.jpg',
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //                 Center(
            //                   child: Text(
            //                     totalContacts[index].displayName!,
            //                     style: TextStyle(
            //                         fontSize: FontSize16,
            //                         fontFamily: 'Urbanist',
            //                         fontWeight: FontWeight.w600,
            //                         color: Colors.black),
            //                   ),
            //                 ),
            //                 GestureDetector(
            //                   onTap: () {
            //                     if (addFriend.contains(
            //                         totalContacts[index].displayName)) {
            //                       setState(() {
            //                         addFriend.remove(
            //                             totalContacts[index].displayName);
            //                         print("hi: $addFriend");
            //                       });
            //                     } else {
            //                       setState(() {
            //                         addFriend
            //                             .add(totalContacts[index].displayName!);
            //                         print("hi: $addFriend");
            //                       });
            //                     }
            //                   },
            //                   child: Container(
            //                     // width: 50,
            //                     height: 27,
            //                     margin: EdgeInsets.only(right: 8),
            //                     padding: EdgeInsets.all(5),
            //                     decoration: BoxDecoration(
            //                         color: addFriend.contains(
            //                                 totalContacts[index].displayName)
            //                             ? Color(0xff8391A1)
            //                             : primarycolor,
            //                         borderRadius: BorderRadius.circular(8)),
            //                     child: Center(
            //                       child: Text(
            //                         addFriend.contains(
            //                                 totalContacts[index].displayName)
            //                             ? "Added"
            //                             : value,
            //                         style: TextStyle(
            //                             fontSize: FontSize14,
            //                             fontFamily: 'Urbanist',
            //                             fontWeight: FontWeight.w700,
            //                             color: Colors.white),
            //                       ),
            //                     ),
            //                   ),
            //                 )
            //               ],
            //             )),
            //           );
            //         });
          },
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          addMember = [];
          for (int i = 0; i < addFriend.length; i++) {
            addMember.add(useridByPhone[addFriend[i]]);
          }
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => AddMembersKuri(
                        kuri: widget.kuri,
                      )));
          setState(() {});
        },
        child: Container(
          width: 100,
          height: 50,
          decoration: BoxDecoration(
              color: primarycolor, borderRadius: BorderRadius.circular(17)),
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
          child: Center(
              child: Text(
            "Add Members",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                fontFamily: 'Outfit',
                color: Colors.white),
          )),
        ),
      ),
    );
  }
}
