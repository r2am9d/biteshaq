part of 'fab_bloc.dart';

abstract class FabState extends Equatable {
  const FabState();

  @override
  List<Object> get props => [];
}

class FabInitial extends FabState {
  const FabInitial();
}

class FabLoading extends FabState {
  const FabLoading();
}

class FabSuccess extends FabState {
  const FabSuccess();
}

class FabFailure extends FabState {
  const FabFailure();
}

class FabShown extends FabState {
  const FabShown();
}

class FabHidden extends FabState {
  const FabHidden();
}
