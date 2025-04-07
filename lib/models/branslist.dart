
class BrandsListModel {
    List<Banners>? banners;

    BrandsListModel({this.banners});

    BrandsListModel.fromJson(Map<String, dynamic> json) {
        banners = json["banners"] == null ? null : (json["banners"] as List).map((e) => Banners.fromJson(e)).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        if(banners != null) {
            data["banners"] = banners?.map((e) => e.toJson()).toList();
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

    Banners({this.brandId, this.brandName, this.brandImg, this.brandDescription, this.brandOrder, this.brandstatus});

    Banners.fromJson(Map<String, dynamic> json) {
        brandId = json["brand_id"];
        brandName = json["brand_name"];
        brandImg = json["brand_img"];
        brandDescription = json["brand_description"];
        brandOrder = json["brand_order"];
        brandstatus = json["brandstatus"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["brand_id"] = brandId;
        _data["brand_name"] = brandName;
        _data["brand_img"] = brandImg;
        _data["brand_description"] = brandDescription;
        _data["brand_order"] = brandOrder;
        _data["brandstatus"] = brandstatus;
        return _data;
    }
}