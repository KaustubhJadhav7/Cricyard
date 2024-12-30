import 'package:flutter/material.dart';
import '../../../../core/app_export.dart';
import '../../../widgets/custom_elevated_button.dart'; // ignore_for_file: must_be_immutable

class SideSlideMenuDraweritem extends StatelessWidget {
  const SideSlideMenuDraweritem({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(bottom: 7.v),
          padding: EdgeInsets.only(
            left: 28.h,
            top: 174.v,
            right: 28.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 284.h,
                margin: EdgeInsets.only(right: 88.h),
                padding: EdgeInsets.symmetric(
                  horizontal: 43.h,
                  vertical: 5.v,
                ),
                decoration: AppDecoration.fillPrimary.copyWith(
                  borderRadius: BorderRadiusStyle.roundedBorder15,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 3.v),
                    Text(
                      "Leaderboard",
                      style: CustomTextStyles.titleMediumWhiteA700,
                    )
                  ],
                ),
              ),
              SizedBox(height: 21.v),
              Container(
                width: 284.h,
                margin: EdgeInsets.only(right: 88.h),
                padding: EdgeInsets.symmetric(
                  horizontal: 46.h,
                  vertical: 6.v,
                ),
                decoration: AppDecoration.fillPrimary.copyWith(
                  borderRadius: BorderRadiusStyle.roundedBorder15,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 1.v),
                    Text(
                      "GoLive",
                      style: CustomTextStyles.titleMediumGray300,
                    )
                  ],
                ),
              ),
              SizedBox(height: 19.v),
              _buildMyMatchesButton(context),
              SizedBox(height: 23.v),
              _buildMyTournamentsButton(context),
              SizedBox(height: 21.v),
              _buildMyHighlightsButton(context),
              SizedBox(height: 23.v),
              _buildChangeLanguageButton(context),
              SizedBox(height: 18.v),
              _buildCommunityButton(context),
              SizedBox(height: 18.v),
              _buildFindFriendsButton(context),
              SizedBox(height: 18.v)
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildMyMatchesButton(BuildContext context) {
    return CustomElevatedButton(
      text: "My Matches",
      margin: EdgeInsets.only(right: 88.h),
    );
  }

  /// Section Widget
  Widget _buildMyTournamentsButton(BuildContext context) {
    return CustomElevatedButton(
      text: "My Tournaments",
      margin: EdgeInsets.only(right: 88.h),
    );
  }

  /// Section Widget
  Widget _buildMyHighlightsButton(BuildContext context) {
    return CustomElevatedButton(
      text: "My Highlights",
      margin: EdgeInsets.only(right: 88.h),
    );
  }

  /// Section Widget
  Widget _buildChangeLanguageButton(BuildContext context) {
    return CustomElevatedButton(
      text: "Change language",
      margin: EdgeInsets.only(right: 88.h),
    );
  }

  /// Section Widget
  Widget _buildCommunityButton(BuildContext context) {
    return CustomElevatedButton(
      text: "Community",
      margin: EdgeInsets.only(right: 88.h),
    );
  }

  /// Section Widget
  Widget _buildFindFriendsButton(BuildContext context) {
    return CustomElevatedButton(
      text: "Find Friends",
      margin: EdgeInsets.only(right: 88.h),
    );
  }
}
