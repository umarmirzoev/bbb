import 'package:flutter/material.dart';

import '../../theme/app_gradients.dart';
import '../../theme/app_radius.dart';

/// Pill badge whose color automatically follows order/master status
/// (🟢 done · 🟡 in progress · 🔴 urgent) instead of every screen picking
/// its own ad-hoc color for the same states.
class StatusBadge extends StatelessWidget {
  const StatusBadge({
    super.key,
    required this.label,
    required this.tone,
    this.dense = false,
  });

  final String label;
  final AppStatusTone tone;
  final bool dense;

  /// Convenience mapper from common backend status strings to a tone.
  /// Falls back to [AppStatusTone.neutral] for unknown values.
  factory StatusBadge.fromStatusKey(String key, {bool dense = false}) {
    final normalized = key.toLowerCase();
    AppStatusTone tone;
    String label;
    if (normalized.contains('done') ||
        normalized.contains('complete') ||
        normalized.contains('заверш') ||
        normalized.contains('выполн')) {
      tone = AppStatusTone.success;
      label = 'Выполнено';
    } else if (normalized.contains('urgent') ||
        normalized.contains('cancel') ||
        normalized.contains('срочн') ||
        normalized.contains('отмен')) {
      tone = AppStatusTone.danger;
      label = 'Срочно';
    } else if (normalized.contains('progress') ||
        normalized.contains('pending') ||
        normalized.contains('процесс') ||
        normalized.contains('ожид')) {
      tone = AppStatusTone.warning;
      label = 'В процессе';
    } else {
      tone = AppStatusTone.neutral;
      label = key;
    }
    return StatusBadge(label: label, tone: tone, dense: dense);
  }

  @override
  Widget build(BuildContext context) {
    final gradient = AppGradients.forStatus(tone);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: dense ? 8 : 12,
        vertical: dense ? 4 : 6,
      ),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: dense ? 11 : 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
