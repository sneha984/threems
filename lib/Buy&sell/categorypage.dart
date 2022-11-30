import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getwidget/components/dropdown/gf_multiselect.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';
import 'package:threems/Buy&sell/storedetailsfill2.dart';

import '../screens/splash_screen.dart';
import '../utils/themes.dart';

class CategoryPage extends StatefulWidget {
   final String storeId;
   CategoryPage({Key? key, required this.storeId}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  String? selectedcategory;
  List getcategory=[];
  List dropdownCategory=[];
  List dropdownSelectedCategory=[];
  getCategory(){
    FirebaseFirestore.instance.collection('stores').doc(widget.storeId).snapshots().listen((event) {
      getcategory=event.get('storeCategory');
      if(mounted){
        setState(() {

        });
      }
    });
  }
  categoryDropdown(){
    FirebaseFirestore.instance.collection('storeCategory').snapshots().listen((event) {
dropdownCategory=[];
      for(DocumentSnapshot <Map<String,dynamic>> doc in event.docs){
        print('${doc['categoryName']}');
        print('${event.docs[1]['categoryName']}');
        // categoryListAll.add(doc.data()!);
        dropdownCategory.add(doc['categoryName']);
      }
      if(mounted){
        setState(() {

        });
      }
    });

  }

  @override
  void initState() {
    getCategory();
    categoryDropdown();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
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
            "Category",
            style: TextStyle(
                fontSize: scrWidth * 0.047,
                color: Colors.black,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w700),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(
                right: scrWidth * 0.04,
                top: scrHeight * 0.045,
                bottom: scrHeight * 0.025),
            child: InkWell(
              onTap: () {
                // Navigator.push(context,
                //    MaterialPageRoute(builder: (context) => ));
              },
              child: Container(
                height: scrHeight * 0.07,
                width: scrWidth * 0.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(scrWidth * 0.04),
                  color: primarycolor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.add,
                      size: 12,
                      color: Colors.white,
                    ),
                    Text(
                      "Category",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: CreateChitFont,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              child: GridView.builder(
                  itemCount:getcategory.length,
                  itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 30,
                    width: 50,
                    decoration: BoxDecoration(
                        color:Colors.green,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Container(
                      height: 20,
                        width: 20,

                        child: Center(child: Text(getcategory[index]))),
                  ),
                );
                  },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 10,
                    childAspectRatio: 3/1.5
                ),),
            ),
            Container(
              width: scrWidth*27,
              decoration: BoxDecoration(                color: textFormFieldFillColor,
                  borderRadius: BorderRadius.circular(scrWidth * 0.026)),
              child: GFMultiSelect(
                items: dropdownCategory,
                onSelect: (value) {
                  selectedcategory=value.toString();
                  dropdownSelectedCategory=[];
                  for(int i=0;i<value.length;i++){
                    dropdownSelectedCategory.add(dropdownCategory[value[i]].toString());
                  }
                  print('selected $value ');
                },

                dropdownTitleTileText: 'Store Category',
                // dropdownTitleTileHintText: 'Store Category',
                // dropdownTitleTileHintTextStyle: TextStyle(
                //  color: Color(0xffB0B0B0),
                //   fontWeight: FontWeight.w600,
                //   fontSize: FontSize15,
                //   fontFamily: 'Urbanist',
                //
                // ),
                dropdownTitleTileColor: textFormFieldFillColor,
                dropdownTitleTilePadding: EdgeInsets.only(left: 9),
                dropdownTitleTileMargin: EdgeInsets.only(
                    top: 22, left: 18, right: 18, bottom: 14),
                //  dropdownTitleTilePadding: EdgeInsets.all(10),
                dropdownUnderlineBorder: const BorderSide(
                    color: Colors.transparent, width: 2),
                // dropdownTitleTileBorder:
                // Border.all(color:Colors.red, width: 1),
                dropdownTitleTileBorderRadius: BorderRadius.circular(10),
                expandedIcon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black,
                ),
                collapsedIcon: const Icon(
                  Icons.arrow_drop_up,
                  color: Colors.black,
                ),
                submitButton: InkWell(
                  onTap: (){
                    FirebaseFirestore.instance.collection('stores').doc(widget.storeId).update({
                      'storeCategory':FieldValue.arrayUnion(dropdownSelectedCategory),
                    });
                  },
                    child: Container(child: Text('OK'))),

                dropdownTitleTileTextStyle:  TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    fontFamily: 'Urbanist'),
                padding: const EdgeInsets.all(6),
                margin: const EdgeInsets.all(6),
                type: GFCheckboxType.square,
                activeBgColor: Colors.green.withOpacity(0.5),
                inactiveBorderColor:primarycolor,
              ),
            ),

          ],
        ),
      ),

    );
  }
}
