import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hemantenterprises/constants/colorconstants.dart';
import 'package:hemantenterprises/constants/imageconstants.dart';
import 'package:hemantenterprises/constants/searchfield.dart';
import 'package:hemantenterprises/filters/sortandfilter.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({super.key});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  String selectedColor = "";
  String selectedSortOption = ""; // Stores selected sort option
  String selectedBrand = ""; // Stores selected brand
  String selectedCategory = ""; // Stores selected category

  void updateSortState(String sortOption) {
    setState(() {
      selectedSortOption = sortOption; // Persist the selected sort option
    });
  }

  void updateFilterState(String filterOption, String selectedValue) {
    setState(() {
      if (filterOption == "Brand") {
        selectedBrand = selectedValue; // Persist the selected brand
      } else if (filterOption == "Category") {
        selectedCategory = selectedValue; // Persist the selected category
      }
    });
  }

  final List<String> searchImages = [
    Imageconstants.waterClosets,
    Imageconstants.washBasins,
    Imageconstants.cisterns,
    Imageconstants.comboPacks,
    Imageconstants.urinals,
    Imageconstants.bathTubs,
    Imageconstants.waterClosets,
    Imageconstants.washBasins,
    Imageconstants.cisterns,
  ];

  final List<String> names = [
    'Water Closets',
    'Wash Basins',
    'Cisterns',
    'Combo Packs',
    'Urinals',
    'Bath Tubs',
    'Water Closets',
    'Wash Basins',
    'Cisterns'
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
                hintText: 'Search',
                onSearchTap: () {},
              ),
              SizedBox(height: 2.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Sort By Button
                    ElevatedButton(
                      onPressed: () => SortByFilterBottomSheet.showSortBy(
                        context,
                        updateSortState,
                        selectedSortOption,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colorconstants.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(
                            color: selectedSortOption.isNotEmpty
                                ? Colorconstants.secondaryColor
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Sort by",
                            style: GoogleFonts.instrumentSans(
                              color: selectedSortOption.isNotEmpty
                                  ? Colorconstants.darkBlack
                                  : Colorconstants
                                      .brandLogoCircle, // Change text color
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            color: selectedSortOption.isNotEmpty
                                ? Colorconstants.darkBlack
                                : Colorconstants
                                    .brandLogoCircle, // Change icon color
                            size: 18.sp,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: 2.w),

                    // Filter Button
                    ElevatedButton(
                      onPressed: () => SortByFilterBottomSheet.showFilter(
                        context,
                        updateFilterState,
                        selectedBrand,
                        selectedCategory,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colorconstants.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(
                            color: (selectedBrand.isNotEmpty ||
                                    selectedCategory.isNotEmpty)
                                ? Colorconstants.secondaryColor
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Filter",
                            style: GoogleFonts.instrumentSans(
                              color: (selectedBrand.isNotEmpty ||
                                      selectedCategory.isNotEmpty)
                                  ? Colorconstants.darkBlack
                                  : Colorconstants.brandLogoCircle,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            color: (selectedBrand.isNotEmpty ||
                                    selectedCategory.isNotEmpty)
                                ? Colorconstants.darkBlack
                                : Colorconstants.brandLogoCircle,
                            size: 18.sp,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              Divider(
                thickness: 1,
                height: 1,
                color: Colorconstants.brandLogoCircle,
              ),
              SizedBox(height: 2.h),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 50,
                    mainAxisExtent: 150,
                  ),
                  itemCount: searchImages.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final product = searchImages[index];
                    final productName = names[index];
                    return GestureDetector(
                      onTap: () {},
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              product,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            productName,
                            style: GoogleFonts.instrumentSans(
                              fontSize: 12,
                              color: Colorconstants.darkBlack,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
