



import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ShowSnackAlert{
  static SnackBar CustomMessenger(BuildContext context, Color color1, Color color2, String text){
    return SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            content: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  
                  padding: EdgeInsets.all(16),
                  height: 100,
                  decoration:  BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: color1
                  ),
                  child:  Row(
                    children: [
                      const SizedBox(width: 48,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if(color1  == Colors.red.shade400)
                            Text('Oh Snap!', style: TextStyle(fontSize: 18, color: Colors.white),),
                            if(color1 == Colors.orange.shade400)
                            Text('Alert',style: TextStyle(fontSize: 18, color: Colors.white)),
                            if(color1 == Colors.green.shade600)
                              Text('Success',style: TextStyle(fontSize: 18, color: Colors.white)),

                            
                            Text("${text}", style: TextStyle(fontSize: 12, color: Colors.white), maxLines: 2, overflow: TextOverflow.ellipsis,),
                          ],
                        ),
                      ),
                    ],
                  )),
                  Positioned(
                    bottom: 0,
                  
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20)),
                      child: SvgPicture.asset(
                        
                        'assets/icon/bubbles.svg',
                         
                        height: 48,
                        width: 40,
                         colorFilter: ColorFilter.mode(color2, BlendMode.srcIn)
                        ),
                    ),
                  ),
                 Positioned(
                   top: -20,
                   left: 0,
                   child: Stack(
                    alignment: Alignment.center,
                     children: [
                       SvgPicture.asset(
                        'assets/icon/fail.svg',
                        height: 40,
                       ),
                       Positioned(
                        top: 10,
                        child: InkWell(
                          onTap: (){
                            ScaffoldMessenger.of(context).clearSnackBars();
                          },
                          child: SvgPicture.asset('assets/icon/close.svg', height: 16)))
                     ],
                   ),
                 )

              ],
            ),
            backgroundColor: Colors.transparent,
          );
  }
}