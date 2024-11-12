import 'package:flutter/material.dart';
import 'package:redacted/redacted.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/utilts/api_constant.dart';


class PostShimmer extends StatelessWidget {
  const PostShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Constant.width(context) * .01),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200], // Light grey background color
          borderRadius: BorderRadius.circular(16), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 2), // Shadow position
            ),
          ],
        ),
        width: Constant.width(context) * .4,
        height: 70.h,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 1.w,
                bottom: 3.w,
                left: 3.w,
                right: 1.w,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 1.5.h,
                        backgroundColor: Colors.grey[400],
                      ),
                      SizedBox(width: 1.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            color: Colors.grey[400],
                            height: 1.5.h,
                            width: 10.w,
                          ),
                          SizedBox(height: 0.5.h),
                          Container(
                            color: Colors.grey[300],
                            height: 1.h,
                            width: 5.w,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Icon(
                    Icons.menu,
                    color: Colors.grey[400],
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.grey[300],
              width: 35.w,
              height: 45.h,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 3.w,
                right: 3.w,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.favorite,
                        color: Colors.grey[400],
                      ),
                      SizedBox(width: 0.5.w),
                      Container(
                        color: Colors.grey[400],
                        height: 1.h,
                        width: 3.w,
                      ),
                    ],
                  ),
                  Container(
                    color: Colors.grey[400],
                    height: 1.h,
                    width: 8.w,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 13.3.w,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      shape: const RoundedRectangleBorder(),
                    ),
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(
                          Icons.favorite_border,
                          color: Colors.grey[400],
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          'React',
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 2.w),
                ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Icon(
                        Icons.comment,
                        color: Colors.grey[400],
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        'Comment',
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 2.w),
                ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Icon(
                        Icons.share,
                        color: Colors.grey[400],
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        'Share',
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ).redacted(
        context: context,
        configuration: RedactedConfiguration(
          animationDuration: const Duration(milliseconds: 800),
        ),
        redact: true,
      ),
    );
  }
}
