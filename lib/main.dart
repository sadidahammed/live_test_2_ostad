import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Live test',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController NameController = TextEditingController();
  TextEditingController NumberController = TextEditingController();

  List<String> NameList = [];
  List<String> NumberList = [];

  void addContact() {
    if (NameController.text.isNotEmpty && NumberController.text.isNotEmpty) {
      setState(() {
        NameList.add(NameController.text);
        NumberList.add(NumberController.text);
        NameController.clear();
        NumberController.clear();
      });
    }
  }

  void showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Confirmation", style: TextStyle(fontWeight: FontWeight.bold),),
          content: Text("Are you sure you want to Delete?"),
          actions: [
            IconButton(
              icon: Icon(Icons.delete_forever),
              onPressed: () {
                Navigator.pop(context); // Close dialog
              },
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                setState(() {
                  NameList.removeAt(index);
                  NumberList.removeAt(index);
                });
                Navigator.pop(context); // Close dialog
              },
            ),

          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Contact List",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: NameController,
              decoration: InputDecoration(
                hintText: "Name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: NumberController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                hintText: "Number",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: addContact,
                child: Text("ADD"),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: NameList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onLongPress: (){
                      showDeleteDialog(index);
                    },

                    leading: Icon(Icons.person,),
                    trailing: Icon(Icons.phone, color: Colors.lightBlueAccent,),
                    title: Text(
                      NameList[index],
                      style: TextStyle(color: Colors.red),
                    ),
                    subtitle: Text(
                        NumberList[index],
                      ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
