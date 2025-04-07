// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:hemantenterprises/constants/apiservices.dart';
import 'package:hemantenterprises/models/branslist.dart';
import 'package:hemantenterprises/constants/apiconstants.dart'; // Import API constants

class BrandListScreen extends StatefulWidget {
  const BrandListScreen({super.key});

  @override
  _BrandListScreenState createState() => _BrandListScreenState();
}

class _BrandListScreenState extends State<BrandListScreen> {
  final ApiServices _apiServices = ApiServices();
  List<Banners>? _brandsList = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    await _apiServices.fetchBrandData();
    setState(() {
      _brandsList = _apiServices.brandsListModel?.banners ?? [];
    });

    print("Fetched Brand List:");
    for (var brand in _brandsList!) {
      print("Brand ID: ${brand.brandId}, Name: ${brand.brandName}, Image: ${brand.brandImg}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Brand List"),
      ),
      body: _brandsList == null || _brandsList!.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _brandsList!.length,
              itemBuilder: (context, index) {
                final brand = _brandsList![index];

                // Construct full image URL
                final String imageUrl = "${ApiConstants.brandImgBaseUrl}${brand.brandImg}";

                return ListTile(
                  leading: Image.network(
                    imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.image_not_supported, size: 50);
                    },
                  ),
                  title: Text(brand.brandName ?? "Unknown Brand"),
                  subtitle: Text(brand.brandDescription ?? "No Description"),
                );
              },
            ),
    );
  }
}
