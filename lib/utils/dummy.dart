List<String> carouselImages = [
  'https://images.pexels.com/photos/1000445/pexels-photo-1000445.jpeg',
  'https://images.pexels.com/photos/1679618/pexels-photo-1679618.jpeg',
  'https://images.pexels.com/photos/3182812/pexels-photo-3182812.jpeg',
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
