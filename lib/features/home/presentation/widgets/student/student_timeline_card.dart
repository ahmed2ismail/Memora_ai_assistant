import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_styles.dart';
import '../../../../../core/widgets/glass_card.dart';
import '../../../domain/entities/student_models.dart';

class StudentTimelineCard extends StatelessWidget {
  final StudentTimelineItem item;

  const StudentTimelineCard({
    super.key,
    required this.item,
  });

  Color _fromHex(String hexString) {
    if (hexString.isEmpty) return Colors.transparent;
    var buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    final dotColor = _fromHex(item.dotColorHex);
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            transform: Matrix4.translationValues(-6, 4, 0),
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: dotColor,
              shape: BoxShape.circle,
              border: item.isActive
                  ? Border.all(color: dotColor.withValues(alpha: 0.3), width: 4)
                  : null,
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: GlassCard(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(item.timeRange,
                              style: AppStyles.body12(context,
                                  color: dotColor, weight: FontWeight.bold)),
                        ),
                      ),
                      if (item.isActive)
                        const Icon(Icons.more_horiz,
                            size: 16, color: AppColors.onSurfaceVariant),
                    ],
                  ),
                  const SizedBox(height: 8),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(item.title, style: AppStyles.body16(context)),
                  ),
                  const SizedBox(height: 4),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(item.description, style: AppStyles.body14(context)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
