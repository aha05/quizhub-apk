import 'package:flutter/material.dart';
import 'package:quizhub/features/home/presentation/theme/home_colors.dart';

class NavIconBtn extends StatelessWidget {
  final IconData icon;
  final int? badge;
  final bool active;
  final VoidCallback onTap;
  const NavIconBtn({
    super.key,
    required this.icon,
    required this.onTap,
    this.badge,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: active
                  ? HomeColors.primary.withOpacity(0.12)
                  : HomeColors.border,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(
              icon,
              color: active ? HomeColors.primary : HomeColors.textDark,
              size: 20,
            ),
          ),
          if (badge != null)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                width: 16,
                height: 16,
                decoration: const BoxDecoration(
                  color: HomeColors.accent,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '$badge',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
