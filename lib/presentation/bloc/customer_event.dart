import 'package:equatable/equatable.dart';

import '../../domain/entities/product.dart';

abstract class CustomerEvent extends Equatable {
  const CustomerEvent();

  @override
  List<Object?> get props => [];
}

class LoadProductsRequested extends CustomerEvent {
  const LoadProductsRequested();
}

class PlaceOrderRequested extends CustomerEvent {
  const PlaceOrderRequested(this.product);

  final Product product;

  @override
  List<Object?> get props => [product];
}

class ClearFeedbackRequested extends CustomerEvent {
  const ClearFeedbackRequested();
}
