class ServiceDetails {
  String? name;
  String? emailId;
  String? phoneNumber;
  String? whatsappNo;
  String? address;
  String? city;
  String? serviceId;
  String? userId;
  String? serviceCategory;
  double? wage;
  String? serviceUnit;
  String? image;
  DateTime? addedDate;
  String? documents;
  String? subCategory;
  String? servicesProvided;
  String? aboutService;
  double? lat;
  double? long;
  String? serviceLocation;
  Map? position;

  ServiceDetails({
    this.name,
    this.emailId,
    this.phoneNumber,
    this.whatsappNo,
    this.address,
    this.city,
    this.serviceId,
    this.userId,
    this.addedDate,
    this.serviceCategory,
    this.wage,
    this.serviceUnit,
    this.image,
    this.documents,
    this.subCategory,
    this.servicesProvided,
    this.aboutService,
    this.lat,
    this.long,
    this.serviceLocation,
    this.position,
  });

  ServiceDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    emailId = json['emailId'];
    phoneNumber = json['phoneNo'];
    whatsappNo = json['whatsappNo'];
    address = json['address'];
    city = json['city'];
    userId = json['userId'];
    serviceId = json['serviceId'];
    serviceCategory = json['serviceCategory'];
    subCategory = json['subCategory'];
    wage = json['wage'];
    serviceUnit = json['serviceUnit'];
    aboutService = json['aboutService'];
    servicesProvided = json['servicesProvided'];
    image = json['image'];
    documents = json['documents'];
    lat = json['lat'];
    long = json['long'];
    serviceLocation = json['serviceLocation'];
    position = json['position'];
    addedDate = json['addedDate'].toDate();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['emailId'] = emailId;
    data['phoneNo'] = phoneNumber;
    data['whatsappNo'] = whatsappNo;
    data['address'] = address;
    data['city'] = city;
    data['userId'] = userId;
    data['serviceId'] = serviceId;
    data['wage'] = wage;
    data['serviceCategory'] = serviceCategory;
    data['serviceUnit'] = serviceUnit;
    data['aboutService'] = aboutService;
    data['servicesProvided'] = servicesProvided;
    data['image'] = image;
    data['documents'] = documents;
    data['addedDate'] = addedDate;
    data['subCategory'] = subCategory;
    data['serviceLocation'] = serviceLocation;
    data['position'] = position;
    data['lat'] = lat;
    data['long'] = long;
    return data;
  }
}
