import '../../domain/entities/product.dart';
import '../../domain/repositories/customer_repository.dart';
import '../datasources/local_product_data_source.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  CustomerRepositoryImpl(this.dataSource);

  final LocalProductDataSource dataSource;

  @override
  Future<List<Product>> getProducts() => dataSource.getProducts();

  @override
  Future<String> placeOrder(Product product) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    return 'Order placed successfully';
  }
}
