import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: BlocBuilder<ProfilePageCubit, ProfilePageState>(
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
                  // Menampilkan foto profil
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage('https://picsum.photos/200'),
                  ),
                  SizedBox(height: 16.0),

                  // Menampilkan data user
                  _buildUserInfo('ID Pengguna:', state.user.userId.toString()),
                  _buildUserInfo('Nama Depan:', state.user.userFirstName),
                  _buildUserInfo('Nama Belakang:', state.user.userLastName),
                  _buildUserInfo('Username:', state.user.userUsername),
                  _buildUserInfo('Jabatan:', state.user.userRole),

                  // Tombol logout
                  SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () async {
                      // Implementasi logout
                      if(await UsersUseCases().signOutApplication()){
                        context.go("/login");
                      }
                    },
                    child: Text('Logout'),
                  ),
                ],
              );
            } else if (state is ProfilePageError) {
              return ErrorMessage(message: state.message);
            }
            return const SizedBox();
          },
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: BlocBuilder<ProfilePageCubit, ProfilePageState>(
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
                  // Menampilkan foto profil
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage('https://picsum.photos/200'),
                  ),
                  SizedBox(height: 16.0),

                  // Menampilkan data user
                  _buildUserInfo('ID Pengguna:', state.user.userId.toString()),
                  _buildUserInfo('Nama Depan:', state.user.userFirstName),
                  _buildUserInfo('Nama Belakang:', state.user.userLastName),
                  _buildUserInfo('Username:', state.user.userUsername),
                  _buildUserInfo('Jabatan:', state.user.userRole),

                  // Tombol logout
                  SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () async {
                      // Implementasi logout
                      if(await UsersUseCases().signOutApplication()){
                        context.go("/login");
                      }
                    },
                    child: Text('Logout'),
                  ),
                ],
              );
            } else if (state is ProfilePageError) {
              return ErrorMessage(message: state.message);
            }
            return const SizedBox();
          },
        ),
      ),
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
