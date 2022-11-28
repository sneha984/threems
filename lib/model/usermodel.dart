import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../Authentication/root.dart';

UserModel? currentuser;

class UserModel {
  String? userName;
  String? userEmail;
  String? userImage;
  String? userId;
  String? phone;
  List<Cart>? cart;
  List<Address>? address;

  UserModel(
      {this.userName, this.userEmail, this.userImage, this.userId, this.phone,this.cart,this.address});
  UserModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    userEmail = json['userEmail'];
    userImage = json['userImage'];
    userId = json['userId'];
    phone = json['phone'] ?? '';
    if (json['address'] != null) {
      address = <Address>[];
      json['address'].forEach((v) {
        address!.add(new Address.fromJson(v));
      });
    }
    if (json['cart'] != null) {
      cart = <Cart>[];
      json['cart'].forEach((v) {
        cart!.add(new Cart.fromJson(v));
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
    if (this.address != null) {
      data['address'] = this.address!.map((v) => v.toJson()).toList();
    }
    if (this.cart != null) {
      data['cart'] = this.cart!.map((v) => v.toJson()).toList();
    }
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
class Address {
  String? name;
  String? phoneNumber;
  String? pinCode;
  String? locality;
  String? flatNo;
  String? select;

  Address(
      {this.name,
        this.phoneNumber,
        this.pinCode,
        this.locality,
        this.flatNo,
        this.select});

  Address.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    pinCode = json['pinCode'];
    locality = json['locality'];
    flatNo = json['flatNo'];
    select = json['select'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    data['pinCode'] = this.pinCode;
    data['locality'] = this.locality;
    data['flatNo'] = this.flatNo;
    data['select'] = this.select;
    return data;
  }
}
class Cart {
  String? productId;
  String? storeId;
  int? qty;

  Cart({this.productId, this.storeId, this.qty});

  Cart.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    storeId = json['storeId'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['storeId'] = this.storeId;
    data['qty'] = this.qty;
    return data;
  }
}