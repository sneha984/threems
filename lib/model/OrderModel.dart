class OrderModel {
  DateTime? time;
  Addresses? address;
  String? orderId;
  String? userId;
  double? deliveryCharge;
  int? status;
  String? storeId;
  List<OrderedItems>? orderedItems;
  OrderModel(
      {
        this.time,
        this.address,
        this.orderId,
        this.userId,
        this.deliveryCharge,
        this.status,
        this.storeId,
        this.orderedItems});

  OrderModel.fromJson(Map<String, dynamic> json) {
    time = DateTime.tryParse(json['time'].toString());
    address =
    json['address'] != null ? new Addresses.fromJson(json['address']) : null;
    if (json['orderedItems'] != null) {
      orderedItems = <OrderedItems>[];
      json['orderedItems'].forEach((v) {
        orderedItems!.add(new OrderedItems.fromJson(v));
      });
    }
    orderId = json['orderId'];
    userId = json['userId'];
    deliveryCharge = json['deliveryCharge'];
    status=json['status'];
    storeId=json['storeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['status']=this.status;
    if (this.address != null) {
      data['address'] = this.address!.toJson();

    }
    if (this.orderedItems != null) {
      data['orderedItems'] = this.orderedItems!.map((v) => v.toJson()).toList();
    }
    data['orderId'] = this.orderId;
    data['userId'] = this.userId;
    data['deliveryCharge'] = this.deliveryCharge;
    data['storeId']=this.storeId;
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
class OrderedItems {
  double? amount;
  int? count;
  String? item;
  String? itemImage;

  OrderedItems({this.amount, this.count, this.item, this.itemImage});

  OrderedItems.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    count = json['count'];
    item = json['item'];
    itemImage = json['itemImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['count'] = this.count;
    data['item'] = this.item;
    data['itemImage'] = this.itemImage;
    return data;
  }
}