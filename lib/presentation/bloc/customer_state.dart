import 'package:equatable/equatable.dart';

import '../../domain/entities/product.dart';

enum CustomerStatus { initial, loading, loaded, error }

class CustomerState extends Equatable {
  const CustomerState({
    this.status = CustomerStatus.initial,
    this.products = const [],
    this.feedbackMessage,
    this.errorMessage,
  });

  final CustomerStatus status;
  final List<Product> products;
  final String? feedbackMessage;
  final String? errorMessage;

  CustomerState copyWith({
    CustomerStatus? status,
    List<Product>? products,
    String? feedbackMessage,
    String? errorMessage,
    bool clearFeedback = false,
    bool clearError = false,
  }) {
    return CustomerState(
      status: status ?? this.status,
      products: products ?? this.products,
      feedbackMessage: clearFeedback
          ? null
          : (feedbackMessage ?? this.feedbackMessage),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [status, products, feedbackMessage, errorMessage];
}
