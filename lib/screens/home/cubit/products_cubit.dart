import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:products_app/models/product_model.dart';
import 'package:products_app/shared/components/utils/error_handler.dart';
import 'package:products_app/shared/network/end_points.dart';
import 'package:products_app/shared/network/remote/dio_helper.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());
  static ProductsCubit get(context) => BlocProvider.of(context);

  ScrollController scrollController = ScrollController();

  initalScrollController() {
    scrollController.addListener(_scrollListener);
  }

  int perPage = 0;
  // Scroll listener
  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      // Scroll to the bottom, load more data
      getProducts(10, perPage + 10);
    }
  }

  List<ProductModel> list_products = [];
  bool isLoading = false;
  getProducts(limit, skip) async {
    isLoading = true;
    emit(ProductsLoading());
    try {
      var response = await DioHelper.getData(url: PATH_URL, query: {
        'limit': limit,
        'skip': skip,
        'select': 'id,title,price,thumbnail,discountPercentage'
      });

      if (response.statusCode == 200) {
        perPage = skip;
        List<dynamic> products = response.data['products'];
        list_products
            .addAll(products.map((e) => ProductModel.fromJson(e)).toList());
      }
      isLoading = false;
      emit(ProductsGet());
    } catch (e) {
      isLoading = false;
      emit(ProductsError());
      ErrorHandler.handleError(e);
    }
  }

  ///Search
  List<ProductModel> list_products_searched = [];
  bool isLoading_search = false;
  var controllSearch = TextEditingController();
  searchProducts(value) async {
    isLoading_search = true;
    emit(ProductsLoadingSearched());
    try {
      var response = await DioHelper.getData(url: SEARCH, query: {
        'q': value,
      });

      if (response.statusCode == 200) {
        List<dynamic> products = response.data['products'];
        list_products_searched =
            (products.map((e) => ProductModel.fromJson(e)).toList());
      }
      isLoading_search = false;
      emit(ProductsGetSearched());
    } catch (e) {
      isLoading_search = false;
      emit(ProductsErrorSearched());
      ErrorHandler.handleError(e, showToast: true);
    }
  }

  ///Edit
  var formKey = GlobalKey<FormState>();
  bool isEditLoading = false;
  var controllPrice = TextEditingController();
  Future<ProductModel?> editProductPrice(price, id) async {
    ProductModel? prod;
    isEditLoading = true;
    emit(ProductsLoadingEdit());
    try {
      var response = await DioHelper.putData(url: PATH_URL + '/$id', data: {
        'price': price,
      });

      if (response.statusCode == 200) {
        controllPrice.text = "";
        prod = ProductModel.fromJson(response.data);

        isEditLoading = false;
        emit(ProductsGetEdit(productModel: prod));
      } else {
        isEditLoading = false;
        emit(ProductsErrorEdit());
      }
    } catch (e) {
      isEditLoading = false;
      emit(ProductsErrorEdit());
      ErrorHandler.handleError(e);
    }

    return prod;
  }
}
