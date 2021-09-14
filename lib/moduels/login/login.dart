import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/moduels/login/cubit/cubit.dart';
import 'package:untitled3/moduels/login/cubit/states.dart';
import 'package:untitled3/moduels/signup/sign_up_screen.dart';
import 'package:untitled3/shared/components/components.dart';
import 'package:untitled3/shared/network/local/cache_helper.dart';

import '../home.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController =TextEditingController();
    var passwordController =TextEditingController();
    var formKey =GlobalKey<FormState>();
    return BlocProvider(
      create: (context)=>LoginCubit(),

      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context,state)
        {
          if(state is LoginErrorState)
          {
            showToast(text: state.error, state: ToastStates.ERROR);
          }
          if(state is LoginSuccessState)
          {
            CacheHelper.saveData(key: "uId", value: state.uId).then((value)
            {
              navigateAndFinish(context, HomeScreen());
            });
          }
        },
        builder: (context,state)
        {
          var cubit= LoginCubit.get(context);
         return Scaffold(
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
                         "SignIn".toUpperCase(),
                         style: Theme.of(context).textTheme.headline2,
                       ),
                     ),
                    const SizedBox(
                       height: 80,
                     ),
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
                         isPassword:  cubit.isPassword,
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
                       condition: state is! LoginLoadingState,
                       builder: (context)=> defaultbutton(titleButton: "Login",onPressed: ()
                       {
                         if(formKey.currentState.validate())
                         {
                           cubit.userLogin(
                               email: emailController.text,
                               password: passwordController.text,
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
                         Text("Do\'nt have an Account ?",style: Theme.of(context).textTheme.headline6,),
                         TextButton(onPressed: ()
                         {
                           navigateTo(context, SignUpScreen());
                         }, child: Text("SignUp".toUpperCase()))
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
