import 'package:equatable/equatable.dart';
import 'package:flutter_firebase_list/services/custom_firestore/dtos/user_fields_dto.dart';

class UserInfoFirestore extends Equatable {
  const UserInfoFirestore({
    required this.id,
    required this.userFieldsDTO,
  });

  final String id;
  final UserFieldsDTO userFieldsDTO;

  @override
  List<Object?> get props => [id, userFieldsDTO];
}
