import '../entities/product.dart';
import '../repositories/customer_repository.dart';

class PlaceOrder {
  const PlaceOrder(this.repository);

  final CustomerRepository repository;

  Future<String> call(Product product) => repository.placeOrder(product);
}
