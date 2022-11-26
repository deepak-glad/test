import 'package:flutter/material.dart';
import 'package:test/model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _dob = TextEditingController();
  final TextEditingController _profile = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<Model> data = [];
  List<String> name = [];
  List<String> dob = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form')),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(children: [
              TextFormField(
                controller: _name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _dob,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter dob';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _profile,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter profile';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (name.contains(_name.text) ||
                          dob.contains(_dob.text)) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Your data already exits'),
                        ));
                      } else {
                        setState(() {
                          data.add(Model(_name.text, _dob.text, _profile.text));
                          name.add(_name.text);
                          dob.add(_dob.text);
                        });
                        _name.text = '';
                        _dob.text = '';
                        _profile.text = '';
                      }
                    }
                  },
                  child: const Text('Submit')),
              const SizedBox(height: 40),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Text('${index + 1}'),
                      title: Text(data[index].name),
                      subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data[index].profile),
                            Text(data[index].dob)
                          ]),
                      trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              data.removeAt(index);
                            });
                          },
                          icon: const Icon(Icons.delete)),
                    );
                  })
            ]),
          ),
        ),
      ),
    );
  }
}
