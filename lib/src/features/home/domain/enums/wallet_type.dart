import 'package:signal/src/features/common/domain/assets.dart';

enum WalletType {
  binance,
  bitcoin,
  coinbase;

  String get asset {
    switch(this) {
      case WalletType.binance:
        return Assets.binance;
      case WalletType.bitcoin:
        return Assets.bitcoin;
      case WalletType.coinbase:
        return Assets.bitcoin;
    }
  }
}
