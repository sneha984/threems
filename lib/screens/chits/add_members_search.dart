import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:threems/utils/dummy.dart';

import '../../utils/themes.dart';
import '../splash_screen.dart';

class AddMembersSearch extends StatefulWidget {
  const AddMembersSearch({super.key});

  @override
  State<AddMembersSearch> createState() => _AddMembersSearchState();
}

class _AddMembersSearchState extends State<AddMembersSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(scrWidth * 0.31),
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
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                // color: Colors.red,
                width: 13,
                height: 12,
                padding: EdgeInsets.all(scrWidth * 0.05),
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
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                width: 60,
                height: 20,
                // color: Colors.red,
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: '1',
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
                          text: '10',
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
              SizedBox(
                width: scrWidth * 0.059,
                // width: 21,
              ),
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(50),
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
                    showCursor: false,
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
          itemCount: Users.users.length,
          shrinkWrap: true,
          itemBuilder: (context, index) => Container(
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://pbs.twimg.com/profile_images/1392793006877540352/ytVYaEBZ_400x400.jpg',
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    Users.users[index],
                    style: TextStyle(
                        fontSize: FontSize16,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (addFriends.contains(Users.users[index])) {
                      setState(() {
                        addFriends.remove(Users.users[index]);
                        print("hi: $addFriends");
                      });
                    } else {
                      setState(() {
                        addFriends.add(Users.users[index]);
                        print("hi: $addFriends");
                      });
                    }
                  },
                  child: Container(
                    // width: 50,
                    height: 27,
                    margin: EdgeInsets.only(right: 8),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: addFriends.contains(Users.users[index])
                            ? Color(0xff8391A1)
                            : primarycolor,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(
                        addFriends.contains(Users.users[index])
                            ? "Added"
                            : "+ Add",
                        style: TextStyle(
                            fontSize: FontSize14,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            )),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: 100,
        height: 50,
        decoration: BoxDecoration(
            color: primarycolor, borderRadius: BorderRadius.circular(17)),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
        child: Center(
            child: Text(
          "Create New Chit",
          style: TextStyle(color: Colors.white),
        )),
      ),
    );
  }
}
