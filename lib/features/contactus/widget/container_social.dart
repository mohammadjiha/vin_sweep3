import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

class ContainerSocial extends StatelessWidget{
  final String imageSocial;
  const ContainerSocial({super.key, required this.imageSocial});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(color: const Color.fromRGBO(235, 245, 250, 1),
      borderRadius: BorderRadius.circular(10),
      ),
      height: 6.h,
      width: 13.w,
      child: 
      Image.asset('assets/images/$imageSocial'),
     );
  }
  
}