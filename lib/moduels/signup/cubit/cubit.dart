import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/moduels/login/cubit/states.dart';
import 'package:untitled3/moduels/signup/cubit/states.dart';


class SignUpCubit extends Cubit<SignUpStates>
{
  SignUpCubit(): super(SignUpInitialState());

  static SignUpCubit get(context) =>BlocProvider.of(context);

  void SignupUser ({
    @required String email,
    @required String password
  })
  {
    emit(SignUpLoadingState());

       FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value)
       {
         emit(SignUpSuccessState());
       }).catchError((error)
       {
         emit(SignUpErrorState(error.toString()));
       });


  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(SignUpChangePasswordVisibilityState());
  }




}