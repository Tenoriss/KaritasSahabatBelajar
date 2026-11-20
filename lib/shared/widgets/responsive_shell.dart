import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/dark_color_mapper.dart';

/// Wrapper responsif: di layar sempit (≤ 480) konten full-width, di layar lebar
/// konten terpusat dalam wadah ponsel dengan latar merek KARSA.
class ResponsiveShell extends StatelessWidget {
  final Widget child;
  final Color outerBg;
  final bool isDark;

  const ResponsiveShell({
    super.key,
    required this.child,
    required this.outerBg,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // ── Mobile: langsung tampil full-width ────────────────────────────────
    if (screenWidth <= 500) {
      return child;
    }

    // ── Tablet / Desktop: konten di tengah, background branded ───────────
    final phoneWidth = screenWidth > 900 ? 400.0 : 440.0;
    final brandBg = isDark
        ? DarkColorMapper.surface(const Color(0xFF1A1A2E), isDark: true)
        : const Color(0xFFF0F4F8);

    return Container(
      color: brandBg,
      child: Stack(
        children: <Widget>[
          // Pola dekoratif di background
          Positioned(
            top: -60,
            right: -60,
            child: _Circle(200, isDark ? const Color(0x11FFFFFF) : const Color(0x0AE8617A)),
          ),
          Positioned(
            bottom: -40,
            left: -40,
            child: _Circle(160, isDark ? const Color(0x11FFFFFF) : const Color(0x085B9EC9)),
          ),
          // Konten ponsel di tengah
          Center(
            child: Container(
              width: phoneWidth,
              margin: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: isDark
                        ? const Color(0x44000000)
                        : const Color(0x22000000),
                    blurRadius: 40,
                    spreadRadius: 4,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Circle extends StatelessWidget {
  final double size;
  final Color color;
  const _Circle(this.size, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
