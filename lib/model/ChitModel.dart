class ChitModel {
  String? chitName;
  bool? private;
  String? chitId;
  String? commission;
  String? userId;
  int? status;
  double? payableAmount;
  List? members;
  double? amount;
  int? duration;
  double? subscriptionAmount;
  bool? drawn;
  double? dividendAmount;
  String? document;
  String? profile;
  List<Winners>? winners;
  String? chitType;
  DateTime? createdDate;
  int? membersCount;
  int? chitDate;
  String? chitTime;
  List? upiApps;
  String? phone;
  String? accountNumber;
  String? accountHolderName;
  String? bankName;
  String? ifsc;

  ChitModel({
    this.chitName,
    this.private,
    this.commission,
    this.members,
    this.chitId,
    this.userId,
    this.upiApps,
    this.payableAmount,
    this.phone,
    this.accountNumber,
    this.accountHolderName,
    this.bankName,
    this.ifsc,
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
  });

  ChitModel.fromJson(Map<String, dynamic> json) {
    chitName = json['chitName'];
    private = json['private'];
    commission = json['commission'];
    payableAmount = json['payableAmount'].toDouble();
    members = json['members'].cast<String>();
    upiApps = json['upiApps'].cast<String>();
    if (json['winners'] != null) {
      winners = <Winners>[];
      json['winners'].forEach((v) {
        winners!.add(Winners.fromJson(v));
      });
    }
    amount = json['amount'];
    duration = json['duration'];
    subscriptionAmount = json['subscriptionAmount'].toDouble();
    payableAmount = json['payableAmount'].toDouble();
    chitId = json['chitId'];
    userId = json['userId'];
    phone = json['phone'];
    accountNumber = json['accountNumber'];
    accountHolderName = json['accountHolderName'];
    bankName = json['bankName'];
    ifsc = json['ifsc'];
    drawn = json['drawn'];
    status = json['status'];
    dividendAmount = double.tryParse(json['dividendAmount'].toString());
    membersCount = json['membersCount'];
    document = json['document'];
    profile = json['profile'];
    chitType = json['chitType'];
    createdDate = json['createdDate'].toDate();
    chitDate = json['chitDate'];
    chitTime = json['chitTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['chitName'] = chitName;
    data['private'] = private;
    data['commission'] = commission;
    data['membersCount'] = membersCount;
    data['payableAmount'] = payableAmount;
    data['chitId'] = chitId;
    data['members'] = members;
    if (winners != null) {
      data['winners'] = winners!.map((v) => v.toJson()).toList();
    }
    data['upiApps'] = upiApps;
    data['userId'] = userId;
    data['status'] = status;
    data['amount'] = amount;
    data['duration'] = duration;
    data['subscriptionAmount'] = subscriptionAmount;
    data['drawn'] = drawn;
    data['dividendAmount'] = dividendAmount;
    data['phone'] = phone;
    data['accountNumber'] = accountNumber;
    data['accountHolderName'] = accountHolderName;
    data['bankName'] = bankName;
    data['ifsc'] = ifsc;
    data['document'] = document;
    data['profile'] = profile;
    data['chitType'] = chitType;
    data['createdDate'] = createdDate;
    data['chitDate'] = chitDate;
    data['chitTime'] = chitTime;

    return data;
  }
}

class Payments {
  DateTime? datePaid;
  String? userId;
  double? amount;
  bool? verified;
  String? url;
  String? paymentId;

  Payments(
      {this.datePaid,
      this.userId,
      this.amount,
      this.verified,
      this.url,
      this.paymentId});

  Payments.fromJson(Map<String, dynamic> json) {
    datePaid = json['datePaid'].toDate();
    userId = json['userId'];
    amount = json['amount'];
    paymentId = json['paymentId'];
    verified = json['verified'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['datePaid'] = datePaid;
    data['userId'] = userId;
    data['amount'] = amount;
    data['paymentId'] = paymentId;
    data['verified'] = verified;
    data['url'] = url;
    return data;
  }
}

class Winners {
  DateTime? date;
  String? userId;
  double? amount;

  Winners({
    this.date,
    this.userId,
    this.amount,
  });

  Winners.fromJson(Map<String, dynamic> json) {
    date = json['date'].toDate();
    userId = json['userId'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['date'] = date;
    data['userId'] = userId;
    data['amount'] = amount;
    return data;
  }
}
