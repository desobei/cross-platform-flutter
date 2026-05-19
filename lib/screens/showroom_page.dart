import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app/car_store_state.dart';
import '../data/car_store_repository.dart';
import '../models/car_feedback.dart';
import '../models/car_store_models.dart';
import '../widgets/car_store_bottom_nav.dart';
import '../widgets/animated_tap_button.dart';

class ShowroomPage extends StatelessWidget {
  const ShowroomPage({
    super.key,
    required this.showroomId,
    required this.tab,
    required this.state,
  });

  final String showroomId;
  final CarStoreTab tab;
  final CarStoreState state;

  @override
  Widget build(BuildContext context) {
    final showroom = CarStoreRepository.showroomById(showroomId);
    final listings = CarStoreRepository.listingsForShowroom(showroomId);
    final imagePath = CarStoreRepository.showroomHeroAsset(showroom.id);

    return AnimatedBuilder(
      animation: state,
      builder: (context, _) {
        final theme = Theme.of(context);

        return Scaffold(
          appBar: AppBar(),
          bottomNavigationBar: CarStoreBottomNav(
            state: state,
            currentTab: tab,
            action: SizedBox(
              width: double.infinity,
              child: AnimatedTapButton(
                onTap: () => context.go('/home/checkout?tab=${tab.queryValue}'),
                semanticLabel: 'Animated checkout button',
                child: FilledButton.icon(
                  onPressed: () => context.go('/home/checkout?tab=${tab.queryValue}'),
                  icon: const Icon(Icons.shopping_cart_rounded),
                  label: Text('${state.reservationItems.length} items in cart'),
                ),
              ),
            ),
          ),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            children: [
          Hero(
            tag: 'showroom-hero-${showroom.id}',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: SizedBox(
                height: 220,
                child: _ImageWithFallback(
                  assetPath: imagePath,
                  fallbackColor: showroom.accentColor,
                  icon: Icons.storefront_rounded,
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: const Offset(12, -24),
            child: Align(
              alignment: Alignment.centerLeft,
              child: CircleAvatar(
                radius: 22,
                backgroundColor: showroom.accentColor.withOpacity(0.18),
                child: Icon(Icons.garage_rounded, color: showroom.accentColor),
              ),
            ),
          ),
          Text(
            showroom.name,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${showroom.city} · Rating: ${showroom.rating} · ${showroom.specialty}',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 4),
          Text(showroom.description, style: theme.textTheme.bodySmall),
          const SizedBox(height: 22),
          Text(
            'Inventory',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          for (final entry in listings.asMap().entries)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: StaggeredSlideIn(
                index: entry.key,
                child: _InventoryRow(
                  car: entry.value,
                  isFavorite: state.isFavorite(entry.value.id),
                  onToggleFavorite: () => state.toggleFavorite(entry.value.id),
                  onTap: () => _openCarSheet(context, entry.value, state),
                ),
              ),
            ),
            ],
          ),
        );
      },
    );
  }

  void _openCarSheet(
    BuildContext context,
    CarListing car,
    CarStoreState state,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      builder: (context) {
        final imagePath = CarStoreRepository.carImageAsset(car.id);
        var quantity = 1;
        var isFavorite = state.isFavorite(car.id);

        return StatefulBuilder(
          builder: (context, setSheetState) {
            return SafeArea(
              top: false,
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 42,
                        height: 4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(999),
                          color: Theme.of(context).colorScheme.outlineVariant,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            car.title,
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(fontWeight: FontWeight.w800),
                          ),
                        ),
                        IconButton.filledTonal(
                          onPressed: () {
                            final nextFavorite = !isFavorite;
                            setSheetState(() {
                              isFavorite = nextFavorite;
                            });
                            state.toggleFavorite(car.id);
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(
                                SnackBar(
                                  duration: const Duration(seconds: 1),
                                  content: Text(
                                    nextFavorite
                                        ? 'Saved to favorites'
                                        : 'Removed from favorites',
                                  ),
                                ),
                              );
                          },
                          icon: Icon(
                            isFavorite
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Hero(
                      tag: 'car-sheet-image-${car.id}',
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: SizedBox(
                          height: 160,
                          width: double.infinity,
                          child: _ImageWithFallback(
                            assetPath: imagePath,
                            fallbackColor: car.accentColor,
                            icon: Icons.directions_car_filled_rounded,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      car.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    _CarFeedbackSection(car: car, state: state),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _CounterButton(
                          icon: Icons.remove,
                          onTap: quantity > 1
                              ? () => setSheetState(() {
                                  quantity -= 1;
                                })
                              : null,
                        ),
                        Container(
                          width: 44,
                          alignment: Alignment.center,
                          child: Text(
                            '$quantity',
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                        _CounterButton(
                          icon: Icons.add,
                          onTap: () => setSheetState(() {
                            quantity += 1;
                          }),
                        ),
                        const Spacer(),
                        Text(
                          '\$${car.price}',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      child: AnimatedTapButton(
                        onTap: () {
                          for (var i = 0; i < quantity; i++) {
                            state.addReservation(car, 'Signature package');
                          }
                          Navigator.of(context).pop();
                        },
                        semanticLabel: 'Animated add to cart button',
                        child: FilledButton(
                          onPressed: () {
                            for (var i = 0; i < quantity; i++) {
                              state.addReservation(car, 'Signature package');
                            }
                            Navigator.of(context).pop();
                          },
                          child: const Text('Add to cart'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _InventoryRow extends StatelessWidget {
  const _InventoryRow({
    required this.car,
    required this.isFavorite,
    required this.onToggleFavorite,
    required this.onTap,
  });

  final CarListing car;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final imagePath = CarStoreRepository.carImageAsset(car.id);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: theme.colorScheme.outlineVariant),
          color: theme.colorScheme.surface.withOpacity(0.88),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      car.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      car.highlight,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '\$${car.price}',
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Hero(
              tag: 'car-image-${car.id}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: 86,
                  height: 66,
                  child: _ImageWithFallback(
                    assetPath: imagePath,
                    fallbackColor: car.accentColor,
                    icon: Icons.directions_car_filled_rounded,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              transitionBuilder: (child, animation) => ScaleTransition(
                scale: animation,
                child: child,
              ),
              child: IconButton(
                key: ValueKey(isFavorite),
                tooltip: isFavorite ? 'Remove from favorites' : 'Add to favorites',
                onPressed: onToggleFavorite,
                icon: Icon(
                  isFavorite
                      ? Icons.favorite_rounded
                      : Icons.favorite_outline_rounded,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class _CarFeedbackSection extends StatefulWidget {
  const _CarFeedbackSection({required this.car, required this.state});

  final CarListing car;
  final CarStoreState state;

  @override
  State<_CarFeedbackSection> createState() => _CarFeedbackSectionState();
}

class _CarFeedbackSectionState extends State<_CarFeedbackSection> {
  late final TextEditingController _controller;
  bool _sending = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.55),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.forum_rounded,
                  size: 18,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Firebase feedback',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            StreamBuilder<List<CarFeedback>>(
              stream: widget.state.watchCarFeedback(widget.car.id),
              builder: (context, snapshot) {
                final feedback = snapshot.data ?? const <CarFeedback>[];
                if (feedback.isEmpty) {
                  return Text(
                    'No feedback yet. Add the first comment for this car.',
                    style: theme.textTheme.bodySmall,
                  );
                }
                return Column(
                  children: [
                    for (final item in feedback.take(3))
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            '${item.driverName}: ${item.text}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodySmall,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    key: const ValueKey('carFeedbackField'),
                    controller: _controller,
                    minLines: 1,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      labelText: 'Write feedback',
                      isDense: true,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filledTonal(
                  tooltip: 'Send feedback',
                  onPressed: _sending ? null : _sendFeedback,
                  icon: _sending
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.send_rounded),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendFeedback() async {
    final text = _controller.text.trim();
    if (text.isEmpty) {
      return;
    }
    setState(() => _sending = true);
    try {
      await widget.state.sendCarFeedback(carId: widget.car.id, text: text);
      _controller.clear();
    } finally {
      if (mounted) {
        setState(() => _sending = false);
      }
    }
  }
}

class _CounterButton extends StatelessWidget {
  const _CounterButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Ink(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
        child: Icon(icon, size: 18),
      ),
    );
  }
}

class _ImageWithFallback extends StatelessWidget {
  const _ImageWithFallback({
    required this.assetPath,
    required this.fallbackColor,
    required this.icon,
  });

  final String assetPath;
  final Color fallbackColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    if (assetPath.isEmpty) {
      return _FallbackArt(color: fallbackColor, icon: icon);
    }

    return Image.asset(
      assetPath,
      fit: BoxFit.cover,
      errorBuilder: (_, _, _) => _FallbackArt(color: fallbackColor, icon: icon),
    );
  }
}

class _FallbackArt extends StatelessWidget {
  const _FallbackArt({required this.color, required this.icon});

  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withOpacity(0.95),
            color.withOpacity(0.74),
          ],
        ),
      ),
      child: Center(child: Icon(icon, color: Colors.white, size: 34)),
    );
  }
}
