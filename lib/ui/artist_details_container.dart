import 'package:flutter_staggered_animations/data/mock_data.dart';
import 'package:flutter_staggered_animations/ui/artist_details_page.dart';
import 'package:flutter/material.dart';

class ArtistsDetailsAnimator extends StatefulWidget {
  @override
  _ArtistsDetailsAnimatorState createState() => _ArtistsDetailsAnimatorState();
}

class _ArtistsDetailsAnimatorState extends State<ArtistsDetailsAnimator>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 2200))
          ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ArtistDetailsPage(MockData.andy);
  }
}
