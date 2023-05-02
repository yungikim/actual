import 'package:actual/common/const/colors.dart';
import 'package:actual/restaurant/model/restaurant_detail_model.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Image image;
  final String name;
  final String detail;
  final int price;

  const ProductCard({
    Key? key,
    required this.image,
    required this.name,
    required this.detail,
    required this.price,
  }) : super(key: key);

  factory ProductCard.fromModel({
    required RestaurantProductModel model,
  }){

    return ProductCard(
        image: Image.network(
         model.imgUrl,
          width: 110,
          height: 110,
          fit: BoxFit.cover,
        ),
        name: model.name,
        detail: model.detail,
        price: model.price,
    );

  }

  @override
  Widget build(BuildContext context) {
    //좌측에 있는 이미지의 높이에 맞춰서 내부에 최대 높이에 맞추어준다 설정해주기 위해서 IntrinsicHeight로 감싸주어야 한다.
    return IntrinsicHeight(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: image,
          ),
          SizedBox(
            width: 16.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  detail,
                  overflow: TextOverflow.ellipsis,  //텍스트가 넘어가면 ...으로 처리한다.
                  maxLines: 2,
                  style: TextStyle(
                    color: BODY_TEXT_COLOR,
                    fontSize: 14.0,
                  ),
                ),
                SizedBox(
                  width: double.infinity,   //우측 정렬이 안되서 최대 높이로 맞추어 주었다.
                  child: Text(
                    '₩${price}',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: PRIMARY_COLOR,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
