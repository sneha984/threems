import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:threems/Buy&sell/buy_and_sell.dart';

class StoreDetailsModel {
  double? deliveryCharge;
  double? totalSales;
  String? storeName;
  String? blockedReason;
  List<dynamic>? storeCategory;
  List<dynamic>? productCategory;
  String? storeAddress;
  String? storeLocation;
  String? storeId;
  String? storeImage;
  String? userId;
  double? latitude;
  double? longitude;
  bool? online;
  String? storeQR;
  bool? storeVerification;
  String? localBodyName;
  String? localBodyDoc;
  String? localBodyDocName;
  Map? position;

  bool? block;
  int? status;
  bool? rejected;
  String? rejectedReason;
  String? contactNumber;
  StoreDetailsModel(
      {this.storeName,
      this.deliveryCharge,
      this.totalSales,
      this.storeCategory,
        this.productCategory,
      this.storeAddress,
      this.storeLocation,
      this.storeId,
      this.storeImage,
      this.userId,
      this.longitude,
      this.latitude,
      this.position,
        this.online,
        this.storeQR,
        this.storeVerification,
        this.localBodyName,
        this.localBodyDoc,
        this.localBodyDocName,
        this.block,
        this.status,
        this.rejected,
        this.rejectedReason,
        this.contactNumber,
      this.blockedReason});

  StoreDetailsModel.fromJson(Map<String, dynamic> json) {
    deliveryCharge = double.tryParse(json['deliveryCharge'].toString());
    totalSales = json['totalSales'];
    storeName = json['storeName'];
    storeCategory = json['storeCategory'];
    productCategory = json['productCategory'];
    storeAddress = json['storeAddress'];
    storeLocation = json['storeLocation'];
    storeId = json['storeId'];
    storeImage = json['storeImage'];
    longitude = double.tryParse(json['longitude'].toString());
    latitude = double.tryParse(json['latitude'].toString());
    position = json['position'];
    online=json['online'];
    storeQR=json['storeQR'];
    storeVerification=json['storeVerification'];
    localBodyName=json['localBodyName'];
    localBodyDoc=json['localBodyDoc'];
    localBodyDocName=json['localBodyDocName'];
    block=json['block'];
    status=json['status'];
    blockedReason=json['blockedReason'];

    userId = json['userId'];
    rejected=json['rejected'];
    rejectedReason=json['rejectedReason'];
    contactNumber=json['contactNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deliveryCharge'] = this.deliveryCharge;
    data['totalSales'] = this.totalSales;
    data['storeName'] = this.storeName;
    data['storeCategory'] = this.storeCategory;
    data['productCategory'] = this.productCategory;
    data['storeAddress'] = this.storeAddress;
    data['storeLocation'] = this.storeLocation;
    data['storeId'] = this.storeId;
    data['storeImage'] = this.storeImage;
    data['longitude'] = this.longitude;
    data['userId'] = this.userId;
    data['latitude'] = this.latitude;
    data['position'] = this.position;
    data['online']=this.online;
    data['storeQR']=this.storeQR;
    data['localBodyName']=this.localBodyName;
    data['localBodyDoc']=this.localBodyDoc;
    data['storeVerification']=this.storeVerification;
    data['localBodyDocName']=this.localBodyDocName;
    data['block']=this.block;
    data['blockedReason']=this.blockedReason;
    data['status']=this.status;
    data['rejected']=this.rejected;
    data['rejectedReason']=this.rejectedReason;
    data['contactNumber']=this.contactNumber;

    return data;
  }
}

class ProductModel {
  List<dynamic>? images;
  String? productId;
  String? storeId;
  String? productName;
  String? productCategory;
  double? price;
  bool? available;
  int? quantity;
  String? storedCategorys;
  String? unit;
  String? details;
  bool? delete;
  // List<String> categoryName=[];

  ProductModel(
      {this.images,
      this.productName,
      this.productCategory,
      this.price,
      this.quantity,
      this.available,
      this.productId,
      this.unit,
      this.storeId,
      this.storedCategorys,
        this.delete,
      // required this.categoryName,
      this.details});
  ProductModel.fromJson(Map<String, dynamic> json) {
    images = json['images'].cast<String>();
    productName = json['productName'];
    productCategory = json['productCategory'];
    price = double.tryParse(json['price'].toString());
    available = json['available'];
    quantity = int.tryParse(json['quantity'].toString());
    storedCategorys = json['storedCategorys'];
    productId = json['productId'];
    storeId = json['storeId'];
    delete=json['delete'];
    // categoryName=json['categoryName'];

    unit = json['unit'];
    details = json['details'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['images'] = this.images;
    data['productName'] = this.productName;
    data['storeId'] = this.storeId;
    data['available'] = this.available;
    data['productCategory'] = this.productCategory;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['storedCategorys'] = this.storedCategorys;
    data['storeId'] = this.storeId;
    data['delete']=this.delete;

    // data['categoryName']=this.categoryName;
    data['unit'] = this.unit;
    data['details'] = this.details;
    data['productId'] = this.productId;
    return data;
  }
}
