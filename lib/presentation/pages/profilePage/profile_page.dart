import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../domain/usecases/users_usecases.dart';
import '../../core/widget/checkSession.dart';
import '../../core/widget/errorMessage.dart';
import 'cubit/profile_page_cubit.dart';

class ProfilePageWrapperProvider extends StatelessWidget {
  const ProfilePageWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProfilePageCubit()),
      ],
      child: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  ProfilePage();

  @override
  Widget build(BuildContext context) {
    UsersUseCases().checkSession(context: context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Icon(Icons.person, color: Colors.blueAccent),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                'My Profile',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              BlocBuilder<ProfilePageCubit, ProfilePageState>(
                builder: (BuildContext context, ProfilePageState state) {
                  if (state is ProfilePageInitial) {
                    return Center(
                      child: Text(
                        'Your profile data is waiting for you!',
                      ),
                    );
                  } else if (state is ProfilePageLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.purpleAccent,
                      ),
                    );
                  } else if (state is ProfilePageLoaded) {
                    return Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(25),
                          child: Column(
                            children: [
                              SizedBox(
                                width: 120,
                                height: 120,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image(
                                        image: NetworkImage(
                                            'https://picsum.photos/200'))),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '${state.user.userFirstName} ${state.user.userLastName}',
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                              Text('${state.user.userRole}',
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: 200,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFDFFC71F),
                                      side: BorderSide.none,
                                      shape: const StadiumBorder()),
                                  child: const Text(
                                    "Edit Profile",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              const Divider(),
                              const SizedBox(
                                height: 10,
                              ),
                              ListTile(
                                leading: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color:
                                          Colors.purpleAccent.withOpacity(0.1)),
                                  child:
                                      const Icon(Icons.verified_user_outlined),
                                ),
                                title: Text(
                                  '${state.user.userUsername}',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                trailing: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.grey.withOpacity(0.1),
                                  ),
                                  child: const Icon(
                                    Icons.chevron_right,
                                    size: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              ListTile(
                                leading: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color:
                                          Colors.purpleAccent.withOpacity(0.1)),
                                  child: const Icon(
                                      Icons.drive_file_rename_outline),
                                ),
                                title: Text(
                                  '${state.user.userFirstName}',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                trailing: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.grey.withOpacity(0.1),
                                  ),
                                  child: const Icon(
                                    Icons.chevron_right,
                                    size: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              ListTile(
                                leading: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color:
                                          Colors.purpleAccent.withOpacity(0.1)),
                                  child: const Icon(
                                      Icons.drive_file_rename_outline_sharp),
                                ),
                                title: Text(
                                  '${state.user.userLastName}',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                trailing: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.grey.withOpacity(0.1),
                                  ),
                                  child: const Icon(
                                    Icons.chevron_right,
                                    size: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              ListTile(
                                leading: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color:
                                          Colors.purpleAccent.withOpacity(0.1)),
                                  child: const Icon(Icons.calendar_today),
                                ),
                                title: Text(
                                  '${DateFormat('yyyy-MM-dd').format(state.user.createdAt!)}',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                trailing: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.grey.withOpacity(0.1),
                                  ),
                                  child: const Icon(
                                    Icons.chevron_right,
                                    size: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else if (state is ProfilePageError) {
                    return ErrorMessage(message: state.message);
                  }
                  return const SizedBox();
                },
              ),
              SizedBox(
                width: double.maxFinite,
                child: Container(
                  margin: EdgeInsets.only(right: 25, left: 25),
                  child: ElevatedButton(
                    onPressed: () async {
                      // Implementasi logout
                      if (await UsersUseCases().signOutApplication()) {
                        context.go("/login");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        side: BorderSide.none,
                        shape: const StadiumBorder()),
                    child: const Text(
                      "Log out",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ),
            ],
          )),
    );
  }

  Widget _buildUserInfo(String label, String value) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: <Widget>[
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 8.0),
          Text(value),
        ],
      ),
    );
  }
}
