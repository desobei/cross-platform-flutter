import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app/car_store_state.dart';
import '../data/car_store_repository.dart';
import '../models/car_store_models.dart';
import '../widgets/animated_tap_button.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key, required this.state});

  final CarStoreState state;

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  late final TextEditingController _searchController;
  List<CarListing> _searchResults = const <CarListing>[];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    final initialSearch = widget.state.recentSearches.isNotEmpty
        ? widget.state.recentSearches.first
        : '';
    _searchController = TextEditingController(text: initialSearch);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.state,
      builder: (context, _) {
        final theme = Theme.of(context);
        final favoriteListings = CarStoreRepository.listings
            .where(
              (listing) => widget.state.favoriteCarIds.contains(listing.id),
            )
            .toList(growable: false);

        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Showrooms near me',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => widget.state.changeThemeMode(
                        widget.state.themeMode != ThemeMode.dark,
                      ),
                      icon: Icon(
                        widget.state.themeMode == ThemeMode.dark
                            ? Icons.light_mode_rounded
                            : Icons.nightlight_round,
                      ),
                    ),
                    IconButton(
                      tooltip: 'Advisor Chat',
                      onPressed: () => context.go(
                        '/home?tab=${CarStoreTab.advisor.queryValue}',
                      ),
                      icon: const Icon(Icons.support_agent_rounded),
                    ),
                    IconButton(
                      onPressed: () => context.go(
                        '/home?tab=${CarStoreTab.account.queryValue}',
                      ),
                      icon: const Icon(Icons.tune_rounded),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 6, 20, 6),
                child: _SearchCard(
                  controller: _searchController,
                  recentSearches: widget.state.recentSearches,
                  loading: _loading,
                  onSearch: _runSearch,
                  onSelectRecent: (value) {
                    _searchController.text = value;
                    _runSearch(value);
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 6, 20, 10),
                child: FilledButton.icon(
                  onPressed: () =>
                      context.go('/home?tab=${CarStoreTab.advisor.queryValue}'),
                  icon: const Icon(Icons.support_agent_rounded),
                  label: const Text('Advisor Chat'),
                ),
              ),
            ),
            if (_searchResults.isNotEmpty)
              SliverToBoxAdapter(
                child: _SectionHeader(
                  title: 'Search results',
                  subtitle:
                      '${_searchResults.length} vehicle${_searchResults.length == 1 ? '' : 's'} matched your search',
                ),
              ),
            if (_searchResults.isNotEmpty)
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final listing = _searchResults[index];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                    child: StaggeredSlideIn(
                      index: index,
                      child: _SearchResultCard(
                        car: listing,
                        isFavorite: widget.state.isFavorite(listing.id),
                        onToggleFavorite: () =>
                            widget.state.toggleFavorite(listing.id),
                      ),
                    ),
                  );
                }, childCount: _searchResults.length),
              ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 208,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  itemCount: CarStoreRepository.showrooms.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final showroom = CarStoreRepository.showrooms[index];
                    return SizedBox(
                      width: 300,
                      child: StaggeredSlideIn(
                        index: index,
                        offset: const Offset(0.08, 0),
                        child: _ShowroomRailCard(showroom: showroom),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 10)),
            SliverToBoxAdapter(
              child: _SectionHeader(
                title: 'Driver activity',
                subtitle: 'What other collectors and EV drivers are doing',
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 110,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  itemCount: CarStoreRepository.activities.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    return _ActivityCard(
                      activity: CarStoreRepository.activities[index],
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: _SectionHeader(
                title: 'Categories',
                subtitle: 'Browse by style and use case',
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final category = CarStoreRepository.categories[index];
                  final categoryListings =
                      CarStoreRepository.listingsForCategory(category.label);
                  return _CategoryCard(
                    category: category,
                    listingCount: categoryListings.length,
                    onTap: () => _openCategorySheet(
                      context,
                      category: category,
                      cars: categoryListings,
                    ),
                  );
                }, childCount: CarStoreRepository.categories.length),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.92,
                ),
              ),
            ),
            if (favoriteListings.isNotEmpty)
              SliverToBoxAdapter(
                child: _SectionHeader(
                  title: 'Saved for later',
                  subtitle:
                      '${favoriteListings.length} favorites ready to revisit',
                ),
              ),
            if (favoriteListings.isNotEmpty)
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 206,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    scrollDirection: Axis.horizontal,
                    itemCount: favoriteListings.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final listing = favoriteListings[index];
                      return SizedBox(
                        width: 260,
                        child: _SavedCarCard(
                          car: listing,
                          onOpen: () => context.go(
                            '/home/showroom/${listing.showroomId}?tab=${CarStoreTab.discover.queryValue}',
                          ),
                          onToggleSaved: () =>
                              widget.state.toggleFavorite(listing.id),
                        ),
                      );
                    },
                  ),
                ),
              ),
            const SliverToBoxAdapter(child: SizedBox(height: 92)),
          ],
        );
      },
    );
  }

  Future<void> _runSearch([String? overrideQuery]) async {
    final query = (overrideQuery ?? _searchController.text).trim();
    if (query.isEmpty) {
      setState(() {
        _searchResults = const <CarListing>[];
      });
      return;
    }

    setState(() {
      _loading = true;
    });

    final results = await widget.state.searchCars(query);
    if (!mounted) {
      return;
    }

    setState(() {
      _loading = false;
      _searchResults = results;
      _searchController.text = query;
    });
  }
}

class _SearchCard extends StatelessWidget {
  const _SearchCard({
    required this.controller,
    required this.recentSearches,
    required this.loading,
    required this.onSearch,
    required this.onSelectRecent,
  });

  final TextEditingController controller;
  final List<String> recentSearches;
  final bool loading;
  final Future<void> Function([String? value]) onSearch;
  final ValueChanged<String> onSelectRecent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Find cars or decode VIN',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Chapter 12 uses the CarAPI VIN endpoint. Make, model and tag searches still use the local showroom inventory.',
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (_) => onSearch(),
                    decoration: const InputDecoration(
                      labelText: 'Search make, model, tag or VIN',
                      prefixIcon: Icon(Icons.search_rounded),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                AnimatedTapButton(
                  onTap: loading ? null : () => onSearch(),
                  semanticLabel: 'Animated search button',
                  child: FilledButton.icon(
                    onPressed: loading ? null : () => onSearch(),
                    icon: loading
                        ? const PulsingLoadingIndicator(size: 18)
                        : const Icon(Icons.travel_explore_rounded),
                    label: const Text('Search'),
                  ),
                ),
              ],
            ),
            if (recentSearches.isNotEmpty) ...[
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Recent searches',
                  prefixIcon: Icon(Icons.history_rounded),
                ),
                items: recentSearches
                    .map(
                      (search) => DropdownMenuItem<String>(
                        value: search,
                        child: Text(search),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    onSelectRecent(value);
                  }
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _SearchResultCard extends StatelessWidget {
  const _SearchResultCard({
    required this.car,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  final CarListing car;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final imagePath = CarStoreRepository.carImageAsset(car.id);

    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: () => context.go(
        '/home/showroom/${car.showroomId}?tab=${CarStoreTab.discover.queryValue}',
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: SizedBox(
                  width: 112,
                  height: 96,
                  child: Hero(
                    tag: 'car-image-${car.id}',
                    child: _ImageWithFallback(
                      assetPath: imagePath,
                      fallbackColor: car.accentColor,
                      icon: Icons.directions_car_filled_rounded,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      car.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(car.highlight),
                    const SizedBox(height: 6),
                    Text(car.rangeOrMileage, style: theme.textTheme.bodySmall),
                    const SizedBox(height: 8),
                    Text(
                      '\$${car.price.toString()}',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onToggleFavorite,
                icon: Icon(
                  isFavorite
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(subtitle, style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class _ShowroomRailCard extends StatelessWidget {
  const _ShowroomRailCard({required this.showroom});

  final Showroom showroom;

  @override
  Widget build(BuildContext context) {
    final tab = CarStoreTab.discover.queryValue;
    final theme = Theme.of(context);
    final imagePath = CarStoreRepository.showroomHeroAsset(showroom.id);

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () => context.go('/home/showroom/${showroom.id}?tab=$tab'),
      child: Card(
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Hero(
                tag: 'showroom-hero-${showroom.id}',
                child: _ImageWithFallback(
                  assetPath: imagePath,
                  fallbackColor: showroom.accentColor,
                  icon: Icons.storefront_rounded,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    showroom.name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${showroom.city} · ${showroom.specialty}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  const _ActivityCard({required this.activity});

  final DriverActivity activity;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: 250,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: scheme.surface.withOpacity(0.9),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: scheme.primaryContainer,
            child: Text(activity.name.characters.first),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                Text(
                  activity.note,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            activity.timeAgo,
            style: TextStyle(color: scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.category,
    required this.listingCount,
    required this.onTap,
  });

  final CarCategory category;
  final int listingCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      _ImageWithFallback(
                        assetPath: category.imageAssetPath,
                        fallbackColor: scheme.primaryContainer,
                        icon: category.icon,
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.02),
                              Colors.black.withOpacity(0.34),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.white.withOpacity(0.86),
                            child: Icon(category.icon, color: scheme.primary),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                category.label,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text('$listingCount cars available'),
            ],
          ),
        ),
      ),
    );
  }
}

class _SavedCarCard extends StatelessWidget {
  const _SavedCarCard({
    required this.car,
    required this.onOpen,
    required this.onToggleSaved,
  });

  final CarListing car;
  final VoidCallback onOpen;
  final VoidCallback onToggleSaved;

  @override
  Widget build(BuildContext context) {
    final imagePath = CarStoreRepository.carImageAsset(car.id);
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onOpen,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: SizedBox(
                  height: 112,
                  width: double.infinity,
                  child: _ImageWithFallback(
                    assetPath: imagePath,
                    fallbackColor: car.accentColor,
                    icon: Icons.directions_car_filled_rounded,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      car.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: onToggleSaved,
                    icon: const Icon(Icons.favorite_rounded),
                  ),
                ],
              ),
              Text(car.highlight),
            ],
          ),
        ),
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
      return DecoratedBox(
        decoration: BoxDecoration(color: fallbackColor),
        child: Center(child: Icon(icon, color: Colors.white, size: 48)),
      );
    }

    return Image.asset(
      assetPath,
      fit: BoxFit.cover,
      errorBuilder: (_, _, _) {
        return DecoratedBox(
          decoration: BoxDecoration(color: fallbackColor),
          child: Center(child: Icon(icon, color: Colors.white, size: 48)),
        );
      },
    );
  }
}

void _openCategorySheet(
  BuildContext context, {
  required CarCategory category,
  required List<CarListing> cars,
}) {
  showModalBottomSheet<void>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
    ),
    builder: (context) {
      return SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category.label,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              for (final car in cars)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(child: Icon(category.icon)),
                  title: Text(car.title),
                  subtitle: Text(car.highlight),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    context.go(
                      '/home/showroom/${car.showroomId}?tab=${CarStoreTab.discover.queryValue}',
                    );
                  },
                ),
            ],
          ),
        ),
      );
    },
  );
}
