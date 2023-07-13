part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    required this.balance,
    required this.wallet,
    required this.products,
  });

  const HomeState.init()
      : balance = 0,
        wallet = WalletType.binance,
        products = const <Product>[];

  final double balance;
  final WalletType wallet;
  final List<Product> products;

  HomeState copyWith({
    double? balance,
    WalletType? wallet,
    List<Product>? products,
  }) {
    return HomeState(
      balance: balance ?? this.balance,
      wallet: wallet ?? this.wallet,
      products: products ?? this.products,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    balance,
    wallet,
    products,
  ];
}
