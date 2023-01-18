part of 'cook_bloc.dart';

abstract class CookEvent extends Equatable {
  const CookEvent();

  @override
  List<Object> get props => [];
}

class CookFetch extends CookEvent {
  const CookFetch({this.request = ''});

  final dynamic request;
}
