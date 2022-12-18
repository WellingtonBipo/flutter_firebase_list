import 'package:equatable/equatable.dart';

class SignupRequest extends Equatable {
  const SignupRequest({
    required this.name,
    required this.email,
  });

  final String name;
  final String email;

  @override
  List<Object?> get props => [name, email];
}
