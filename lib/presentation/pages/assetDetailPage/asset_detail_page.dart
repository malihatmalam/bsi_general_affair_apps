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
              icon: Icon(Icons.arrow_back)
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
                  color: Colors.purpleAccent,
                ),
              );
            } else if (state is AssetDetailLoaded) {
              return Column(
                children: <Widget>[
                  SizedBox(height: 16.0),

                  // Menampilkan data asset
                  _buildUserInfo('ID Asset:', state.asset.assetNumber),
                  _buildUserInfo('Nama Asset:', state.asset.asssetName),
                  _buildUserInfo('Nomor Pabrik:', state.asset.assetFactoryNumber),
                  _buildUserInfo('Kategori:', state.asset.assetCategory?.assetCategoryName ?? "Kosong"),
                  _buildUserInfo('Brand:', state.asset.brand?.brandName ?? "Kosong"),
                  _buildUserInfo('Harga:', formatRupiah(state.asset.assetCost.toDouble()) as String),
                  _buildUserInfo('Kondisi:', state.asset.assetCondition),

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