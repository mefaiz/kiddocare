import 'package:kiddocare/models/kindergarten.dart';

class PaginatedResponse<T> {
  final int first;
  final int prev;
  final int next;
  final int last;
  final int pages;
  final int items;
  final List<Kindergarten> data;

  PaginatedResponse({
    required this.first,
    required this.prev,
    required this.next,
    required this.last,
    required this.pages,
    required this.items,
    required this.data,
  });

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    return PaginatedResponse(
      first: json['first'] as int,
      prev: json['prev'] as int,
      next: json['next'] as int,
      last: json['last'] as int,
      pages: json['pages'] as int,
      items: json['items'] as int,
      data: (json['data'] as List).map((e) => Kindergarten.fromJson(e)).toList(),
    );
  }
} 