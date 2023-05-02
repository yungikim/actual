
import 'package:json_annotation/json_annotation.dart';

import '../../restaurant/model/restaurant_model.dart';

part 'cursor_pagination_model.g.dart';

@JsonSerializable(
  genericArgumentFactories: true,  //T를 받기 위해서는 이런 설정을 해주어야 한다.
)
class CursorPagination<T>{
  final CursorPaginationMeta meta;
  final List<T> data;   //List Type만 계속 변경되는 형태이다. T가 뭐가 될지 모른다. 컴파일 시점에서
  
  CursorPagination({
    required this.meta,
    required this.data
  });

  //"T Function(Object? json) fromJsonT" 이부분을 추가해 주어야 한다.
  factory CursorPagination.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT)
  => _$CursorPaginationFromJson(json, fromJsonT);
}

@JsonSerializable()
class CursorPaginationMeta{
  final int count;
  final bool hasMore;

  CursorPaginationMeta({
    required this.count,
    required this.hasMore
  });

  factory CursorPaginationMeta.fromJson(Map<String, dynamic> json)
  => _$CursorPaginationMetaFromJson(json);
}