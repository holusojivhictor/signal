import 'dart:math' as math;

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signal/src/features/home/domain/enums/enums.dart';
import 'package:signal/src/features/home/domain/models/models.dart';
import 'package:signal/src/features/home/infrastructure/wallet_service.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._walletService) : super(const HomeState.init()) {
    on<HomeInit>(_onInit);
    on<HomeWalletChanged>(_onWalletChanged);
  }

  final WalletService _walletService;

  Future<void> _onInit(HomeInit event, Emitter<HomeState> emit) async {
    final balance = math.Random().nextDouble() * 15000.0;
    final products = await _walletService.getProducts();
    emit(state.copyWith(balance: balance, products: products));
  }

  void _onWalletChanged(HomeWalletChanged event, Emitter<HomeState> emit) {
    if (event.newValue == null) return;
    if (state.wallet == event.newValue) return;
    emit(state.copyWith(wallet: event.newValue));
  }
}
