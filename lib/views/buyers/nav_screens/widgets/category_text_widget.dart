import 'package:flutter/material.dart';

class CatergoryText extends StatelessWidget {
  final List<String> _categorulable = [
    'egg',
    'tomato',
    'olive',
    'rice',
    'limone',
    'orange',
    'kiwi'
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categories',
            style: TextStyle(fontSize: 19),
          ),
          Container(
            height: 40,
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _categorulable.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ActionChip(
                            backgroundColor: Colors.yellow.shade900,
                            onPressed: () {},
                            label: Text(
                              _categorulable[index],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      }),
                ),
                IconButton(
                    onPressed: () {}, icon: Icon(Icons.arrow_forward_ios))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
