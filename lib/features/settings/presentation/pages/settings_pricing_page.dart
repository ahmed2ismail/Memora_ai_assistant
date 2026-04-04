import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../di/injection_container.dart';
import '../../domain/entities/settings_models.dart';
import '../cubit/settings_cubit.dart';
import '../cubit/settings_state.dart';

class SettingsPricingPage extends StatelessWidget {
  const SettingsPricingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SettingsCubit>(),
      child: const SettingsPricingView(),
    );
  }
}

class SettingsPricingView extends StatelessWidget {
  const SettingsPricingView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 100, bottom: 120, left: 24, right: 24),
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          if (state is SettingsLoading) {
            return const SizedBox(
              height: 500,
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (state is SettingsLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                const SizedBox(height: 32),
                _buildExperienceModeCard(context, state),
                const SizedBox(height: 16),
                _buildAccessibilityBento(context, state),
                const SizedBox(height: 16),
                _buildCognitiveRemindersCard(context, state),
                const SizedBox(height: 48),
                _buildPricingHeader(context),
                const SizedBox(height: 32),
                _buildPricingCards(context, state.plans),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  // ─── Settings Header ──────────────────────────────────────────────────

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Settings',
          style: AppStyles.headline(context, fontSize: 40),
        ),
        const SizedBox(height: 8),
        Text(
          'Manage your account, experience mode, and accessibility preferences.',
          style: AppStyles.body14(context),
        ),
      ],
    );
  }

  // ─── Experience Mode Selector ─────────────────────────────────────────

  Widget _buildExperienceModeCard(BuildContext context, SettingsLoaded state) {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'EXPERIENCE MODE',
            style: AppStyles.custom(
              context,
              fontSize: 10,
              color: AppColors.primary,
              weight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Tailors the UI and AI focus based on your needs.',
            style: AppStyles.body12(context),
          ),
          const SizedBox(height: 20),
          ...state.modes.map((mode) {
            final isSelected = mode.id == state.selectedModeId;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => context.read<SettingsCubit>().selectMode(mode.id),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primaryContainer
                          : AppColors.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(16),
                      border: isSelected
                          ? Border.all(color: AppColors.primary.withValues(alpha: 0.3))
                          : null,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              _getModeIcon(mode.iconName),
                              color: isSelected ? AppColors.primary : AppColors.onSurface,
                              size: 22,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              mode.label,
                              style: AppStyles.body14(
                                context,
                                color: isSelected ? AppColors.primary : AppColors.onSurface,
                                weight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        if (isSelected)
                          const Icon(Icons.check_circle, color: AppColors.primary, size: 20),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  // ─── Accessibility Bento Grid ─────────────────────────────────────────

  Widget _buildAccessibilityBento(BuildContext context, SettingsLoaded state) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 500) {
          return Row(
            children: state.accessibilityToggles.map((toggle) {
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: toggle == state.accessibilityToggles.first ? 8 : 0,
                    left: toggle == state.accessibilityToggles.last ? 8 : 0,
                  ),
                  child: _buildAccessibilityCard(context, toggle),
                ),
              );
            }).toList(),
          );
        }
        return Column(
          children: state.accessibilityToggles.map((toggle) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _buildAccessibilityCard(context, toggle),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildAccessibilityCard(BuildContext context, AccessibilityToggle toggle) {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      child: SizedBox(
        height: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  _getAccessibilityIcon(toggle.iconName),
                  color: AppColors.secondary,
                  size: 24,
                ),
                _buildCustomSwitch(context, toggle.isEnabled, () {
                  context.read<SettingsCubit>().toggleAccessibility(toggle.id);
                }),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(toggle.title, style: AppStyles.body16(context)),
                const SizedBox(height: 4),
                Text(toggle.subtitle, style: AppStyles.body12(context)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ─── Cognitive Reminders ──────────────────────────────────────────────

  Widget _buildCognitiveRemindersCard(BuildContext context, SettingsLoaded state) {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.notifications_active, color: AppColors.primary, size: 22),
                  const SizedBox(width: 12),
                  Text('Cognitive Reminders', style: AppStyles.body16(context)),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Pro Feature',
                  style: AppStyles.body12(context, color: AppColors.primary, weight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...List.generate(state.cognitiveReminders.length, (index) {
            final reminder = state.cognitiveReminders[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(reminder.label, style: AppStyles.body14(context, color: AppColors.onSurface)),
                    GestureDetector(
                      onTap: () => context.read<SettingsCubit>().toggleCognitiveReminder(index),
                      child: Icon(
                        reminder.isEnabled ? Icons.toggle_on : Icons.toggle_off,
                        color: reminder.isEnabled ? AppColors.primary : AppColors.outlineVariant,
                        size: 36,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  // ─── Pricing Section ──────────────────────────────────────────────────

  Widget _buildPricingHeader(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            'Choose Your Journey',
            style: AppStyles.headline(context, fontSize: 32),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: Text(
            'Elevate your cognitive health with specialized AI assistance tailored for your life stage.',
            style: AppStyles.body14(context),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildPricingCards(BuildContext context, List<PricingPlan> plans) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 700) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: plans.map((plan) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: _buildPricingCard(context, plan),
                ),
              );
            }).toList(),
          );
        }
        return Column(
          children: plans.map((plan) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: _buildPricingCard(context, plan),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildPricingCard(BuildContext context, PricingPlan plan) {
    final Color accentColor;
    switch (plan.accentColorMode) {
      case 'primary':
        accentColor = AppColors.primary;
        break;
      case 'secondary':
        accentColor = AppColors.secondary;
        break;
      default:
        accentColor = AppColors.onSurface;
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        GlassCard(
          borderRadius: 32,
          padding: const EdgeInsets.all(28),
          border: plan.isPopular
              ? Border.all(color: AppColors.primary.withValues(alpha: 0.2))
              : plan.accentColorMode == 'secondary'
                  ? Border.all(color: AppColors.secondary.withValues(alpha: 0.2))
                  : null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (plan.isPopular) const SizedBox(height: 8),
              // Plan Name
              Text(
                plan.name,
                style: AppStyles.body16(context, color: accentColor),
              ),
              const SizedBox(height: 8),
              // Price
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '\$${plan.pricePerMonth}',
                    style: AppStyles.custom(
                      context,
                      fontSize: 36,
                      weight: FontWeight.w800,
                      color: AppColors.onSurface,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text('/month', style: AppStyles.body12(context)),
                ],
              ),
              if (plan.subtitle != null) ...[
                const SizedBox(height: 8),
                Text(
                  plan.subtitle!,
                  style: AppStyles.custom(
                    context,
                    fontSize: 10,
                    color: accentColor.withValues(alpha: 0.7),
                    weight: FontWeight.w500,
                  ),
                ),
              ],
              const SizedBox(height: 28),
              // Features
              ...plan.features.map((feature) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      Icon(
                        feature.isIncluded
                            ? (feature.iconOverride != null
                                ? _getFeatureIcon(feature.iconOverride!)
                                : Icons.check_circle)
                            : Icons.cancel,
                        color: feature.isIncluded
                            ? accentColor
                            : AppColors.onSurfaceVariant.withValues(alpha: 0.4),
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          feature.text,
                          style: AppStyles.body14(
                            context,
                            color: feature.isIncluded
                                ? AppColors.onSurface
                                : AppColors.onSurface.withValues(alpha: 0.4),
                            weight: feature.isBold ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 12),
              // CTA Button
              _buildPricingButton(context, plan, accentColor),
            ],
          ),
        ),
        // "Most Popular" Badge
        if (plan.isPopular)
          Positioned(
            top: -14,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'MOST POPULAR',
                  style: AppStyles.custom(
                    context,
                    fontSize: 10,
                    weight: FontWeight.bold,
                    color: AppColors.onPrimary,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildPricingButton(BuildContext context, PricingPlan plan, Color accentColor) {
    if (plan.isCurrent) {
      return SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: AppColors.outlineVariant.withValues(alpha: 0.2)),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          onPressed: () {},
          child: Text(plan.buttonLabel, style: AppStyles.body14(context, weight: FontWeight.bold)),
        ),
      );
    }

    if (plan.isPopular) {
      return SizedBox(
        width: double.infinity,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              colors: [AppColors.primary, Color(0xFF00A471)],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.2),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: Text(
                    plan.buttonLabel,
                    style: AppStyles.body14(context, color: AppColors.onPrimary, weight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    // Secondary accent (Life Care)
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: accentColor.withValues(alpha: 0.4)),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        onPressed: () {},
        child: Text(
          plan.buttonLabel,
          style: AppStyles.body14(context, color: accentColor, weight: FontWeight.bold),
        ),
      ),
    );
  }

  // ─── Custom Switch ────────────────────────────────────────────────────

  Widget _buildCustomSwitch(BuildContext context, bool isEnabled, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 48,
        height: 24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isEnabled ? AppColors.primary : AppColors.surfaceContainerHighest,
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment: isEnabled ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.all(3),
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isEnabled ? Colors.white : AppColors.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }

  // ─── Icon Helpers ─────────────────────────────────────────────────────

  IconData _getModeIcon(String name) {
    switch (name) {
      case 'psychology': return Icons.psychology;
      case 'school': return Icons.school;
      case 'person': return Icons.person;
      default: return Icons.person;
    }
  }

  IconData _getAccessibilityIcon(String name) {
    switch (name) {
      case 'visibility': return Icons.visibility;
      case 'text_fields': return Icons.text_fields;
      default: return Icons.settings;
    }
  }

  IconData _getFeatureIcon(String name) {
    switch (name) {
      case 'auto_awesome': return Icons.auto_awesome;
      case 'psychology': return Icons.psychology;
      default: return Icons.check_circle;
    }
  }
}
