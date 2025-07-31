import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/shared/component/components.dart';
import '../../shared/component/constants.dart';
import '../register/register_screen.dart';
import 'cubit/cubit.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener:(context, state){
          if (state is ShopLoginSuccessState)
            {
              if (state.loginModel.status!) {
                print(state.loginModel.message);
                print(state.loginModel.data?.token);

                CacheHelper.saveData(
                    key: 'token', value: state.loginModel.data?.token)
                    .then((value) {
                      token = state.loginModel.data?.token;
                      navigateAndFinish(context, ShopLayout());
                });
              }
              else
                {
                  print(state.loginModel.message);
                  showToast(
                      text: '${state.loginModel.message}',
                      state: ToastStates.ERROR);

                }
            }
        } ,
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Text(
                            "LOGIN",
                            style: Theme.of(context)
                                .textTheme.headlineMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height:16),
                          Text(
                            "Login now to discover our hot offers",
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey[500]
                            ),
                          ),
                          SizedBox(height: 30),
                          Form(
                            key: formKey,
                            child: Column(
                              children: [
                                defaultFormfield(
                                  controller: emailController,
                                  type: TextInputType.emailAddress,
                                  prefix: Icons.email,
                                  validate: (String? value){
                                    if(value!.isEmpty){
                                      return 'email address required';
                                    }
                                  },
                                  borderColor: Colors.indigo,
                                  labeledColor: Colors.indigo,
                                  textStyle: const TextStyle(
                                      fontSize: 17
                                  ),
                                  label: 'Email address',),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                                  child: defaultFormfield(
                                      controller: passwordController,
                                      type: TextInputType.visiblePassword,
                                      prefix: Icons.lock,
                                      validate: (String? value){
                                        if(value!.isEmpty){
                                          return 'password required';
                                        }
                                      },
                                      suffix: ShopLoginCubit.get(context).suffix,
                                      isPassword: ShopLoginCubit.get(context).isPassword,
                                      suffixPressed: (){
                                        ShopLoginCubit.get(context).changePasswordVisibility();
                                      },
                                      onSubmit: (value) {
                                        if(formKey.currentState!.validate()){
                                          ShopLoginCubit.get(context).userLogin(
                                              email: emailController.text,
                                              password: passwordController.text
                                          ) ;
                                        }
                                      },
                                      textStyle: const TextStyle(
                                          fontSize: 17
                                      ),
                                      borderColor: Colors.indigo,
                                      labeledColor: Colors.indigo,
                                      label: 'Password'),
                                ),
                                SizedBox(
                                  height: 55,
                                  child: ConditionalBuilder(
                                    condition: state is! ShopLoginLoadingState,
                                    builder: (BuildContext context) => ElevatedButton(
                                      onPressed: () {
                                        if(formKey.currentState!.validate()){
                                          ShopLoginCubit.get(context).userLogin(
                                              email: emailController.text,
                                              password: passwordController.text
                                          ) ;
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          backgroundColor: Colors.indigo,
                                          foregroundColor: Colors.white,
                                          minimumSize: const Size(double.infinity, 48),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(15))
                                      ),
                                      child: const Text("LOGIN",
                                        style: TextStyle(
                                            fontSize: 18, fontWeight: FontWeight.bold
                                        ),),

                                    ), fallback: (BuildContext context) => const Center(
                                      child: CircularProgressIndicator()
                                  ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Don\'t have an account? '
                                      ,style: TextStyle(
                                        fontSize: 15, color: Colors.grey[600]
                                    ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        navigateTo(context, RegisterScreen());
                                      },
                                      child: const Text(
                                          'Resister'
                                          ,style: TextStyle(
                                          fontSize: 17, color: Colors.indigo,
                                          fontWeight: FontWeight.bold
                                      )),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      )
    );

  }
}


