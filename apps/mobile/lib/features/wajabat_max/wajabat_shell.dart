import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/wajabat_theme.dart';

class WajabatShell extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const WajabatShell({super.key, required this.navigationShell});

  @override
  State<WajabatShell> createState() => _WajabatShellState();
}

class _WajabatShellState extends State<WajabatShell> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Content Layer
          widget.navigationShell,

          // 2. Glass Dock Layer
          Positioned(bottom: 24, left: 24, right: 24, child: _buildGlassDock()),
        ],
      ),
    );
  }

  Widget _buildGlassDock() {
    return ClipRRect(
      borderRadius: WajabatTheme.radiusXL,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          height: 76,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.85),
            borderRadius: WajabatTheme.radiusXL,
            border: Border.all(color: Colors.white.withOpacity(0.4)),
            boxShadow: WajabatTheme.shadowGlass,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(0, Icons.home_rounded, Icons.home_outlined),
              _buildNavItem(1, Icons.explore_rounded, Icons.explore_outlined),
              _buildNavItem(
                2,
                Icons.favorite_rounded,
                Icons.favorite_border_rounded,
              ),
              _buildNavItem(
                3,
                Icons.person_rounded,
                Icons.person_outline_rounded,
              ),
            ],
          ),
        ),
      ),
    ).animate().slideY(
      begin: 1.0,
      end: 0,
      duration: 800.ms,
      curve: Curves.easeOutBack,
    );
  }

  Widget _buildNavItem(int index, IconData activeIcon, IconData inactiveIcon) {
    final isSelected = widget.navigationShell.currentIndex == index;
    final color = isSelected ? WajabatTheme.primary : WajabatTheme.textLight;

    return GestureDetector(
      onTap: () => widget.navigationShell.goBranch(
        index,
        initialLocation: index == widget.navigationShell.currentIndex,
      ),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(isSelected ? activeIcon : inactiveIcon, color: color, size: 28)
                .animate(target: isSelected ? 1 : 0)
                .scale(
                  begin: const Offset(1, 1),
                  end: const Offset(1.2, 1.2),
                  duration: 200.ms,
                ),

            Container(
              margin: const EdgeInsets.only(top: 4),
              width: 4,
              height: 4,
              decoration: const BoxDecoration(
                color: WajabatTheme.primary,
                shape: BoxShape.circle,
              ),
            ).animate().scale(duration: 200.ms),
          ],
        ),
      ),
    );
  }
}
