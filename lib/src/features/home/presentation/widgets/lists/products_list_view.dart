import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signal/src/features/common/presentation/styles.dart';
import 'package:signal/src/features/home/application/home_bloc.dart';
import 'package:signal/src/features/home/presentation/widgets/cards/product_card.dart';

class ProductsListView extends StatefulWidget {
  const ProductsListView({super.key});

  @override
  State<ProductsListView> createState() => _ProductsListViewState();
}

class _ProductsListViewState extends State<ProductsListView> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (ctx, state) => SliverToBoxAdapter(
        child: SizedBox(
          height: 160,
          child: Padding(
            padding: Styles.edgeInsetHorizontal16,
            child: Scrollbar(
              thickness: 2,
              controller: scrollController,
              radius: const Radius.circular(8),
              thumbVisibility: true,
              trackVisibility: true,
              child: ListView.builder(
                itemCount: state.products.length,
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                padding: Styles.edgeInsetVertical10,
                itemBuilder: (context, index) {
                  final item = state.products[index];
                  return ProductCard(width: 110, item: item);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
