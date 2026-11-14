import 'package:flutter/services.dart';

/// Tactile haptic feedback triggers optimized for lab bench interaction.
class LabHaptics {
  LabHaptics._();

  /// Fired upon tare or completing an ingredient weigh step.
  static Future<void> stepCompleted() async {
    await HapticFeedback.mediumImpact();
  }

  /// Fired upon completing an entire batch compounding session.
  static Future<void> batchSuccess() async {
    await HapticFeedback.heavyImpact();
  }

  /// Fired upon threshold warnings (e.g. over-pouring target weight).
  static Future<void> warning() async {
    await HapticFeedback.vibrate();
  }

  /// Fired on light touch/tab selection.
  static Future<void> selection() async {
    await HapticFeedback.selectionClick();
  }
}
