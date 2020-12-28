class Breeds{
  String status;
  Breed message;

  Breeds({
    this.status,
    this.message
});

  factory Breeds.fromJson(Map<String, dynamic> parsedJson){
    return Breeds(
      status: parsedJson['status'],
      message: Breed.fromJson(parsedJson['message'])
    );
  }
}


class Breed extends Object{
  List<String> breed;

  factory Breed.fromJson(Map<String, dynamic> parsedJson){
    var breedFromJson = parsedJson['message'];
  }
}

