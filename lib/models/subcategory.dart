
class SubCategoryModel {
    List<SubCat>? subCat;

    SubCategoryModel({this.subCat});

    SubCategoryModel.fromJson(Map<String, dynamic> json) {
        subCat = json["sub_cat"] == null ? null : (json["sub_cat"] as List).map((e) => SubCat.fromJson(e)).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        if(subCat != null) {
            _data["sub_cat"] = subCat?.map((e) => e.toJson()).toList();
        }
        return _data;
    }
}

class SubCat {
    String? subId;
    String? catId;
    String? catName;
    String? catImage;
    String? catOrder;
    String? status;

    SubCat({this.subId, this.catId, this.catName, this.catImage, this.catOrder, this.status});

    SubCat.fromJson(Map<String, dynamic> json) {
        subId = json["sub_id"];
        catId = json["cat_id"];
        catName = json["cat_name"];
        catImage = json["cat_image"];
        catOrder = json["cat_order"];
        status = json["status"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["sub_id"] = subId;
        _data["cat_id"] = catId;
        _data["cat_name"] = catName;
        _data["cat_image"] = catImage;
        _data["cat_order"] = catOrder;
        _data["status"] = status;
        return _data;
    }
}