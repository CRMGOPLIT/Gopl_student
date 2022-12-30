class ContactModel {
  String? name;
  String? number;
  String? email;
  int? id;
  String? address;

  ContactModel(
      {this.name, this.number, this.email, this.address, required int id});
}
