import 'package:flutter/services.dart';

/// Centralised tactile feedback so every "important" action across the app
/// feels the same: accepting an order, paying, completing a job, errors.
///
/// Kept as a thin wrapper (rather than scattering HapticFeedback.* calls)
/// so intensity/behavior can be tuned in one place, and so it can be
/// disabled globally later (e.g. a "reduce haptics" setting) without
/// touching every screen.
class AppHaptics {
  AppHaptics._();

  static bool enabled = true;

  /// Light tick — button taps, list selection, toggles.
  static void tap() {
    if (!enabled) return;
    HapticFeedback.selectionClick();
  }

  /// Medium pulse — order accepted, item added to cart.
  static void success() {
    if (!enabled) return;
    HapticFeedback.mediumImpact();
  }

  /// Stronger pulse — payment confirmed, job completed.
  static void celebrate() {
    if (!enabled) return;
    HapticFeedback.heavyImpact();
  }

  /// Sharp double-buzz — errors, validation failures, cancellations.
  static void error() {
    if (!enabled) return;
    HapticFeedback.vibrate();
  }
}
