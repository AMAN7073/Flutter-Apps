import 'package:flutter/material.dart';
import 'package:state_management/providers/products.dart';
import '../providers/product.dart';
import 'package:provider/provider.dart';

class EditUserProduct extends StatefulWidget {
  //const EditUserProduct({Key? key}) : super(key: key);

  static const routeName = '/edit-products';

  @override
  State<EditUserProduct> createState() => _EditUserProductState();
}

class _EditUserProductState extends State<EditUserProduct> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrl = TextEditingController();
  final _imageFocusnode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _isInit = true;
  var _editedProduct = Product(
    id: null.toString(),
    title: '',
    description: '',
    price: 0,
    imageUrl: '',
  );

  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };

  var _isLoading = false;

  @override
  void initState() {
    _imageFocusnode.addListener(_imageListner);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context)!.settings.arguments as String;
      if (productId != null.toString()) {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findById(productId);
        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          //'imageUrl': _editedProduct.imageUrl,
          'imageUrl': '',
        };
        _imageUrl.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageFocusnode.removeListener(_imageListner);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrl.dispose();
    super.dispose();
  }

  void _imageListner() {
    if (!_imageFocusnode.hasFocus) {
      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    var _check = _form.currentState!.validate();
    if (!_check) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedProduct.id != null.toString()) {
      await Provider.of<Products>(context, listen: false)
          .upDateProducts(_editedProduct.id, _editedProduct);
    } else {
      try {
        await Provider.of<Products>(context, listen: false)
            .addproduct(_editedProduct);
      } catch (error) {
        await showDialog<Null>(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text('Oops! An Error Occured!'),
              content: const Text('Something Wrong Happend'),
              actions: [
                FlatButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: const Text('OKAY'),
                ),
              ],
            );
          },
        );
      }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _form,
                child: ListView(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(label: Text('Title')),
                      initialValue: _initValues['title'],
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter a Value!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          id: _editedProduct.id,
                          isFavourite: _editedProduct.isFavourite,
                          title: value.toString(),
                          description: _editedProduct.description,
                          price: _editedProduct.price,
                          imageUrl: _editedProduct.imageUrl,
                        );
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(label: Text('Price')),
                      initialValue: _initValues['price'],
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _priceFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter a Price';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Enter a valid Price ';
                        }
                        if (double.parse(value) <= 0) {
                          return 'Enter a Price Greater Than 0';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          id: _editedProduct.id,
                          isFavourite: _editedProduct.isFavourite,
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          price: double.parse(value.toString()),
                          imageUrl: _editedProduct.imageUrl,
                        );
                      },
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(label: Text('Description')),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      initialValue: _initValues['description'],
                      focusNode: _descriptionFocusNode,
                      onSaved: (value) {
                        _editedProduct = Product(
                          id: _editedProduct.id,
                          isFavourite: _editedProduct.isFavourite,
                          title: _editedProduct.title,
                          description: value.toString(),
                          price: _editedProduct.price,
                          imageUrl: _editedProduct.imageUrl,
                        );
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter a DESCRIPTION';
                        }
                        if (value.length <= 10) {
                          return 'Enter a Description of Bigger Length';
                        }
                        return null;
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.only(top: 10, right: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: Theme.of(context).accentColor),
                          ),
                          child: _imageUrl.text.isEmpty
                              ? const Text('Enter the URL')
                              : FittedBox(
                                  child: Image.network(
                                    _imageUrl.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration:
                                const InputDecoration(label: Text('Image Url')),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrl,
                            focusNode: _imageFocusnode,
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return 'Please Enter a Image Url';
                            //   }
                            //   if (!value.startsWith('http') ||
                            //       !value.startsWith('https')) {
                            //     return 'Enter a Valid URL';
                            //   }
                            //   if (!value.endsWith('.png') ||
                            //       !value.endsWith('.jpg') ||
                            //       !value.endsWith('.jpeg')) {
                            //     return 'Enter a Valid URL';
                            //   }
                            //   return null;
                            // },
                            onSaved: (value) {
                              _editedProduct = Product(
                                id: _editedProduct.id,
                                isFavourite: _editedProduct.isFavourite,
                                title: _editedProduct.title,
                                description: _editedProduct.description,
                                price: _editedProduct.price,
                                imageUrl: value.toString(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
