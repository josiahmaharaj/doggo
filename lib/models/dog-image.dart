class DogImage {
  final List imageLinks;
  final String status;

  DogImage({this.imageLinks, this.status});

  factory DogImage.fromJson(Map<String, dynamic> json) {
    var dogCeoJson = json['message'];
    List<String> imageList = new List<String>.from(dogCeoJson);

    return DogImage(imageLinks: imageList, status: json['status']);
  }
}
