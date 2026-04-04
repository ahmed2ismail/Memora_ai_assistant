import 'package:equatable/equatable.dart';
import '../../domain/entities/settings_models.dart';

abstract class SettingsState extends Equatable {
  final String selectedModeId;
  final List<ExperienceMode> modes;
  final List<AccessibilityToggle> accessibilityToggles;
  final List<CognitiveReminderToggle> cognitiveReminders;
  final List<PricingPlan> plans;

  const SettingsState({
    required this.selectedModeId,
    required this.modes,
    required this.accessibilityToggles,
    required this.cognitiveReminders,
    required this.plans,
  });

  @override
  List<Object> get props => [selectedModeId, modes, accessibilityToggles, cognitiveReminders, plans];
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
  });
}
