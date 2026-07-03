import 'package:flutter/material.dart';

import '../../../core/theme/app_gradients.dart';

/// Maps numeric order status from API to readable label.
String orderStatusText(int status) {
  switch (status) {
    case 1:
      return 'Создан';
    case 2:
      return 'Ожидает мастера';
    case 3:
      return 'Назначен';
    case 4:
      return 'Принят';
    case 5:
      return 'В работе';
    case 6:
      return 'Завершён';
    case 7:
      return 'Отменён';
    case 8:
      return 'Спор';
    default:
      return 'Неизвестно';
  }
}

/// Maps numeric order status to display color.
Color orderStatusColor(int status) {
  switch (status) {
    case 4:
      return Colors.green;
    case 6:
      return const Color(0xFF1B5E20);
    case 7:
      return Colors.red;
    case 2:
    case 8:
      return Colors.orange;
    case 3:
    case 5:
      return Colors.blue;
    default:
      return Colors.grey;
  }
}

/// Maps numeric order status to a semantic tone (🟢 done · 🟡 in progress ·
/// 🔴 urgent/cancelled), used to drive [AppGradients.forStatus] /
/// `StatusBadge` so the color always matches the same rule everywhere.
AppStatusTone orderStatusTone(int status) {
  switch (status) {
    case 4:
    case 6:
      return AppStatusTone.success;
    case 7:
    case 8:
      return AppStatusTone.danger;
    case 2:
    case 3:
    case 5:
      return AppStatusTone.warning;
    default:
      return AppStatusTone.neutral;
  }
}

/// Resolves API status (numeric string or legacy enum name) to label + color.
({String label, Color color}) resolveOrderStatus(String status) {
  final code = int.tryParse(status.trim());
  if (code != null) {
    return (label: orderStatusText(code), color: orderStatusColor(code));
  }

  final lower = status.toLowerCase();
  final label = switch (lower) {
    'created' => 'Создан',
    'accepted' => 'Принят',
    'cancelled' => 'Отменён',
    'completed' => 'Завершён',
    'inprogress' || 'in_progress' => 'В работе',
    'assigned' => 'Назначен',
    'waitingmaster' || 'waiting_master' => 'Ожидает мастера',
    'dispute' => 'Спор',
    _ => status,
  };

  final color = lower.contains('cancel')
      ? Colors.red
      : lower.contains('completed')
          ? const Color(0xFF1B5E20)
          : lower.contains('accept')
              ? Colors.green
              : lower.contains('progress')
                  ? Colors.blue
                  : lower.contains('dispute')
                      ? Colors.orange
                      : Colors.grey;

  return (label: label, color: color);
}

/// Same resolution as [resolveOrderStatus] but returns a semantic
/// [AppStatusTone] instead of a raw [Color], for use with `StatusBadge`.
({String label, AppStatusTone tone}) resolveOrderStatusTone(String status) {
  final code = int.tryParse(status.trim());
  if (code != null) {
    return (label: orderStatusText(code), tone: orderStatusTone(code));
  }

  final lower = status.toLowerCase();
  final label = resolveOrderStatus(status).label;
  final tone = lower.contains('cancel') || lower.contains('dispute')
      ? AppStatusTone.danger
      : lower.contains('completed') || lower.contains('accept')
          ? AppStatusTone.success
          : lower.contains('progress') ||
                  lower.contains('assigned') ||
                  lower.contains('waiting')
              ? AppStatusTone.warning
              : AppStatusTone.neutral;

  return (label: label, tone: tone);
}
