part of 'cook_bloc.dart';

abstract class CookState extends Equatable {
  const CookState();

  @override
  List<Object> get props => [];
}

class CookInitial extends CookState {
  const CookInitial();
}

class CookLoading extends CookState {
  const CookLoading();
}

class CookSuccess extends CookState {
  const CookSuccess(this.data);

  final String data;
}

class CookFailure extends CookState {
  const CookFailure(this.message);

  final String? message;
}
