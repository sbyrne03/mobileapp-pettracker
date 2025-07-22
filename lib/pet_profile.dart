import "package:flutter/material.dart";
import "util.dart";

class PetProfile extends StatefulWidget {
  final String name;
  final String age;
  final String weight;
  final String breed;
  final String color;
  final String imageAsset;

  const PetProfile({
    Key? key,
    required this.name,
    required this.age,
    required this.weight,
    required this.breed,
    required this.color,
    required this.imageAsset,
  }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<PetProfile> {
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _weightController;
  late TextEditingController _breedController;
  late TextEditingController _colorController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _ageController = TextEditingController(text: widget.age);
    _weightController = TextEditingController(text: widget.weight);
    _breedController = TextEditingController(text: widget.breed);
    _colorController = TextEditingController(text: widget.color);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: backgroundColor,
        foregroundColor: Colors.black,
        actions: [
          Icon(
            Icons.settings,
            size: 35,
          )
        ],
        title: Text(
          '${widget.name}\'s Profile',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 27),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Container(
            // color: Colors.yellow[50],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      alignment: Alignment.center,
                      widget.imageAsset,
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width * 0.9,
                      fit: BoxFit.cover,
                    ),
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 22),
                    contentPadding: EdgeInsets.all(20),
                  ),
                ),
                TextFormField(
                  controller: _ageController,
                  decoration: InputDecoration(
                    labelText: 'Age',
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 22),
                    contentPadding: EdgeInsets.all(20),
                  ),
                ),
                TextFormField(
                  controller: _weightController,
                  decoration: InputDecoration(
                    labelText: 'Weight',
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 22),
                    contentPadding: EdgeInsets.all(20),
                  ),
                ),
                TextFormField(
                  controller: _breedController,
                  decoration: InputDecoration(
                    labelText: 'Breed',
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 22),
                    contentPadding: EdgeInsets.all(20),
                  ),
                ),
                TextFormField(
                  controller: _colorController,
                  decoration: InputDecoration(
                    labelText: 'Color',
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 22),
                    contentPadding: EdgeInsets.all(20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
