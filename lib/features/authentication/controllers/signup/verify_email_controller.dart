import 'dart:async';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../common/widgets/success_screen/success_screen.dart';
import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/popups/loaders.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Send Email Verification Link whenever Verify Screen appears and Set Timer for auto redirect
  @override
  void onInit() {
    // Send email verification when screen appears
    sendEmailVerification();

    // Start the timer for auto redirection to Success Screen when email is verified
    startAutoRedirectTimer();
    super.onInit();
  }

  // Send the email verification
  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      MyLoaders.successSnackBar(
        title: 'Email Sent',
        message: "Hãy kiểm tra hộp thư và xác minh email của bạn nhé.",
      );
    } catch (e) {
      MyLoaders.errorSnackBar(title: "Oops!!", message: e.toString());
    }
  }

  // Set timer for auto redirect
  startAutoRedirectTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;

      if (user?.emailVerified ?? false) {
        timer.cancel();
        // Redirect to success screen if email is verified
        Get.off(() => SuccessScreen(
              image: MyImages.staticSuccessIllustration,
              title: MyTexts.yourAccountCreatedTitle,
              subTitle: MyTexts.yourAccountCreatedSubTitle,
              onPressed: () => AuthenticationRepository.instance
                  .screenRedirect(_auth.currentUser),
            ));
      }
    });
  }

  // Manually check if email is verified
  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null && currentUser.emailVerified) {
      // Redirect to success screen if email is verified
      Get.off(() => SuccessScreen(
            image: MyImages.staticSuccessIllustration,
            title: MyTexts.yourAccountCreatedTitle,
            subTitle: MyTexts.yourAccountCreatedSubTitle,
            onPressed: () => AuthenticationRepository.instance
                .screenRedirect(_auth.currentUser),
          ));
    } else {
      // Display warning if email is not verified
      MyLoaders.warningSnackBar(
        title: 'Email chưa xác minh',
        message: 'Vui lòng kiểm tra email của bạn và xác minh để tiếp tục.',
      );
    }
  }
}
