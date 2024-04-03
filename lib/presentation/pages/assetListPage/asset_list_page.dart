import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/usecases/users_usecases.dart';
import '../../core/widget/errorMessage.dart';
import 'cubit/asset_list_cubit.dart';

class AssetListPageWrapperProvider extends StatelessWidget {
  const AssetListPageWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AssetListCubit(),
      child: const AssetListPage(),
    );
  }
}

class AssetListPage extends StatelessWidget {
  const AssetListPage();

  @override
  Widget build(BuildContext context) {
    UsersUseCases().checkSession(context: context);
    // var listPenduduk = PendudukUseCases().getAllPenduduk();
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Icon(Icons.grid_view_rounded ,color: Colors.blueAccent),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                'My Asset',
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.all(2),
                // height: 400,
                child: BlocBuilder<AssetListCubit, AssetListState>(
                  builder: (context, state) {
                    if(state is AssetListInitial){
                      return Center(
                        child: Text(
                          'Your asset data is waiting for you!',
                        ),
                      );
                    } else if (state is AssetListLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.blueAccent,
                        ),
                      );
                    } else if (state is AssetListLoaded) {
                      var listAsset = state.assets;
                      if(listAsset.length < 1){
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/folder-1.png', // Ganti dengan path gambar Anda
                                width: 300,
                                height: 300,
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Oops, your data is empty',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return ListView(
                        children: List.generate(listAsset.length, (index) {
                          return Column(
                            children: [
                              Container(
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.blueAccent,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0)
                                ),
                                child: ListTile(
                                  leading: Icon(
                                      Icons.archive,
                                      color: Colors.blueAccent,
                                      grade: 2),
                                  onTap: () {
                                    context.go('/asset/${listAsset[index].assetNumber}');
                                  },
                                  title: Text('${listAsset[index].asssetName}', style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold)),
                                  subtitle: Text('Code: ${listAsset[index].assetNumber}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                  // title: Text('test'),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // IconButton(onPressed: () {
                                      //   PendudukUseCases().deletePenduduk(key: index);
                                      //   BlocProvider.of<IndexCubit>(context).pendudukGetData();
                                      // }, icon: Icon(Icons.delete)),
                                      SizedBox(width: 4,),
                                      IconButton(onPressed: () {
                                        context.go('/asset/${listAsset[index].assetNumber}');
                                      }, icon: Icon(Icons.arrow_forward)),
                                    ],
                                  ),
                                  style: ListTileStyle.list,
                                ),
                              ),
                              SizedBox(height: 10)
                            ],
                          );
                        }),
                      );
                    } else if (state is AssetListError) {
                      return ErrorMessage(message: state.message);
                    } return const SizedBox();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
