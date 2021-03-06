import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/moduels/login/login.dart';
import 'package:untitled3/moduels/signup/cubit/cubit.dart';
import 'package:untitled3/moduels/signup/cubit/states.dart';
import 'package:untitled3/shared/components/components.dart';


class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController =TextEditingController();
    var nameController =TextEditingController();
    var phoneController =TextEditingController();
    var passwordController =TextEditingController();
    var formKey =GlobalKey<FormState>();
    return  BlocProvider(
      create: (context)=>SignUpCubit(),

      child: BlocConsumer<SignUpCubit,SignUpStates>(
        listener: (context,state)
        {
          if(state is UserCreateSuccessState)
          {
            showToast(text: "Sign Up Success (:", state: ToastStates.SUCCESS);
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()), (route) => false);
          }
          if(state is SignUpErrorState)
          {
            showToast(text: state.error, state: ToastStates.ERROR);
          }
        },
        builder: (context,state)
        {
          var cubit =SignUpCubit.get(context);
          return   Scaffold(
            appBar: AppBar(
                centerTitle: true,
                title: Text("Login")
            ),
            body:Padding(
              padding: const EdgeInsets.all(18.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children:
                    [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Register".toUpperCase(),
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                      defaultFormField(
                          controller:nameController,
                          type: TextInputType.name,
                          validate: (String value)
                          {
                            if(value.isEmpty)
                            {
                              return "UserName Must Not Be Empty";
                            }
                            return null;
                          },
                          label: "UserName",
                          prefix: Icons.person,
                          hint: "UserName"
                      ),
                      const SizedBox(height: 20,),
                      defaultFormField(
                          controller:phoneController,
                          type: TextInputType.phone,
                          validate: (String value)
                          {
                            if(value.isEmpty)
                            {
                              return "Phone Must Not Be Empty";
                            }
                            return null;
                          },
                          label: "Phone Number",
                          prefix: Icons.phone,
                          hint: "Phone Number"
                      ),
                      const SizedBox(height: 20,),
                      defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String value)
                          {
                            if(value.isEmpty)
                            {
                              return "Email Must Not Be Empty";
                            }
                            return null;
                          },
                          label: "E-Mail",
                          prefix: Icons.email,
                          hint: "E-Mail"
                      ),
                      const SizedBox(height: 20,),
                      defaultFormField(
                          isPassword: cubit.isPassword,
                          suffix: cubit.suffix,
                          suffixPressed: ()
                          {
                        cubit.changePasswordVisibility();
                          },
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          validate: (String value)
                          {
                            if(value.isEmpty)
                            {
                              return "Password Must Not Be Empty";
                            }
                            return null;
                          },
                          label: "Password",
                          prefix: Icons.lock,
                          hint: "Password"
                      ),
                      const  SizedBox(height: 20,),
                      ConditionalBuilder(
                        condition: state is! SignUpLoadingState,
                        builder: (context)=> defaultbutton(titleButton: "SignUp",onPressed: ()
                        {
                          if(formKey.currentState.validate())
                          {
                            cubit.SignupUser(
                              email: emailController.text,
                              password: passwordController.text,
                              name: nameController.text,
                              phone: phoneController.text,
                            );
                          }

                        }),
                        fallback: (context)=>Center(child: CircularProgressIndicator(),),
                      ),
                      const   SizedBox(height: 20,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:
                        [
                          Text("Already have an Account ?",style: TextStyle(fontSize: 15),),
                          TextButton(onPressed: ()
                          {
                            navigateTo(context, LoginScreen());
                          }, child: Text("SignIn".toUpperCase()))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
