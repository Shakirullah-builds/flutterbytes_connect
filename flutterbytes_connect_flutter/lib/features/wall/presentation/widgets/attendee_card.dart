import 'package:flutter/material.dart';
import 'package:flutterbytes_connect_client/flutterbytes_connect_client.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/utils/avatar_utils.dart';
import '../../../../core/widgets/fbc_button.dart';
import '../../../../core/widgets/fbc_chip.dart';

class AttendeeCard extends StatefulWidget {
  final AttendeeProfile profile;
  final VoidCallback onCollaborate;

  const AttendeeCard({
    super.key,
    required this.profile,
    required this.onCollaborate,
  });

  @override
  State<AttendeeCard> createState() => _AttendeeCardState();
}

class _AttendeeCardState extends State<AttendeeCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final profile = widget.profile;
    final avatarUrl = AvatarUtils.getGithubAvatarUrl(profile.githubHandle);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: FbcDecorations.cardDecoration(isHovered: _isHovered),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Avatar, Name, Handle & Verified Badge
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    borderRadius: FbcDecorations.borderRadiusMd,
                    gradient: AvatarUtils.getGradient(profile.avatarSeed),
                    border: Border.all(color: FbcColors.border, width: 1.0),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: avatarUrl != null
                      ? Image.network(
                          avatarUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Center(
                            child: Text(
                              AvatarUtils.getInitials(profile.name),
                              style: FbcTypography.h3.copyWith(fontSize: 14),
                            ),
                          ),
                        )
                      : Center(
                          child: Text(
                            AvatarUtils.getInitials(profile.name),
                            style: FbcTypography.h3.copyWith(fontSize: 14),
                          ),
                        ),
                ),
                const SizedBox(width: 12),

                // Name & Meta
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              profile.name,
                              style: FbcTypography.h3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(
                            Icons.verified,
                            size: 14,
                            color: FbcColors.sky,
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        profile.githubHandle != null
                            ? '${profile.role} · @${profile.githubHandle}'
                            : profile.role,
                        style: FbcTypography.caption,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // AI Persona Title
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: FbcColors.dark,
                borderRadius: FbcDecorations.borderRadiusSm,
                border: Border.all(color: FbcColors.border),
              ),
              child: Text(
                profile.personaTitle,
                style: FbcTypography.personaTitle,
              ),
            ),
            const SizedBox(height: 10),

            // Bio / Project Interests
            Text(
              profile.bioHook,
              style: FbcTypography.bodyMedium.copyWith(color: FbcColors.white),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 14),

            // Skills Chips
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: profile.skills.take(4).map((skill) {
                return FbcChip(label: skill);
              }).toList(),
            ),
            const Spacer(),
            const SizedBox(height: 14),

            // Action: Collaborate
            FbcButton(
              label: 'Collaborate',
              icon: Icons.call_split,
              isOutlined: !_isHovered,
              width: double.infinity,
              onPressed: widget.onCollaborate,
            ),
          ],
        ),
      ),
    );
  }
}
