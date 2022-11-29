class Sproducts {
  final String productimage;
  final String storename;
  final double price;
  final String productname;
  Sproducts(
      {required this.price,
      required this.productimage,
      required this.storename,
      required this.productname});
}

class EachStore {
  final String productimage;
  final String productunit;
  final double productprice;
  final String productname;
  int counter;
  bool ShouldVisible;
  EachStore(
      {required this.counter,
      required this.ShouldVisible,
      required this.productimage,
      required this.productprice,
      required this.productunit,
      required this.productname});
}

class NearStore {
  final String image;
  final String storename;
  final String category;
  NearStore(
      {required this.image, required this.storename, required this.category});
}

class SubCategory {
  final String storeimage;
  final String storename;
  final String noofproduct;
  SubCategory(
      {required this.noofproduct,
      required this.storename,
      required this.storeimage});
}

class Categorys {
  final String categoryname;
  final String categoryimage;
  Categorys({required this.categoryimage, required this.categoryname});
}

List<String> carouselImages = [
  'https://images.pexels.com/photos/1000445/pexels-photo-1000445.jpeg',
  'https://images.pexels.com/photos/1679618/pexels-photo-1679618.jpeg',
  'https://images.pexels.com/photos/3182812/pexels-photo-3182812.jpeg',
];
List<String> carouselImage = [
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfFH9GI999GFGnemv_RBjRY1FySnnevAFPcg&usqp=CAU',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfFH9GI999GFGnemv_RBjRY1FySnnevAFPcg&usqp=CAU',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfFH9GI999GFGnemv_RBjRY1FySnnevAFPcg&usqp=CAU',

  // 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQxSBtzVoSGMmvxYmoFzM_hLlQCtXKywwCElA&usqp=CAU',
  // 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQxSBtzVoSGMmvxYmoFzM_hLlQCtXKywwCElA&usqp=CAU',
];

List<Map<String, dynamic>> verifiedCharities = [
  {
    'image':
        'https://www.who.int/images/default-source/health-and-climate-change/rescue-operation-haiti-flood-c-un-photo-marco-dormino.tmb-1920v.jpg',
    'category': "Disaster",
    "title": "Urgent! Help the people in Assam",
    'percetage': .6,
    'amount': 458360
  },
  {
    'image':
        'https://cwaofwa.asn.au/images/cwa_wa/events/nursing%20scholarship.jpg',
    'category': "Medical",
    'title': "Helping a small baby in kerala.",
    'percetage': .4,
    'amount': 245000
  },
];

class Users {
  static final List<String> users = [
    'akhilgeorge',
    'amalnadh',
    'asifalihussain',
    'aqifmuhd',
    'anjanavinod',
    'baskarabbas'
  ];

  static List<String> getSuggestions(String query) {
    List<String> matches = [];
    matches.addAll(users);
    matches.retainWhere(
        (users) => users.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}

List addMem = [];

List<String> addFriends = [];

class User {
  static final List<String> userss = [
    'akhilgeorge',
    'sneha',
    'asifalihussain',
    'shalfa',
    'anjanavinod',
    'baskarabbas'
  ];

  static List<String> getSuggestions(String query) {
    List<String> matches = [];
    matches.addAll(userss);
    matches.retainWhere(
        (users) => users.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}

List addMember = [];

List<String> addFriend = [];

class Item {
  String payname;
  String pic;
  Item({required this.pic, required this.payname});
}

class ItemData {
  final String Name;
  int Counter;
  bool ShouldVisible;

  ItemData(
      {required this.Name, required this.Counter, required this.ShouldVisible});
}
