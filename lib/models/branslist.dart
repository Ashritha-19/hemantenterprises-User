// ignore_for_file: unnecessary_this

class Brands {
  List<Banners>? banners;

  Brands({this.banners});

  Brands.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      banners = <Banners>[];
      json['banners'].forEach((v) {
        banners!.add(Banners.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.banners != null) {
      data['banners'] = this.banners!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banners {
  String? brandId;
  String? brandName;
  String? brandImg;
  String? brandDescription;
  String? brandOrder;
  String? brandstatus;

  Banners(
      {this.brandId,
      this.brandName,
      this.brandImg,
      this.brandDescription,
      this.brandOrder,
      this.brandstatus});

  Banners.fromJson(Map<String, dynamic> json) {
    brandId = json['brand_id'];
    brandName = json['brand_name'];
    brandImg = json['brand_img'];
    brandDescription = json['brand_description'];
    brandOrder = json['brand_order'];
    brandstatus = json['brandstatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['brand_id'] = this.brandId;
    data['brand_name'] = this.brandName;
    data['brand_img'] = this.brandImg;
    data['brand_description'] = this.brandDescription;
    data['brand_order'] = this.brandOrder;
    data['brandstatus'] = this.brandstatus;
    return data;
  }
}
