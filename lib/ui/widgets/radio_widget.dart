import 'package:flutter/material.dart';

import '../styles/color.dart';
import '../styles/texts.dart';

class RadioWidget extends StatefulWidget {
  final String label;
  final List<String> textValue;
  String? value;

  RadioWidget({Key? key, required this.label, required this.textValue,this.value})
      : super(key: key);

  @override
  State<RadioWidget> createState() => _RadioWidgetState();
}

class _RadioWidgetState extends State<RadioWidget> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(bottom: 33),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.label,
              style: headerPoppins.copyWith(
                  color: AppColors.textSecondary,)),
          const SizedBox(height: 4),
          Container(
            decoration: BoxDecoration(
                color: AppColors.boxBorder,
                borderRadius: BorderRadius.circular(20)),
            height: 35,
            width: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
              widget.textValue.length,
              (index) => GestureDetector(
                onTap: (){
                  setState(() {
                    selectedIndex = index;
                    if (widget.value == null){

                    }
                    widget.value = widget.textValue.elementAt(index);
                    print(widget.value);
                  });
                },
                child: Container(
                  width: 75,
                    height: 35,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: selectedIndex == index
                            ? AppColors.white
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(widget.textValue[index])),
              ),
            )),
          ),
        ],
      ),
    );
  }
}
