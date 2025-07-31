import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit/search_cubit.dart';
import 'package:shop_app/modules/search/cubit/search_states.dart';
import 'package:shop_app/shared/component/components.dart';
import 'package:shop_app/styles/colors.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormfield(
                      controller: searchController,
                      type: TextInputType.text,
                      prefix: Icons.search,
                      borderColor: defaultColor,
                      labeledColor: defaultColor,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return "Type here to search";
                        }
                        return null;
                      },
                      onSubmit: (String text) {
                        if (formKey.currentState!.validate()) {
                          SearchCubit.get(context).search(text);
                        }
                      },
                      label: "Search",
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    if (state is SearchLoadingState)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: SearchCubit.get(context).searchModel != null &&
                              SearchCubit.get(context).searchModel!.data !=
                                  null &&
                              SearchCubit.get(context)
                                      .searchModel!
                                      .data!
                                      .data !=
                                  null
                          ? ListView.separated(
                              itemBuilder: (context, index) => buildListProduct(
                                SearchCubit.get(context)
                                    .searchModel!
                                    .data!
                                    .data![index],
                                context,
                                isOldPrice: false,
                              ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 10,
                              ),
                              itemCount: SearchCubit.get(context)
                                  .searchModel!
                                  .data!
                                  .data!
                                  .length,
                            )
                          : const Center(
                              child: Icon(
                                Icons.person_search_rounded,
                                color: Colors.grey,
                                size: 150,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
