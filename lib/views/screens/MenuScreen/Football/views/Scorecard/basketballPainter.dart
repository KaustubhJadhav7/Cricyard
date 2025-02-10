import 'dart:async';

import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

class BasketballConfettiPainter extends CustomPainter {
  final ui.Image image;
  final List<Offset> positions;
  final double size;

  BasketballConfettiPainter({required this.image, required this.positions, this.size = 30});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    for (var position in positions) {
      canvas.drawImageRect(
        image,
        Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
        Rect.fromCenter(center: position, width: this.size, height: this.size),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(BasketballConfettiPainter oldDelegate) => true;
}

void _showConfettiAnimation(BuildContext context, bool isHomeTeamGoal, ui.Image basketballImage) {
  ConfettiController confettiController = ConfettiController(duration: Duration(seconds: 2));
  confettiController.play(); // Start confetti animation

  final Random random = Random();
  List<Offset> positions = List.generate(30, (index) {
    return Offset(
      random.nextDouble() * MediaQuery.of(context).size.width, // Random x position
      random.nextDouble() * MediaQuery.of(context).size.height, // Random y position
    );
  });

  OverlayEntry overlayEntry = OverlayEntry(
    builder: (context) {
      return Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height * 0.1, // Adjust height
            left: isHomeTeamGoal ? 50 : null,
            right: !isHomeTeamGoal ? 50 : null,
            child: ConfettiWidget(
              confettiController: confettiController,
              blastDirection: pi / 2,
              emissionFrequency: 0.05,
              numberOfParticles: 80,
              gravity: 0.5,
              shouldLoop: false,
              createParticlePath: (size) {
                return Path()..addOval(Rect.fromCircle(center: Offset(0, 0), radius: size.width / 2));
              },
            ),
          ),
          Positioned.fill(
            child: CustomPaint(
              painter: BasketballConfettiPainter(image: basketballImage, positions: positions),
            ),
          ),
        ],
      );
    },
  );

  Overlay.of(context)?.insert(overlayEntry);

  // Remove confetti animation after a delay
  Future.delayed(Duration(seconds: 3), () {
    confettiController.stop();
    overlayEntry.remove();
  });
}

// Function to load the basketball image
Future<ui.Image> loadBasketballImage() async {
  final ByteData data = await rootBundle.load('assets/images/basketball.png');
  final Completer<ui.Image> completer = Completer();
  ui.decodeImageFromList(data.buffer.asUint8List(), (ui.Image img) {
    completer.complete(img);
  });
  return completer.future;
}
