import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:products_app/models/product_model.dart';
import 'package:products_app/screens/details_product/details_product_page.dart';
import 'package:products_app/screens/home/cubit/products_cubit.dart';
import 'package:products_app/screens/search/search_page.dart';
import 'package:products_app/shared/components/components.dart';
import 'package:products_app/shared/components/custom_widgits/custom_progress_Indicator.dart';
import 'package:products_app/shared/components/custom_widgits/custom_sized_box.dart';
import 'package:products_app/shared/components/custom_widgits/custom_text.dart';
import 'package:products_app/shared/styles/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ProductsCubit.get(context);
        cubit.initalScrollController();
        return Scaffold(
          body: SafeArea(
              child: Column(
            children: [
              InkWell(
                onTap: () {
                  Get.to(SearchPage());
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  height: 50,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      Icon(Icons.search),
                      CustomSizedBox(
                        width: 5,
                      ),
                      CustomText('Search ...'),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                    controller: cubit.scrollController,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      if (index == cubit.list_products.length) {
                        return CustomProgressIndicator();
                      } else {
                        return InkWell(
                            onTap: () async {
                              ProductModel? pro = await Get.to(
                                  ProductDetailsPage(
                                      product: cubit.list_products[index]));
                              if (pro != null) {
                                cubit.list_products[index] = pro;
                              }
                            },
                            child:
                                buildProductCard(cubit.list_products[index]));
                      }
                    },
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: cubit.list_products.length + 1),
              )
            ],
          )),
        );
      },
    );
  }
}
