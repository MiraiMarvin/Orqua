import 'package:flutter/material.dart';

class HeroBanner extends StatelessWidget {
  HeroBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    double bannerHeight;
    double fontSize;
    double subtitleSize;

    if (screenWidth > 1200) {
      bannerHeight = 300;
      fontSize = 48;
      subtitleSize = 22;
    } else if (screenWidth > 800) {
      bannerHeight = 280;
      fontSize = 42;
      subtitleSize = 20;
    } else {
      bannerHeight = 250;
      fontSize = 36;
      subtitleSize = 18;
    }

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1200),
        height: bannerHeight,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/images/harbor.jpg',
                fit: BoxFit.cover,
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.7),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Orqua',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        shadows: const [
                          Shadow(
                            color: Color(0x80000000),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Produits frais de la mer',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: subtitleSize,
                        fontWeight: FontWeight.w500,
                        shadows: const [
                          Shadow(
                            color: Color(0x80000000),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

