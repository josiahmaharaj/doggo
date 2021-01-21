class Dogs {
  final List breeds;
  final String status;

  Dogs({this.breeds, this.status});

  factory Dogs.fromJson(Map<String, dynamic> json) {
    List breeds = [];
    var dogCeoJson = json['message'];
    for (var key in dogCeoJson.keys) breeds.add(key);
    // Map<String,List> map = linkedHashMap.map((a, b) => MapEntry(a as String, b as List));

    return Dogs(breeds: breeds, status: json['status']);
  }
}
