import 'package:flutter/material.dart';

class TvDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv_detail';

  final int id;

  TvDetailPage({required this.id});

  @override
  _TvDetailState createState() => _TvDetailState();
}

class _TvDetailState extends State<TvDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Detail Tv"),),
    );
  }
}
