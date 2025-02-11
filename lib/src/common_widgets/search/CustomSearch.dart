import 'package:flutter/material.dart';

class CustomSearch<T> extends StatelessWidget{
  final String hintText;
  final List<T> arrData;
  final Widget Function(T item,SearchController controller ) itemBuilder;
  const CustomSearch(this.hintText,this.arrData,this.itemBuilder,{super.key});

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      builder: (BuildContext context, SearchController controller) {
        return SizedBox(
          height: 45,
          child: SearchBar(
            controller: controller,
            hintText: hintText,
            padding: const WidgetStatePropertyAll<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 12.0 ,vertical: 4)),
            onTap: () {
              controller.openView();
            },
            onChanged: (_) {
              controller.openView();
            },
            leading: const Icon(Icons.search),
          )
        );
      },
      suggestionsBuilder:
          (BuildContext context, SearchController controller) {
        return arrData.map((item)=>itemBuilder(item , controller)).toList();
      },
    );
  }
}
