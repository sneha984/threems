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
  List<String>? members;

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
    amount = json['amount'];
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
    if (this.payments != null) {
      data['payments'] = this.payments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Payments {
  double? amount;
  String? datePaid;
  bool? verified;
  String? url;
  String? userId;

  Payments({this.amount, this.datePaid, this.verified, this.url, this.userId});

  Payments.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    datePaid = json['datePaid'];
    verified = json['verified'];
    url = json['url'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['datePaid'] = this.datePaid;
    data['verified'] = this.verified;
    data['url'] = this.url;
    data['userId'] = this.userId;
    return data;
  }
}
