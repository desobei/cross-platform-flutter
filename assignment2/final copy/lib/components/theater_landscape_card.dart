import 'package:flutter/material.dart';

import '../models/theater.dart';
import '../screens/theater_page.dart';

class TheaterLandscapeCard extends StatefulWidget {
  final Theater theater;

  const TheaterLandscapeCard({super.key, required this.theater});

  @override
  State<TheaterLandscapeCard> createState() => _TheaterLandscapeCardState();
}

class _TheaterLandscapeCardState extends State<TheaterLandscapeCard> {
  bool _isFavorited = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(8.0)),
            child: AspectRatio(
              aspectRatio: 2,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    widget.theater.imageUrl,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 4.0,
                    right: 4.0,
                    child: IconButton(
                      icon: Icon(
                        _isFavorited
                            ? Icons.favorite //
                            : Icons.favorite_border,
                      ),
                      iconSize: 30.0,
                      color: Colors.red[400],
                      onPressed: () {
                        setState(() {
                          _isFavorited = !_isFavorited;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: Text(
              widget.theater.name,
              style: textTheme.titleSmall,
            ),
            subtitle: Text(
              widget.theater.attributes,
              maxLines: 1,
              style: textTheme.bodySmall,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TheaterPage(
                    theater: widget.theater,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
