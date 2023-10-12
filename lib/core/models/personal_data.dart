class PersonalDataForm {

  final String? fullname;
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? gender;
  final String? department;
  final String? homeAddress;
  final int? yearOfGraduation;
  final int? sessionOfAdmission;

  // old parameters that can be used later
  String? id;
  DateTime? dateOfBirth;
  String? stateOfOrigin;
  String? localGovernmentOfOrigin;
  String? homeTown;
  String? phoneNumber;

  /// The State of residence
  String? state;
  String? localGovernment;
  String? levelOfEducation;
  String? typeOfOccupation;
  bool? isSkillful;
  String? skillDescription;
  String? employmentStatus;
  String? skill;
  String? imageUrl;
  DateTime? registrationDate;
  String? maritalStatus;
  String? senatorialDistrict;

  PersonalDataForm({
    this.fullname,
    this.firstname,
    this.lastname,
    this.email,
    this.gender,
    this.homeAddress,
    this.department,
    this.yearOfGraduation,
    this.sessionOfAdmission,
    //parameters to be used later
    this.id,
    this.dateOfBirth,
    this.stateOfOrigin,
    this.localGovernmentOfOrigin,
    this.homeTown,
    this.phoneNumber,
    this.state,
    this.localGovernment,
    this.levelOfEducation,
    this.typeOfOccupation,
    this.isSkillful,
    this.skillDescription,
    this.employmentStatus,
    this.skill,
    this.imageUrl,
    this.registrationDate,
    this.maritalStatus,
    this.senatorialDistrict,
  });

  factory PersonalDataForm.fromJson(Map<String, dynamic> json) =>
      PersonalDataForm(
        fullname: (json["firstname"] + json["lastname"]) as String,
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        gender: json["gender"],
        homeAddress: json["home_address"],
        department: json["department"],
        yearOfGraduation: json["year_of_grad"],

        // paremeters to be added later
        id: json["id"] as String,
        dateOfBirth: json["dateOfBirth"] != null
            ? DateTime.parse(json["dateOfBirth"] as String)
            : null,
        stateOfOrigin: json["stateOfOrigin"],
        localGovernmentOfOrigin: json["localGovernmentOfOrigin"],
        homeTown: json["homeTown"],
        phoneNumber: json["phoneNumber"],
        state: json["state"],
        localGovernment: json["localGovernment"],
        levelOfEducation: json["levelOfEducation"],
        typeOfOccupation: json["typeOfOccupation"],
        isSkillful: json["isSkillful"],
        skillDescription: json["skillDescription"],
        // registrationDate: (json["registrationDate"] as Timestamp).toDate(),
        // registrationDate: (json["registrationDate"] as DateTime).toDate(),
        employmentStatus: json["employmentStatus"],
        imageUrl: json["imageUrl"],
        skill: json["skill"],
        maritalStatus: json["maritalStatus"],
        senatorialDistrict: json["senatorialDistrict"],
      );

  Map<String, dynamic> _toJson() => {
        // 'fullname':fullname,
        'firstname':firstname,
        'lastname':lastname,
        'email':email,
        'gender':gender,
        'department':department,
        'home_address':homeAddress,
        'year_of_grad':yearOfGraduation,
        // 'sessionOfAdmission':sessionOfAdmission,

        //parameters that can be used later 
        'id': id,
        'dateOfBirth': dateOfBirth?.toIso8601String(),
        'stateOfOrigin': stateOfOrigin,
        'localGovernmentOfOrigin': localGovernmentOfOrigin,
        'homeTown': homeTown,
        'phone': phoneNumber,
        'state': state,
        'localGovernment': localGovernment,
        'levelOfEducation': levelOfEducation,
        'typeOfOccupation': typeOfOccupation,
        'isSkillful': isSkillful,
        'skillDescription': skillDescription,
        'registrationDate': registrationDate,
        'employmentStatus': employmentStatus,
        'imageUrl': imageUrl,
        'skill': skill,
        'maritalStatus': maritalStatus,
        'senatorialDistrict': senatorialDistrict,
      };

  Map<String, dynamic> toJson() => _toJson();

  // int numbersOfYearsSpentInSchool() => sessionOfAdmission! + yearOfGraduation!;

  @override
  String toString() {
    return 'PersonalDataForm{id: $id, fullName: $fullname, gender: $gender, dateOfBirth: $dateOfBirth, stateOfOrigin: $stateOfOrigin, localGovernmentOfOrigin: $localGovernmentOfOrigin, homeTown: $homeTown, phoneNumber: $phoneNumber, email: $email, state: $state, localGovernment: $localGovernment, levelOfEducation: $levelOfEducation, typeOfOccupation: $typeOfOccupation, isSkillful: $isSkillful, skillDescription: $skillDescription, employmentStatus: $employmentStatus, skill: $skill, imageUrl: $imageUrl, registrationDate: $registrationDate, maritalStatus: $maritalStatus, senatorialDistrict: $senatorialDistrict}';
  }
}
