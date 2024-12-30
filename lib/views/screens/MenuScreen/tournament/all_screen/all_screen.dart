import 'package:cricyard/core/utils/size_utils.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/image_constant.dart';
import '../../../../../theme/app_decoration.dart';
import '../../../../../theme/custom_text_style.dart';
import '../../../../../theme/theme_helper.dart';
import '../../../../widgets/custom_image_view.dart';
import '../../../ReuseableWidgets/BottomAppBarWidget.dart';

class AllScreen extends StatelessWidget {
  const AllScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(vertical: 10.v),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _headerWidget(context),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(bottom: 13.v),
                  padding: EdgeInsets.symmetric(horizontal: 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5.v),
                      Container(
                        margin: EdgeInsets.only(right: 3.h),
                        padding: EdgeInsets.all(16.h),
                        decoration: AppDecoration.fillWhiteA,
                        child: Column(
                          children: [
                            _buildRecentOrders(
                              context,
                              text26three: "26.4",
                              textTabsOne: "1",
                              textJbumrahtodOne: "J Bumrah to D Wellalage",
                              textBackofaOne:
                                  "Back of a length angling in around off, Wellalage plays and misses through to the keeper to end the over.",
                            ),
                            SizedBox(height: 16.v),
                            _buildRecentOrders(
                              context,
                              text26three: "26.3",
                              textTabsOne: "1",
                              textJbumrahtodOne: "J Bumrah to D Wellalage",
                              textBackofaOne:
                                  "Back of a length angling away outside off, Wellalage lets it go through to the keeper.",
                            ),
                            SizedBox(height: 16.v),
                            _buildRecentOrders(
                              context,
                              text26three: "26.2",
                              textTabsOne: "1",
                              textJbumrahtodOne: "J Bumrah to D Wellalage",
                              textBackofaOne:
                                  "Back of a length angling away outside off, Wellalage plays inside the line and lets the ball pass through to the keeper.",
                            ),
                            SizedBox(height: 16.v),
                            _buildRecentOrders(
                              context,
                              text26three: "26.1",
                              textTabsOne: "0",
                              textJbumrahtodOne: "J Bumrah to D Wellalage",
                              textBackofaOne:
                                  "Good length around off, Silva defends it to the point region.",
                            ),
                            SizedBox(height: 16.v),
                            _buildUserProfile(context),
                            SizedBox(height: 16.v),
                            _buildDoctorReviews(context),
                            _buildClientTestimonials(context),
                            SizedBox(height: 16.v),
                            _buildReviews(context)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBarWidget(),
    );
  }

  /// Section Widget
  Widget _buildUserProfile(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 45.h,
        vertical: 11.v,
      ),
      decoration: AppDecoration.fillBlueA.copyWith(
        borderRadius: BorderRadiusStyle.circleBorder12,
      ),
      child: SizedBox(
        width: 270.h,
        child: Text(
          "J Bumrah is back into the attack.\nSri Lanka needs 106 run in 138 balls to win.",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: CustomTextStyles.labelLargeSFProTextWhiteA700.copyWith(
            height: 1.38,
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildDoctorReviews(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.h,
        vertical: 11.v,
      ),
      decoration: AppDecoration.fillGray800.copyWith(
        borderRadius: BorderRadiusStyle.customBorderTL12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 1.v,
              bottom: 5.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "End of Over 25".toUpperCase(),
                  style: CustomTextStyles.labelLargeSFProTextWhiteA700,
                ),
                SizedBox(height: 5.v),
                Text(
                  "2 runs",
                  style: CustomTextStyles.labelLargeSFProTextWhiteA700,
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 1.v),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "SL 104/6",
                  style: CustomTextStyles.labelLargeSFProTextWhiteA700,
                ),
                SizedBox(height: 10.v),
                Text(
                  "CRR: 4.4 | RRR: 4.0",
                  style: CustomTextStyles.labelLargeSFProTextWhiteA700,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildClientTestimonials(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.h,
        vertical: 11.v,
      ),
      decoration: AppDecoration.fillPrimary.copyWith(
        borderRadius: BorderRadiusStyle.customBorderBL12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 2.v,
              bottom: 4.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "D Wellalage",
                  style: CustomTextStyles.labelLargeSFProTextWhiteA700,
                ),
                SizedBox(height: 5.v),
                Text(
                  "28 (33)",
                  style: CustomTextStyles.labelLargeSFProTextWhiteA700,
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 12.h,
              top: 1.v,
              bottom: 4.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "D Silva",
                  style: CustomTextStyles.labelLargeSFProTextWhiteA700,
                ),
                SizedBox(height: 7.v),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "40 (58)",
                    style: CustomTextStyles.labelLargeSFProTextWhiteA700,
                  ),
                )
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(top: 2.v),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "H Pandya",
                    style: CustomTextStyles.labelLargeSFProTextWhiteA700,
                  ),
                ),
                SizedBox(height: 9.v),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "0-5 (2.0)",
                    style: CustomTextStyles.labelLargeSFProTextWhiteA700,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildReviews(BuildContext context) {
    return Container(
      decoration: AppDecoration.fillPink.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 16.h,
              top: 15.v,
              bottom: 15.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "6-99 ",
                        style: CustomTextStyles.titleLargeWhiteA700,
                      ),
                      TextSpan(
                        text: "25.1",
                        style: CustomTextStyles.labelMediumWhiteA700ExtraBold,
                      )
                    ],
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 16.v),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "D Shanaka ",
                        style: CustomTextStyles.labelLargeWhiteA700_1,
                      ),
                      TextSpan(
                        text: "9 (13)",
                        style: CustomTextStyles.labelLargeAmber300,
                      )
                    ],
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 3.v),
                Text(
                  "b Wellalage",
                  style: CustomTextStyles.labelMediumWhiteA700,
                )
              ],
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgImage599x189,
            height: 99.v,
            width: 189.h,
            margin: EdgeInsets.only(top: 6.v),
          )
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildRecentOrders(
    BuildContext context, {
    required String text26three,
    required String textTabsOne,
    required String textJbumrahtodOne,
    required String textBackofaOne,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 1.v,
            bottom: 26.v,
          ),
          child: Column(
            children: [
              Center(
                child: Text(
                  text26three,
                  style: CustomTextStyles.labelLargeSFProTextPrimary.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
              SizedBox(height: 4.v),
              Container(
                width: 30.adaptSize,
                padding: EdgeInsets.symmetric(
                  horizontal: 11.h,
                  vertical: 6.v,
                ),
                decoration: AppDecoration.fillPrimary2.copyWith(
                  borderRadius: BorderRadiusStyle.roundedBorder16,
                ),
                child: Center(
                  child: Text(
                    textTabsOne,
                    style: CustomTextStyles.labelLargePrimaryBold.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 12.h),
            padding: EdgeInsets.symmetric(
              horizontal: 12.h,
              vertical: 6.v,
            ),
            decoration: AppDecoration.fillGray.copyWith(
              borderRadius: BorderRadiusStyle.circleBorder12,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 4.v),
                Opacity(
                  opacity: 0.6,
                  child: Text(textJbumrahtodOne,
                      style: CustomTextStyles.titleSmallPoppinsBlack900),
                ),
                SizedBox(height: 8.v),
                Container(
                  width: 260.h,
                  margin: EdgeInsets.only(right: 34.h),
                  child: Text(
                    textBackofaOne,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextStyles.labelLargeSFProTextPrimary.copyWith(
                      color: theme.colorScheme.primary,
                      height: 1.38,
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _headerWidget(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: const Color(0xFFC4FD62),
                  borderRadius: BorderRadius.circular(12)),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Text("All ", style: CustomTextStyles.titleLargePoppinsBlack40)
        ],
      ),
    );
  }
}
