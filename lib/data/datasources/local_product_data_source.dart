import '../../domain/entities/product.dart';

class LocalProductDataSource {
  final List<Product> _products = const [
    Product(
      id: '1',
      name: 'Arabica Coffee Beans',
      description: 'Premium arabica beans with rich aroma and smooth flavor.',
      price: 12.99,
      imageUrl: 'https://picsum.photos/seed/arwika1/1200/800',
    ),
    Product(
      id: '2',
      name: 'Organic Honey',
      description: 'Natural forest honey harvested sustainably.',
      price: 8.75,
      imageUrl: 'https://picsum.photos/seed/arwika2/1200/800',
    ),
    Product(
      id: '3',
      name: 'Handmade Soap',
      description: 'Gentle handmade soap with lavender extract.',
      price: 4.50,
      imageUrl: 'https://picsum.photos/seed/arwika3/1200/800',
    ),
    Product(
      id: '4',
      name: 'Brown Rice',
      description: 'Healthy whole-grain brown rice from local farmers.',
      price: 6.20,
      imageUrl: 'https://picsum.photos/seed/arwika4/1200/800',
    ),
    Product(
      id: '5',
      name: 'Fresh Almonds',
      description: 'Crunchy premium almonds packed with nutrients.',
      price: 10.40,
      imageUrl: 'https://picsum.photos/seed/arwika5/1200/800',
    ),
    Product(
      id: '6',
      name: 'Green Tea Pack',
      description: 'Refreshing green tea leaves for a daily detox.',
      price: 7.30,
      imageUrl: 'https://picsum.photos/seed/arwika6/1200/800',
    ),
    Product(
      id: '7',
      name: 'Coconut Oil',
      description: 'Cold-pressed coconut oil for cooking and skincare.',
      price: 9.90,
      imageUrl: 'https://picsum.photos/seed/arwika7/1200/800',
    ),
    Product(
      id: '8',
      name: 'Dried Mango',
      description: 'Sweet and chewy dried mango slices.',
      price: 5.60,
      imageUrl: 'https://picsum.photos/seed/arwika8/1200/800',
    ),
    Product(
      id: '9',
      name: 'Granola Mix',
      description: 'Nutritious granola with nuts and dried fruits.',
      price: 11.15,
      imageUrl: 'https://picsum.photos/seed/arwika9/1200/800',
    ),
    Product(
      id: '10',
      name: 'Herbal Shampoo',
      description: 'Mild herbal shampoo suitable for daily use.',
      price: 13.00,
      imageUrl: 'https://picsum.photos/seed/arwika10/1200/800',
    ),
  ];

  Future<List<Product>> getProducts() async {
    await Future<void>.delayed(const Duration(milliseconds: 900));
    return _products;
  }
}
