import 'package:flutter_firebase_list/services/custom_firestore/dtos/user_fields_dto.dart';

class UserInfoFirestore {
  UserInfoFirestore({
    required this.id,
    required this.userFieldsDTO,
  });

  final String id;
  final UserFieldsDTO userFieldsDTO;
}
