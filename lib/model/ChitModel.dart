class ChitModel {
  String? chitName;
  bool? private;
  String? chitId;
  String? commission;
  String? userId;
  int? status;
  List? members;
  double? amount;
  int? duration;
  double? subscriptionAmount;
  bool? drawn;
  double? dividendAmount;
  String? document;
  String? profile;
  List? winners;
  String? chitType;
  DateTime? createdDate;
  int? membersCount;
  int? chitDate;
  String? chitTime;
  List<Payments>? payments;

  ChitModel(
      {this.chitName,
      this.private,
      this.commission,
      this.members,
      this.chitId,
      this.userId,
      this.status,
      this.amount,
      this.duration,
      this.subscriptionAmount,
      this.drawn,
      this.dividendAmount,
      this.document,
      this.winners,
      this.profile,
      this.chitType,
      this.createdDate,
      this.chitDate,
      this.membersCount,
      this.chitTime,
      this.payments});

  ChitModel.fromJson(Map<String, dynamic> json) {
    chitName = json['chitName'];
    private = json['private'];
    commission = json['commission'];
    members = json['members'].cast<String>();
    winners = json['winners'].cast<String>();
    amount = json['amount'];
    duration = json['duration'];
    subscriptionAmount = json['subscriptionAmount'];
    chitId = json['chitId'];
    userId = json['userId'];

    drawn = json['drawn'];
    status = json['status'];
    dividendAmount = json['dividendAmount'];
    membersCount = json['membersCount'];
    document = json['document'];
    profile = json['profile'];
    chitType = json['chitType'];
    createdDate = json['createdDate'];
    chitDate = json['chitDate'];
    chitTime = json['chitTime'];
    if (json['payments'] != null) {
      payments = <Payments>[];
      json['payments'].forEach((v) {
        payments!.add(Payments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['chitName'] = chitName;
    data['private'] = private;
    data['commission'] = commission;
    data['membersCount'] = membersCount;
    data['chitId'] = chitId;
    data['members'] = members;
    data['winners'] = winners;
    data['userId'] = userId;
    data['status'] = status;
    data['amount'] = amount;
    data['duration'] = duration;
    data['subscriptionAmount'] = subscriptionAmount;
    data['drawn'] = drawn;
    data['dividendAmount'] = dividendAmount;
    data['document'] = document;
    data['profile'] = profile;
    data['chitType'] = chitType;
    data['createdDate'] = createdDate;
    data['chitDate'] = chitDate;
    data['chitTime'] = chitTime;
    if (payments != null) {
      data['payments'] = payments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Payments {
  DateTime? datePaid;
  String? userId;
  double? amount;
  bool? verified;
  String? url;

  Payments({this.datePaid, this.userId, this.amount, this.verified, this.url});

  Payments.fromJson(Map<String, dynamic> json) {
    datePaid = json['datePaid'];
    userId = json['userId'];
    amount = json['amount'];
    verified = json['verified'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['datePaid'] = datePaid;
    data['userId'] = userId;
    data['amount'] = amount;
    data['verified'] = verified;
    data['url'] = url;
    return data;
  }
}
