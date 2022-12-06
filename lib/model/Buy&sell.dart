import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:threems/Buy&sell/buy_and_sell.dart';

class StoreDetailsModel {
  double? deliveryCharge;
  String? storeName;
  List<dynamic>? storeCategory;
  String? storeAddress;
  String? storeLocation;
  String? storeId;
  String? storeImage;
  String? userId;
  double? latitude;
  double? longitude;
  StoreDetailsModel(
      {this.storeName,
        this.deliveryCharge,
         this.storeCategory,
        this.storeAddress,
        this.storeLocation,
      this.storeId,
      this.storeImage,
        this.userId,
        this.longitude,
        this.latitude
      });

  StoreDetailsModel.fromJson(Map<String, dynamic> json) {
    deliveryCharge=json['deliveryCharge'];
    storeName = json['storeName'];
    storeCategory = json['storeCategory'];
    storeAddress = json['storeAddress'];
    storeLocation = json['storeLocation'];
    storeId=json['storeId'];
    storeImage=json['storeImage'];
    longitude=json['longitude'];
    latitude=json['latitude'];

    userId=json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deliveryCharge']=this.deliveryCharge;
    data['storeName'] = this.storeName;
    data['storeCategory'] = this.storeCategory;
    data['storeAddress'] = this.storeAddress;
    data['storeLocation'] = this.storeLocation;
    data['storeId']=this.storeId;
    data['storeImage']=this.storeImage;
    data['longitude']=this.longitude;
    data['userId']=this.userId;
    data['latitude']=this.latitude;
    return data;
  }
}



class ProductModel {
  List<String>? images;
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
        // required this.categoryName,
        this.details});
  ProductModel.fromJson(Map<String, dynamic> json) {
    images = json['images'].cast<String>();
    productName = json['productName'];
    productCategory = json['productCategory'];
    price = json['price'];
    available = json['available'];
    quantity = json['quantity'];
    storedCategorys=json['storedCategorys'];
    productId=json['productId'];
    storeId=json['storeId'];
    // categoryName=json['categoryName'];

    unit = json['unit'];
    details = json['details'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['images'] = this.images;
    data['productName'] = this.productName;
    data['storeId']=this.storeId;
    data['available']=this.available;
    data['productCategory'] = this.productCategory;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['storedCategorys']=this.storedCategorys;
    data['storeId']=this.storeId;

    // data['categoryName']=this.categoryName;
    data['unit'] = this.unit;
    data['details'] = this.details;data['productId']=this.productId;
    return data;
  }
}
