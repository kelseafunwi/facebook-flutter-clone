import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:practice_flutter/core/constants/app_colors.dart';
import 'package:practice_flutter/core/constants/constants.dart';
import 'package:practice_flutter/features/posts/presentation/widgets/round_profile_tile_widget.dart';

class FeedMakePostWidget extends StatelessWidget {
  const FeedMakePostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: () {

        },
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                const RoundProfileTile(url: Constants.maleProfileUser),

                _buildPostTextField(),

                 const Padding(
                  padding: EdgeInsets.all(12),
                  child: Icon(
                    FontAwesomeIcons.solidImages,
                    color: Colors.green,
                  ),
                )
              ],
            ),
          )
        ),
      ),
    );
  }

  Widget _buildPostTextField() {
    return Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: AppColors.darkGreyColor),
          ),
          child: ,
        )
    );
  }
}
