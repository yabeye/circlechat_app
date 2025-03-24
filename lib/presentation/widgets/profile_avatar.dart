import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:circlechat_app/core/constants/app_sizes.dart';
import 'package:circlechat_app/core/constants/asset_files.dart';
import 'package:circlechat_app/core/theme/app_theme.dart';
import 'package:circlechat_app/data/models/status_model.dart';
import 'package:circlechat_app/presentation/cubit/auth/auth_cubit.dart';
import 'package:circlechat_app/presentation/cubit/presence/presence_cubit.dart';
import 'package:circlechat_app/presentation/widgets/app_widgets/app_image.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    required this.profileId,
    this.imageUrl,
    this.isGroup = false,
    this.isChannel = false,
    this.width,
    this.height,
    this.status,
    this.showOnline = true,
    this.showAddStory = false,
  });

  final String profileId;
  final String? imageUrl;
  final bool isGroup;
  final bool isChannel;
  final double? width;
  final double? height;
  final StatusModel? status;
  final bool showOnline;
  final bool showAddStory;

  @override
  Widget build(BuildContext context) {
    final hasProfilePic = (imageUrl ?? '').isNotEmpty;
    final profileId = this.profileId.replaceAll(' ', '_');
    double width = this.width ?? AppSizes.profilePicSize;
    double height = this.height ?? AppSizes.profilePicSize;

    final hasStatus = status != null;
    if (hasStatus) {
      width *= .8;
      height *= .8;
    }

    // context.read<PresenceCubit>().startPresenceListener(profileId);

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final isMyProfile = context.read<AuthCubit>().isMyId(profileId);

        return Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: hasStatus
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: darkTheme.primaryColor,
                        width: 3,
                      ),
                    )
                  : null,
              child: Padding(
                padding: EdgeInsets.all(hasStatus ? 2.0 : 0),
                child: hasProfilePic
                    ? AppCachedNetworkImage(
                        borderRadius: BorderRadius.circular(100),
                        width: width,
                        height: height,
                        imageUrl: imageUrl ?? '',
                      )
                    : isGroup
                        ? KIcons.defaultGroupProfilePic()
                        : KIcons.defaultProfilePic(),
              ),
            ),
            // online show
            if (showOnline)
              BlocProvider<PresenceCubit>(
                create: (context) =>
                    PresenceCubit()..startPresenceListener(profileId),
                child: BlocBuilder<PresenceCubit, PresenceState>(
                  builder: (context, state) {
                    if (state is PresenceUpdated) {
                      if (state.isOnline) {
                        return Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              color: darkTheme.primaryColor,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                width: 2,
                              ),
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            if (isMyProfile && showAddStory)
              Positioned(
                right: 0,
                bottom: 0,
                child: InkWell(
                  onTap: () {
                    // TODO: Implement add a story logic
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.add,
                      size: 22,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
