import 'package:flutter_firebase_list/features/signup/domain/entities/signup_request.dart';

extension SignupRequestModel on SignupRequest {
  Map<String, dynamic> toMap() => {
        'name': name,
        'email': email,
      };
}
