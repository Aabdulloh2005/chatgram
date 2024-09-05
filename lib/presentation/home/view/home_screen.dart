import 'package:chatgram/app/bloc/app_bloc.dart';
import 'package:chatgram/core/di/dependect_injection.dart';
import 'package:chatgram/core/utils/app_colors.dart';
import 'package:chatgram/core/widgets/custom_text.dart';
import 'package:chatgram/presentation/chat/views/chat_screen.dart';
import 'package:chatgram/presentation/home/cubit/home_cubit.dart';
import 'package:chatgram/presentation/home/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static Page<void> page() => const CupertinoPage<void>(child: HomeScreen());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: <Widget>[
            IconButton(
              key: const Key('homePage_logout_iconButton'),
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                context.read<AppBloc>().add(const AppLogOutPressed());
              },
            ),
          ],
        ),
        body: BlocProvider(
          create: (context) => getIt.get<UserCubit>(),
          child: BlocBuilder<UserCubit, UserState>(
            bloc: getIt.get<UserCubit>()..loadUsers(),
            builder: (context, state) {
              if (state is UserLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is UserLoaded) {
                return ListView.separated(
                  itemCount: state.users.length,
                  separatorBuilder: (context, index) => const Padding(
                    padding: EdgeInsets.only(left: 60.0),
                    child: Divider(
                      height: 15,
                    ),
                  ),
                  padding: const EdgeInsets.all(15),
                  itemBuilder: (context, index) {
                    final user = state.users[index];
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) => ChatScreen(user: user),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          const Avatar(),
                          const Gap(10),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(text: user.name),
                                    CustomText(
                                      text: "Nima gapla",
                                      color: AppColors.grayDark7,
                                    ),
                                  ],
                                ),
                                CustomText(
                                  text: "12:44",
                                  color: AppColors.grayDark1,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
              if (state is UserError) {
                Center(
                  child: CustomText(text: state.message),
                );
              }

              return const Center(
                child: CustomText(text: "Statelarga tushmadi"),
              );
            },
          ),
        ));
  }
}
