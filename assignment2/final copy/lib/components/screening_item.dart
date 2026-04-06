import 'package:flutter/material.dart';

import '../models/theater.dart';

class ScreeningItem extends StatelessWidget {
  final Screening screening;

  const ScreeningItem({super.key, required this.screening});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: _buildListItem()),
        _buildImageStack(colorScheme),
      ],
    );
  }

  Widget _buildListItem() {
    return ListTile(
      contentPadding: const EdgeInsets.all(8.0),
      title: Text(screening.name),
      subtitle: _buildSubtitle(),
    );
  }

  Widget _buildSubtitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDescription(),
        const SizedBox(height: 4),
        _buildPriceAndLikes(),
      ],
    );
  }

  Widget _buildDescription() {
    return Text(
      screening.description,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildPriceAndLikes() {
    return Row(
      children: [
        Text('\$${screening.price.toStringAsFixed(2)}'),
        const SizedBox(width: 4),
        const Icon(
          Icons.movie,
          color: Colors.green,
          size: 18,
        ),
      ],
    );
  }

  Widget _buildImageStack(ColorScheme colorScheme) {
    return Stack(
      children: [
        _buildImage(),
        _buildAddButton(colorScheme),
      ],
    );
  }

  Widget _buildImage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Image.network(
            screening.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildAddButton(ColorScheme colorScheme) {
    return Positioned(
      bottom: 8.0,
      right: 8.0,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 4.0,
        ),
        decoration: BoxDecoration(
          color: colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: const Text(
          'Book',
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
