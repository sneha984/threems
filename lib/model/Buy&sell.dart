class StoreDetailsModel {
  String? storeName;
  String? storeCategory;
  String? storeAddress;
  String? storeLocation;

  StoreDetailsModel(
      {this.storeName,
        this.storeCategory,
        this.storeAddress,
        this.storeLocation});

  StoreDetailsModel.fromJson(Map<String, dynamic> json) {
    storeName = json['storeName'];
    storeCategory = json['storeCategory'];
    storeAddress = json['storeAddress'];
    storeLocation = json['storeLocation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['storeName'] = this.storeName;
    data['storeCategory'] = this.storeCategory;
    data['storeAddress'] = this.storeAddress;
    data['storeLocation'] = this.storeLocation;
    return data;
  }
}