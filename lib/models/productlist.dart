
class ProductListModel {
    List<Allproperties>? allproperties;

    ProductListModel({this.allproperties});

    ProductListModel.fromJson(Map<String, dynamic> json) {
        allproperties = json["allproperties"] == null ? null : (json["allproperties"] as List).map((e) => Allproperties.fromJson(e)).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        if(allproperties != null) {
            _data["allproperties"] = allproperties?.map((e) => e.toJson()).toList();
        }
        return _data;
    }
}

class Allproperties {
    String? prodId;
    String? brandId;
    String? catId;
    String? subId;
    String? productCode;
    String? productName;
    String? productDescription;
    String? productPrice;
    String? productDocument;
    String? productImage1;
    String? productImage2;
    String? productImage3;
    String? productStatus;
    String? addedOn;

    Allproperties({this.prodId, this.brandId, this.catId, this.subId, this.productCode, this.productName, this.productDescription, this.productPrice, this.productDocument, this.productImage1, this.productImage2, this.productImage3, this.productStatus, this.addedOn});

    Allproperties.fromJson(Map<String, dynamic> json) {
        prodId = json["prodId"];
        brandId = json["brand_id"];
        catId = json["cat_id"];
        subId = json["sub_id"];
        productCode = json["product_code"];
        productName = json["product_name"];
        productDescription = json["product_description"];
        productPrice = json["product_price"];
        productDocument = json["product_document"];
        productImage1 = json["product_image1"];
        productImage2 = json["product_image2"];
        productImage3 = json["product_image3"];
        productStatus = json["product_status"];
        addedOn = json["addedOn"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["prodId"] = prodId;
        _data["brand_id"] = brandId;
        _data["cat_id"] = catId;
        _data["sub_id"] = subId;
        _data["product_code"] = productCode;
        _data["product_name"] = productName;
        _data["product_description"] = productDescription;
        _data["product_price"] = productPrice;
        _data["product_document"] = productDocument;
        _data["product_image1"] = productImage1;
        _data["product_image2"] = productImage2;
        _data["product_image3"] = productImage3;
        _data["product_status"] = productStatus;
        _data["addedOn"] = addedOn;
        return _data;
    }

      @override
    String toString() {
    return 'Allproperties(prodId: $prodId, productName: $productName, productPrice: $productPrice)';
  }
}