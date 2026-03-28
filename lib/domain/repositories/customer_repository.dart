import '../entities/product.dart';

abstract class CustomerRepository {
  Future<List<Product>> getProducts();
  Future<String> placeOrder(Product product);
}
