// Models for the Pricing & Settings feature.

class ExperienceMode {
  final String id;
  final String label;
  final String iconName;

  const ExperienceMode({
    required this.id,
    required this.label,
    required this.iconName,
  });
}

class AccessibilityToggle {
  final String id;
  final String title;
  final String subtitle;
  final String iconName;
  final bool isEnabled;

  const AccessibilityToggle({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.iconName,
    required this.isEnabled,
  });

  AccessibilityToggle copyWith({bool? isEnabled}) {
    return AccessibilityToggle(
      id: id,
      title: title,
      subtitle: subtitle,
      iconName: iconName,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }
}

class CognitiveReminderToggle {
  final String label;
  final bool isEnabled;

  const CognitiveReminderToggle({
    required this.label,
    required this.isEnabled,
  });

  CognitiveReminderToggle copyWith({bool? isEnabled}) {
    return CognitiveReminderToggle(
      label: label,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }
}

class PricingPlan {
  final String id;
  final String name;
  final int pricePerMonth;
  final String? subtitle;
  final List<PlanFeature> features;
  final String buttonLabel;
  final bool isPopular;
  final bool isCurrent;
  final String accentColorMode; // 'primary', 'secondary', 'default'

  const PricingPlan({
    required this.id,
    required this.name,
    required this.pricePerMonth,
    this.subtitle,
    required this.features,
    required this.buttonLabel,
    this.isPopular = false,
    this.isCurrent = false,
    this.accentColorMode = 'default',
  });
}

class PlanFeature {
  final String text;
  final bool isIncluded;
  final bool isBold;
  final String? iconOverride; // null = check_circle

  const PlanFeature({
    required this.text,
    required this.isIncluded,
    this.isBold = false,
    this.iconOverride,
  });
}
