class PersonalDataForm {

  final String? fullname;
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? phoneNumber;
  final String? gender;
  // final Institution? zone;
  final String? zone;
  final String? fellowshipName;
  final String? unit;
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
    this.fellowshipName,
    this.unit,
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
        id: json["id"] as String?,
        fullname: json["fullname"] as String?,
        firstname: json["firstname"] as String?,
        lastname: json["lastname"] as String?,
        email: json["email"] as String?,
        phoneNumber: json["phoneNumber"] as String?,
        gender: json["gender"] as String?,
        zone: json["zone"] as String?,
        fellowshipName: json['fellowshipName'] as String?,
        unit: json["unit"] as String?,
        portfolio: json['portfolio'] as String?,
        uuid: json['uuid'] as String?,
        imageUrl: json["imageUrl"] as String?,

        // paremeters to be added later
        attending: json['attending'] as bool?,
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
        'fellowshipName':fellowshipName,
        'unit':unit,
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
