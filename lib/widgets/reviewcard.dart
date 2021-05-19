import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  String name;
  int rating;
  String review;
  ReviewCard({this.name, this.rating, this.review});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        // direction: Axis.vertical,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            // circular_image1
            child: rating % 2 == 0
                ? Image.asset(
              "assets/images/circular_image1.png",
              height: 60,
            )
                : Image.asset(
              "assets/images/circular_image2.png",
              height: 60,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  this.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "2 Days ago",
                  style: TextStyle(fontSize: 11),
                ),
                SizedBox(
                  height: 3,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.orange,
                    ),
                    Icon(
                      Icons.star,
                      color: this.rating >= 2 ? Colors.orange : Colors.grey,
                    ),
                    Icon(
                      Icons.star,
                      color: this.rating >= 3 ? Colors.orange : Colors.grey,
                    ),
                    Icon(
                      Icons.star,
                      color: this.rating >= 4 ? Colors.orange : Colors.grey,
                    ),
                    Icon(
                      Icons.star,
                      color: this.rating >= 5 ? Colors.orange : Colors.grey,
                    )
                  ],
                ),
                Text(
                  this.review,
                  style: TextStyle(fontWeight: FontWeight.w500),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}