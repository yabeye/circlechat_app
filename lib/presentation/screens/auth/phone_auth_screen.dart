import 'package:circlechat_app/core/navigation/app_router.dart';
import 'package:circlechat_app/core/navigation/navigation_helper.dart';
import 'package:circlechat_app/core/utils/internalization_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:circlechat_app/presentation/widgets/app_widgets/app_image.dart';
import 'package:circlechat_app/core/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:circlechat_app/presentation/cubit/auth/auth_cubit.dart'; // Import AuthCubit

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  PhoneAuthScreenState createState() => PhoneAuthScreenState();
}

class PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Your phone number',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'Select a country code and enter your phone number.',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    String? countryCode = state.phoneNumber?.isoCode ?? 'US';

                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            // color: Theme.of(context).cardColor.withOpacity(0.5),
                            border: Border.all(
                              color: (Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.color ??
                                      Colors.black)
                                  .withOpacity(0.1),
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: ListTile(
                            leading: countryCode == null
                                ? null
                                : Text(
                                    InternalizationUtils.getCountryFlag(
                                      countryCode,
                                    ),
                                    style: const TextStyle(fontSize: 20),
                                  ),
                            title: Text(
                              countryCode == null
                                  ? 'Select Country'
                                  : '${InternalizationUtils.getCountryName(countryCode)} ($countryCode)',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                              color: AppColors.disabled,
                            ),
                          ),
                        ),
                        Positioned(
                          top: -10,
                          left: 10,
                          child: Text(
                            'Country',
                            style: Theme.of(context)
                                .inputDecorationTheme
                                .labelStyle,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 16),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    String countryCode = state.phoneNumber?.isoCode ?? 'US';

                    // if (countryCode == null) return const SizedBox.shrink();

                    return Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: InternationalPhoneNumberInput(
                        onInputChanged: (PhoneNumber number) {
                          context.read<AuthCubit>().setPhoneNumber(number);
                        },
                        onInputValidated: (bool value) {
                          print(value);
                        },
                        selectorConfig: const SelectorConfig(
                          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                          useBottomSheetSafeArea: true,
                        ),
                        ignoreBlank: false,
                        autoFocus: true,
                        // autoValidateMode: AutovalidateMode.disabled,
                        selectorTextStyle: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color),
                        initialValue:
                            context.read<AuthCubit>().selectedPhoneNumber ??
                                PhoneNumber(isoCode: 'US'),
                        textFieldController: controller,
                        formatInput: true,
                        maxLength: 13,
                        // keyboardType: TextInputType.phone,
                        inputBorder: InputBorder.none,
                        inputDecoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          border: InputBorder.none,
                          hintText: 'Phone Number',
                          hintStyle: TextStyle(
                            color: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.color
                                ?.withOpacity(0.6),
                          ),
                        ),
                        onSaved: (PhoneNumber number) {
                          print('On Saved: $number');
                        },
                      ),
                    );
                  },
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          final isValid = (context.read<AuthCubit>().isValidPhoneNumber &&
              state is! AuthLoading);
          return FloatingActionButton(
            backgroundColor: isValid ? AppColors.primary : AppColors.disabled,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            onPressed: !isValid
                ? null
                : () async {
                    try {
                      await context.read<AuthCubit>().sendVerificationCode();

                      if (!mounted) return;

                      if (state is AuthError) {
                        throw Exception(state.message);
                      }
                      NavigationHelper.navigateTo(context, AppRouter.otpAuth);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error: ${e.toString()}'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
            child: state is AuthLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                  )
                : const Icon(Icons.arrow_forward),
          );
        },
      ),
    );
  }
}
