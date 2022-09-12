part of 'bottom_navbar_bloc.dart';

abstract class BottomNavbarState extends Equatable {
  const BottomNavbarState();

  @override
  List<Object> get props => [];
}

class BottomNavbarInitial extends BottomNavbarState {
  const BottomNavbarInitial();
}

class BottomNavbarLoading extends BottomNavbarState {
  const BottomNavbarLoading();
}

class BottomNavbarSuccess extends BottomNavbarState {
  const BottomNavbarSuccess();
}

class BottomNavbarFailure extends BottomNavbarState {
  const BottomNavbarFailure();
}

class BottomNavbarShown extends BottomNavbarState {
  const BottomNavbarShown();
}

class BottomNavbarHidden extends BottomNavbarState {
  const BottomNavbarHidden();
}
