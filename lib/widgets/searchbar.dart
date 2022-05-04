import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:newnote/controller/NoteController.dart';

import '../view/note_detail_page.dart';

class SearchBar extends SearchDelegate {
  NoteController controller = Get.find<NoteController>();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Get.back();
        },
        icon: AnimatedIcon(
          progress: transitionAnimation,
          icon: AnimatedIcons.menu_arrow,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionLsit = query.isEmpty
        ? controller.notes
        : controller.notes.where((element) {
            return element.title!.toLowerCase().contains(query.toLowerCase()) || element.content!.toLowerCase().contains(query.toLowerCase());
          }).toList();
    return Container(
      padding: EdgeInsets.all(10),
      child: AlignedGridView.count(
        itemCount: suggestionLsit.length,
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            Get.to(NoteDetailPage(), arguments: index);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  offset: Offset(10, 10),
                  blurRadius: 15,
                ),
              ],
            ),
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  suggestionLsit[index].title!,
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  suggestionLsit[index].content!,
                  style: TextStyle(fontSize: 17),
                  maxLines: 6,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  controller.notes[index].dateTimeEdited!,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
