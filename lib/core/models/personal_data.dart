import 'package:cloud_firestore/cloud_firestore.dart';

class PersonalDataForm {

  final String? fullname;
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? phoneNumber;
  final String? gender;
  final String? zone;
  final String? unit;
  final String? workerOrExec;
  final String? portfolio;
  final String? uuid;

  // old parameters that can be used later
  final String? id;
  final String? imageUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? attending;

  PersonalDataForm({
    this.fullname,
    this.firstname,
    this.lastname,
    this.email,
    this.phoneNumber,
    this.gender,
    this.zone,
    this.unit,
    this.workerOrExec,
    this.portfolio,
    //parameters to be used later
    this.id,
    this.uuid,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
    this.attending
  });

  factory PersonalDataForm.fromJson(Map<String, dynamic> json) =>
      PersonalDataForm(
        id: json["id"] as String,
        fullname: (json["fullname"]) as String,
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        gender: json["gender"],
        zone: json["zone"],
        unit: json["unit"],
        workerOrExec: json["workerOrExec"],
        portfolio: json['portfolio'],
        uuid: json['uuid'],
        imageUrl: json["imageUrl"],

        // paremeters to be added later
        attending: json['attending'],
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"] as String)
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"] as String)
            : null,
        // createdAt: (json["createdAt"] as Timestamp).toDate(),
        // updatedAt: (json["updatedAt"] as Timestamp).toDate(),
      );

  Map<String, dynamic> _toJson() => {
        'fullname':fullname,
        'firstname':firstname,
        'lastname':lastname,
        'email':email,
        'phoneNumber': phoneNumber,
        'gender':gender,
        'zone':zone,
        'unit':unit,
        'workerOrExec':workerOrExec,
        'portfolio':portfolio,
        'uuid':uuid,
        'imageUrl': imageUrl,
        'attending':attending,

        //parameters that can be used later 
        'id': id,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };

  Map<String, dynamic> toJson() => _toJson();


  @override
  String toString() {
    return 'PersonalDataForm{id: $id, fullname: $fullname, gender: $gender, phoneNumber: $phoneNumber, email: $email, imageUrl: $imageUrl, updatedAt: $updatedAt,createdAt: $createdAt,}';
  }
}
