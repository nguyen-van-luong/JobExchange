import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_exchange/ui/widgets/user_avatar.dart';

import '../../models/address.dart';
import '../../models/job.dart';
import '../common/utils/date_time.dart';

class JobFeedItem extends StatelessWidget {
  final Job job;

  const JobFeedItem({super.key, required this.job});

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
                  imageUrl: job.employer!.avatarUrl,
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
                            job.employer.name,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: Colors.indigo[700]),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          getTimeAgo(job.updatedAt),
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
                      job.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                      ),
                      softWrap: true,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Row(children: [
                      salaryView(job.salaryFrom, job.salaryTo),
                      const SizedBox(width: 16),
                      addressView(job.addresses)
                    ]),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget salaryView(int? salaryFrom, int? salaryTo) {
    String text = "";
    if(salaryFrom != null && salaryTo != null) {
      text = salaryFrom.toString() + " - " +salaryTo.toString() + " triệu";
    } else {
      text = (salaryFrom.toString() ?? "") + (salaryTo.toString() ?? "") + " triệu";
    }

    return Container(
      child: Row(
        children: [
          Icon(
            Icons.attach_money,
            size: 16,
            color: Colors.grey[700],
          ),
          const SizedBox(width: 2),
          Text(text,
              style: TextStyle(fontSize: 13, color: Colors.grey[700])),
        ],
      ),
    );
  }

  Widget addressView(List<Address> addresses) {
    String text = addresses[0].province.name;
    if(addresses.length > 1) {
      text += ' & ${addresses.length - 1} nơi khác';
    }

    return Container(
      child: Row(
        children: [
          Icon(
            Icons.location_on_outlined,
            size: 16,
            color: Colors.grey[700],
          ),
          const SizedBox(width: 2),
          Text(text,
              style: TextStyle(fontSize: 13, color: Colors.grey[700])),
        ],
      ),
    );
  }
}
