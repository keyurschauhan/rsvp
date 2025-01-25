import 'package:flutter/material.dart';

class SlideRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  SlideRoute({required this.page})
      : super(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // Forward (Entering) slide transition
      const begin = Offset(1.0, 0.0); // Start from the right
      const end = Offset.zero; // End at the center
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var reverseOffsetAnimation = animation.drive(tween);

      // Reverse (Exiting) slide transition
      var reverseTween = Tween(begin: Offset.zero,
          end: const Offset(-1.0, 0.0)).chain(CurveTween(curve: curve));
      var offsetAnimation = secondaryAnimation.drive(reverseTween);

      // Apply correct transition based on forward or backward navigation
      return SlideTransition(
        position: animation.status == AnimationStatus.reverse
            ? reverseOffsetAnimation  // Going back (Exiting)
            : offsetAnimation,  // Going forward (Entering)
        child: child,
      );
    },
  );
}