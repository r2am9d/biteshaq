part of 'fab_bloc.dart';

abstract class FabEvent extends Equatable {
  const FabEvent();

  @override
  List<Object> get props => [];
}

class FabToggle extends FabEvent {
  const FabToggle({this.isHidden = false});

  final bool isHidden;
}
