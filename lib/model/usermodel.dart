import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../Authentication/root.dart';

UserModel? currentuser;
StreamSubscription? listenUserSub;
class UserModel {
  String? userName;
  String? userEmail;
  String? userImage;
  String? userId;
  String? phone;
  // Timestamp? dateTime;
  List<Address>? address;

  UserModel(
      {this.userName,
      this.userEmail,
      this.userImage,
      this.userId,
      this.phone,
      // this.dateTime,
      this.address});
  UserModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    userEmail = json['userEmail'];
    userImage = json['userImage'];
    userId = json['userId'];
    // dateTime=json['dateTime'].toDate();
    phone = json['phone'] ?? '';
    if (json['address'] != null) {
      address = <Address>[];
      json['address'].forEach((v) {
        address!.add(new Address.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['userEmail'] = this.userEmail;
    data['userImage'] = this.userImage;
    data['userId'] = this.userId;
    data['phone'] = this.phone;
    // data['dateTime']=this.dateTime;
    if (this.address != null) {
      data['address'] = this.address!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}


getcurrentuser() {
  print('Here');
  print(currentuserid);
  listenUserSub = FirebaseFirestore.instance
      .collection('users')
      .doc(currentuserid)
      .snapshots()
      .listen((event) {
        if(event.exists) {
          currentuser = UserModel.fromJson(event.data()!);
        }
  });
}

class Address {
  String? name;
  String? phoneNumber;
  String? pinCode;
  String? locality;
  String? flatNo;
  String? select;
  int? selectedIndex;
  Address(
      {this.name,
      this.phoneNumber,
      this.pinCode,
      this.locality,
      this.flatNo,
      this.select,
      this.selectedIndex});

  Address.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    pinCode = json['pinCode'];
    locality = json['locality'];
    flatNo = json['flatNo'];
    select = json['select'];
    selectedIndex=json['selectedIndex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    data['pinCode'] = this.pinCode;
    data['locality'] = this.locality;
    data['flatNo'] = this.flatNo;
    data['select'] = this.select;
    data['selectedIndex']=this.selectedIndex;
    return data;
  }
}
