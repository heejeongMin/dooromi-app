class User {
  String name;
  String phoneNumber;
  String birthdate;
  String address;
  String nationality;

  User(this.name, this.phoneNumber, this.birthdate, this.address, this.nationality);

  setName(name) {
    this.name = name;
  }

  setPhoneNumber(phoneNumber) {
    this.phoneNumber = phoneNumber;
  }

  setBirthdate(birthdate) {
    this.birthdate = birthdate;
  }

  setAddress(address) {
    this.address = address;
  }

  setNationality(nationality) {
    this.nationality = nationality;
  }

  String get getName => name;
  String get getPhoneNumber => phoneNumber;
  String get getBirthdate => birthdate;
  String get getAddress => address;
  String get getNationality => nationality;
}