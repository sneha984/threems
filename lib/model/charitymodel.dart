import 'package:cloud_firestore/cloud_firestore.dart';

class CharityModel {
  String? accountHolderName;
  String? accountNumber;
  String? bankName;
  String? beneficiaryName;
  String? beneficiaryPhNumber;
  int? cause;
  String? fileNme;
  String? charityDetailes;
  String? confirmAccountNumber;
  String? documents;//----------------------------------------
  String? emailId;
  Timestamp? endDate;
  String? ifscCode;
  String? image;
  String? orgName;
  String? phoneNumber;
  int? status;
  double? valueAmount;
  String? youTubeLink;
  String? beneficiaryLocation;
  String? reason;
  String? charityId;
  String? userId;
  String? userName;
  bool? block;
  double?totalAmount;
  List<Payments>? payments;
  CharityModel(
      {this.accountHolderName,
        this.accountNumber,
        this.bankName,
        this.beneficiaryName,
        this.beneficiaryPhNumber,
        this.cause,
        this.fileNme,
        this.charityDetailes,
        this.confirmAccountNumber,
        this.documents,
        this.emailId,
        this.endDate,
        this.ifscCode,
        this.image,
        this.orgName,
        this.phoneNumber,
        this.status,
        this.valueAmount,
        this.youTubeLink,
        this.beneficiaryLocation,
        this.reason,
        this.charityId,
        this.userId,
        this.userName,
        required this.block,
        this.payments,
        this.totalAmount

      });

  CharityModel.fromJson(Map<String, dynamic> json) {
    accountHolderName = json['accountHolderName'];
    accountNumber = json['accountNumber'];
    bankName = json['bankName'];
    fileNme = json['fileNme'];
    beneficiaryName = json['beneficiaryName'];
    beneficiaryPhNumber = json['beneficiaryPhNumber'];
    cause = json['cause'];
    charityDetailes = json['charityDetailes'];
    confirmAccountNumber = json['confirmAccountNumber'];
    documents = json['documents'];
    emailId = json['emailId'];
    endDate = json['endDate'];
    ifscCode = json['ifscCode'];
    image = json['image'];
    orgName = json['orgName'];
    phoneNumber = json['phoneNumber'];
    status = json['status'];
    valueAmount = json['valueAmount'];
    youTubeLink=json['youTubeLink'];
    beneficiaryLocation=json['beneficiaryLocation'];
    reason=json['reason'];
    charityId=json['charityId'];
    userId=json['userId'];
    userName=json['userName'];
    block=json['block'];
    totalAmount=json['totalAmount'];
    if (json['payments'] != null) {
      payments = <Payments>[];
      json['payments'].forEach((v) {
        payments!.add(Payments.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accountHolderName'] = this.accountHolderName;
    data['accountNumber'] = this.accountNumber;
    data['bankName'] = this.bankName;
    data['beneficiaryName'] = this.beneficiaryName;
    data['beneficiaryPhNumber'] = this.beneficiaryPhNumber;
    data['cause'] = this.cause;
    data['charityDetailes'] = this.charityDetailes;
    data['confirmAccountNumber'] = this.confirmAccountNumber;
    data['documents'] = this.documents;
    data['emailId'] = this.emailId;
    data['fileNme'] = this.fileNme;
    data['endDate'] = this.endDate;
    data['ifscCode'] = this.ifscCode;
    data['image'] = this.image;
    data['orgName'] = this.orgName;
    data['phoneNumber'] = this.phoneNumber;
    data['status'] = this.status;
    data['valueAmount'] = this.valueAmount;
    data['youTubeLink']=this.youTubeLink;
    data['beneficiaryLocation']=this.beneficiaryLocation;
    data['reason']=this.reason;
    data['charityId']=this.charityId;
    data['userId']=this.userId;
    data['userName']=this.userName;
    data['block']=this.block;
    data['totalAmount']=this.totalAmount;
    if (this.payments != null) {
      data['payments'] = this.payments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Payments {
  bool? verified;
  String? userName;
  String? userId;
  double? amount;
  String? screenShotUrl;
  String? date;

  Payments(
      {this.verified,
        this.userName,
        this.userId,
        this.amount,
        this.screenShotUrl,
        this.date
      });

  Payments.fromJson(Map<String, dynamic> json) {
    verified = json['verified'];
    userName = json['userName'];
    userId = json['userId'];
    amount = double.tryParse(json['amount'].toString());
    screenShotUrl = json['screenShotUrl'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['verified'] = this.verified;
    data['userName'] = this.userName;
    data['userId'] = this.userId;
    data['amount'] = this.amount;
    data['screenShotUrl'] = this.screenShotUrl;
    data['date'] = this.date;
    return data;
  }
}
