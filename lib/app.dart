import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/datasources/local_product_data_source.dart';
import 'data/repositories/customer_repository_impl.dart';
import 'domain/entities/product.dart';
import 'domain/usecases/get_products.dart';
import 'domain/usecases/place_order.dart';
import 'presentation/bloc/customer_bloc.dart';
import 'presentation/bloc/customer_event.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/product_detail_page.dart';
import 'presentation/pages/profile_page.dart';
import 'presentation/pages/splash_page.dart';

class ArwikaCustomerApp extends StatelessWidget {
  const ArwikaCustomerApp({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = CustomerRepositoryImpl(LocalProductDataSource());

    return MultiBlocProvider(
      providers: [
        BlocProvider<CustomerBloc>(
          create: (_) => CustomerBloc(
            getProducts: GetProducts(repository),
            placeOrder: PlaceOrder(repository),
          )..add(const LoadProductsRequested()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Arwika Customer',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF3A6DFF),
            brightness: Brightness.light,
          ),
          scaffoldBackgroundColor: const Color(0xFFF6F7FB),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
          ),
          cardTheme: const CardThemeData(
            elevation: 0,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          ),
          filledButtonTheme: FilledButtonThemeData(
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),
        initialRoute: SplashPage.routeName,
        onGenerateRoute: (settings) {
          Widget page;
          switch (settings.name) {
            case SplashPage.routeName:
              page = const SplashPage();
              break;
            case HomePage.routeName:
              page = const HomePage();
              break;
            case ProductDetailPage.routeName:
              page = ProductDetailPage(product: settings.arguments as Product);
              break;
            case ProfilePage.routeName:
              page = const ProfilePage();
              break;
            default:
              page = const SplashPage();
          }
          return PageRouteBuilder<void>(
            settings: settings,
            transitionDuration: const Duration(milliseconds: 320),
            pageBuilder: (context, animation, secondaryAnimation) =>
                FadeTransition(
                  opacity: CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutCubic,
                  ),
                  child: SlideTransition(
                    position:
                        Tween<Offset>(
                          begin: const Offset(0.03, 0),
                          end: Offset.zero,
                        ).animate(
                          CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeOutCubic,
                          ),
                        ),
                    child: page,
                  ),
                ),
          );
        },
      ),
    );
  }
}
