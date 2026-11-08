import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';
import '../../../core/widgets/fbc_button.dart';
import '../../matchmaker/presentation/widgets/collaboration_modal.dart';
import '../../registration/presentation/widgets/claim_card_modal.dart';
import 'controllers/wall_controller.dart';
import 'controllers/wall_state.dart';
import 'widgets/attendee_card.dart';
import 'widgets/floating_navbar.dart';
import 'widgets/hero_telemetry.dart';
import 'widgets/skill_filter_bar.dart';

class WallPage extends StatefulWidget {
  const WallPage({super.key});

  @override
  State<WallPage> createState() => _WallPageState();
}

class _WallPageState extends State<WallPage> {
  late final WallController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WallController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _openClaimCard() {
    ClaimCardModal.show(
      context,
      onCardCreated: () => _controller.init(),
    );
  }

  void _showPresenterResetDialog() {
    final passwordController = TextEditingController();
    String? errorMessage;
    bool isSubmitting = false;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            Future<void> submit() async {
              final pin = passwordController.text.trim();
              if (pin.isEmpty) {
                setDialogState(() {
                  errorMessage = 'Please enter your presenter PIN.';
                });
                return;
              }

              setDialogState(() {
                isSubmitting = true;
                errorMessage = null;
              });

              final messenger = ScaffoldMessenger.of(this.context);
              final nav = Navigator.of(dialogContext);

              final success = await _controller.resetWall(pin);

              if (!mounted) return;

              if (success) {
                nav.pop();
                messenger.showSnackBar(
                  SnackBar(
                    content: const Row(
                      children: [
                        Icon(Icons.check_circle_outline, color: Colors.white, size: 18),
                        SizedBox(width: 8),
                        Text('Demo reset complete! The wall is clean for your showcase.'),
                      ],
                    ),
                    backgroundColor: const Color(0xFF10B981),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                );
              } else {
                setDialogState(() {
                  isSubmitting = false;
                  errorMessage = 'That passcode is incorrect. Please check your PIN and try again.';
                });
              }
            }

            return AlertDialog(
              backgroundColor: FbcColors.card,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: FbcColors.border.withValues(alpha: 0.8)),
              ),
              title: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: FbcColors.blue.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.lock_reset, color: FbcColors.sky, size: 20),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Presenter Demo Reset',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                ],
              ),
              content: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 360),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enter your passcode to wipe test cards and return the wall to a clean slate.',
                      style: FbcTypography.bodyMuted.copyWith(fontSize: 13),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      autofocus: true,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => submit(),
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'Enter presenter PIN',
                        hintStyle: TextStyle(
                          color: FbcColors.muted.withValues(alpha: 0.6),
                          fontSize: 13,
                        ),
                        filled: true,
                        fillColor: FbcColors.navy,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: FbcColors.border),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: FbcColors.border),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: FbcColors.sky),
                        ),
                      ),
                    ),
                    if (errorMessage != null) ...[
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEF4444).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: const Color(0xFFEF4444).withValues(alpha: 0.4),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.info_outline, size: 16, color: Color(0xFFFCA5A5)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                errorMessage!,
                                style: const TextStyle(color: Color(0xFFFCA5A5), fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              actionsPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              actions: [
                TextButton(
                  onPressed: isSubmitting ? null : () => Navigator.of(dialogContext).pop(),
                  child: const Text('Cancel', style: TextStyle(color: FbcColors.muted)),
                ),
                FbcButton(
                  label: 'Reset Wall',
                  icon: Icons.delete_sweep_outlined,
                  isLoading: isSubmitting,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  fontSize: 12,
                  onPressed: isSubmitting ? null : submit,
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Scaffold(
      backgroundColor: FbcColors.navy,
      body: ValueListenableBuilder<WallState>(
        valueListenable: _controller,
        builder: (context, state, _) {
          return Stack(
            children: [
              // Layer 1: Scrollable Wall Feed (scrolls smoothly underneath navbar)
              Positioned.fill(
                child: CustomScrollView(
                  slivers: [
                    // Top Spacer to account for pinned floating navbar
                    SliverToBoxAdapter(
                      child: SizedBox(height: isMobile ? 68 : 80),
                    ),

                    // Hero Telemetry Section
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 16 : 24,
                          vertical: 12,
                        ),
                        child: HeroTelemetry(totalBuilders: state.totalCount),
                      ),
                    ),

                    // Search & Skill Filters
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 16 : 24,
                          vertical: 16,
                        ),
                        child: SkillFilterBar(
                          selectedFilter: state.selectedFilter,
                          onFilterChanged: (filter) => _controller.setFilter(filter),
                          onSearchChanged: (query) => _controller.setSearchQuery(query),
                        ),
                      ),
                    ),

                    // Content Body / Grid
                    if (state.isLoading)
                      const SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(FbcColors.sky),
                          ),
                        ),
                      )
                    else if (state.errorMessage != null && state.allProfiles.isEmpty)
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.wifi_off, size: 40, color: FbcColors.muted),
                                const SizedBox(height: 14),
                                Text(
                                  'Unable to connect to Serverpod Live Feed',
                                  style: FbcTypography.h3,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  state.errorMessage!,
                                  style: FbcTypography.bodyMuted,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 18),
                                ElevatedButton.icon(
                                  onPressed: () => _controller.init(),
                                  icon: const Icon(Icons.refresh, size: 16),
                                  label: const Text('Retry Connection'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    else if (state.filteredProfiles.isEmpty)
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(40.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.group_off_outlined, size: 44, color: FbcColors.muted),
                                const SizedBox(height: 16),
                                Text(
                                  state.searchQuery.isNotEmpty
                                      ? 'No engineers found matching "${state.searchQuery}"'
                                      : 'No developer cards registered yet on the wall.',
                                  style: FbcTypography.h3,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Be the first engineer to claim a card and synthesize your persona!',
                                  style: FbcTypography.bodyMuted,
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: _openClaimCard,
                                  child: const Text('Claim Your Card Now'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    else
                      SliverPadding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 16 : 24,
                          vertical: 20,
                        ),
                        sliver: SliverLayoutBuilder(
                          builder: (context, constraints) {
                            final width = constraints.crossAxisExtent;
                            final int crossAxisCount = width < 680
                                ? 1
                                : width < 1120
                                    ? 2
                                    : 3;

                            final profiles = state.filteredProfiles;
                            final double mainAxisExtent = width < 480 ? 326 : 310;

                            return SliverGrid(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: 18,
                                mainAxisSpacing: 18,
                                mainAxisExtent: mainAxisExtent,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  final profile = profiles[index];
                                  return AttendeeCard(
                                    profile: profile,
                                    onCollaborate: () {
                                      CollaborationModal.show(
                                        context,
                                        devOne: profile,
                                        allProfiles: state.allProfiles,
                                      );
                                    },
                                  );
                                },
                                childCount: profiles.length,
                              ),
                            );
                          },
                        ),
                      ),

                    // Bottom Spacer
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 48),
                    ),
                  ],
                ),
              ),

              // Layer 2: Always-Visible Sticky Top Navbar with Frosted Blur
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: isMobile ? 8 : 14,
                      left: isMobile ? 12 : 20,
                      right: isMobile ? 12 : 20,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 800),
                        child: FloatingNavbar(
                          onlineCount: state.totalCount,
                          onClaimCardPressed: _openClaimCard,
                          onLogoLongPress: _showPresenterResetDialog,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
