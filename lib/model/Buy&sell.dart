class StoreDetailsModel {
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
  String? productName;
  String? productCategory;
  double? price;
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
        this.productId,
        this.unit,
        this.storedCategorys,
        // required this.categoryName,
        this.details});
  ProductModel.fromJson(Map<String, dynamic> json) {
    images = json['images'].cast<String>();
    productName = json['productName'];
    productCategory = json['productCategory'];
    price = json['price'];
    quantity = json['quantity'];
    storedCategorys=json['storedCategorys'];
    productId=json['productId'];
    // categoryName=json['categoryName'];

    unit = json['unit'];
    details = json['details'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['images'] = this.images;
    data['productName'] = this.productName;
    data['productCategory'] = this.productCategory;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['storedCategorys']=this.storedCategorys;

    // data['categoryName']=this.categoryName;
    data['unit'] = this.unit;
    data['details'] = this.details;data['productId']=this.productId;
    return data;
  }
}