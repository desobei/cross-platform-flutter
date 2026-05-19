import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app/car_store_state.dart';
import '../models/car_store_models.dart';
import '../widgets/car_store_bottom_nav.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key, required this.tab, required this.state});

  final CarStoreTab tab;
  final CarStoreState state;

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _nameController = TextEditingController(text: 'Alex Driver');
  ReservationMode _mode = ReservationMode.homeDelivery;
  String _selectedDate = 'Select Date';
  String _selectedTime = 'Select Time';
  bool _submitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final items = widget.state.reservationItems;
    final total = items.fold<int>(0, (sum, item) => sum + item.car.price);

    return Scaffold(
      appBar: AppBar(title: const Text('Order Details')),
      bottomNavigationBar: CarStoreBottomNav(
        state: widget.state,
        currentTab: widget.tab,
        action: SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: items.isEmpty || _submitting
                ? null
                : () async {
                    setState(() {
                      _submitting = true;
                    });

                    await widget.state.submitOrder(
                      customerName: _nameController.text,
                      mode: _mode,
                      pickupDateLabel:
                          _selectedDate == 'Select Date' ||
                              _selectedTime == 'Select Time'
                          ? 'Date/time pending'
                          : '$_selectedDate · $_selectedTime',
                    );
                    if (context.mounted) {
                      context.go('/home?tab=${CarStoreTab.orders.queryValue}');
                    }
                  },
            child: Text(
              _submitting
                  ? 'Saving order...'
                  : 'Submit order - \$${_formatPrice(total)}',
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 18),
        children: [
          Text(
            'Order Details',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 14),
          SegmentedButton<ReservationMode>(
            segments: const [
              ButtonSegment(
                value: ReservationMode.homeDelivery,
                icon: Icon(Icons.pedal_bike_rounded),
                label: Text('Delivery'),
              ),
              ButtonSegment(
                value: ReservationMode.showroomPickup,
                icon: Icon(Icons.shopping_bag_outlined),
                label: Text('Pickup'),
              ),
            ],
            selected: {_mode},
            onSelectionChanged: (selection) {
              setState(() {
                _mode = selection.first;
              });
            },
          ),
          const SizedBox(height: 22),
          Text('Contact Name', style: theme.textTheme.titleMedium),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              isDense: true,
              border: UnderlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              TextButton(
                onPressed: _pickDate,
                child: Text(
                  _selectedDate,
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              TextButton(
                onPressed: _pickTime,
                child: Text(
                  _selectedTime,
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Order Summary',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          if (items.isEmpty)
            const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text('No cars in cart yet.'),
            ),
          for (final grouped in _groupItems(items))
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: theme.colorScheme.primary),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'x${grouped.quantity}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          grouped.item.car.title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'Price: \$${_formatPrice(grouped.item.car.price)}',
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      final index = widget.state.reservationItems.indexWhere(
                        (item) => item.car.id == grouped.item.car.id,
                      );
                      if (index != -1) {
                        setState(() {
                          widget.state.removeReservationAt(index);
                        });
                      }
                    },
                    icon: const Icon(Icons.remove_circle_outline_rounded),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 90),
        ],
      ),
    );
  }

  Future<void> _pickDate() async {
    final selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );

    if (selected != null) {
      setState(() {
        _selectedDate =
            '${selected.month.toString().padLeft(2, '0')}/${selected.day.toString().padLeft(2, '0')}/${selected.year}';
      });
    }
  }

  Future<void> _pickTime() async {
    final selected = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selected != null) {
      setState(() {
        _selectedTime = selected.format(context);
      });
    }
  }

  List<_GroupedReservation> _groupItems(List<ReservationItem> items) {
    final grouped = <String, _GroupedReservation>{};

    for (final item in items) {
      final existing = grouped[item.car.id];
      if (existing == null) {
        grouped[item.car.id] = _GroupedReservation(item: item, quantity: 1);
      } else {
        grouped[item.car.id] = _GroupedReservation(
          item: existing.item,
          quantity: existing.quantity + 1,
        );
      }
    }

    return grouped.values.toList(growable: false);
  }

  String _formatPrice(int amount) {
    return amount.toString();
  }
}

class _GroupedReservation {
  const _GroupedReservation({required this.item, required this.quantity});

  final ReservationItem item;
  final int quantity;
}
