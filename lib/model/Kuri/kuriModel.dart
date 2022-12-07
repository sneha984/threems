class KuriModel {
  bool? private;
  String? kuriName;
  double? amount;
  DateTime? deadLine;
  double? totalReceived;
  String? purpose;
  String? phone;
  List<String>? upiApps;
  String? accountNumber;
  String? holderName;
  List<Payments>? payments;
  String? bankName;
  String? iFSC;
  String? userID;
  String? kuriId;
  List? members;

  KuriModel(
      {this.private,
      this.kuriName,
      this.amount,
      this.deadLine,
      this.kuriId,
      this.purpose,
      this.payments,
      this.totalReceived,
      this.phone,
      this.upiApps,
      this.accountNumber,
      this.holderName,
      this.bankName,
      this.iFSC,
      this.userID,
      this.members});

  KuriModel.fromJson(Map<String, dynamic> json) {
    private = json['private'];
    kuriName = json['kuriName'];
    amount = double.tryParse(json['amount'].toString());
    kuriId = json['kuriId'];
    totalReceived = double.tryParse(json['totalReceived'].toString());

    deadLine = json['deadLine'].toDate();
    purpose = json['purpose'];
    phone = json['phone'];
    upiApps = json['upiApps'].cast<String>();
    accountNumber = json['accountNumber'];
    holderName = json['holderName'];
    bankName = json['bankName'];
    iFSC = json['IFSC'];
    userID = json['userID'];
    members = json['members'].cast<String>();
    if (json['payments'] != null) {
      payments = <Payments>[];
      json['payments'].forEach((v) {
        payments!.add(Payments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['private'] = private;
    data['kuriName'] = kuriName;
    data['amount'] = amount;
    data['deadLine'] = deadLine;
    data['purpose'] = purpose;
    data['kuriId'] = kuriId;
    data['phone'] = phone;
    data['upiApps'] = upiApps;
    data['accountNumber'] = accountNumber;
    data['holderName'] = holderName;
    data['bankName'] = bankName;
    data['totalReceived'] = totalReceived;
    data['IFSC'] = iFSC;
    data['userID'] = userID;
    data['members'] = members;
    if (payments != null) {
      data['payments'] = payments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Payments {
  double? amount;
  DateTime? datePaid;
  bool? verified;
  String? url;
  String? userId;
  String? paymentId;

  Payments(
      {this.amount,
      this.datePaid,
      this.verified,
      this.url,
      this.userId,
      this.paymentId});

  Payments.fromJson(Map<String, dynamic> json) {
    amount = json['amount'].toDouble();
    datePaid = DateTime.tryParse(json['datePaid'].toString());
    verified = json['verified'];
    paymentId = json['paymentId'];
    url = json['url'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['amount'] = amount;
    data['datePaid'] = datePaid;
    data['verified'] = verified;
    data['paymentId'] = paymentId;
    data['url'] = url;
    data['userId'] = userId;
    return data;
  }
}
