import 'dart:convert';

import 'package:book_app/models/book_list_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/book_detail_response.dart';

class BookController extends ChangeNotifier {
  BookListResponse? bookList;
  fatchBookApi() async {
    var url = Uri.https('https://api.itbook.store/1.0/new');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonBookList = jsonDecode(response.body);
      bookList = BookListResponse.fromJson(jsonBookList);
      notifyListeners();
    }

    //print(await http.read(Uri.https('example.com', 'foobar.txt')));
  }
  BookDetailResponse? detailBook;
  fatchDetailBookApi(isbn) async {
    
    var url = Uri.https('https://api.itbook.store/1.0/books/$isbn');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonDetail = jsonDecode(response.body);
      detailBook = BookDetailResponse.fromJson(jsonDetail);
      notifyListeners();
      fatchSimiliarBookApi(detailBook!.title!);
    }
    //print(await http.read(Uri.https('example.com', 'foobar.txt')));
  }

  BookListResponse? similiarBooks;
  fatchSimiliarBookApi(String title) async {
    //print(widget.isbn);
    var url = Uri.https('https://api.itbook.store/1.0/search/$title');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonDetail = jsonDecode(response.body);
      similiarBooks = BookListResponse.fromJson(jsonDetail);
    }
    //print(await http.read(Uri.https('example.com', 'foobar.txt')));
  }



}

