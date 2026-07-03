import 'dart:ui';

import 'package:flutter/material.dart';

import '../../theme/app_radius.dart';
import '../../theme/app_shadows.dart';
import '../../theme/app_spacing.dart';
import '../../utils/app_haptics.dart';

/// Semi-transparent, blurred card used for hero sections, greeting headers
/// and floating panels — the "glassmorphism" look requested for the redesign.
///
/// Deliberately kept as a self-contained widget (not a global theme change)
/// so it can be adopted screen-by-screen without touching [AppCard] usages
/// that already exist across the app.
class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius,
    this.onTap,
    this.blurSigma = 18,
    this.tintOpacity = 0.14,
    this.gradient,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final VoidCallback? onTap;
  final double blurSigma;
  final double tintOpacity;

  /// Optional gradient painted under the glass tint (e.g. [AppGradients.primary]).
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final radius = borderRadius ?? AppRadius.lg;
    final borderColor = Colors.white.withValues(alpha: isDark ? 0.10 : 0.35);
    final tint = (isDark ? Colors.white : Colors.white)
        .withValues(alpha: tintOpacity);

    Widget content = ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: Container(
          padding: padding ?? const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            gradient: gradient,
            color: gradient == null ? tint : null,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(color: borderColor, width: 1),
            boxShadow: AppShadows.medium(
              isDark ? Colors.black : const Color(0xFF0F172A),
            ),
          ),
          child: gradient != null
              ? Container(
                  decoration: BoxDecoration(
                    color: tint,
                    borderRadius: BorderRadius.circular(radius),
                  ),
                  padding: EdgeInsets.zero,
                  child: child,
                )
              : child,
        ),
      ),
    );

    if (margin != null) {
      content = Padding(padding: margin!, child: content);
    }

    if (onTap == null) return content;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(radius),
        onTap: () {
          AppHaptics.tap();
          onTap!();
        },
        child: content,
      ),
    );
  }
}
