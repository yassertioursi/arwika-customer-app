import '../entities/product.dart';
import '../repositories/customer_repository.dart';

class GetProducts {
  const GetProducts(this.repository);

  final CustomerRepository repository;

  Future<List<Product>> call() => repository.getProducts();
}
