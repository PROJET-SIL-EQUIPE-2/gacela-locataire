import 'package:flutter/material.dart';
import 'package:gacela_locataire/config/theme/colors.dart';
import 'package:gacela_locataire/views/screens.dart';
import 'package:gacela_locataire/views/widgets.dart';
import 'package:gacela_locataire/views/widgets/map_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import "package:flutter_svg/flutter_svg.dart" ;

class HomeScreen extends StatefulWidget {
  static const route = "/";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          SlidingUpPanel(
              maxHeight: panelHeightOpen,
              minHeight: panelHeightClosed,
              parallaxEnabled: true,
              parallaxOffset: 0.5,
              body: Stack(
                children: const [
                  MapWidget(),
                ],
              ),
              panelBuilder: (controller) => PanelWidget(controller: controller),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              onPanelSlide: (position) => setState(
                    () {
                      final panelMaxScrollExtent =
                          panelHeightOpen - panelHeightClosed;
                      fabHieght =
                          position * panelMaxScrollExtent + fabHeightClosed;
                    },
                  )),
                  Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    height: height /5,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      
                    ),
                    child : Stack (
                      children : [
                        Positioned(
                          left : 0 , 
                          top : 20 ,
                          child: Container(
                            padding :  const EdgeInsets.all(3.0), 
                            child: Column (
                                    mainAxisSize: MainAxisSize.min,
                          
                                      children : [
                                        
                                    
                                      Padding(
                                        padding: const EdgeInsets.only(right :8.0 , left : 8.0 , bottom : 5 , top : 8.0),
                                        child: SvgPicture.asset(
                                        "assets/icons/depart.svg" ,
                                        height : 20 , 
                                        width : 20  , 
                                         ),
                                      ), 
                                      Padding(
                                        padding: const EdgeInsets.only(right :8.0 , left : 8.0 , bottom : 1.5 , top : 1.5),
                                        child: SvgPicture.asset(
                                        "assets/icons/point.svg" , 
                                         height : 5 , 
                                        width : 5  , ),
                                      ), 
                                      Padding(
                                        padding: const EdgeInsets.only(right :8.0 , left : 8.0 , bottom : 1.5 , top : 1.5),
                                        child: SvgPicture.asset(
                                        "assets/icons/point.svg" ,
                                          height : 5 , 
                                        width : 5  ,  ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right :8.0 , left : 8.0 , bottom : 1.5 , top : 1.5),
                                        child: SvgPicture.asset(
                                        "assets/icons/point.svg" ,
                                          height : 5 , 
                                        width : 5  ,  ),
                                      ), 
                                      Padding(
                                        padding: const EdgeInsets.only(right :8.0 , left : 8.0 , bottom : 1.5 , top : 1.5),
                                        child: SvgPicture.asset(
                                        "assets/icons/point.svg" ,
                                          height : 5 , 
                                        width : 5  ,  ),
                                      ), 
                                      Padding(
                                        padding: const EdgeInsets.only(right :8.0 , left : 8.0 , bottom : 1.5 , top : 1.5),
                                        child: SvgPicture.asset(
                                        "assets/icons/point.svg" ,
                                          height : 5 , 
                                        width : 5  ,  ),
                                      ), 
                                      Padding(
                                        padding: const EdgeInsets.only(right :8.0 , left : 8.0 , bottom : 5 , top : 5.0),
                                        child: SvgPicture.asset(
                                        "assets/icons/destination.svg" ,
                                        height : 27, 
                                          width : 27 , ),
                                      ), 
                                        
                                                    
                                                    
                                      ] 
                                      
                                    ),
                          ),
                        ) ,
                                  Positioned(
                                    left : 50 , 
                                    right : 0 , 
                                    top : 0 ,
                                    child: Container(
                                     padding: EdgeInsets.only( left : 10 , right : 10 , bottom : 10, top : 0  ),
                                    child: Form( 
                                    child : Column (
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TextFormField(
                                        decoration : InputDecoration(
                                          labelText : "Votre location"
                                        ) , 
                                        validator : (value) {
                                          if(value!.isEmpty || RegExp(r'^[a-z A-Z]').hasMatch(value!)) {
                                            return "Entere correct location" ;
                                          }
                                          else {
                                            return null ;
                                          }
                                        }
                                      ) ,
/*                                       SizedBox(height:height*0.04),
 */                                      TextFormField(
                                        decoration : InputDecoration(
                                          labelText : "Où partir ?"
                                        ) , 
                                        validator : (value) {
                                          if(value!.isEmpty || RegExp(r'^[a-z A-Z]').hasMatch(value!)) {
                                            return "Entere correct location" ;
                                          }
                                          else {
                                            return null ;
                                                              
                                          }
                                        }
                                      )
                                    ]
                                      )  
                                      )
                                    ),
                                  ) ,
                       ]

                    )
                    
                  ),
                )  ,
          Positioned(
            right: 20,
            bottom: fabHieght,
            child: FloatingActionButton(
              onPressed: () {},
              child: const Icon(
                Icons.search_outlined,
              ),
              backgroundColor: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}

class PanelWidget extends StatelessWidget {
  final ScrollController controller;
  const PanelWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

        child: Column(
          
      // Title
      children: [
        Container(

          padding: const EdgeInsets.all(20.0),
          child: const Text(
            "Véhicules proches de vous",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        // List of vehicules
        Expanded(
          child: ListView(
            children: const [
              GacelaCarListItemWidget(
                  carName: "Hyundai classic",
                  distance: 5,
                  type: "classic",
                  price: 200),

              GacelaCarListItemWidget(
                  carName: "Hyundai classic",
                  distance: 5,
                  type: "classic",
                  price: 200),

              GacelaCarListItemWidget(
                  carName: "Hyundai classic",
                  distance: 5,
                  type: "classic",
                  price: 200),
              GacelaCarListItemWidget(
                  carName: "Hyundai classic",
                  distance: 5,
                  type: "classic",
                  price: 200),
              // GacelaCarListItemWidget(),
              // GacelaCarListItemWidget(),
            ],
            controller: controller,
          ),
        )
      ],
    ));
  }
}

class Rounded extends StatelessWidget {
  final Widget content;
  void Function()? onClick;

  Rounded({Key? key, required this.content, required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.all(5.0),
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.black,
        ),
      ),
    );
  }
}
