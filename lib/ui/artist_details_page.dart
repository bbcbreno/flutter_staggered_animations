import 'package:flutter_staggered_animations/data/models.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter_staggered_animations/ui/video_card.dart';
import 'package:flutter_staggered_animations/ui/artist_details_enter_animation.dart';

class ArtistDetailsPage extends StatelessWidget {
  ArtistDetailsPage(
      {@required this.artist, @required AnimationController controller})
      : animation = ArtistDetailsEnterAnimation(controller);
  final Artist artist;
  final ArtistDetailsEnterAnimation animation;

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Opacity(
          opacity: animation.backdropOpacity.value,
          child: Image.asset(
            artist.backdropPhoto,
            fit: BoxFit.cover,
          ),
        ),
        BackdropFilter(
          filter: ui.ImageFilter.blur(
              sigmaX: animation.backdropBlur.value,
              sigmaY: animation.backdropBlur.value),
          child: Container(
            color: Colors.black.withOpacity(0.5),
            child: _buildContent(),
          ),
        )
      ],
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildAvatar(),
          _buildInfo(),
          _buildVideoScroller(),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.diagonal3Values(
          animation.avatarSize.value, animation.avatarSize.value, 1.0),
      child: Container(
        margin: EdgeInsets.only(top: 32, left: 16),
        padding: EdgeInsets.all(3.0),
        width: 110,
        height: 110,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white30,
          ),
        ),
        child: ClipOval(
          child: Image.asset(artist.avatar),
        ),
      ),
    );
  }

  Widget _buildInfo() {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '${artist.firstName}\n${artist.lastName}',
            style: TextStyle(
              color: Colors.white.withOpacity(animation.nameOpacity.value),
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            artist.location,
            style: TextStyle(
              color: Colors.white.withOpacity(animation.locationOpacity.value),
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            color: Colors.white.withOpacity(0.85),
            margin: EdgeInsets.symmetric(vertical: 16.0),
            width: animation.dividerWidth.value,
            height: 1.0,
          ),
          Text(
            artist.biography,
            style: TextStyle(
              color: Colors.white.withOpacity(animation.biographyOpacity.value),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoScroller() {
    return Padding(
      padding: EdgeInsets.only(top: 16),
      child: Transform(
        transform: Matrix4.translationValues(
            animation.videoScrollerXTranslation.value, 0.0, 0.0),
        child: Opacity(
          opacity: animation.videoScrollerOpacity.value,
          child: SizedBox.fromSize(
            size: Size.fromHeight(245.0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 8),
              itemCount: artist.videos.length,
              itemBuilder: (BuildContext context, int index) {
                var video = artist.videos[index];
                return VideoCard(video);
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnimatedBuilder(
      animation: animation.controller,
      builder: _buildAnimation,
    ));
  }
}
