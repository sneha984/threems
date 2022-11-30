class OrderModel {
  String? item;
  double? amount;
  String? itemImage;
  DateTime? time;
  Addresses? address;
  String? orderId;
  String? userId;
  double? deliveryCharge;
  int? status;
  int? count;
  String? storeId;
  OrderModel(
      {this.item,
        this.amount,
        this.time,
        this.address,
        this.orderId,
        this.userId,
        this.deliveryCharge,
        this.status,
        this.count,
        this.storeId,this.itemImage});

  OrderModel.fromJson(Map<String, dynamic> json) {
    item = json['item'];
    amount = json['amount'];
    time = json['time'];
    address =
    json['address'] != null ? new Addresses.fromJson(json['address']) : null;
    orderId = json['orderId'];
    userId = json['userId'];
    deliveryCharge = json['deliveryCharge'];
    status=json['status'];
    count=json['count'];
    storeId=json['storeId'];
    itemImage=json['itemImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item'] = this.item;
    data['amount'] = this.amount;
    data['time'] = this.time;
    data['status']=this.status;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['orderId'] = this.orderId;
    data['userId'] = this.userId;
    data['deliveryCharge'] = this.deliveryCharge;
    data['count']=this.count;
    data['storeId']=this.storeId;
    data['itemImage']=this.itemImage;
    return data;
  }
}

class Addresses {
  String? flatNo;
  String? locality;
  String? pincode;
  String? locationType;
  String? phoneNumber;
  String? name;

  Addresses(
      {this.flatNo,
        this.locality,
        this.pincode,
        this.locationType,
        this.phoneNumber,
        this.name});

  Addresses.fromJson(Map<String, dynamic> json) {
    flatNo = json['flatNo'];
    locality = json['locality'];
    pincode = json['pincode'];
    locationType = json['locationType'];
    phoneNumber = json['phoneNumber'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['flatNo'] = this.flatNo;
    data['locality'] = this.locality;
    data['pincode'] = this.pincode;
    data['locationType'] = this.locationType;
    data['phoneNumber'] = this.phoneNumber;
    data['name'] = this.name;
    return data;
  }
}