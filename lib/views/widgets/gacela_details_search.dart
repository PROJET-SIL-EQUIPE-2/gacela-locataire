import 'package:flutter/material.dart';
import 'package:gacela_locataire/config/theme/colors.dart';
import "package:flutter_svg/flutter_svg.dart" ;


class CarDetailSearch extends StatelessWidget {
  final String depart;
  final String dest ; 
  const CarDetailSearch(
    
      {Key? key,
      required this.depart,
      required this.dest,
     })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double itemMargin = 10.0;
    double height = 100;
    double width = MediaQuery.of(context).size.width - itemMargin;
    double padding = 10.0;
   
    return Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               mainAxisSize: MainAxisSize.max,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Expanded(
                    child : Container(
                     width: 3*width/5, 
           
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                       ),
                       child : Row (
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         mainAxisSize: MainAxisSize.max,
                         crossAxisAlignment: CrossAxisAlignment.center,
              
                         children: [
                        
                          Padding(
                               padding: const EdgeInsets.only(left :15.0 , top : 10 , bottom : 10 , right : 5 ),
                               child: Text(
                               depart , 
                               style: TextStyle(
                               color :GacelaColors.gacelaDeepBlue , 
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              ),),
                         ),
                        
                          Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: SvgPicture.asset('assets/icons/red_circle.svg'),
                         ) , 
                        Padding(
                               padding: const EdgeInsets.only(top :8.0 , bottom: 8 , right:3 , left : 0),
                               child: SvgPicture.asset('assets/icons/point.svg'),
                         ) ,
                         Padding(
                               padding: const EdgeInsets.only(top :8.0 , bottom: 8 , right:3 , left : 3),
                               child: SvgPicture.asset('assets/icons/point.svg'),
                         ) ,
                         Padding(
                               padding: const EdgeInsets.only(top :8.0 , bottom: 8 , right:3 , left : 3),
                               child: SvgPicture.asset('assets/icons/point.svg'),
                         ) ,
                         Padding(
                               padding: const EdgeInsets.only(top :8.0 , bottom: 8 , right:3 , left : 3),
                               child: SvgPicture.asset('assets/icons/point.svg'),
                         ) ,
                         Padding(
                               padding: const EdgeInsets.only(top :8.0 , bottom: 8 , right:0 , left : 3),
                               child: SvgPicture.asset('assets/icons/point.svg'),
                         ) ,
                         Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: SvgPicture.asset('assets/icons/depart.svg'),
                         ) ,
                          
                         Padding(
                               padding: const EdgeInsets.only(right :15.0 , top : 10 , bottom : 10 , left : 5 ),
                               child: Text(
                               dest , 
                               style: TextStyle(
                               color :GacelaColors.gacelaDeepBlue , 
                               fontSize: 15,
                              fontWeight: FontWeight.w500,
                          ),
                          ),
                         ),
                        ],
                       )
                   
                              ),
                 ), 
               
                
               
                 Container(
                    width : width / 5 , 
                    padding: const EdgeInsets.all(0) ,
                    child: FloatingActionButton(
                    onPressed: () {},
                    child: const Icon(
                      Icons.search_outlined,
                      size : 30 ,
                    ),
                    backgroundColor: Colors.white,
                               ), 
                             /* ), */
                           
                             ),
              
           
               ]
             );
  }
}
