part of 'appbar_bloc.dart';

abstract class AppbarState extends Equatable {
  const AppbarState();

  @override
  List<Object> get props => [];
}

class AppbarInitial extends AppbarState {
  const AppbarInitial();
}

class AppbarLoading extends AppbarState {
  const AppbarLoading();
}

class AppbarSuccess extends AppbarState {
  const AppbarSuccess();
}

class AppbarFailure extends AppbarState {
  const AppbarFailure();
}

class AppbarShown extends AppbarState {
  const AppbarShown();
}

class AppbarHidden extends AppbarState {
  const AppbarHidden();
}
