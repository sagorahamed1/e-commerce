import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/crud_my_product_controller.dart';
import '../controller/my_product_controller.dart';

class MyProductsCrudPage extends StatelessWidget {
  final CrudController crudController = CrudController();
  MyProductController myProductController = Get.put(MyProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(() => ListView.builder(
            itemCount: myProductController.myProduct.length,
            itemBuilder: (context, index) {
              final product = myProductController.myProduct[index];
              return ListTile(
                leading: product['url'] == null
                    ? Image.network(
                        "https://demo.alorferi.com/images/blank_product_picture.png")
                    : Image.network(
                        "https://demo.alorferi.com${product["url"]}"),
                title: Text(product['name']),
                subtitle: Text('Price: \$${product['price']}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        showEditDialog(context, product);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        showDeleteDialog(context, product);
                      },
                    ),
                  ],
                ),
              );
            },
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  /// show create dialog
  void showAddDialog(BuildContext context) async {
    TextEditingController nameController = TextEditingController();
    TextEditingController priceController = TextEditingController();

    await Get.defaultDialog(
      title: 'Add Product',
      content: Column(
        children: [
          Container(
            height: 150,
            color: Colors.green,
          ),
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Product Name'),
          ),
          TextFormField(
            controller: priceController,
            decoration: InputDecoration(labelText: 'Price'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            await myProductController.createProduct({
              'name': nameController.text,
              'price': double.parse(priceController.text),
            });
            Get.back();
          },
          child: Text('Submit'),
        ),
      ],
    );

    // Dispose controllers to prevent memory leaks
    nameController.dispose();
    priceController.dispose();
  }

  /// show update dialog
  void showEditDialog(
      BuildContext context, Map<String, dynamic> product) async {
    TextEditingController nameController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    await Get.dialog(
      Dialog(
        child: Column(
          children: [
            Container(
              height: 600,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 200,
                    width: 300,
                    color: Colors.green,
                  ),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Product Name'),
                  ),
                  TextFormField(
                    controller: priceController,
                    decoration: InputDecoration(labelText: 'Price'),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await myProductController.updateProduct(
                      product['id'],
                      {
                        'name': nameController.text,
                        'price': double.parse(priceController.text),
                      },
                    );
                    Get.back();
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    // Dispose controllers to prevent memory leaks
    nameController.dispose();
    priceController.dispose();
  }

  /// show delete dialog
  void showDeleteDialog(
      BuildContext context, Map<String, dynamic> product) async {
    await Get.defaultDialog(
      title: 'Delete Product',
      content: Column(
        children: [
          Text("Are you sure you want to delete this product?"),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('No'),
        ),
        ElevatedButton(
          onPressed: () async {
            await myProductController.deleteProduct(product['id']);
            Get.back();
          },
          child: Text('Yes'),
        ),
      ],
    );
  }
}
