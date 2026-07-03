import 'package:flutter/material.dart';

/// Living gradients for the "premium AI home-concierge" brand identity.
/// Used instead of flat single-tone fills across heroes, CTAs and status
/// chips so the app reads as one cohesive brand rather than a set of screens.
class AppGradients {
  AppGradients._();

  /// Primary brand gradient — hero sections, main CTA buttons, splash.
  static const primary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2563EB), Color(0xFF7C3AED)],
  );

  /// Warm success gradient — "order accepted / completed" states.
  static const success = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF22C55E), Color(0xFF15B392)],
  );

  /// In-progress / attention gradient.
  static const warning = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFF59E0B), Color(0xFFF97316)],
  );

  /// Urgent / danger gradient.
  static const danger = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFEF4444), Color(0xFFDB2777)],
  );

  /// Deep splash/hero background gradient (brand green, alive not flat).
  static const splash = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF6BC96F), Color(0xFF3F9F49)],
  );

  /// Soft app-wide background wash used behind glass cards.
  static const backgroundWashLight = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFF3F6FF), Color(0xFFF8FAFC)],
  );

  static const backgroundWashDark = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF0B0F1A), Color(0xFF000000)],
  );

  /// Returns the correct status gradient for a dynamic order/master status.
  static LinearGradient forStatus(AppStatusTone tone) {
    switch (tone) {
      case AppStatusTone.success:
        return success;
      case AppStatusTone.warning:
        return warning;
      case AppStatusTone.danger:
        return danger;
      case AppStatusTone.neutral:
        return primary;
    }
  }
}

/// Semantic status tone driving both color and gradient across the app,
/// e.g. 🟢 done / 🟡 in progress / 🔴 urgent.
enum AppStatusTone { success, warning, danger, neutral }
