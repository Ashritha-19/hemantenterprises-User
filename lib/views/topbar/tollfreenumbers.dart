import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hemantenterprises/constants/colorconstants.dart';
import 'package:hemantenterprises/constants/imageconstants.dart';
import 'package:hemantenterprises/constants/searchfield.dart';

class Tollfreenumbers extends StatelessWidget {
  Tollfreenumbers({super.key});

  final List<Map<String, String>> contacts = [
    {'name': 'Hindware', 'phone': '+91 98765 43210'},
    {'name': 'Brizo', 'phone': '+91 98765 43210'},
    {'name': 'Franke', 'phone': '+91 98765 43210'},
    {'name': 'Jaguar', 'phone': '+91 98765 43210'},
    {'name': 'Queo', 'phone': '+91 98765 43210'},
    {'name': 'Grohe', 'phone': '+91 98765 43210'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Imageconstants.background),
                  fit: BoxFit.cover,
                  opacity: 0.2,
                ),
              ),
            ),
          ),
          Column(
            children: [
              CustomAppBar(
                hintText: "Search",
                onSearchTap: () {
                  // Define action when search bar is tapped
                },
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Toll Free Numbers',
                        style: GoogleFonts.instrumentSans(
                            color: Colorconstants.darkBlack,
                            fontSize: 14,
                            fontWeight: FontWeight.w800),
                      ),
                      SizedBox(height: 2.h),
                      Divider(
                        thickness: 1,
                        height: 1,
                        color: Colorconstants.brandLogoCircle,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      //  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),                          
                        child: Column(
                          children: [
                            GridView.builder(
                              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10), 
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 2,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 4,
                              ),
                              itemCount: contacts.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      contacts[index]['name']!,
                                      style: GoogleFonts.instrumentSans(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      contacts[index]['phone']!,
                                      style: GoogleFonts.instrumentSans(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Divider(),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      )
                    ]),
              )
            ],
          )
        ],
      ),
    );
  }
}
