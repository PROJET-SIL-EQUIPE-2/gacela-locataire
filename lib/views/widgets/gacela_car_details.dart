import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:gacela_locataire/config/theme/colors.dart';
import 'package:gacela_locataire/views/screens.dart';
import 'package:gacela_locataire/views/widgets.dart';
import 'package:gacela_locataire/views/widgets/gacela_car_details.dart';

import 'package:gacela_locataire/views/widgets/map_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import "package:flutter_svg/flutter_svg.dart" ;

import 'package:gacela_locataire/config/theme/colors.dart';
import "package:flutter_svg/flutter_svg.dart" ;

class GacelaCarDetailsWidget extends StatelessWidget {
  final bool clim;
  final int places;
  final String type;
  final String carName ; 
  final double price;
  const GacelaCarDetailsWidget(
    
      {Key? key,
      required this.clim,
      required this.carName,
      required this.places,
      required this.type,
      required this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double itemMargin = 10.0;
    double height = 300;
    double width = MediaQuery.of(context).size.width - itemMargin;
    double padding = 10.0;
   
    return Container(
      height: height,
      width: width,
      /* padding: EdgeInsets.all(padding),
      margin: EdgeInsets.all(itemMargin), */
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      color : GacelaColors.gacelaLightOrange ,
      ),

      
      
      child: 
        Column (
          children : [
            Container ( 
              height : height ,
              width : width , 

              decoration: BoxDecoration(

                color : GacelaColors.gacelaLightOrange ,
                borderRadius: BorderRadius.only( topLeft: Radius.circular(20) , topRight: Radius.circular(20))
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Stack(
                    children: [
                      Column(
                            children: [
                               Container(
                                 padding: const EdgeInsets.only(bottom : 13 , top : 10 ,) ,
                              width : width , 
                              child: Text(
                               carName ,
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                  color : GacelaColors.gacelaDeepBlue ,
                                ),
                              ),
                            ), 
                              Container(
                                width : width , 
                                child: Text.rich(
                            
                                 TextSpan(
                                children: <InlineSpan>[
                                    WidgetSpan(
                                        child: Padding(
                                          padding: const EdgeInsets.only( right :5.0 ),
                                          child: SvgPicture.asset(
                                            "assets/icons/type.svg" ,
                                            height : 20 , 
                                            width : 20  , 
                                             ),
                                        ),
                                          ),
                                    TextSpan(text: type , 
                                    style: TextStyle(
                                    fontSize: 15 ,
                                    fontWeight: FontWeight.w500,
                                    color : GacelaColors.gacelaDeepBlue ,
                              ),
                                    ),
                                ],
                              ),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 15 ,
                              ),
                  
                            ),
                              ), 
                           
                            
                            ]
                          ), 
                          Positioned(
                            right : -10 , 
                            bottom : -50 ,
                            child: Container(
                              height : 200 ,
                              child: Image.asset(
                                'assets/images/voiture.png' ,
                                fit: BoxFit.fill,

                             
                                
                              ),
                            ),
                          ),
                    ]
                  ),
                        
                  ) , 
                  Expanded (
                    child : Container(
                      decoration: BoxDecoration(
                                 color : Colors.white ,
                                  borderRadius: BorderRadius.only( topLeft: Radius.circular(20) , topRight: Radius.circular(20))
                                ),
                      child: Column (
                        children : [
                         Container(
                                width : width , 
                                 /* decoration: BoxDecoration(
                                   color : Colors.yellow ,
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                  ), */
                                child: Padding(
                                  padding: const EdgeInsets.only(right :8.0 , left : 8 , top : 20 , bottom :10 ),
                                  child: Text(
                                   'Attributs' ,
                                    style: TextStyle(
                                      fontSize: 22,
                                      color : GacelaColors.gacelaDeepBlue ,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ), 
                              Row (children: [
                                Expanded(
                                  child: Container (
                                    margin: const EdgeInsets.all(20) ,
                                    height : 100 ,               
                                    decoration: BoxDecoration(
                                    color : Colors.white ,
                                    border: Border.all(
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                  ),
                                  child: Column (children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgPicture.asset("assets/icons/clim.svg" , 
                                      color : GacelaColors.gacelaDeepBlue ,
                                      height: 30 , width : 30
                                      ),
                                    ) ,
                                    Padding(
                                      padding: const EdgeInsets.only(top :5.0 , left : 8 , right : 8),
                                      child: Text('Climatisation' ,
                                      style: TextStyle(
                                          fontSize: 15 ,
                                          fontWeight: FontWeight.w500,
                                          color : GacelaColors.gacelaDeepBlue , 

                                          
                                       ), ),
                                    )
                                  ],)
                                  ),
                                ) ,
                                 Expanded(
                                   child: Container (
                                    height : 100 , 
                                    margin: const EdgeInsets.all(20) ,
                                    decoration: BoxDecoration(
                                    color : Colors.white , 
                                    border: Border.all(
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                                               ),
                                    child: Column (
                                      children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgPicture.asset("assets/icons/place.svg" , 
                                      color : GacelaColors.gacelaDeepBlue ,
                                      height: 30 , width : 30 ),
                                    ) ,
                                    Padding(
                                      padding: const EdgeInsets.only(top :5.0 , right : 8 , left : 8 ),
                                      child: Text( places.toString() + " places" , 
                                      style: TextStyle(
                                          fontSize: 15 ,
                                          color : GacelaColors.gacelaDeepBlue ,
                                          fontWeight: FontWeight.w500,

                                          
                                       ),),
                                    )
                                  ],)
                                                               ),
                                 ) ,
                                 

                              ],
                              ) , 
                              Row (
                                children: [
                                  Expanded(
                                    
                                    child: Container(
                                      margin: const EdgeInsets.all(20) ,

                                      child: Text.rich(
                                                                
                                       TextSpan(

                                      children: <InlineSpan>[
                                          
                                          TextSpan(text: price.toString() + " DA" ,
                                          style: TextStyle(
                                          fontSize: 20 ,
                                          color: GacelaColors.gacelaDeepBlue ,
                                          fontWeight: FontWeight.w700,  
                                       ),
                                                                   ),
                                          TextSpan(text: "/h" , 
                                          style: TextStyle(
                                          fontSize: 10 ,
                                          color: GacelaColors.gacelaDeepBlue ,

                                             ), ),  
                                                                           
                                  
                                  
                                      ],
                                                                  ),
                                      textAlign: TextAlign.left,
                                      
                                                      
                                                                ),
                                    ),
                                  ),
                              Expanded(
                                child: Container(
                                    margin: const EdgeInsets.all(20) ,
                                    padding: const EdgeInsets.only(top : 10) ,
                                     decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color : Colors.white ,
                                    ),

                                  child: ElevatedButton (
                                    
                                    onPressed: () {},
                                  style : ElevatedButton.styleFrom(
                                      primary : GacelaColors.gacelaDeepBlue ,
                                      padding: const EdgeInsets.all(10) ,
                                      shape : RoundedRectangleBorder(
                                        borderRadius : BorderRadius.circular(20) , 

                                      )) ,
                                  child : Text("Appeler" ,
                                  style: TextStyle(
                                          fontSize: 20 ,
                                          fontWeight: FontWeight.w700,
                                          color : Colors.white , 

                                          
                                       ),
                                  ) ,
                                  
                                  ),
                                ),
                              )
                        
                        ]
                      ) ,
/*                       CarDetailSearch(depart: "ESI", dest:"Beaulieu")
 */                      ]
                        
                  ),
                    )
                  )

            
          ]
       
        
      ), 
    );
  }
}
