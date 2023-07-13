import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signal/src/extensions/extensions.dart';
import 'package:signal/src/features/common/domain/assets.dart';
import 'package:signal/src/features/common/presentation/images/svg_asset.dart';
import 'package:signal/src/features/common/presentation/styles.dart';
import 'package:signal/src/features/home/application/home_bloc.dart';
import 'package:signal/src/features/home/domain/enums/enums.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SliverToBoxAdapter(
      child: Container(
        height: 200,
        margin: Styles.edgeInsetHorizontal16,
        padding: Styles.edgeInsetAll16,
        decoration: const BoxDecoration(
          borderRadius: Styles.defaultBorderRadius,
          image: DecorationImage(
            opacity: 0.4,
            image: AssetImage(Assets.noise),
            fit: BoxFit.fill,
          ),
          gradient: Styles.homeCardGradient,
        ),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (ctx, state) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Wallet',
                    style: textTheme.bodyLarge,
                  ),
                  Container(
                    padding: Styles.edgeInsetHorizontal10,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: Styles.stadiumBorder,
                    ),
                    child: DropdownButton<WalletType>(
                      value: state.wallet,
                      underline: const SizedBox.shrink(),
                      dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                      items: WalletType.values.map((WalletType val) {
                        return DropdownMenuItem<WalletType>(
                          value: val,
                          child: Row(
                            children: <Widget>[
                              SvgAsset(image: val.asset),
                              const SizedBox(width: 5),
                              Text(
                                val.name.capitalize,
                                style: textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (val) => context
                          .read<HomeBloc>()
                          .add(HomeWalletChanged(newValue: val)),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Account Balance',
                    style: textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 10),
                  Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        const TextSpan(text: r'$ '),
                        TextSpan(text: state.balance.toStringAsFixed(2)),
                      ],
                    ),
                    style: textTheme.headlineSmall!.copyWith(
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
