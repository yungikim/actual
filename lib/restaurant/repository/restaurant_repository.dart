
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

import '../../common/model/cursor_pagination_model.dart';
import '../model/restaurant_detail_model.dart';
import '../model/restaurant_model.dart';

part 'restaurant_repository.g.dart';

@RestApi()
abstract class RestaurantRepository{
  //http://$ip/restaurant
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
    _RestaurantRepository;

  //http://$ip/restaurant/
  @GET('/')
  @Headers({
    'accessToken' : 'true',
  })
  Future<CursorPagination<RestaurantModel>> paginate();

  //http://$ip/restaurant/:id
  @GET('/{id}')
  @Headers({
    'accessToken' : 'true',
  })
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path('id') required String id,
  });
}