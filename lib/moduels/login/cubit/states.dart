 abstract class LoginStates {}

 class LoginInitialState extends LoginStates{}

 class LoginSuccessState extends LoginStates
 {
  final String uId;
  LoginSuccessState(this.uId);
 }

 class LoginLoadingState extends LoginStates{}

 class LoginErrorState extends LoginStates
 {
  final String error;
  LoginErrorState(this.error);
 }
 class ChangePasswordVisibilityState extends LoginStates
 {

 }