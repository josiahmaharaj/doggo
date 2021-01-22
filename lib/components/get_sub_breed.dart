// Get sub breed from api link

String getSubBreed(link) {
  var breed = link.substring(30);
  var slash = breed.indexOf('/');
  var sub = breed.indexOf('-');
  return (sub < 0 || sub > slash)
      ? ''
      : breed.substring(breed.indexOf('-') + 1, slash);
}
