import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import '../providers/product.dart';
import '../providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeId = '/edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _imageUrlContoller = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: null,
    title: '',
    description: '',
    price: 0.0,
    imageUrl: '',
  );

  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImgUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final prodcutId = ModalRoute.of(context).settings.arguments as String;
      if (prodcutId != null) {
        _editedProduct = Provider.of<ProductsProvider>(context, listen: false)
            .findById(prodcutId);
        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          //'imageUrl': _editedProduct.imageUrl,
          'imageUrl': '',
        };
        _imageUrlContoller.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

//* -------------------------------------------------------
//* Some comments here
//* -------------------------------------------------------
  @override
  void dispose() {
    _imageUrlContoller.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImgUrl);
    super.dispose();
  }

  void _updateImgUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if (!_imageUrlContoller.text.startsWith('http') &&
          !_imageUrlContoller.text.startsWith('hhtps')) {
        return;
      }
      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    var _isValid = _form.currentState.validate();
    if (!_isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedProduct.id != null) {
      Provider.of<ProductsProvider>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
      setState(() {
        _isLoading = false;
      });
      Navigator.pop(context);
    } else {
      try {
        await Provider.of<ProductsProvider>(context, listen: false)
            .addProduct(_editedProduct);
      } catch (error) {
        await showDialog<Null>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Error occurred: '),
            content: Text('Something went wrong'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text('Okay'),
              ),
            ],
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          )
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _initValues['title'],
                      decoration: InputDecoration(labelText: 'Title'),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a Title!';
                        } else if (value.length < 5) {
                          return 'Too short title';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _editedProduct = Product(
                          isFavorite: _editedProduct.isFavorite,
                          id: _editedProduct.id,
                          title: newValue,
                          description: _editedProduct.description,
                          price: _editedProduct.price,
                          imageUrl: _editedProduct.imageUrl,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['price'],
                      decoration: InputDecoration(labelText: 'Price'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a price';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        if (double.parse(value) <= 0) {
                          return 'Price should be greater than zero';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _editedProduct = Product(
                          isFavorite: _editedProduct.isFavorite,
                          id: _editedProduct.id,
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          price: double.parse(newValue),
                          imageUrl: _editedProduct.imageUrl,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['description'],
                      decoration: InputDecoration(labelText: 'Description'),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter desctiption';
                        }
                        if (value.length < 10) {
                          return 'Description should be longer than 10 char';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _editedProduct = Product(
                          isFavorite: _editedProduct.isFavorite,
                          id: _editedProduct.id,
                          title: _editedProduct.title,
                          description: newValue,
                          price: _editedProduct.price,
                          imageUrl: _editedProduct.imageUrl,
                        );
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 100.0,
                          height: 100.0,
                          margin: EdgeInsets.only(top: 8.0, right: 10.0),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey)),
                          child: _imageUrlContoller.text.isEmpty
                              ? Text('Enter URL pls')
                              : FittedBox(
                                  child: Image.network(
                                  _imageUrlContoller.text,
                                  fit: BoxFit.cover,
                                )),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Image URL'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlContoller,
                            focusNode: _imageUrlFocusNode,
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter an image URL';
                              }
                              if (!value.startsWith('http') &&
                                  !value.startsWith('hhtps')) {
                                return 'Enter a valid URL';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              _editedProduct = Product(
                                title: _editedProduct.title,
                                description: _editedProduct.description,
                                price: _editedProduct.price,
                                imageUrl: newValue,
                                isFavorite: _editedProduct.isFavorite,
                                id: _editedProduct.id,
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
