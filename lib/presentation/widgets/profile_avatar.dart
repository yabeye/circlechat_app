import 'package:circlechat_app/core/constants/app_sizes.dart';
import 'package:circlechat_app/core/constants/asset_files.dart';
import 'package:circlechat_app/core/theme/app_theme.dart';
import 'package:circlechat_app/data/models/status_model.dart';
import 'package:circlechat_app/presentation/cubit/auth/auth_cubit.dart';
import 'package:circlechat_app/presentation/widgets/app_widgets/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  });

  final String profileId;
  final String? imageUrl;
  final bool isGroup;
  final bool isChannel;
  final double? width;
  final double? height;
  final StatusModel? status;

  @override
  Widget build(BuildContext context) {
    final hasProfilePic = (imageUrl ?? '').isNotEmpty;

    double width = this.width ?? AppSizes.profilePicSize;
    double height = this.height ?? AppSizes.profilePicSize;

    final hasStatus = status != null;
    if (hasStatus) {
      width *= .8;
      height *= .8;
    }

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
            if (isMyProfile)
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
