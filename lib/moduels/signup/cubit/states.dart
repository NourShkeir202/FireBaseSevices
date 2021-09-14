abstract class SignUpStates {}

class SignUpInitialState extends SignUpStates{}

class SignUpSuccessState extends SignUpStates {}

class SignUpLoadingState extends SignUpStates{}

class SignUpErrorState extends SignUpStates
{
  final String error;
  SignUpErrorState(this.error);
}

class UserCreateSuccessState extends SignUpStates {}

class UserCreateErrorState extends SignUpStates
{
  final String error;
  UserCreateErrorState(this.error);
}

class SignUpChangePasswordVisibilityState extends SignUpStates{}

