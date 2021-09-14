import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/models/user_model.dart';
import 'package:untitled3/moduels/login/cubit/states.dart';
import 'package:untitled3/moduels/signup/cubit/states.dart';


class SignUpCubit extends Cubit<SignUpStates>
{
  SignUpCubit(): super(SignUpInitialState());

  static SignUpCubit get(context) =>BlocProvider.of(context);

  void SignupUser ({
    @required String email,
    @required String password,
    @required String name,
    @required String phone
  })
  {
    emit(SignUpLoadingState());

       FirebaseAuth.instance.createUserWithEmailAndPassword(
           email: email,
           password: password
       )
        .then((value)
       {
         userCreate(
           uId: value.user.uid,
           email: email,
           phone: phone,
           name: name
         );
       }).catchError((error)
       {
         emit(SignUpErrorState(error.toString()));
         print(error.toString());
       });
  }


  void userCreate({
    @required String name,
    @required String phone,
    @required String email,
    @required String uId,
  })
  {
    UserModel userModel =UserModel(
        name: name,
        email: email,
        phone: phone,
        uId: uId
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap())
        .then((value)
    {
      emit(UserCreateSuccessState());
    })
        .catchError((error)
    {
      emit(UserCreateErrorState(error.toString()));
      print(error.toString());
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