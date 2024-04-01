import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/usecases/users_usecases.dart';
import '../../core/widget/checkSession.dart';
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
      appBar: AppBar(
        title: Text('List Asset'),
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
                          'Your profile data is waiting for you!',
                        ),
                      );
                    } else if (state is AssetListLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.purpleAccent,
                        ),
                      );
                    } else if (state is AssetListLoaded) {
                      var listAsset = state.assets;
                      return ListView(
                        children: List.generate(listAsset.length, (index) {
                          return Container(
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0)
                            ),
                            child: ListTile(
                              onTap: () {
                                context.go('/asset/${listAsset[index].assetNumber}');
                              },
                              title: Text('${listAsset[index].asssetName}'),
                              subtitle: Text('${listAsset[index].assetNumber}'),
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
