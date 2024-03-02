import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:products_app/models/product_model.dart';
import 'package:products_app/screens/details_product/details_product_page.dart';
import 'package:products_app/screens/home/cubit/products_cubit.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:products_app/shared/components/constants.dart';
import 'package:products_app/shared/components/custom_widgits/custom_border.dart';
import 'package:products_app/shared/components/custom_widgits/custom_button_widget.dart';
import 'package:products_app/shared/components/custom_widgits/custom_shadow.dart';
import 'package:products_app/shared/components/custom_widgits/custom_image.dart';
import 'package:products_app/shared/components/custom_widgits/custom_progress_Indicator.dart';
import 'package:products_app/shared/components/custom_widgits/custom_sized_box.dart';
import 'package:products_app/shared/components/custom_widgits/custom_text.dart';
import 'package:products_app/shared/components/utils/functions.dart';
import 'package:products_app/shared/network/end_points.dart';
import 'package:products_app/shared/styles/colors.dart';
import 'package:products_app/shared/styles/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';

Widget buildProductCard(ProductModel product) => Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: CustomImage(
                url: product.thumbnail,
                fit: BoxFit.cover,
              )),
          CustomSizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  product.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 16,
                ),
                CustomSizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    CustomText(
                      '${product.price}\$',
                      fontWeight: FontWeight.bold,
                    ),
                    CustomSizedBox(
                      width: 10,
                    ),
                    CustomText(
                      '${product.discountPercentage}%',
                      color: Colors.red,
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
