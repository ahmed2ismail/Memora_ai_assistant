import 'package:equatable/equatable.dart';
import '../../domain/entities/settings_models.dart';

abstract class SettingsState extends Equatable {
  final String selectedModeId;
  final List<ExperienceMode> modes;
  final List<AccessibilityToggle> accessibilityToggles;
  final List<CognitiveReminderToggle> cognitiveReminders;
  final List<PricingPlan> plans;
  final String? alertMessage;

  const SettingsState({
    required this.selectedModeId,
    required this.modes,
    required this.accessibilityToggles,
    required this.cognitiveReminders,
    required this.plans,
    this.alertMessage,
  });

  @override
  List<Object?> get props => [selectedModeId, modes, accessibilityToggles, cognitiveReminders, plans, alertMessage];
}

class SettingsLoading extends SettingsState {
  const SettingsLoading()
      : super(
          selectedModeId: '',
          modes: const [],
          accessibilityToggles: const [],
          cognitiveReminders: const [],
          plans: const [],
        );
}

class SettingsLoaded extends SettingsState {
  const SettingsLoaded({
    required super.selectedModeId,
    required super.modes,
    required super.accessibilityToggles,
    required super.cognitiveReminders,
    required super.plans,
    super.alertMessage,
  });

  SettingsLoaded copyWith({
    String? selectedModeId,
    List<ExperienceMode>? modes,
    List<AccessibilityToggle>? accessibilityToggles,
    List<CognitiveReminderToggle>? cognitiveReminders,
    List<PricingPlan>? plans,
    String? alertMessage,
    bool clearAlert = false,
  }) {
    return SettingsLoaded(
      selectedModeId: selectedModeId ?? this.selectedModeId,
      modes: modes ?? this.modes,
      accessibilityToggles: accessibilityToggles ?? this.accessibilityToggles,
      cognitiveReminders: cognitiveReminders ?? this.cognitiveReminders,
      plans: plans ?? this.plans,
      alertMessage: clearAlert ? null : (alertMessage ?? this.alertMessage),
    );
  }
}
