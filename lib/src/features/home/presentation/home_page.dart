import 'package:flutter/material.dart';
import 'package:signal/src/features/home/domain/enums/enums.dart';
import 'package:signal/src/features/home/presentation/widgets/cards/balance_card.dart';
import 'package:signal/src/features/home/presentation/widgets/home_bar.dart';
import 'package:signal/src/features/home/presentation/widgets/lists/products_list_view.dart';
import 'package:signal/src/features/home/presentation/widgets/tab/custom_tab_bar.dart';
import 'package:signal/src/features/home/presentation/widgets/tab/tab_bar_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;

  static int get tabLength => Tracker.values.length;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabLength, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size(0, 70),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.paddingOf(context).top - 5,
            ),
            const HomeBar(),
          ],
        ),
      ),
      body: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: <Widget>[
          const BalanceCard(),
          const ProductsListView(),
          CustomTabBar(tabController: tabController),
          CustomTabBarView(tabController: tabController),
        ],
      ),
    );
  }
}
