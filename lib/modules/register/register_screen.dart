import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/register/cubit/cubit.dart';
import 'package:shop_app/modules/register/cubit/states.dart';
import '../../network/local/cache_helper.dart';
import '../../shared/component/components.dart';
import '../../shared/component/constants.dart';

class RegisterScreen extends StatelessWidget {
   RegisterScreen({super.key});

  var formKey = GlobalKey<FormState>();

   var emailController = TextEditingController();
   var passwordController = TextEditingController();
   var nameController = TextEditingController();
   var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates> (
        listener: (context, state) {
          if (state is ShopRegisterSuccessState)
          {
            if (state.loginModel.status!) {
              print(state.loginModel.message);
              print(state.loginModel.data?.token);

              CacheHelper.saveData(
                  key: 'token', value: state.loginModel.data?.token)
                  .then((value) {
                token = state.loginModel.data?.token;
                navigateAndFinish(context, LoginScreen());
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
        },
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
                          const SizedBox(height: 20),
                          Text(
                            "REGISTER",
                            style: Theme.of(context)
                                .textTheme.headlineMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height:16),
                          Text(
                            "Register now to discover our hot offers",
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey[500]
                            ),
                          ),
                          const SizedBox(height: 30),
                          Form(
                            key: formKey,
                            child: Column(
                              children: [
                                defaultFormfield(
                                  controller: nameController,
                                  type: TextInputType.name,
                                  prefix: Icons.person,
                                  validate: (String? value){
                                    if(value!.isEmpty){
                                      return 'please enter your name';
                                    }
                                  },
                                  borderColor: Colors.indigo,
                                  labeledColor: Colors.indigo,
                                  textStyle: const TextStyle(
                                      fontSize: 17
                                  ),
                                  label: 'user name',),
                                const SizedBox(
                                  height: 20,
                                ),
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
                                const SizedBox(
                                  height: 20,
                                ),
                                defaultFormfield(
                                    controller: passwordController,
                                    type: TextInputType.visiblePassword,
                                    prefix: Icons.lock,
                                    validate: (String? value){
                                      if(value!.isEmpty){
                                        return 'password required';
                                      }
                                    },
                                    suffix: ShopRegisterCubit.get(context).suffix,
                                    isPassword: ShopRegisterCubit.get(context).isPassword,
                                    suffixPressed: (){
                                      ShopRegisterCubit.get(context).changePasswordVisibility();
                                    },
                                    onSubmit: (value) {
                                    },
                                    textStyle: const TextStyle(
                                        fontSize: 17
                                    ),
                                    borderColor: Colors.indigo,
                                    labeledColor: Colors.indigo,
                                    label: 'Password'),
                                const SizedBox(
                                  height: 20,
                                ),
                                defaultFormfield(
                                  controller: phoneController,
                                  type: TextInputType.phone,
                                  validate: (String? value){
                                    if(value!.isEmpty){
                                      return 'phone number required';
                                    }
                                  },
                                  borderColor: Colors.indigo,
                                  prefix: Icons.phone,
                                  labeledColor: Colors.indigo,
                                  textStyle: const TextStyle(
                                      fontSize: 17
                                  ),
                                  label: 'phone number',),
                                const SizedBox(
                                  height: 20,
                                ),
                                ConditionalBuilder(
                                  condition: state is! ShopRegisterLoadingState,
                                  builder: (BuildContext context) => ElevatedButton(
                                    onPressed: () {
                                      if(formKey.currentState!.validate()){
                                        ShopRegisterCubit.get(context).userRegister(
                                            email: emailController.text,
                                            password: passwordController.text,
                                            name: nameController.text,
                                            phone: phoneController.text
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
                                    child: const Text("REGISTER",
                                      style: TextStyle(
                                          fontSize: 18, fontWeight: FontWeight.bold
                                      ),),

                                  ), fallback: (BuildContext context) => const Center(
                                    child: CircularProgressIndicator()
                                ),
                                ),

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
