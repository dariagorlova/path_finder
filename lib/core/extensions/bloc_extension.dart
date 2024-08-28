import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension BlocProviderWrapper on Widget {
  Widget createWithCubit<T extends StateStreamableSource<Object?>>(
    T Function(BuildContext context) createCubit, {
    Key? key,
    bool lazy = true,
  }) {
    return BlocProvider(
      create: createCubit,
      key: key,
      lazy: lazy,
      child: this,
    );
  }
}
