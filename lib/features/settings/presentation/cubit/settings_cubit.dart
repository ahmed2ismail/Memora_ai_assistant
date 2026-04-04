import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/settings_models.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsLoading()) {
    _loadSettings();
  }

  void _loadSettings() {
    emit(SettingsLoaded(
      selectedModeId: 'patient',
      modes: const [
        ExperienceMode(id: 'patient', label: 'Patient', iconName: 'psychology'),
        ExperienceMode(id: 'student', label: 'Student', iconName: 'school'),
        ExperienceMode(id: 'normal', label: 'Normal', iconName: 'person'),
      ],
      accessibilityToggles: const [
        AccessibilityToggle(
          id: 'high_contrast',
          title: 'High Contrast',
          subtitle: 'Enhanced visibility for Patient Mode.',
          iconName: 'visibility',
          isEnabled: true,
        ),
        AccessibilityToggle(
          id: 'large_text',
          title: 'Large Text',
          subtitle: 'Optimize legibility across all screens.',
          iconName: 'text_fields',
          isEnabled: false,
        ),
      ],
      cognitiveReminders: const [
        CognitiveReminderToggle(label: 'Medication Alerts', isEnabled: true),
        CognitiveReminderToggle(label: 'Memory Checkpoints', isEnabled: true),
      ],
      plans: const [
        PricingPlan(
          id: 'standard',
          name: 'Standard',
          pricePerMonth: 0,
          features: [
            PlanFeature(text: 'Basic Note Taking', isIncluded: true),
            PlanFeature(text: 'Search History', isIncluded: true),
            PlanFeature(text: 'Advanced AI Assistant', isIncluded: false),
          ],
          buttonLabel: 'Current Plan',
          isCurrent: true,
        ),
        PricingPlan(
          id: 'student',
          name: 'Student',
          pricePerMonth: 9,
          accentColorMode: 'primary',
          isPopular: true,
          features: [
            PlanFeature(text: 'Pro AI Features included', isIncluded: true, isBold: true, iconOverride: 'auto_awesome'),
            PlanFeature(text: 'Smart Lecture Sync', isIncluded: true),
            PlanFeature(text: 'Flashcard Generator', isIncluded: true),
            PlanFeature(text: 'Multi-device Sync', isIncluded: true),
          ],
          buttonLabel: 'Get Started',
        ),
        PricingPlan(
          id: 'lifecare',
          name: 'Life Care',
          pricePerMonth: 19,
          subtitle: 'Specialized Alzheimer Support',
          accentColorMode: 'secondary',
          features: [
            PlanFeature(text: 'Cognitive Preservation Tools', isIncluded: true, iconOverride: 'psychology'),
            PlanFeature(text: 'Family Sharing & Alerts', isIncluded: true),
            PlanFeature(text: 'AI Face Recognition', isIncluded: true),
            PlanFeature(text: 'Emergency Geo-fencing', isIncluded: true),
          ],
          buttonLabel: 'Choose Life Care',
        ),
      ],
    ));
  }

  void selectMode(String modeId) {
    if (state is SettingsLoaded) {
      final loaded = state as SettingsLoaded;
      emit(loaded.copyWith(selectedModeId: modeId));
    }
  }

  void toggleAccessibility(String toggleId) {
    if (state is SettingsLoaded) {
      final loaded = state as SettingsLoaded;
      final updated = loaded.accessibilityToggles.map((t) {
        if (t.id == toggleId) return t.copyWith(isEnabled: !t.isEnabled);
        return t;
      }).toList();
      emit(loaded.copyWith(accessibilityToggles: updated));
    }
  }

  void toggleCognitiveReminder(int index) {
    if (state is SettingsLoaded) {
      final loaded = state as SettingsLoaded;
      final updated = List<CognitiveReminderToggle>.from(loaded.cognitiveReminders);
      updated[index] = updated[index].copyWith(isEnabled: !updated[index].isEnabled);
      emit(loaded.copyWith(cognitiveReminders: updated));
    }
  }

  void processAction(String message) async {
    if (state is SettingsLoaded) {
      final loaded = state as SettingsLoaded;
      emit(loaded.copyWith(alertMessage: "Connecting to App Store..."));
      await Future.delayed(const Duration(seconds: 1));
      emit(loaded.copyWith(alertMessage: message));
      await Future.delayed(const Duration(seconds: 2));
      emit(loaded.copyWith(clearAlert: true));
    }
  }
}
