import 'package:flutter/material.dart';

import '../app/car_store_state.dart';
import '../models/car_store_models.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key, required this.state});

  final CarStoreState state;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: state,
      builder: (context, _) {
        final orders = state.orders;
        final theme = Theme.of(context);
        final scheme = theme.colorScheme;

        if (orders.isEmpty) {
          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
            children: [
              Text(
                'Orders',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Track your reservations and delivery updates in one place.',
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 22),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 82,
                        height: 82,
                        decoration: BoxDecoration(
                          color: scheme.primary.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Icon(
                          Icons.receipt_long_outlined,
                          size: 42,
                          color: scheme.primary,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Text(
                        'No reservations yet',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Reserve a car from Discover and your order timeline will appear here.',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }

        return ListView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
          children: [
            Text(
              'Orders',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${orders.length} active reservation${orders.length == 1 ? '' : 's'}',
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  children: [
                    _SummaryDot(
                      color: scheme.primary,
                      label: 'In progress',
                      value: orders.length.toString(),
                    ),
                    const SizedBox(width: 12),
                    _SummaryDot(
                      color: scheme.secondary,
                      label: 'Delivery',
                      value: orders
                          .where(
                            (order) =>
                                order.mode == ReservationMode.homeDelivery,
                          )
                          .length
                          .toString(),
                    ),
                    const SizedBox(width: 12),
                    _SummaryDot(
                      color: scheme.tertiary,
                      label: 'Pickup',
                      value: orders
                          .where(
                            (order) =>
                                order.mode == ReservationMode.showroomPickup,
                          )
                          .length
                          .toString(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            for (final order in orders) ...[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              order.id,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              color: scheme.primary.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              child: Text(
                                order.status,
                                style: TextStyle(
                                  color: scheme.primary,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text('${order.customerName} • ${order.pickupDateLabel}'),
                      const SizedBox(height: 6),
                      Text(
                        order.mode == ReservationMode.homeDelivery
                            ? 'Home delivery'
                            : 'Showroom pickup',
                        style: TextStyle(color: scheme.onSurfaceVariant),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        'Reserved vehicles',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      for (final item in order.items)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_circle_rounded,
                                size: 16,
                                color: scheme.primary,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  '${item.car.title} (${item.packageName})',
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),
            ],
          ],
        );
      },
    );
  }
}

class _SummaryDot extends StatelessWidget {
  const _SummaryDot({
    required this.color,
    required this.label,
    required this.value,
  });

  final Color color;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: theme.textTheme.titleLarge?.copyWith(
                color: color,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 2),
            Text(label, style: theme.textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
