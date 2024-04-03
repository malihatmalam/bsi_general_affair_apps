import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/usecases/users_usecases.dart';
import '../../core/widget/errorMessage.dart';
import 'cubit/asset_detail_cubit.dart';

import 'package:intl/intl.dart';

class AssetDetailPageWrapperProvider extends StatelessWidget {
  String? assetNumber;
  AssetDetailPageWrapperProvider({required this.assetNumber, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AssetDetailCubit(assetNumber: assetNumber),
      child: const AssetDetailPage(),
    );
  }
}

class AssetDetailPage extends StatelessWidget {
  const AssetDetailPage();

  String formatRupiah(double number) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID', // Indonesian locale
      symbol: 'Rp', // Rupiah symbol
      decimalDigits: 0, // No decimal places
    );
    return formatter.format(number);
  }

  @override
  Widget build(BuildContext context) {
    UsersUseCases().checkSession(context: context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Asset'),
        leading: Container(
          margin: EdgeInsets.all(4),
          child: IconButton(
            onPressed: () {
              context.go('/');
            },
            icon: Icon(Icons.arrow_back),
            color: Colors.blueAccent,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: BlocBuilder<AssetDetailCubit, AssetDetailState>(
          builder: (BuildContext context, AssetDetailState state) {
            if (state is AssetDetailInitial) {
              return Center(
                child: Text(
                  'Your asset data is waiting for you!',
                ),
              );
            } else if (state is AssetDetailLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.blueAccent,
                ),
              );
            } else if (state is AssetDetailLoaded) {
              return Column(
                children: <Widget>[
                  SizedBox(height: 16.0),
                  Card(
                    child: Container(
                      margin: EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                state.asset.asssetName,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.archive_outlined,color: Colors.white),
                              SizedBox(width: 10,),
                              Text(
                                state.asset.assetNumber,
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold,color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    color: Colors.lightBlueAccent,
                    elevation: 2,
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color : Colors.white,
                        border: Border.all(color: Colors.cyan,width: 2)
                    ),
                    child: Column(
                      children: [
                        Text('Detail Information : ',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black)),
                        SizedBox(height: 15,),
                        Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.factory),
                                SizedBox(width: 10,),
                                Text('Factory Number: ',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
                                Expanded(child: Text('${state.asset.assetFactoryNumber}',style: TextStyle(fontSize: 16, color: Colors.grey),))
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.category),
                                SizedBox(width: 10,),
                                Text('Category: ',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
                                Expanded(child: Text('${state.asset.assetCategory?.assetCategoryName}',style: TextStyle(fontSize: 16, color: Colors.grey),))
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.badge),
                                SizedBox(width: 10,),
                                Text('Brand: ',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
                                Expanded(child: Text('${state.asset.brand?.brandName}',style: TextStyle(fontSize: 16, color: Colors.grey),))
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.money),
                                SizedBox(width: 10,),
                                Text('Cost: ',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
                                Expanded(child: Text('${formatRupiah(state.asset.assetCost.toDouble()) as String}',style: TextStyle(fontSize: 16, color: Colors.grey),))
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 5,),
                        // Row(
                        //   children: [
                        //     Expanded(child: Text(state.proposal.proposalDescription,style: TextStyle(color: Colors.black),))
                        //   ],
                        // ),
                        SizedBox(height: 10,),
                        // Row(
                        //   children: [
                        //     Expanded(child: Text('Note : ',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black, fontStyle: FontStyle.italic)),)
                        //   ],
                        // ),
                        // Row(
                        //   children: [
                        //     Expanded(child: Text(state.proposal.proposalNote,style: TextStyle(color: Colors.black, fontSize: 10),))
                        //   ],
                        // )
                      ],
                    ),
                  ),
                  // Tombol logout
                  SizedBox(height: 24.0),
                ],
              );
            } else if (state is AssetDetailError) {
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