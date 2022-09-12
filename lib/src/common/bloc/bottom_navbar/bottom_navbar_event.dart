part of 'bottom_navbar_bloc.dart';

abstract class BottomNavbarEvent extends Equatable {
  const BottomNavbarEvent();

  @override
  List<Object> get props => [];
}

class BottomNavbarToggle extends BottomNavbarEvent {
  const BottomNavbarToggle({this.isHidden = false});

  final bool isHidden;
}
