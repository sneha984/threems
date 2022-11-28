class ServiceCategory {
  String? categoryId;
  String? serviceCategory;
  String? image;

  ServiceCategory({this.categoryId, this.serviceCategory});

  ServiceCategory.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    serviceCategory = json['serviceCategory'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryId'] = this.categoryId;
    data['serviceCategory'] = this.serviceCategory;
    data['image'] = this.image;
    return data;
  }
}
