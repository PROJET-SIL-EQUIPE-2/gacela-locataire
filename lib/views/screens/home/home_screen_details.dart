import 'package:flutter/material.dart';
import 'package:gacela_locataire/config/theme/colors.dart';
import 'package:gacela_locataire/views/screens.dart';
import 'package:gacela_locataire/views/widgets.dart';

import 'package:gacela_locataire/views/widgets/map_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import "package:flutter_svg/flutter_svg.dart" ;


class HomeScreenDetails extends StatefulWidget {
  static const route = "/";
  const HomeScreenDetails({Key? key}) : super(key: key);

  @override
  State<HomeScreenDetails> createState() => _HomeScreenDetailsState();
}

class _HomeScreenDetailsState extends State<HomeScreenDetails> {
  static const double fabHeightClosed = 116.0;
  double fabHieght = fabHeightClosed;
  int _currentStep = 0 ;


  @override
  Widget build(BuildContext context) {
    final double panelHeightOpen = MediaQuery.of(context).size.height / 2;
    final double panelHeightClosed = MediaQuery.of(context).size.height / 10;
    double height = MediaQuery.of(context).size.height   ;
    double width = MediaQuery.of(context).size.width   ;


    return Scaffold(
      body: Stack(
        
        children: [
          Positioned( 
             top : 0 ,
             right : 70 ,
             child: FloatingActionButton(
              onPressed: () {},
              child: const Icon(
                Icons.person ,
              ),
              backgroundColor: Colors.white,
            ),
           ) ,
           Positioned(
              top : 0 , 
              right : 0 ,
              child: FloatingActionButton(
              onPressed: () {},
              child: const Icon(
                Icons.notifications,
              ),
              backgroundColor: Colors.white,
            ),
            ),
            /* Stack(
              children: [
                            const MapWidget() ,
                            
          
          
              ]
            ), */
          
            

           
           
            
            Positioned(
             child: CarDetailSearch(depart: "ESI", dest:"Beaulieu") ,
           ) , 
          
                   Positioned (
                     bottom : 0 , 
                     left : 0 , 
                     right : 0 ,
                     child : Container(
                    height : height / 2 ,
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color : GacelaColors.gacelaLightOrange ,
                  ),


                      child: GacelaCarDetailsWidget(
                          clim : true,
                          places : 5,
                          type : "0234 5678 8939 16" ,
                          carName : "Hyundai accent" , 
                          price : 120 ,
                      
                        ),
                      
                  )
                
                   )
          
        ],
      ),
    );
  }
}
