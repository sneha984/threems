import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_select_item/multi_select_item.dart';
import 'package:threems/screens/splash_screen.dart';
import 'package:threems/utils/themes.dart';
import 'package:threems/utils/dummy.dart';

class Kuri extends StatefulWidget {
  const Kuri({Key? key}) : super(key: key);

  @override
  State<Kuri> createState() => _KuriState();
}

class _KuriState extends State<Kuri> {
  List multiSelectList = [];
  MultiSelectController controller = new MultiSelectController();
  @override
  void initState() {
    super.initState();

    multiSelectList.add({"images": 'assets/pay/googlepaysvg.svg', "desc":"Google Pay"});
    multiSelectList.add({"images":'assets/pay/whatsappapysvg.svg' ,"desc":"Whatsapp Pay"});
    multiSelectList.add({"images":'assets/pay/paytmpaysvg.svg' ,"desc":"Paytm"});
    multiSelectList.add({"images":'assets/pay/phonepesvg.svg', "desc":"Phonepe"});
    multiSelectList.add({"images":'assets/pay/amazonepaysvg.svg', "desc":"Amazon Pay"});
    controller.disableEditingWhenNoneSelected = true;
    controller.set(multiSelectList.length);
  }
  void add() {
    multiSelectList.add({"images": multiSelectList.length});
    multiSelectList.add({"desc": multiSelectList.length});

    setState(() {
      controller.set(multiSelectList.length);
    });
  }

  void delete() {
    var list = controller.selectedIndexes;
    list.sort((b, a) =>
        a.compareTo(b));
    list.forEach((element) {
      multiSelectList.removeAt(element);
    });

    setState(() {
      controller.set(multiSelectList.length);
    });
  }

  void selectAll() {
    setState(() {
      controller.toggleAll();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
          height:100,
          child: ListView.builder(
            itemCount: multiSelectList.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      MultiSelectItem(
                        isSelecting: controller.isSelecting,
                        onSelected: () {
                          setState(() {
                            controller.toggle(index);
                          });
                        },
                        child: Column(
                          children: [
                            Container(
                              width: scrWidth * 0.17,
                              height: scrHeight * 0.07,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:Colors.grey.shade200,
                                border:  controller.isSelected(index)?
                                Border.all(color: primarycolor,width: 1.5):
                                    Border.all(color: Colors.transparent)
                              ),
                              child: SvgPicture.asset(multiSelectList[index]['images']),


                            ),
                            SizedBox(height: 5,),
                            Text(multiSelectList[index]['desc'],
                              style: TextStyle(
                                  color: Color(0xffB0B0B0),
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10),)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );



  }
}
