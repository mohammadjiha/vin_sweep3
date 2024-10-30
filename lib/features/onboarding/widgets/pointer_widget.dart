import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

class PointerContainer extends StatelessWidget{
  final Color colorContainer;
  final int numberWith;
  const PointerContainer({super.key, required this.colorContainer, required this.numberWith});

  @override
  Widget build(BuildContext context) {
   return Container(height: 0.7.h,width: numberWith.w,
     decoration: BoxDecoration(color: colorContainer,borderRadius: BorderRadius.circular(25)),
   );
  }

}