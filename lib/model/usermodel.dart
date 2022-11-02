import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../Authentication/root.dart';


UserModel? currentuser;
class UserModel {
  String? userName;
  String? userEmail;
  String? userImage;
  String? userId;
  UserModel({this.userName, this.userEmail, this.userImage, this.userId});
  UserModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    userEmail = json['userEmail'];
    userImage = json['userImage'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['userEmail'] = this.userEmail;
    data['userImage'] = this.userImage;
    data['userId'] = this.userId;
    return data;
  }
}
StreamSubscription? listenUserSub;
getcurrentuser() {
  listenUserSub = FirebaseFirestore.instance
      .collection('users')
      .doc(currentuserid)
      .snapshots()
      .listen((event) {
    currentuser = UserModel.fromJson(event.data()!);
      });
}

