import 'package:flutter/material.dart';
import 'package:flutterbytes_connect_client/flutterbytes_connect_client.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/fbc_button.dart';
import '../../../../core/widgets/fbc_chip.dart';
import '../../../../core/widgets/fbc_modal_shell.dart';
import '../controllers/matchmaker_controller.dart';
import '../controllers/matchmaker_state.dart';

class CollaborationModal extends StatefulWidget {
  final AttendeeProfile devOne;
  final List<AttendeeProfile> allProfiles;

  const CollaborationModal({
    super.key,
    required this.devOne,
    required this.allProfiles,
  });

  static Future<void> show(
    BuildContext context, {
    required AttendeeProfile devOne,
    required List<AttendeeProfile> allProfiles,
  }) {
    return showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.75),
      builder: (_) => CollaborationModal(
        devOne: devOne,
        allProfiles: allProfiles,
      ),
    );
  }

  @override
  State<CollaborationModal> createState() => _CollaborationModalState();
}

class _CollaborationModalState extends State<CollaborationModal> {
  late final MatchmakerController _controller;
  AttendeeProfile? _selectedPartner;

  @override
  void initState() {
    super.initState();
    _controller = MatchmakerController();

    // Default partner is the first different developer in the list
    final candidates = widget.allProfiles.where((p) => p.id != widget.devOne.id).toList();
    if (candidates.isNotEmpty) {
      _selectedPartner = candidates.first;
      _triggerPairing();
    }
  }

  void _triggerPairing() {
    if (_selectedPartner != null && widget.devOne.id != null && _selectedPartner!.id != null) {
      _controller.pairDevelopers(
        devOneId: widget.devOne.id!,
        devTwoId: _selectedPartner!.id!,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final candidates = widget.allProfiles.where((p) => p.id != widget.devOne.id).toList();

    return FbcModalShell(
      title: 'Hackathon Architecture Synergy',
      subtitle: 'Synthesizing technical scope between engineers powered by Gemini & Serverpod.',
      maxWidth: 680,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Partner Selection Bar
          if (candidates.length > 1) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: FbcColors.card,
                borderRadius: FbcDecorations.borderRadiusMd,
                border: Border.all(color: FbcColors.border),
              ),
              child: Row(
                children: [
                  const Icon(Icons.people_outline, size: 18, color: FbcColors.sky),
                  const SizedBox(width: 10),
                  Text('Pair ${widget.devOne.name} with:', style: FbcTypography.caption),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<AttendeeProfile>(
                        value: _selectedPartner,
                        dropdownColor: FbcColors.dark,
                        style: FbcTypography.bodyMedium,
                        isExpanded: true,
                        items: candidates.map((p) {
                          return DropdownMenuItem(
                            value: p,
                            child: Text('${p.name} (${p.role})'),
                          );
                        }).toList(),
                        onChanged: (partner) {
                          if (partner != null) {
                            setState(() => _selectedPartner = partner);
                            _triggerPairing();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],

          // Synergy Body
          ValueListenableBuilder<MatchmakerState>(
            valueListenable: _controller,
            builder: (context, state, _) {
              if (state.isLoading) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(48.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          width: 36,
                          height: 36,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation<Color>(FbcColors.sky),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          'Analyzing engineering skillsets with Gemini 2.5...',
                          style: FbcTypography.bodyMuted,
                        ),
                      ],
                    ),
                  ),
                );
              }

              if (state.errorMessage != null) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      children: [
                        const Icon(Icons.error_outline, size: 36, color: Colors.redAccent),
                        const SizedBox(height: 12),
                        Text(state.errorMessage!, style: FbcTypography.bodyMuted),
                        const SizedBox(height: 16),
                        FbcButton(
                          label: 'Retry Synergy Analysis',
                          isOutlined: true,
                          onPressed: _triggerPairing,
                        ),
                      ],
                    ),
                  ),
                );
              }

              final match = state.match;
              if (match == null) {
                return const SizedBox.shrink();
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Telemetry Header
                  Row(
                    children: [
                      const FbcChip(
                        label: '96.4% Architecture Synergy',
                        hasDot: true,
                        dotColor: FbcColors.emerald,
                      ),
                      const SizedBox(width: 10),
                      const FbcChip(
                        label: 'Serverpod Cloud 4.1',
                        textColor: FbcColors.muted,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Project Title
                  Text(match.projectTitle, style: FbcTypography.h1),
                  const SizedBox(height: 8),

                  // Elevator Pitch Tagline
                  Text(
                    match.tagline,
                    style: FbcTypography.bodyLarge.copyWith(color: FbcColors.white),
                  ),
                  const SizedBox(height: 24),

                  // Deliverables Scope Breakdown
                  Text('Engineering Scope & Deliverables', style: FbcTypography.h3),
                  const SizedBox(height: 12),

                  // Grid for Dev 1 vs Dev 2
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isNarrow = constraints.maxWidth < 560;

                      final card1 = Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: FbcColors.card,
                          borderRadius: FbcDecorations.borderRadiusMd,
                          border: Border.all(color: FbcColors.border),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.code, size: 16, color: FbcColors.sky),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    match.devOneName,
                                    style: FbcTypography.h3.copyWith(fontSize: 14),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              match.devOneResponsibility,
                              style: FbcTypography.bodyMedium.copyWith(color: FbcColors.muted),
                            ),
                          ],
                        ),
                      );

                      final card2 = Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: FbcColors.card,
                          borderRadius: FbcDecorations.borderRadiusMd,
                          border: Border.all(color: FbcColors.border),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.dns, size: 16, color: FbcColors.purple),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    match.devTwoName,
                                    style: FbcTypography.h3.copyWith(fontSize: 14),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              match.devTwoResponsibility,
                              style: FbcTypography.bodyMedium.copyWith(color: FbcColors.muted),
                            ),
                          ],
                        ),
                      );

                      if (isNarrow) {
                        return Column(
                          children: [
                            card1,
                            const SizedBox(height: 12),
                            card2,
                          ],
                        );
                      }

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: card1),
                          const SizedBox(width: 14),
                          Expanded(child: card2),
                        ],
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
