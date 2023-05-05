import 'package:actual/riverpodsample/model/shopping_item_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//제너릭1 : 어떤 Notifer인지 , 제너릭2 : 관리하는 state의 타입
final ShoppingListProvider =
    StateNotifierProvider<ShoppingListNotifier, List<ShoppingItemModel>>((ref) => ShoppingListNotifier());

class ShoppingListNotifier extends StateNotifier<List<ShoppingItemModel>> {
  //statenotifierprovider는 무조건 extends StateNotifier 해주고 상태 관리 할 타입을 지정해 주어야 한다.
  //super값이 state라는 인자에 들어간다.

  //1. 생성자를 무조건 선언해 주어야 한다.
  //2. super를 선언해서 초기값을 지정해 주어야 한다. 없을 경우 super([])로 선언
  ShoppingListNotifier()
      : super([
          ShoppingItemModel(
            name: '김치',
            quantity: 3,
            hasBought: false,
            isSpicy: true,
          ),
          ShoppingItemModel(
            name: '라면',
            quantity: 5,
            hasBought: false,
            isSpicy: true,
          ),
          ShoppingItemModel(
            name: '삼겹살',
            quantity: 10,
            hasBought: false,
            isSpicy: false,
          ),
          ShoppingItemModel(
            name: '수박',
            quantity: 2,
            hasBought: false,
            isSpicy: false,
          ),
          ShoppingItemModel(
            name: '카스테라',
            quantity: 5,
            hasBought: false,
            isSpicy: false
          ),
        ]);
  
  void toggleHasBought({required String name}){
    state = state.map(
            (e) => e.name == name ?
      ShoppingItemModel(
        name: e.name,
        quantity: e.quantity,
        hasBought: !e.hasBought,
        isSpicy: e.isSpicy,) : e).toList();
  }
}
