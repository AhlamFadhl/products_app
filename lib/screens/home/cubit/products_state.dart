part of 'products_cubit.dart';

abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsGet extends ProductsState {}

class ProductsError extends ProductsState {}

//Search
class ProductsLoadingSearched extends ProductsState {}

class ProductsGetSearched extends ProductsState {}

class ProductsErrorSearched extends ProductsState {}

//Edit
class ProductsLoadingEdit extends ProductsState {}

class ProductsGetEdit extends ProductsState {
  ProductModel productModel;
  ProductsGetEdit({required this.productModel});
}

class ProductsErrorEdit extends ProductsState {}
