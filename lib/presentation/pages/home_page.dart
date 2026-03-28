import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/product.dart';
import '../bloc/customer_bloc.dart';
import '../bloc/customer_event.dart';
import '../bloc/customer_state.dart';
import '../widgets/product_card.dart';
import 'product_detail_page.dart';
import 'profile_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Arwika Customer'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(ProfilePage.routeName),
            icon: const Icon(Icons.account_circle_outlined),
            tooltip: 'Profile',
          ),
        ],
      ),
      body: BlocConsumer<CustomerBloc, CustomerState>(
        listenWhen: (previous, current) =>
            previous.feedbackMessage != current.feedbackMessage &&
            current.feedbackMessage != null,
        listener: (context, state) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text(state.feedbackMessage ?? 'Done'),
              ),
            );
          context.read<CustomerBloc>().add(const ClearFeedbackRequested());
        },
        builder: (context, state) {
          if (state.status == CustomerStatus.loading ||
              state.status == CustomerStatus.initial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == CustomerStatus.error) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(state.errorMessage ?? 'Something went wrong'),
                  const SizedBox(height: 12),
                  FilledButton.icon(
                    onPressed: () => context.read<CustomerBloc>().add(
                      const LoadProductsRequested(),
                    ),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return _ProductContent(products: state.products);
        },
      ),
    );
  }
}

class _ProductContent extends StatelessWidget {
  const _ProductContent({required this.products});

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final crossAxisCount = width >= 1100
            ? 4
            : width >= 750
            ? 3
            : width >= 520
            ? 2
            : 1;
        final itemAspectRatio = crossAxisCount == 1 ? 1.2 : 0.72;

        return RefreshIndicator(
          onRefresh: () async {
            context.read<CustomerBloc>().add(const LoadProductsRequested());
          },
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(
                            context,
                          ).colorScheme.primary.withValues(alpha: 0.95),
                          Theme.of(context).colorScheme.primaryContainer
                              .withValues(alpha: 0.95),
                        ],
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Discover Products',
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onPrimary,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                '${products.length} local items ready to order',
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary
                                          .withValues(alpha: 0.9),
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.storefront_rounded,
                          color: Theme.of(context).colorScheme.onPrimary,
                          size: 32,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                sliver: SliverGrid.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: itemAspectRatio,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return TweenAnimationBuilder<double>(
                      duration: Duration(milliseconds: 220 + (index * 40)),
                      curve: Curves.easeOut,
                      tween: Tween(begin: 0, end: 1),
                      builder: (context, value, child) => Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 12 * (1 - value)),
                          child: child,
                        ),
                      ),
                      child: ProductCard(
                        product: product,
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            ProductDetailPage.routeName,
                            arguments: product,
                          );
                        },
                        onOrder: () {
                          context.read<CustomerBloc>().add(
                            PlaceOrderRequested(product),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
