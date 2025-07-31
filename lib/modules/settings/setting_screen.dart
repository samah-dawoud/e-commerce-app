import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/component/components.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/cubit/shop_cubit.dart';
import 'package:shop_app/shared/cubit/shop_states.dart';
import 'package:shop_app/styles/colors.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        
        var model = ShopCubit.get(context).userModel;
        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;
        
        
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if(state is ShopLoadingUpdateState)
                  const LinearProgressIndicator(),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultFormfield(
                      controller: nameController,
                      type: TextInputType.text,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return "name must not be empty";
                        }
                        return null;
                      },
                      label: "Name",
                      labeledColor: defaultColor,
                      borderColor: defaultColor,
                      prefix: Icons.person),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultFormfield(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return "email must not be empty";
                        }
                        return null;
                      },
                      label: "Email",
                      labeledColor: defaultColor,
                      borderColor: defaultColor,
                      prefix: Icons.email),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultFormfield(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return "phone must not be empty";
                        }
                        return null;
                      },
                      label: "Phone",
                      labeledColor: defaultColor,
                      borderColor: defaultColor,
                      prefix: Icons.phone),

                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: (){
                        if(formKey.currentState!.validate()){
                          ShopCubit.get(context).updateUserData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text
                          );
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
                      child: const Text(
                          "Update"
                      )
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: (){
                        logOut(context);
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.indigo,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))
                      ),
                      child: const Text(
                        "Log Out"
                      )
                  )
                ],
              ),
            ),
          ), 
          fallback: (BuildContext context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
