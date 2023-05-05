import 'package:actual/riverpodsample/layout/default_layout.dart';
import 'package:actual/riverpodsample/riverpod/state_provider_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StateProviderScreen extends ConsumerWidget {
  const StateProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final provider = ref.watch(numberProvider);

    return DefaultLayout(
      title: 'StateProviderScreen',
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              provider.toString(),
            ),
            ElevatedButton(onPressed: (){
              ref.read(numberProvider.notifier).update((state) => state + 1);
            }, child: Text("Up")),
            ElevatedButton(onPressed: (){
              ref.read(numberProvider.notifier).state = ref.read(numberProvider.notifier).state - 1;
            }, child: Text("Down")),
            ElevatedButton(onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => _NextScreen()),
              );
            }, child: Text("Next Page"))
          ],
        ),
      ),
    );
  }
}

class _NextScreen extends ConsumerWidget {
  const _NextScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final provider = ref.watch(numberProvider);

    return DefaultLayout(
      title: 'StateProviderScreen',
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              provider.toString(),
            ),
            ElevatedButton(onPressed: (){
              ref.read(numberProvider.notifier).update((state) => state + 1);
            }, child: Text("Up"))
          ],
        ),
      ),
    );
  }
}
