
class CategoriesModel {
    List<Allcategories>? allcategories;

    CategoriesModel({this.allcategories});

    CategoriesModel.fromJson(Map<String, dynamic> json) {
        allcategories = json["allcategories"] == null ? null : (json["allcategories"] as List).map((e) => Allcategories.fromJson(e)).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        if(allcategories != null) {
            _data["allcategories"] = allcategories?.map((e) => e.toJson()).toList();
        }
        return _data;
    }
}

class Allcategories {
    String? id;
    String? catName;
    String? catImage;
    String? catOrder;
    String? status;

    Allcategories({this.id, this.catName, this.catImage, this.catOrder, this.status});

    Allcategories.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        catName = json["cat_name"];
        catImage = json["cat_image"];
        catOrder = json["cat_order"];
        status = json["status"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["cat_name"] = catName;
        _data["cat_image"] = catImage;
        _data["cat_order"] = catOrder;
        _data["status"] = status;
        return _data;
    }
}