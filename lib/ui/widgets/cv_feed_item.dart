import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_exchange/ui/widgets/user_avatar.dart';

import '../../models/cv.dart';
import '../common/utils/date_time.dart';

class CVFeedItem extends StatelessWidget {
  final CV cv;

  const CVFeedItem({super.key, required this.cv});

  @override
  Widget build(BuildContext context) {
    return _buildContainer();
  }

  Container _buildContainer() {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => null,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: UserAvatar(
                  imageUrl: cv.student!.avatarUrl,
                  size: 64,
                )),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () => null,
                          child: Text(
                            cv.student.fullname,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: Colors.indigo[700]),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          getTimeAgo(cv.updatedAt),
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(top: 2, bottom: 4),
                  child: InkWell(
                    onTap: () => null,
                    hoverColor: Colors.black12,
                    child: Text(
                      cv.positionWant,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                      ),
                      softWrap: true,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}