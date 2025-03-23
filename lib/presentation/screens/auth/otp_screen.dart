import 'package:circlechat_app/core/navigation/app_router.dart';
import 'package:circlechat_app/core/navigation/navigation_helper.dart';
import 'package:circlechat_app/presentation/cubit/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:circlechat_app/core/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  OtpScreenState createState() => OtpScreenState();
}

class OtpScreenState extends State<OtpScreen> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = AppColors.primary;
    const borderColor = Colors.grey;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: GoogleFonts.poppins(
        fontSize: 22,
        color: Theme.of(context).textTheme.bodyLarge?.color,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration!.copyWith(
      border: Border.all(color: AppColors.primary, width: 3),
    ));

    final cursor = Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: 21,
        height: 1,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: focusedBorderColor,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Enter Verification Code',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  String phoneNumber = '';
                  phoneNumber = state.phoneNumber?.phoneNumber ?? '';

                  return Text(
                    'We have sent a verification code to $phoneNumber',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                    textAlign: TextAlign.center,
                  );
                },
              ),
              const SizedBox(height: 32),
              Form(
                key: formKey,
                child: Pinput(
                  length: 6,
                  controller: pinController,
                  focusNode: focusNode,
                  autofocus: true,
                  defaultPinTheme: defaultPinTheme,
                  submittedPinTheme: submittedPinTheme,
                  separatorBuilder: (index) => const SizedBox(width: 8),
                  hapticFeedbackType: HapticFeedbackType.vibrate,
                  onCompleted: (pin) async {
                    try {
                      await context
                          .read<AuthCubit>()
                          .signInWithPhoneNumber(pin);
                      if (!mounted) return;
                      final state = context.read<AuthCubit>().state;
                      if (state is AuthFailure) {
                        throw Exception(state.message);
                      }
                      NavigationHelper.navigateTo(
                        context,
                        AppRouter.editProfile,
                        replaceAll: true,
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error: ${e.toString()}'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  cursor: cursor,
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
