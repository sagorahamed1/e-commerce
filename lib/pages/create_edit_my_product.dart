import 'dart:io';
import 'package:alorferi_app_practice/controller/my_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'my_pruduct_crud_page.dart';

class ProductEditPage extends StatefulWidget {
  final Map? product;

  const ProductEditPage({Key? key, this.product}) : super(key: key);

  @override
  _ProductEditPageState createState() => _ProductEditPageState();
}

class _ProductEditPageState extends State<ProductEditPage> {
  MyProductController myProductController = Get.put(MyProductController());
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  File? image;

  @override
  void initState() {
    ProductEditPage();
    super.initState();
    myProductController.isLoading.value;
    myProductController.myProduct.value;
    myProductController.getMyProducts();
    // Initialize controllers with existing product data if available
    if (widget.product != null) {
      nameController.text = widget.product!['name'];
      priceController.text = widget.product!['price'].toString();
      priceController.text = widget.product!['stock_quantity'].toString();
      widget.product!['id'];
      // Initialize image if applicable
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.product == null ? 'Add Product' : 'Edit Product'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 250,
                  width: 300,
                  child: image == null
                      ? Center(
                        child: Column(
                          children: [
                            SizedBox(height: 80,),
                            Text("Select Image"),
                            IconButton(
                              onPressed: getImage,
                              icon: Icon(Icons.camera_alt),
                            ),
                          ],
                        ),
                      )
                      : Center(
                          child: Image.file(
                          image!,
                          fit: BoxFit.cover,
                        )),
                ),
              ],
            ),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
            TextFormField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'Price'),
            ),
            TextFormField(
              controller: quantityController,
              decoration: InputDecoration(labelText: 'Quantity'),
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Get.to(MyProductsCrudPage());
                        },
                        child: Text("Cencel")),
                    TextButton(
                        onPressed: () async {
                          if (widget.product == null) {
                            await myProductController.createProductWithImage({
                              'name': nameController.text,
                              'price': double.parse(priceController.text),
                              "stock_quantity":
                                  double.parse(quantityController.text)
                            }, image);
                            Navigator.pop(context);
                          } else {
                            await myProductController.updateProduct(
                              widget.product!["id"],
                              {
                                'name': nameController.text ?? "null value",
                                'price': double.parse(priceController.text) ??
                                    "null value",
                                "stock_quantity":
                                    double.parse(quantityController.text) ??
                                        "null value"
                              },
                              image!,
                            );

                            Navigator.pop(context);
                          }
                        },
                        child: Text("Save")),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Future<void> getImage() async {
    final picImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      if (picImage != null) {
        image = File(picImage.path);
      } else {
        print("YOu have no image");
      }
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }
}
