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
  TextEditingController priceController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  MyProductController myProductController = Get.put(MyProductController());
  File? image;

  String errorMessage = "";

  @override
  void initState() {
    ProductEditPage();
    super.initState();
    myProductController.isLoading.value;
    myProductController.myProduct.value;
    myProductController.getMyProducts();

    /// if product have already fill show this product informaition on All feilds
    if (widget.product != null) {
      nameController.text = widget.product!['name'];
      priceController.text = widget.product!['price'].toString();
      quantityController.text = widget.product!['stock_quantity'].toString();
      widget.product!['id'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.product == null ? 'Add Product' : 'Edit Product'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                                SizedBox(
                                  height: 80,
                                ),
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
              if (errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
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
                            checkValidFields();
                            if (widget.product == null) {
                              await myProductController.createProductWithImage({
                                'name': nameController.text,
                                'price': double.parse(priceController.text),
                                "stock_quantity":
                                    double.parse(quantityController.text)
                              }, image);
                              Navigator.pop(context);
                            } else {
                              checkValidFields();
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
                          child: Text("Submit")),
                    ],
                  )),
            ],
          ),
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
        print("You have no image");
      }
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }


/// check all field are fill up or not
  void checkValidFields() {
    if (_validateFields()) {
      Future.delayed(Duration(seconds: 1), () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Product submit successful!'),
            duration: Duration(seconds: 1),
          ),
        );
      });
    }
  }

  bool _validateFields() {
    if (nameController.text.isEmpty ||
        priceController.text.isEmpty ||
        quantityController.text.isEmpty ||
        image == null) {
      setState(() {
        errorMessage = 'Please fill in all fields.';
      });
      return false;
    }

    setState(() {
      errorMessage = '';
    });
    return true;
  }

}
