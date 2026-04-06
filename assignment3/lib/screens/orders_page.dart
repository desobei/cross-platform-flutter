import 'package:flutter/material.dart';

import '../app/car_store_state.dart';
import '../models/car_store_models.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key, required this.state});

  final CarStoreState state;

  @override
  Widget build(BuildContext context) {
    final orders = state.orders;
    final theme = Theme.of(context);

    if (orders.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.receipt_long_outlined,
                size: 72,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(height: 16),
              Text(
                'No reservations yet',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Once you reserve a car from a showroom, the order will appear here.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: orders.length,
      separatorBuilder: (_, _) => const SizedBox(height: 14),
      itemBuilder: (context, index) {
        final order = orders[index];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.id,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text('${order.customerName} • ${order.pickupDateLabel}'),
                const SizedBox(height: 4),
                Text(
                  order.mode == ReservationMode.homeDelivery
                      ? 'Home delivery'
                      : 'Showroom pickup',
                ),
                const SizedBox(height: 10),
                Text(
                  order.status,
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                for (final item in order.items)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text('• ${item.car.title} (${item.packageName})'),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
