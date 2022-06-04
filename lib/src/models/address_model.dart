class AddressModel {
  String street, suite, city, zipcode;

  AddressModel(this.street, this.suite, this.city, this.zipcode);

  AddressModel.fromJson(parsedJson)
      : street = parsedJson["street"] ?? "NO street FROM API",
        suite = parsedJson["suite"] ?? "NO suite FROM API",
        city = parsedJson["city"] ?? "NO city FROM API",
        zipcode = parsedJson["zipcode"] ?? "NO zipcode FROM API";

  @override
  String toString() {
    return "$street, $suite, $city ($zipcode)";
  }
}
