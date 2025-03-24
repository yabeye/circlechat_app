import 'package:circlechat_app/core/constants/app_constants.dart';
import 'package:circlechat_app/core/constants/app_sizes.dart';
import 'package:circlechat_app/core/constants/asset_files.dart';
import 'package:circlechat_app/core/locator.dart';
import 'package:circlechat_app/core/theme/app_colors.dart';
import 'package:circlechat_app/core/utils/app_formatters.dart';
import 'package:circlechat_app/core/utils/external_utils.dart';
import 'package:circlechat_app/core/utils/theme_utils.dart';
import 'package:circlechat_app/presentation/cubit/app_contacts/app_contacts_cubit.dart';
import 'package:circlechat_app/presentation/cubit/auth/auth_cubit.dart';
import 'package:circlechat_app/presentation/cubit/contacts/contacts_cubit.dart';
import 'package:circlechat_app/presentation/widgets/app_widgets/app_buttons.dart';
import 'package:circlechat_app/presentation/widgets/app_widgets/app_listtile.dart';
import 'package:circlechat_app/presentation/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/contact.dart';

class NewChatScreen extends StatelessWidget {
  const NewChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final myId = getIt.get<AuthCubit>().userId;

    return MultiBlocProvider(
      providers: [
        BlocProvider<ContactsCubit>(
          create: (context) => ContactsCubit()..loadContacts(),
        ),
        BlocProvider<AppContactsCubit>(
          create: (context) => AppContactsCubit()..loadContacts(),
        ),
      ],
      child: BlocBuilder<ContactsCubit, ContactsState>(
        builder: (context, state) {
          final List<Contact> contacts =
              (state is ContactsLoaded) ? state.contacts : [];

          return Scaffold(
            appBar: AppBar(
              title: AppListTile(
                title: 'Select Contact',
                subtitle: (contacts.isNotEmpty)
                    ? (contacts.length == 1
                        ? '1 contact'
                        : '${contacts.length} contacts')
                    : null,
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ],
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(
                vertical: AppSizes.globalPadding,
              ),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: AppColors.greyLight,
                  ),
                ),
              ),
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        AppListTile(
                          leading: Container(
                            width: AppSizes.profilePicSize * .8,
                            height: AppSizes.profilePicSize * .8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).primaryColor,
                            ),
                            child: Icon(
                              Icons.group_add,
                              size: AppSizes.profilePicSize * .5,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                          ),
                          title: 'New Group',
                          titleStyle:
                              ThemeUtils.chatListTileTitleTextStyle(context),
                          onTap: () {},
                        ),
                        AppListTile(
                          leading: Container(
                            width: AppSizes.profilePicSize * .8,
                            height: AppSizes.profilePicSize * .8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).primaryColor,
                            ),
                            child: Icon(
                              Icons.person_add_alt_1,
                              size: AppSizes.profilePicSize * .5,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                          ),
                          title: 'New Contact',
                          titleStyle:
                              ThemeUtils.chatListTileTitleTextStyle(context),
                          trailing: const Icon(Icons.qr_code),
                          onTap: () {},
                        ),
                        AppListTile(
                          leading: Container(
                            width: AppSizes.profilePicSize * .8,
                            height: AppSizes.profilePicSize * .8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).primaryColor,
                            ),
                            child: Icon(
                              Icons.people,
                              size: AppSizes.profilePicSize * .5,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                          ),
                          title: 'New Community',
                          titleStyle:
                              ThemeUtils.chatListTileTitleTextStyle(context),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(AppSizes.globalPadding),
                    sliver: SliverToBoxAdapter(
                      child: Text(
                        'Contacts on CircleChat',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ),
                  BlocBuilder<AppContactsCubit, AppContactsState>(
                    builder: (context, appContactsState) {
                      if (appContactsState is AppContactsLoading &&
                          appContactsState.contacts.isEmpty) {
                        return const SliverToBoxAdapter(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else if (appContactsState is AppContactsLoaded) {
                        if (appContactsState.contacts.isEmpty) {
                          return const SliverToBoxAdapter(
                            child: Center(child: Text('No contacts found.')),
                          );
                        }
                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              final contact = appContactsState.contacts[index];
                              final isMyContact = myId == contact.uid;

                              return AppListTile(
                                leading: ProfileAvatar(
                                  profileId: contact.uid,
                                  showOnline: !isMyContact,
                                  imageUrl: contact.profileImageUrl,
                                  width: AppSizes.profilePicSize * .8,
                                  height: AppSizes.profilePicSize * .8,
                                ),
                                title: isMyContact
                                    ? "${AppFormatters.formatPhoneNumber(
                                        contact.phoneNumber ?? '',
                                      )} (You)"
                                    : contact.name,
                                titleStyle:
                                    ThemeUtils.chatListTileTitleTextStyle(
                                  context,
                                ),
                                subtitle: isMyContact
                                    ? 'Message yourself'
                                    : contact.about,
                                onTap: () {
                                  // Navigator.of(context).pushNamed('/chat');
                                },
                              );
                            },
                            childCount: appContactsState.contacts.length,
                          ),
                        );
                      } else if (appContactsState is AppContactsError) {
                        return SliverToBoxAdapter(
                          child: Center(
                              child: Text('Error: ${appContactsState.error}')),
                        );
                      } else {
                        return const SliverToBoxAdapter(
                            child: SizedBox.shrink());
                      }
                    },
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(AppSizes.globalPadding),
                    sliver: SliverToBoxAdapter(
                      child: Text(
                        'Invite to CircleChat',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ),
                  (state is ContactsLoading)
                      ? const SliverToBoxAdapter(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : (state is ContactsPermissionDenied)
                          ? const Text(
                              'TODO: Show contacts permission denied button')
                          : SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  final groupedContacts =
                                      groupContacts(contacts);
                                  final initials = groupedContacts.keys.toList()
                                    ..sort();

                                  int currentItemIndex = 0;
                                  for (final initial in initials) {
                                    if (index == currentItemIndex) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: AppSizes.globalPadding,
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                right: 12,
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: Container(
                                                  width: 20,
                                                  height: 20,
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: AppColors.greyLight,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      initial,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelSmall!
                                                          .copyWith(
                                                            fontSize: 9,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const Expanded(child: Divider()),
                                          ],
                                        ),
                                      );
                                    }
                                    currentItemIndex++;

                                    final contactList =
                                        groupedContacts[initial]!;
                                    if (index >= currentItemIndex &&
                                        index <
                                            currentItemIndex +
                                                contactList.length) {
                                      final contact =
                                          contactList[index - currentItemIndex];
                                      return AppListTile(
                                        leading: ProfileAvatar(
                                          profileId:
                                              'profileId_${contacts.indexOf(contact)}',
                                          showOnline: false,
                                          width: AppSizes.profilePicSize * .8,
                                          height: AppSizes.profilePicSize * .8,
                                        ),
                                        title: contact.displayName,
                                        titleStyle: ThemeUtils
                                            .chatListTileTitleTextStyle(
                                                context),
                                        trailing: const AppTextButton(
                                          text: 'Invite',
                                        ),
                                        onTap: () {
                                          ExternalUtils.sendSms(
                                            contact.phones.first.number,
                                            AppConstants.inviteContactMessage,
                                          );
                                        },
                                      );
                                    }
                                    currentItemIndex += contactList.length;
                                  }
                                  return const SizedBox
                                      .shrink(); // Shouldn't reach here
                                },
                                childCount: groupContacts(contacts).keys.fold(
                                    0,
                                    (count, initial) =>
                                        (count ?? 0) +
                                        1 +
                                        groupContacts(contacts)[initial]!
                                            .length),
                              ),
                            ),
                ],
              ),
            ),
          );

          // } else if (state is ContactsPermissionDenied) {
          // if (state is ContactsLoaded) {
          //   return const Center(
          //     child: Text('Contacts permission denied.'),
          //   );
          // } else if (state is ContactsError) {
          //   return Center(child: Text('Error: ${state.error}'));
          // } else {
          //   return Container(); // Initial state or empty
          // }
        },
      ),
    );
  }
}

//

Map<String, List<Contact>> groupContacts(List<Contact> contacts) {
  final groupedContacts = <String, List<Contact>>{};
  for (final contact in contacts) {
    final initial = contact.displayName.isNotEmpty
        ? contact.displayName[0].toUpperCase() // Convert to uppercase
        : '#'; // Use '#' for contacts with empty names
    if (!groupedContacts.containsKey(initial)) {
      groupedContacts[initial] = [];
    }
    groupedContacts[initial]!.add(contact);
  }
  return groupedContacts;
}
