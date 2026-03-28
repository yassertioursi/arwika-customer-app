import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_products.dart';
import '../../domain/usecases/place_order.dart';
import 'customer_event.dart';
import 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  CustomerBloc({required this.getProducts, required this.placeOrder})
    : super(const CustomerState()) {
    on<LoadProductsRequested>(_onLoadProductsRequested);
    on<PlaceOrderRequested>(_onPlaceOrderRequested);
    on<ClearFeedbackRequested>(_onClearFeedbackRequested);
  }

  final GetProducts getProducts;
  final PlaceOrder placeOrder;

  Future<void> _onLoadProductsRequested(
    LoadProductsRequested event,
    Emitter<CustomerState> emit,
  ) async {
    emit(state.copyWith(status: CustomerStatus.loading, clearError: true));
    try {
      final products = await getProducts();
      emit(
        state.copyWith(
          status: CustomerStatus.loaded,
          products: products,
          clearError: true,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: CustomerStatus.error,
          errorMessage: 'Failed to load products',
        ),
      );
    }
  }

  Future<void> _onPlaceOrderRequested(
    PlaceOrderRequested event,
    Emitter<CustomerState> emit,
  ) async {
    final message = await placeOrder(event.product);
    emit(state.copyWith(feedbackMessage: message));
  }

  void _onClearFeedbackRequested(
    ClearFeedbackRequested event,
    Emitter<CustomerState> emit,
  ) {
    emit(state.copyWith(clearFeedback: true));
  }
}
