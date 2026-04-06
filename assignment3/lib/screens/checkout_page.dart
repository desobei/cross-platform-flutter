import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app/car_store_state.dart';
import '../models/car_store_models.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key, required this.tab, required this.state});

  final CarStoreTab tab;
  final CarStoreState state;

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _nameController = TextEditingController(text: 'Alex Driver');
  ReservationMode _mode = ReservationMode.showroomPickup;
  String _selectedDate = 'Friday, 4:30 PM';

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.state.reservationItems;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Finalize reservation')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Customer details',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          SegmentedButton<ReservationMode>(
            segments: const [
              ButtonSegment(
                value: ReservationMode.showroomPickup,
                label: Text('Showroom pickup'),
              ),
              ButtonSegment(
                value: ReservationMode.homeDelivery,
                label: Text('Home delivery'),
              ),
            ],
            selected: <ReservationMode>{_mode},
            onSelectionChanged: (selection) {
              setState(() {
                _mode = selection.first;
              });
            },
          ),
          const SizedBox(height: 20),
          DropdownButtonFormField<String>(
            initialValue: _selectedDate,
            items: const [
              DropdownMenuItem(
                value: 'Friday, 4:30 PM',
                child: Text('Friday, 4:30 PM'),
              ),
              DropdownMenuItem(
                value: 'Saturday, 11:00 AM',
                child: Text('Saturday, 11:00 AM'),
              ),
              DropdownMenuItem(
                value: 'Sunday, 2:15 PM',
                child: Text('Sunday, 2:15 PM'),
              ),
            ],
            onChanged: (value) {
              setState(() {
                _selectedDate = value ?? _selectedDate;
              });
            },
            decoration: const InputDecoration(
              labelText: 'Pickup or delivery slot',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Reserved cars',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 14),
          for (var i = 0; i < items.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Card(
                child: ListTile(
                  title: Text(items[i].car.title),
                  subtitle: Text(items[i].packageName),
                  trailing: IconButton(
                    onPressed: () => setState(() {
                      widget.state.removeReservationAt(i);
                    }),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ),
              ),
            ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: items.isEmpty
                  ? null
                  : () {
                      widget.state.submitOrder(
                        customerName: _nameController.text,
                        mode: _mode,
                        pickupDateLabel: _selectedDate,
                      );
                      context.go('/home?tab=${CarStoreTab.orders.indexValue}');
                    },
              child: const Text('Submit reservation'),
            ),
          ),
        ],
      ),
    );
  }
}
