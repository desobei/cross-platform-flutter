import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/car_store_repository.dart';
import '../models/car_store_models.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomScrollView(
      slivers: [
        SliverAppBar.large(
          pinned: true,
          title: const Text('CarStore'),
          actions: [
            IconButton(
              onPressed: () => context.go('/home?tab=2'),
              icon: const Icon(Icons.person_rounded),
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primaryContainer,
                    theme.colorScheme.secondaryContainer,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Build your next garage',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Discover premium showrooms, explore curated inventory and reserve a car in a few taps.',
                    style: theme.textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: _SectionHeader(
            title: 'Nearby showrooms',
            subtitle: 'Tap a showroom to see the available inventory',
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 220,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              itemCount: CarStoreRepository.showrooms.length,
              separatorBuilder: (_, _) => const SizedBox(width: 14),
              itemBuilder: (context, index) {
                final showroom = CarStoreRepository.showrooms[index];
                return SizedBox(
                  width: 280,
                  child: _ShowroomCard(showroom: showroom),
                );
              },
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: _SectionHeader(
            title: 'Browse by category',
            subtitle: 'The Chapter 5-6 style quick filters, re-themed for cars',
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 74,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              itemCount: CarStoreRepository.categories.length,
              separatorBuilder: (_, _) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final category = CarStoreRepository.categories[index];
                return Chip(
                  avatar: Icon(category.icon, size: 18),
                  label: Text(category.label),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                );
              },
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: _SectionHeader(
            title: 'Curator notes',
            subtitle: 'A vertical feed similar to friend posts in Yummy',
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          sliver: SliverList.builder(
            itemCount: CarStoreRepository.posts.length,
            itemBuilder: (context, index) {
              final post = CarStoreRepository.posts[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(18),
                    title: Text(
                      post.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        '${post.author} • ${post.readTime}\n${post.summary}',
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
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
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(subtitle, style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class _ShowroomCard extends StatelessWidget {
  const _ShowroomCard({required this.showroom});

  final Showroom showroom;

  @override
  Widget build(BuildContext context) {
    final tab = CarStoreTab.discover.indexValue;
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () => context.go('/home/showroom/${showroom.id}?tab=$tab'),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            colors: [
              showroom.accentColor,
              showroom.accentColor.withValues(alpha: 0.72),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      showroom.city,
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ),
                  const Icon(Icons.arrow_forward_rounded, color: Colors.white),
                ],
              ),
              const Icon(
                Icons.local_shipping_outlined,
                color: Colors.white,
                size: 46,
              ),
              const SizedBox(height: 16),
              Text(
                showroom.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Text(
                  '${showroom.specialty} • ${showroom.rating} stars',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white70),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
