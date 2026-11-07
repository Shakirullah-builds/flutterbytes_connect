import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FbcColors.navy,
      body: ValueListenableBuilder<WallState>(
        valueListenable: _controller,
        builder: (context, state, _) {
          return CustomScrollView(
            slivers: [
              // Top Floating Navbar
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 10),
                  child: Center(
                    child: FloatingNavbar(
                      onlineCount: state.totalCount,
                      onClaimCardPressed: _openClaimCard,
                    ),
                  ),
                ),
              ),

              // Hero Telemetry Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: HeroTelemetry(totalBuilders: state.totalCount),
                ),
              ),

              // Search & Skill Filters
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  sliver: SliverLayoutBuilder(
                    builder: (context, constraints) {
                      final width = constraints.crossAxisExtent;
                      final int crossAxisCount = width < 680
                          ? 1
                          : width < 1120
                              ? 2
                              : 3;

                      final profiles = state.filteredProfiles;

                      return SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 18,
                          mainAxisSpacing: 18,
                          mainAxisExtent: 310,
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
          );
        },
      ),
    );
  }
}
