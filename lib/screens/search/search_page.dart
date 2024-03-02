import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_app/screens/home/cubit/products_cubit.dart';
import 'package:products_app/shared/components/components.dart';
import 'package:products_app/shared/components/constants.dart';
import 'package:products_app/shared/components/custom_widgits/custom_progress_Indicator.dart';
import 'package:products_app/shared/components/custom_widgits/custom_text_field.dart';
import 'package:products_app/shared/components/utils/functions.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = ProductsCubit.get(context);
    return BlocConsumer<ProductsCubit, ProductsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Search'),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomTextField(
                  controller: cubit.controllSearch,
                  onFieldSubmitted: (value) {
                    if (value.isNotEmpty) {
                      cubit.searchProducts(value);
                    } else {
                      showToast(
                          text: 'Type anything to search',
                          state: ToastStates.WARNING);
                    }
                  },
                  hintText: 'Search for products',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              Expanded(
                child: cubit.isLoading_search
                    ? CustomProgressIndicator()
                    : ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) => buildProductCard(
                            cubit.list_products_searched[index]),
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: cubit.list_products_searched.length),
              )
            ],
          ),
        );
      },
    );
  }
}
