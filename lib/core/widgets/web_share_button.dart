import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import '../theme/orqua_theme.dart';

class WebShareButton extends StatelessWidget {
  final String title;
  final String text;
  final String? url;

  const WebShareButton({
    super.key,
    required this.title,
    required this.text,
    this.url,
  });

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      return const SizedBox.shrink();
    }

    return IconButton(
      icon: const Icon(Icons.share),
      color: OrquaTheme.primaryBlue,
      tooltip: 'Partager',
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Partage disponible sur navigateur web'),
            duration: Duration(seconds: 2),
          ),
        );
      },
    );
  }
}

class WebShareIconButton extends StatelessWidget {
  final String title;
  final String text;
  final String? url;
  final Color? color;
  final double? iconSize;

  const WebShareIconButton({
    super.key,
    required this.title,
    required this.text,
    this.url,
    this.color,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    // Le partage Web Share n'est disponible que sur web
    // Sur mobile Android/iOS, on cache le bouton
    if (!kIsWeb) {
      return const SizedBox.shrink();
    }

    return IconButton(
      icon: const Icon(Icons.share),
      color: color ?? OrquaTheme.primaryBlue,
      iconSize: iconSize,
      tooltip: 'Partager',
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Partage disponible sur navigateur web'),
            duration: Duration(seconds: 2),
          ),
        );
      },
    );
  }
}

