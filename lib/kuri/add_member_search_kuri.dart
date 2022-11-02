import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../screens/splash_screen.dart';
import '../utils/dummy.dart';
import '../utils/themes.dart';

class AddMembersearch extends StatefulWidget {
  const AddMembersearch({Key? key}) : super(key: key);

  @override
  State<AddMembersearch> createState() => _AddMembersearchState();
}

class _AddMembersearchState extends State<AddMembersearch> {
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
              onTap: (){
                Navigator.pop(context);
              },
              child:  Padding(
                padding: EdgeInsets.only(top: scrHeight*0.04,
                    left: scrWidth*0.07,right: scrWidth*0.05),
                child:SvgPicture.asset("assets/icons/arrow.svg",),
              ),
            ),
            title: Padding(
              padding:  EdgeInsets.only(top: 30),
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
          itemCount: User.userss.length,
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
                        User.userss[index],
                        style: TextStyle(
                            fontSize: FontSize16,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (addFriend.contains(User.userss[index])) {
                          setState(() {
                            addFriend.remove(User.userss[index]);
                            print("hi: $addFriend");
                          });
                        } else {
                          setState(() {
                            addFriend.add(User.userss[index]);
                            print("hi: $addFriend");
                          });
                        }
                      },
                      child: Container(
                        // width: 50,
                        height: 27,
                        margin: EdgeInsets.only(right: 8),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: addFriend.contains(User.userss[index])
                                ? Color(0xff8391A1)
                                : primarycolor,
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Text(
                            addFriend.contains(User.userss[index])
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
              "Add Members",
              style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,fontFamily: 'Outfit',color: Colors.white),
            )),
      ),
    );
  }
}
