// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hemantenterprises/constants/colorconstants.dart';

class SortByFilterBottomSheet {
  static void showSortBy(
    BuildContext context,
    Function(String) updateState,
    String selectedOption,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        String currentSelection = selectedOption;

        return SingleChildScrollView(
          child: StatefulBuilder(
            builder: (context, setState) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sort by",
                      style: GoogleFonts.instrumentSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colorconstants.brandLogoCircle,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Divider(
                      height: 1,
                      color: Colorconstants.brandLogoCircle,
                      thickness: 1,
                    ),
                    SizedBox(height: 1.h),
                    Column(
                      children: [
                        "Popularity",
                        "Newest First",
                        "A to Z",
                        "Z to A"
                      ]
                          .map((option) => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    option,
                                    style: GoogleFonts.instrumentSans(
                                      color: Colorconstants.darkBlack,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Radio<String>(
                                    value: option,
                                    groupValue: currentSelection,
                                    activeColor: Colorconstants.primaryColor,
                                    onChanged: (value) {
                                      setState(() => currentSelection = value!);
                                      updateState(value!);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ))
                          .toList(),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  static void showFilter(
    BuildContext context,
    Function(String, String) updateState,
    String selectedBrand,
    String selectedCategory,
  ) {
    bool isBrandSelected =
        true; // Move outside StatefulBuilder to persist state

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            String currentSelection =
                isBrandSelected ? selectedBrand : selectedCategory;

            List<String> brands = [
              "Hindware",
              "Jaguar",
              "Brizo",
              "QUEO",
              "Franke",
              "Grohe"
            ];
            List<String> categories = [
              "Sanitary Ware",
              "Faucets",
              "Shower Systems",
              "Tiles",
              "Bathroom Accessories",
              "Kitchen and Bath Furniture",
              "Water Heaters and Geysers",
              "Kitchen Sink"
            ];

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Filter by",
                      style: GoogleFonts.instrumentSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colorconstants.brandLogoCircle,
                      ),
                    ),
                    SizedBox(height: 10),
                    Divider(
                      height: 1,
                      color: Colorconstants.brandLogoCircle,
                      thickness: 1,
                    ),
                    SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isBrandSelected = true;
                                  currentSelection = selectedBrand;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colorconstants.filter,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  side: BorderSide(
                                    color: isBrandSelected
                                        ? Colorconstants.secondaryColor
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                              ),
                              child: Text(
                                "Brand",
                                style: GoogleFonts.instrumentSans(
                                  color: Colorconstants.primaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isBrandSelected = false;
                                  currentSelection = selectedCategory;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colorconstants.filter,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  side: BorderSide(
                                    color: !isBrandSelected
                                        ? Colorconstants.secondaryColor
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                              ),
                              child: Text(
                                "Category",
                                style: GoogleFonts.instrumentSans(
                                  color: Colorconstants.primaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 10),
                        SizedBox(
                          height: 450,
                          child: VerticalDivider(
                            width: 1,
                            color: Colorconstants.brandLogoCircle,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            children: (isBrandSelected ? brands : categories)
                                .map((option) => ListTile(
                                      title: Text(
                                        option,
                                        style: GoogleFonts.instrumentSans(
                                          color: Colorconstants.darkBlack,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      trailing: Radio<String>(
                                        value: option,
                                        groupValue: currentSelection,
                                        activeColor:
                                            Colorconstants.primaryColor,
                                        onChanged: (value) {
                                          setState(() {
                                            currentSelection = value!;
                                          });
                                          updateState(
                                            isBrandSelected
                                                ? "Brand"
                                                : "Category",
                                            value!,
                                          );
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
