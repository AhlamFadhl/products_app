import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:products_app/screens/home/cubit/products_cubit.dart';
import 'package:products_app/screens/home/home_page.dart';
import 'package:products_app/shared/network/remote/dio_helper.dart';
import 'package:products_app/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (context, child) {
      return BlocProvider(
        create: (context) => ProductsCubit()..getProducts(10, 0),
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: lightTheme,
          home: const HomePage(),
        ),
      );
    });
  }
}
