import 'package:equatable/equatable.dart';

class SignupRequest extends Equatable {
  final String name;
  final String email;
  final String phone;

  const SignupRequest({
    required this.name,
    required this.email,
    required this.phone,
  });

  @override
  List<Object?> get props => [name, email, phone];
}
