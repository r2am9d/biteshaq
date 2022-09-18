part of 'appbar_bloc.dart';

abstract class AppbarEvent extends Equatable {
  const AppbarEvent();

  @override
  List<Object> get props => [];
}

class AppbarToggle extends AppbarEvent {
  const AppbarToggle({this.isHidden = false});

  final bool isHidden;
}
