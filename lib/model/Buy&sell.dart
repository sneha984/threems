class StoreDetailsModel {
  String? storeName;
  String? storeCategory;
  String? storeAddress;
  String? storeLocation;
  String? storeId;
  String? storeImage;

  StoreDetailsModel(
      {this.storeName,
        this.storeCategory,
        this.storeAddress,
        this.storeLocation,
      this.storeId,
      this.storeImage});

  StoreDetailsModel.fromJson(Map<String, dynamic> json) {
    storeName = json['storeName'];
    storeCategory = json['storeCategory'];
    storeAddress = json['storeAddress'];
    storeLocation = json['storeLocation'];
    storeId=json['storeId'];
    storeImage=json['storeImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['storeName'] = this.storeName;
    data['storeCategory'] = this.storeCategory;
    data['storeAddress'] = this.storeAddress;
    data['storeLocation'] = this.storeLocation;
    data['storeId']=this.storeId;
    data['storeImage']=this.storeImage;
    return data;
  }
}



class ProductModel {
  List<String>? images;
  String? productName;
  String? productCategory;
  double? price;
  int? quantity;
  String? unit;
  String? details;
  ProductModel(
      {this.images,
        this.productName,
        this.productCategory,
        this.price,
        this.quantity,
        this.unit,
        this.details});
  ProductModel.fromJson(Map<String, dynamic> json) {
    images = json['images'].cast<String>();
    productName = json['productName'];
    productCategory = json['productCategory'];
    price = json['price'];
    quantity = json['quantity'];
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
    data['unit'] = this.unit;
    data['details'] = this.details;
    return data;
  }
}