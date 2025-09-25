import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/images/my_rounded_image.dart';
import 'package:ecommerce/common/widgets/products/products_cards/product_card_horizontal.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: Text('Techgear'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(MySizes.defaultSpace),
          child: Column(
            children: [
              // Banner
              MyRoundedImage(
<<<<<<< HEAD
                  width: double.infinity,
                  imageUrl: MyImages.promoBanner3,
                  applyImageRadius: true),
=======
                height: 145,
                width: double.infinity,
                imageUrl: category.thumbnail ?? '',
                applyImageRadius: true,
                isNetworkImage: true,
              ),

>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
              SizedBox(height: MySizes.spaceBtwSections),

              // Sub-Categories
<<<<<<< HEAD
              FutureBuilder(
<<<<<<< HEAD
                  future: controller.getSubCategories(category.id),
                  builder: (context, snapshot) {
                    const loader = MyVerticalProductShimmer();
                    final widget = MyCloudHelperFunction.checkMultiRecorState(
                        snapshot: snapshot, loader: loader);
                    if (widget != null) return widget;
                    final subCategories = snapshot.data!;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: subCategories.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, index) {
                        final subCategory = subCategories[index];

                        return FutureBuilder(
                            future: controller.getCategoryProducts(
                                categoryId: subCategory.id),
                            builder: (context, snapshot) {
                              final widget =
                                  MyCloudHelperFunction.checkMultiRecorState(
                                      snapshot: snapshot, loader: loader);
                              if (widget != null) return widget;

                              final products = snapshot.data!;
                              return Column(
                                children: [
                                  // Heading
                                  MySectionHeading(
                                    title: subCategory.name,
                                    onPressed: () => AllProducts(
                                        title: subCategory.name,
                                        futureMethod:
                                            controller.getCategoryProducts(
                                                categoryId: subCategory.id,
                                                limit: -1)),
                                  ),
                                  const SizedBox(
                                      height: MySizes.spaceBtwItems / 2),

                                  SizedBox(
                                    height: 120,
                                    child: ListView.separated(
                                      itemCount: products.length,
                                      scrollDirection: Axis.horizontal,
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(
                                              width: MySizes.spaceBtwItems),
                                      itemBuilder: (context, index) =>
                                          MyProductCardHorizontal(
                                              product: products[index]),
                                    ),
                                  ),
                                ],
                              );
                            });
                      },
                    );
                  }),
=======
                future: controller.getSubCategories(category.id),
                builder: (context, snapshot) {
                  const loader = MyVerticalProductShimmer();
                  final widget = MyCloudHelperFunction.checkMultiRecorState(
                      snapshot: snapshot, loader: loader);
                  if (widget != null) return widget;
                  final subCategories = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: subCategories.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      final subCategory = subCategories[index];

                      return FutureBuilder(
                          future: controller.getCategoryProducts(
                              categoryId: subCategory.id),
                          builder: (context, snapshot) {
                            final widget =
                                MyCloudHelperFunction.checkMultiRecorState(
                                    snapshot: snapshot, loader: loader);
                            if (widget != null) return widget;

                            final products = snapshot.data!;
                            return Column(
                              children: [
                                // Heading
                                MySectionHeading(
                                  title: subCategory.name,
                                  onPressed: () => AllProducts(
                                    title: subCategory.name,
                                    futureMethod:
                                        controller.getCategoryProducts(
                                            categoryId: subCategory.id,
                                            limit: -1),
                                  ),
                                ),
                                const SizedBox(
                                    height: MySizes.spaceBtwItems / 2),

                                SizedBox(
                                  height: 120,
                                  child: ListView.separated(
                                    itemCount: products.length,
                                    scrollDirection: Axis.horizontal,
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                            width: MySizes.spaceBtwItems),
                                    itemBuilder: (context, index) =>
                                        MyProductCardHorizontal(
                                            product: products[index]),
                                  ),
                                ),
                              ],
                            );
                          });
                    },
                  );
                },
              ),
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
=======
              Column(
                children: [
                  //Heading
                  MySectionHeading(
                    title: 'Laptop',
                    onPressed: () {},
                  ),
                  const SizedBox(height: MySizes.spaceBtwItems / 2),

                  SizedBox(
                    height: 120,
                    child: ListView.separated(
                      itemCount: 4,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: MySizes.spaceBtwItems),
                      itemBuilder: (context, index) =>
                          const MyProductCardHorizontal(),
                    ),
                  ),
                ],
              ),
>>>>>>> parent of 450796a (restore all)
            ],
          ),
        ),
      ),
    );
  }
}
