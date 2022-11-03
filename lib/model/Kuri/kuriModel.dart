class KuriModel {
  bool? private;
  String? kuriName;
  double? amount;
  String? deadLine;
  String? purpose;
  String? phone;
  List<String>? upiApps;
  String? accountNumber;
  String? holderName;
  String? bankName;
  String? iFSC;
  String? userID;
  List<Members>? members;

  KuriModel(
      {this.private,
      this.kuriName,
      this.amount,
      this.deadLine,
      this.purpose,
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
    deadLine = json['deadLine'];
    purpose = json['purpose'];
    phone = json['phone'];
    upiApps = json['upiApps'].cast<String>();
    accountNumber = json['accountNumber'];
    holderName = json['holderName'];
    bankName = json['bankName'];
    iFSC = json['IFSC'];
    userID = json['userID'];
    if (json['members'] != null) {
      members = <Members>[];
      json['members'].forEach((v) {
        members!.add(Members.fromJson(v));
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
    data['phone'] = phone;
    data['upiApps'] = upiApps;
    data['accountNumber'] = accountNumber;
    data['holderName'] = holderName;
    data['bankName'] = bankName;
    data['IFSC'] = iFSC;
    data['userID'] = userID;
    if (members != null) {
      data['members'] = members!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Members {
  String? name;
  String? number;

  Members({this.name, this.number});

  Members.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['number'] = number;
    return data;
  }
}
