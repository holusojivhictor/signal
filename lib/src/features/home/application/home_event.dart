part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

class HomeInit extends HomeEvent {
  @override
  List<Object?> get props => <Object?>[];
}

class HomeWalletChanged extends HomeEvent {
  HomeWalletChanged({required this.newValue});

  final WalletType? newValue;

  @override
  List<Object?> get props => <Object?>[newValue];
}
