import 'package:equatable/equatable.dart';

class Home extends Equatable {
  const Home({
    required this.myString,
  });

  final String myString;

  @override
  List<Object?> get props => [myString];
}
