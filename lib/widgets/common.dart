import 'dart:ui';
import 'package:flutter/material.dart';
import '../config/theme.dart';
import 'package:vibration/vibration.dart';

class GameBackground extends StatelessWidget {
  final Widget child;
  const GameBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.bgTop, AppColors.bgBottom],
        ),
      ),
      child: Stack(
        children: [
          const RepaintBoundary(child: _BackgroundBlobs()),
          SafeArea(child: child),
        ],
      ),
    );
  }
}

class _BackgroundBlobs extends StatelessWidget {
  const _BackgroundBlobs();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -100, left: -50,
          child: Container(width: 300, height: 300, decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.accent.withOpacity(0.08), boxShadow: [BoxShadow(color: AppColors.accent.withOpacity(0.15), blurRadius: 80, spreadRadius: 10)]))),
        Positioned(
          bottom: -100, right: -50,
          child: Container(width: 300, height: 300, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.purple.withOpacity(0.08), boxShadow: [BoxShadow(color: Colors.purple.withOpacity(0.15), blurRadius: 80, spreadRadius: 10)]))),
      ],
    );
  }
}

class GameCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool borderHighlight;
  final Color? highlightColor;

  const GameCard({super.key, required this.child, this.onTap, this.onLongPress, this.borderHighlight = false, this.highlightColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () { if(onTap!=null) Vibration.vibrate(duration: 10); onTap?.call(); },
      onLongPress: () { if(onLongPress!=null) Vibration.vibrate(duration: 30); onLongPress?.call(); },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: borderHighlight ? (highlightColor ?? AppColors.accent) : Colors.white.withOpacity(0.1), width: borderHighlight ? 2 : 1),
          boxShadow: borderHighlight ? [BoxShadow(color: (highlightColor ?? AppColors.accent).withOpacity(0.2), blurRadius: 12)] : []
        ),
        child: child,
      ),
    );
  }
}

class GameNavBar extends StatelessWidget {
  final String title;
  final VoidCallback onBack;
  final Widget? action;
  const GameNavBar({super.key, required this.title, required this.onBack, this.action});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(onPressed: onBack, icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20)),
          Text(title, style: AppTheme.heading(18)),
          action ?? const SizedBox(width: 40),
        ],
      ),
    );
  }
}
