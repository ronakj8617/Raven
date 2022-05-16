import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class Contact_Model {
  late final String? phoneNumber;
  late final String? name;
  late final String? dateOfBirth;
  late final String? emailId;
  late final String? status;
  late final String? imageUrl;
  late final String? dateOfJoining;
  late final String? timeOfJoining;
  late final bool isAccountActive;
  late final bool isAccountDeleted;
  late final bool isAccountBanned;

  get getIsAccountActive => this.isAccountActive;

  set setIsAccountActive(isAccountActive) =>
      this.isAccountActive = isAccountActive;

  get getIsAccountDeleted => this.isAccountDeleted;

  set setIsAccountDeleted(isAccountDeleted) =>
      this.isAccountDeleted = isAccountDeleted;

  get getIsAccountBanned => this.isAccountBanned;

  set setIsAccountBanned(isAccountBanned) =>
      this.isAccountBanned = isAccountBanned;

  String? get getPhoneNumber => this.phoneNumber;

  set setPhoneNumber(String? phoneNumber) => this.phoneNumber = phoneNumber;

  get getName => this.name;

  set setName(name) => this.name = name;

  get getDateOfBirth => this.dateOfBirth;

  set setDateOfBirth(dateOfBirth) => this.dateOfBirth = dateOfBirth;

  get getEmailId => this.emailId;

  set setEmailId(emailId) => this.emailId = emailId;

  get getStatus => this.status;

  set setStatus(status) => this.status = status;

  get getImageUrl => this.imageUrl;

  set setImageUrl(imageUrl) => this.imageUrl = imageUrl;

  get getDateOfJoining => this.dateOfJoining;

  set setDateOfJoining(dateOfJoining) => this.dateOfJoining = dateOfJoining;
  get getTimeOfJoining => this.timeOfJoining;

  set setTimeOfJoining(timeOfJoining) => this.timeOfJoining = timeOfJoining;

  Contact_Model({
    required this.phoneNumber,
    required this.name,
    required this.dateOfBirth,
    required this.emailId,
    required this.status,
    required this.imageUrl,
    required this.dateOfJoining,
    required this.isAccountActive,
    required this.isAccountBanned,
    required this.isAccountDeleted,
    required this.timeOfJoining,
  });

  Map<String,dynamic> toJson(Contact_Model contact_model) => {
        'phoneNumber': contact_model.phoneNumber,
        'name': contact_model.name,
        'emailId': contact_model.emailId,
        'status': contact_model.status,
        'dateOfBirth': contact_model.dateOfBirth,
        'imageUrl': contact_model.imageUrl,
        'isAccountDeleted': contact_model.isAccountDeleted,
        'isAccountActive': contact_model.isAccountActive,
        'isAccountBanned': contact_model.isAccountBanned,
        'dateOfJoining': contact_model.dateOfJoining,
        'timeOfJoining': contact_model.timeOfJoining
      };

  factory Contact_Model.fromJson(Map<Object?, Object?> data) {
    // note the explicit cast to String
    // this is required if robust lint rules are enabled
    final phoneNumber = data['phoneNumber'] as String;
    final name = data['name'] as String;
    final emailId = data['emailId'] as String;
    final status = data['status'] as String;
    final dateOfBirth = data['dateOfBirth'] as String;
    final imageUrl = data['imageUrl'] as String;
    final dateOfJoining = data['dateOfJoining'] as String;
    final timeOfJoining = data['timeOfJoining'] as String;
    final isAccountActive = data['isAccountActive'] as bool;
    final isAccountBanned = data['isAccountBanned'] as bool;
    final isAccountDeleted = data['isAccountDeleted'] as bool;

    return Contact_Model(
        phoneNumber: phoneNumber,
        name: name,
        emailId: emailId,
        status: status,
        dateOfBirth: dateOfBirth,
        imageUrl: imageUrl,
        dateOfJoining: dateOfJoining,
        timeOfJoining: timeOfJoining,
        isAccountActive: isAccountActive,
        isAccountBanned: isAccountBanned,
        isAccountDeleted: isAccountDeleted);
  }
}
