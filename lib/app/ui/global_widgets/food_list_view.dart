import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:xin9k/app/controllers/product_controller.dart';
import 'package:xin9k/app/data/models/product.dart';
import 'package:xin9k/app/ui/global_widgets/custom_page_route.dart';
import 'package:xin9k/core/app_style.dart';

import 'package:xin9k/core/app_color.dart';
import 'package:xin9k/core/app_extension.dart';

import 'package:xin9k/src/view/screen/product_detail_screen.dart';

final ProductController controller = Get.put(ProductController());

class ProductListView extends StatelessWidget {
  const ProductListView({
    Key? key,
    required this.products,
    this.isReversedList = false,
  }) : super(key: key);

  final List<Product> products;
  final bool isReversedList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(top: 20, left: 10),
      scrollDirection: Axis.vertical,
      itemCount: isReversedList ? 3 : products.length,
      itemBuilder: (_, index) {
        Product product = isReversedList
            ? products.reversed.toList()[index]
            : products[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              CustomPageRoute(child: ProductDetailScreen(product: product)),
            );
          },
          child: Container(
            width: 160,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: controller.isLightTheme
                  ? Colors.white
                  : DarkThemeColor.primaryLight,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(product.imgUrl, scale: 6),
                  Text(
                    "\$${product.salePrice}",
                    style: h3Style.copyWith(color: LightThemeColor.accent),
                  ),
                  Text(
                    product.name ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ).fadeAnimation(0.7),
            ),
          ),
        );
      },
      separatorBuilder: (_, __) {
        return const Padding(padding: EdgeInsets.only(bottom: 30));
      },
    );
  }
}
