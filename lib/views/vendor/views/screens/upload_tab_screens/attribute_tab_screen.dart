import 'package:amazot_multi_store/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AttributeTabScreen extends StatefulWidget {
  const AttributeTabScreen({super.key});

  @override
  State<AttributeTabScreen> createState() => _AttributeTabScreenState();
}

class _AttributeTabScreenState extends State<AttributeTabScreen> {
  final TextEditingController _sizeController = TextEditingController();
  bool _entered = false;
  List<String> _sizeList = [];
  @override
  Widget build(BuildContext context) {
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          TextFormField(
            onChanged: (value) {
              _productProvider.getFormData(brandName: value);
            },
            decoration: InputDecoration(
              labelText: 'Brand',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                child: Container(
                  width: 100,
                  child: TextFormField(
                    controller: _sizeController,
                    decoration: InputDecoration(labelText: 'Size'),
                    onChanged: (value) {
                      setState(() {
                        _entered = true;
                      });
                    },
                  ),
                ),
              ),
              _entered == true
                  ? ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _sizeList.add(_sizeController.text);
                          _sizeController.clear();
                        });
                        print(_sizeList);
                      },
                      child: Text('Add'))
                  : Text('Enter size'),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          if (_sizeList.isNotEmpty)
            Container(
              height: 50,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: _sizeList.length,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _sizeList[index],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    );
                  })),
            )
        ],
      ),
    );
  }
}
