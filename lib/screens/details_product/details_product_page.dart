import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:products_app/models/product_model.dart';
import 'package:products_app/screens/home/cubit/products_cubit.dart';
import 'package:products_app/shared/components/components.dart';
import 'package:products_app/shared/components/custom_widgits/custom_button_widget.dart';
import 'package:products_app/shared/components/custom_widgits/custom_text_field.dart';

class ProductDetailsPage extends StatelessWidget {
  ProductModel product;
  ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    var cubit = ProductsCubit.get(context);
    cubit.controllPrice.text = product.price.toString();
    return BlocConsumer<ProductsCubit, ProductsState>(
      listener: (context, state) {
        if (state is ProductsGetEdit) {
          Get.back(result: state.productModel);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Edit Price'),
          ),
          body: Column(
            children: [
              buildProductCard(product),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomTextField(
                  controller: cubit.controllPrice,
                  keyboardType: TextInputType.number,
                  prefixIcon: Icon(Icons.monetization_on),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomButtonWidget(
                  title: 'Edit',
                  onTap: () async {
                    cubit.editProductPrice(
                        cubit.controllPrice.text, product.id);
                  },
                  loading: cubit.isEditLoading,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
