class ServiceCategory {
  String? categoryId;
  String? serviceCategory;

  ServiceCategory({this.categoryId, this.serviceCategory});

  ServiceCategory.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    serviceCategory = json['serviceCategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryId'] = this.categoryId;
    data['serviceCategory'] = this.serviceCategory;
    return data;
  }
}
