import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../di/injection_container.dart';
import '../../domain/entities/ai_entities.dart';
import '../cubit/ai_assistant_cubit.dart';
import '../cubit/ai_assistant_state.dart';

class AiAssistantPage extends StatelessWidget {
  const AiAssistantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AiAssistantCubit>(),
      child: const AiAssistantView(),
    );
  }
}

class AiAssistantView extends StatefulWidget {
  const AiAssistantView({super.key});

  @override
  State<AiAssistantView> createState() => _AiAssistantViewState();
}

class _AiAssistantViewState extends State<AiAssistantView> {
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 100), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  Color _fromHex(String hexString) {
    var buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  IconData _getIcon(String name) {
    switch (name) {
      case 'auto_awesome': return Icons.auto_awesome;
      case 'schedule': return Icons.schedule;
      case 'directions_run': return Icons.directions_run;
      default: return Icons.star;
    }
  }

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AiAssistantCubit, AiAssistantState>(
      listener: (context, state) {
        _scrollToBottom();
      },
      builder: (context, state) {
        return SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.only(top: 100, bottom: 120, left: 24, right: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildOrbHeader(context),
              const SizedBox(height: 32),
              if (state.chatHistory.isEmpty) _buildSuggestions(context, state.suggestions),
              _buildChatHistory(context, state.chatHistory, state is AiAssistantProcessing),
              const SizedBox(height: 48),
              _buildQuickReminderCard(context),
              const SizedBox(height: 48),
              _buildContextualSuggestions(context, state.contexts),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOrbHeader(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [AppColors.primary.withValues(alpha: 0.4), Colors.transparent],
              stops: const [0.3, 1.0],
            ),
          ),
          child: Center(
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(colors: [AppColors.primary, AppColors.surfaceContainerLow]),
                boxShadow: [
                  BoxShadow(color: AppColors.primary.withValues(alpha: 0.5), blurRadius: 30, spreadRadius: 5),
                ],
              ),
              child: const Icon(Icons.psychology, color: Color(0xFF003824), size: 36),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text("I'm listening, Alex.", style: AppStyles.headline(context, weight: FontWeight.w800, fontSize: 32)),
        const SizedBox(height: 8),
        Text("Tell me what you need to remember.", style: AppStyles.body14(context)),
      ],
    );
  }

  Widget _buildSuggestions(BuildContext context, List<QuickSuggestion> suggestions) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.5,
      physics: const NeverScrollableScrollPhysics(),
      children: suggestions.map((suggestion) {
        final color = _fromHex(suggestion.colorHex);
        return GestureDetector(
          onTap: () => context.read<AiAssistantCubit>().applySuggestion(suggestion.text),
          child: GlassCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(_getIcon(suggestion.iconName), color: color, size: 24),
                const SizedBox(height: 8),
                Text(suggestion.text, style: AppStyles.body12(context, color: AppColors.onSurfaceVariant)),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildChatHistory(BuildContext context, List<ChatMessage> history, bool isProcessing) {
    return Column(
      children: [
        ...history.map((msg) => _buildChatBubble(context, msg)),
        if (isProcessing)
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: GlassCard(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                borderRadius: 20,
                child: const SizedBox(
                  width: 40,
                  height: 20,
                  child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildChatBubble(BuildContext context, ChatMessage msg) {
    return Align(
      alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
        decoration: BoxDecoration(
          color: msg.isUser ? AppColors.primaryContainer : AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(msg.isUser ? 20 : 0),
            bottomRight: Radius.circular(msg.isUser ? 0 : 20),
          ),
          border: msg.isUser ? Border.all(color: AppColors.primary.withValues(alpha: 0.3)) : Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
        ),
        child: Text(
          msg.text,
          style: AppStyles.body14(context, color: msg.isUser ? AppColors.primary : AppColors.onSurface),
        ),
      ),
    );
  }

  Widget _buildQuickReminderCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.add_circle, color: AppColors.secondary),
              const SizedBox(width: 8),
              Text("Create Quick Reminder", style: AppStyles.body16(context, weight: FontWeight.bold).copyWith(fontSize: 18)),
            ],
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _inputController,
            style: AppStyles.body14(context, color: AppColors.onSurface),
            decoration: InputDecoration(
              hintText: "What should I remember?",
              hintStyle: AppStyles.body14(context, color: AppColors.onSurfaceVariant),
              filled: true,
              fillColor: AppColors.surface,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            ),
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                context.read<AiAssistantCubit>().sendMessage(value);
                _inputController.clear();
              }
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildActionButton(context, Icons.alarm, "Time")),
              const SizedBox(width: 12),
              Expanded(child: _buildActionButton(context, Icons.location_on, "Place")),
              const SizedBox(width: 12),
              Expanded(child: _buildActionButton(context, Icons.mic, "Voice")),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(colors: [AppColors.primary, Color(0xFF00A471)]),
                boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.2), blurRadius: 15, offset: const Offset(0, 5))],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    if (_inputController.text.isNotEmpty) {
                      context.read<AiAssistantCubit>().sendMessage(_inputController.text);
                      _inputController.clear();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Center(child: Text("Save Memory", style: AppStyles.body14(context, color: const Color(0xFF003824), weight: FontWeight.bold))),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 16, color: AppColors.onSurface),
          const SizedBox(width: 8),
          Text(label, style: AppStyles.body12(context, weight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildContextualSuggestions(BuildContext context, List<SmartContext> contexts) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("SMART CONTEXT", style: AppStyles.custom(context, color: AppColors.onSurfaceVariant, weight: FontWeight.bold, fontSize: 10, letterSpacing: 2)),
        const SizedBox(height: 16),
        ...contexts.map((ctx) => GlassCard(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(color: AppColors.surfaceContainer, shape: BoxShape.circle),
                child: Icon(_getIcon(ctx.iconName), color: AppColors.primary),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(ctx.title, style: AppStyles.body14(context, weight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(ctx.description, style: AppStyles.body12(context, color: AppColors.onSurfaceVariant)),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.onSurfaceVariant),
            ],
          ),
        )),
      ],
    );
  }
}
