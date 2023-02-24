import 'package:flutter/material.dart';

class ChipView extends StatefulWidget {
  const ChipView({super.key});

  @override
  State<ChipView> createState() => _ChipViewState();
}

class _ChipViewState extends State<ChipView> {
  int? _value = 1;

  final List<ChipModel> _chipList = [];

  TextEditingController inputText = TextEditingController();

  Future<void> validarSesion() async {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      setState(() {
        _chipList.add(ChipModel(
            id: DateTime.now().toString(),
            name: inputText.text));
        inputText.clear();
      });
    }
  }

  final _formKey = GlobalKey<FormState>();

  void _deleteChip(String id) {
    setState(() {
      _chipList.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              margin: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Wrap(
                    spacing: 5.0,
                    children: List<Widget>.generate(
                      3,
                          (int index) {
                        return InputChip(
                          label: Text('Item $index'),
                          selected: _value == index,
                          onSelected: (bool selected) {
                            setState(() {
                              _value = selected ? index : null;
                            });
                          },
                        );
                      },
                    ).toList(),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: inputText,
                          validator: (value) {
                            print(value);
                            if (value == null || value.isEmpty) {
                              return 'Ingrese un valor';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: "Ingresa tu Usuario",
                            labelStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
                            isDense: true,
                          ),
                        ),
                        SizedBox(
                          width: screenWidth,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
                            ),
                            onPressed: () {
                              validarSesion();
                            },
                            child: const Text(
                              "Submit",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Wrap(
                    spacing: 10,
                    children: _chipList.map(
                      (chip) => Chip(
                        label: Text(chip.name),
                        avatar: CircleAvatar(
                          child: ClipOval(
                            child: SizedBox.fromSize(
                              size: const Size.fromRadius(90), // Image radius
                              child: Image.network(
                                'https://picsum.photos/80/80?random=${chip.id}',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        onDeleted: () => _deleteChip(chip.id), // call delete function by passing click chip id
                      ),
                    ).toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ChipModel {
  final String id;
  final String name;

  ChipModel({required this.id, required this.name});
}
