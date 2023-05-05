import 'package:actual/riverpodsample/layout/default_layout.dart';
import 'package:actual/riverpodsample/model/shopping_item_model.dart';
import 'package:actual/riverpodsample/riverpod/state_notifier_provoider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StateNotifierProviderScreen extends ConsumerWidget {
  const StateNotifierProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<ShoppingItemModel> state = ref.watch(ShoppingListProvider);

    return DefaultLayout(
        title: 'StateNotifierProvider',
        body: ListView(
          children: state
              .map(
                (e) => CheckboxListTile(
                  title: Text(e.name),
                  value: e.hasBought,
                  onChanged: (value) {
                    ref.read(ShoppingListProvider.notifier).toggleHasBought(name: e.name);
                  },
                ),
              )
              .toList(),
        ));
  }
}
