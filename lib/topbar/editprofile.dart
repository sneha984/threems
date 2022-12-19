import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Authentication/root.dart';
import '../model/usermodel.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController nameController=TextEditingController();
  final TextEditingController emailController=TextEditingController();
  final TextEditingController phoneController=TextEditingController();
  getuser(){
    nameController.text=currentuser?.userName??'';
    phoneController.text=currentuser?.phone??'';
    emailController.text=currentuser?.userEmail??'';
  }
  @override
  void initState() {
    getuser();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
                    children: [
                      SizedBox(height: 10,),
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: "name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),

                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: "email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),

                      TextFormField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          labelText: "phoneNumber",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      ElevatedButton(onPressed: (){
                        FirebaseFirestore.instance.collection('users').doc(currentuserid).update({
                          'userName':nameController.text,
                          'userEmail':emailController.text,
                          'phone':phoneController.text,
                        });
                        Navigator.pop(context);

                      }, child:Text("Update"))
                    ],
                  ),
    );
  }
}
