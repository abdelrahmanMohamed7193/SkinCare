import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingapp/cubit/phone_auth_cubit/phone_auth_states.dart';
import 'package:shoppingapp/shared/constants.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthStates> {

  PhoneAuthCubit() : super(PhoneAuthInitialState());
  static PhoneAuthCubit get(context) => BlocProvider.of(context);

  late String verificationId;
  Future<void> submitPhoneNumber(String phoneNumber ) async {
    emit(LoadingState());
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+2${phoneNumber}',
      timeout: const Duration(seconds: 15),
      verificationCompleted: (PhoneAuthCredential credential) async {
        print('in verificationCompleted Now');
        await signIn(credential);
      },
      verificationFailed: (FirebaseAuthException exception) {
        print('in verificationFailed Now');
        print('Errorrrrr ${exception.toString()}');
        emit(
          PhoneAuthErrorState(
            exception.toString(),
          ),
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        print('in codeSent  Now');
        // محتاجه تتهندل  Resend
        this.verificationId = verificationId;
        emit(PhoneAuthNumberSubmittedSuccessState());
       // print('PublicVerificationId of submitphoneNumber is ${PublicVerificationId}');
        print('///////////////////////////////////////') ;
        print('verification Id Of submitPhoneNumber is ${verificationId}//////// ${this.verificationId}' );
        print('///////////////////////////////////////') ;
      },
        codeAutoRetrievalTimeout: (String verificationId) {
        print('in codeAutoRetrievalTimeout  Now');
      },
    );
    //emit(PhoneAuthNumberSubmittedSuccessState());
  }

  // void codeSent(String verificationId, int? resendToken) {
  //   print('in codeSent  Now');
  //   this.verificationId = verificationId;
  //   emit(PhoneAuthNumberSubmittedSuccessState());
  // }

  Future<void> submitOtp(String otpCode) async {
    emit(LoadingState());
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: this.verificationId  ,
      smsCode: otpCode,
    );

    print('OTPCODE FROM Submit OTP  in CUBIT is ${otpCode}');
    print('///////////////////////////////////////');
    print('verification Id Of submitOTP Cubit is${verificationId}///// ${this.verificationId}///');
    print('///////////////////////////////////////');

    await signIn(credential);
  }

  Future<void> signIn(PhoneAuthCredential credential) async {
    print("in sign in now ");
    try {
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) {
        emit(PhoneOtpVerifiedState());
      });
    } catch (error) {
      emit(PhoneAuthErrorState('errrorrrr in sign In ///${error.toString()}'));
    }
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  User getLoggedInUser() {
    User firebaseUser = FirebaseAuth.instance.currentUser!;
    return firebaseUser;
  }
}
