String getSubBreed(link) {
  var breed = link.substring(30);
  var slash = breed.indexOf('/');
  var sub = breed.indexOf('-');
  return sub < 0 ? '' : breed.substring(breed.indexOf('-') + 1, slash);
}
