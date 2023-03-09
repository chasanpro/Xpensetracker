// Reusable widgets 
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

styledText(String label , double? size, Color? paint ){

return   Text(
label ,
              style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                    fontSize: size ?? 15,
                        fontWeight: FontWeight.w600,
                        color: paint ?? const Color.fromARGB(255, 0, 0, 0),
                        letterSpacing: .5),
              ),
            );
}

framedContainer(Widget? child){
return Container(
height: 60,width: 100,
                            decoration: BoxDecoration(
                             border: Border.all(),
                                borderRadius: BorderRadius.circular(15)),
child: Center(child: child),

);
}