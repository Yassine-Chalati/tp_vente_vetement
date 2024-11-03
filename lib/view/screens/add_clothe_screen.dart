import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:vente_vitment/view/components/button_profil.dart';
import 'package:vente_vitment/view/screens/home_page_screen.dart';
import 'package:vente_vitment/view/sections/user_profil_section.dart';
import 'package:vente_vitment/view_model/current_page_view_model.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'dart:math';
import 'package:tflite/tflite.dart';




class AddClotheScreen extends StatefulWidget {
  const AddClotheScreen({super.key});

  @override
  State<AddClotheScreen> createState() => _AddClotheScreenState();
}

class _AddClotheScreenState extends State<AddClotheScreen> {
  TextEditingController _imageController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _tailleController = TextEditingController();
  TextEditingController _marqueController = TextEditingController();
  TextEditingController _prixController = TextEditingController();
  // late File _image;
  // late Interpreter _interpreter;
  // late List<String> _labels;

  late List _outputs;
  late File _image;
  late bool _loading = false;

  // Future pickImage() async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //     if (image == null) return;
      // final imageTemp = File(image.path);
  //     setState(() {
  //       _image = imageTemp;
  //     });
  //     classifyImage(imageTemp);
  //   } on PlatformException catch (e) {
  //     print('Failed to pick image: $e');
  //   }
  // }

  pickImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    File imageTemp = File(image.path);
    setState(() {
      _loading = true;
      
      _image = imageTemp;
    });
    classifyImage(imageTemp);
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _loading = false;
      _outputs = output!;
      _categoryController.text = output as String;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }
  

  // Future pickImage() async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //     if (image == null) return;
  //     final imageTemp = File(image.path);
  //     setState(() {
  //       _image = imageTemp;
  //     });
  //     classifyImage(imageTemp);
  //   } on PlatformException catch (e) {
  //     print('Failed to pick image: $e');
  //   }
  // }

  // Future<void> _loadModel() async {
  //   // Load the TensorFlow Lite model
  //   _interpreter = await Interpreter.fromAsset('model.tflite');
  // }

  // Future<void> _loadLabels() async {
  //   // Load labels from labels.txt
  //   final labelData = await rootBundle.loadString('assets/labels.txt');
  //   _labels = labelData.split('\n').map((label) => label.trim()).toList();
  // }

  // Future<List<double>> classifyImage(File imageFile) async {
  //   // Preprocess the image
  //   var inputImage = await preprocessImage(imageFile);

  //   // Prepare output buffer
  //   var output = List.filled(_labels.length, 0.0).reshape([1, _labels.length]);

  //   // Run inference
  //   _interpreter.run(inputImage, output);

  //   // Get results
  //   return output[0]; // Return the first batch
  // }

  // Future<List<double>> preprocessImage(File imageFile) async {
  //   // Load the image as bytes
  //   var imageBytes = await imageFile.readAsBytes();

  //   // Convert image to RGB format (assuming the image is in ARGB format)
  //   List<int> rgbPixels = [];
  //   for (int i = 0; i < imageBytes.lengthInBytes; i += 4) {
  //     int a = imageBytes[i + 3];
  //     int r = imageBytes[i + 2];
  //     int g = imageBytes[i + 1];
  //     int b = imageBytes[i];
  //     // Store RGB values normalized to [0, 1]
  //     rgbPixels.add((r / 255.0) as int);
  //     rgbPixels.add(g / 255.0 as int);
  //     rgbPixels.add(b / 255.0 as int);
  //   }

  //   // Resize and flatten image to match model input shape [1, height, width, channels]
  //   return rgbPixels; // Replace with actual resizing logic if necessary
  // }

  // String getPrediction(List<double> output) {
  //   int maxIndex = output.indexWhere((value) => value == output.reduce(max));
  //   return _labels[maxIndex]; // Get the label with the highest probability
  // }

  //--

  // Future<void> loadModel() async {
  //   _interpreter = await Interpreter.fromAsset('assets/model_unquant.tflite');
  //   _labels = await loadLabels('assets/labels.txt'); // Adjust the path accordingly
  // }

  // Future<List<String>> loadLabels(String path) async {
  //   // Load labels from the local file
  //   final labelFile = File(path);
  //   String labelData = await labelFile.readAsString();
  //   return labelData.split('\n').map((label) => label.trim()).toList();
  // }

  // Future<void> classifyImage(File imageFile) async {
  //   // Load and preprocess the image
  //   var inputImage = await _preprocessImage(imageFile);

  //   // Define the output buffer
  //   var output = List.filled(_labels.length, 0.0).reshape([1, _labels.length]);

  //   // Run inference
  //   _interpreter.run(inputImage, output);

  //   // Get the predicted label
  //   _getLabelFromOutput(output[0]);
  // }

  // Future<List<dynamic>> _preprocessImage(File imageFile) async {
  //   // Load the image as bytes
  //   var imageBytes = await imageFile.readAsBytes();
  //   // Decode the image to manipulate
  //   var image = img.decodeImage(imageBytes)!;

  //   // Resize and normalize
  //   var resizedImage = img.copyResize(image, width: 224, height: 224); // Adjust to your model's input size
  //   List<double> inputBuffer = [];

  // // Iterate over each pixel in the resized image
  // for (int y = 0; y < resizedImage.height; y++) {
  //   for (int x = 0; x < resizedImage.width; x++) {
  //     // Get the pixel at the (x, y) coordinates
  //     int pixel = resizedImage.getPixel(x, y);
      
  //     // Extract RGB values from the pixel using bitwise operations
  //     var r = (pixel >> 16) & 0xFF;  // Red component
  //     var g = (pixel >> 8) & 0xFF;   // Green component
  //     var b = pixel & 0xFF;          // Blue component

  //     // Normalize RGB values to [0, 1]
  //     inputBuffer.add(r / 255.0);
  //     inputBuffer.add(g / 255.0);
  //     inputBuffer.add(b / 255.0);
  //   }
  // }

  //   return inputBuffer.reshape([1, 224, 224, 3]); // Reshape to [1, height, width, channels]
  // }

  // void _getLabelFromOutput(List<double> output) {
  //   int maxIndex = output.indexWhere((value) => value == output.reduce((a, b) => a > b ? a : b));
  //   // return _labels[maxIndex];
  //   setState(() {
  //     _categoryController.text = _labels[maxIndex];
  //   });
  // }


  // loadModel() async {
  //   _interpreter = await Interpreter.fromAsset('assets/model_unquant.tflite');
  //   _labels = await FileUtil.loadLabels('assets/labels.txt');
  //   Fluttertoast.showToast(msg: "Model and labels loaded successfully.");
  // }

  // Future<void> classifyImage(File imageFile) async {
  //   // Load the image as a TensorImage
  //   var inputImage = TensorImage.fromFile(imageFile);

  //   // Preprocess the image
  //   var imageProcessor = ImageProcessorBuilder()
  //       .add(ResizeOp(224, 224, ResizeMethod.bilinear)) // Resize to match model input size
  //       .add(NormalizeOp(0, 255)) // Adjust as needed for your model
  //       .build();
  //   inputImage = imageProcessor.process(inputImage);

  //   var output = List.generate(1, (index) => List.filled(_labels.length, 0.0)); // Create output array
  //   _interpreter.run(inputImage.buffer, output);

  //   // Find the label with the highest probability
  //   int maxIndex = output.indexWhere((value) => value == output.reduce((a, b) => ((a as double) > (b as double)) ? a : b));

  //   setState(() {
  //     _categoryController.text = _labels[maxIndex];
  //   });
  // }

  // classifyImage(File image) async {
  //   var output = await Tflite.runModelOnImage(
  //     path: image.path,
  //     numResults: 2,
  //     threshold: 0.5,
  //     imageMean: 127.5,
  //     imageStd: 127.5,
  //   );
  //   setState(() {
  //     _loading = false;
  //     _outputs = output;
  //     _categoryController.text = _outputs?[0]["label"];
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    CurrentPageViewModel currentPage =
        Provider.of<CurrentPageViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "CHETVTMNT",
            style: TextStyle(
              color: Color(0xFFfC9B92),
              fontSize: 27,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(37, 252, 155, 146),
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          currentPage.setCurrentScreen(const HomePageScreen());
          currentPage.setCurrentSelectedIndex(2);
        },
        backgroundColor: const Color(0xFFfC9B92),
        child: const Icon(Icons.arrow_back_ios_new),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: SizedBox(
                    width: 160,
                    height: 56,
                    child: ButtonProfil(
                      buttonColor: Colors.green,
                      buttonName: const SizedBox(
                        width: 200,
                        child: Center(
                          child: Text("upload image",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                      onPressed: () {
                        pickImage();
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _titleController,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 13,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
                decoration: const InputDecoration(
                  labelText: 'Titre',
                  labelStyle: TextStyle(
                    color: Color(0xFFfC9B92),
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      width: 1,
                      color: Color(0xFFfC9B92),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      width: 1,
                      color: Color(0xFFfC9B92),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                readOnly: true,
                controller: _categoryController,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 13,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
                decoration: const InputDecoration(
                  labelText: 'Categorie',
                  labelStyle: TextStyle(
                    color: Color(0xFFfC9B92),
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      width: 1,
                      color: Color(0xFFfC9B92),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      width: 1,
                      color: Color(0xFFfC9B92),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _tailleController,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 13,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
                decoration: const InputDecoration(
                  labelText: 'Taille',
                  labelStyle: TextStyle(
                    color: Color(0xFFfC9B92),
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      width: 1,
                      color: Color(0xFFfC9B92),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      width: 1,
                      color: Color(0xFFfC9B92),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _marqueController,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 13,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
                decoration: const InputDecoration(
                  labelText: 'Marque',
                  labelStyle: TextStyle(
                    color: Color(0xFFfC9B92),
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      width: 1,
                      color: Color(0xFFfC9B92),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      width: 1,
                      color: Color(0xFFfC9B92),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                keyboardType: const TextInputType.numberWithOptions(),
                controller: _prixController,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 13,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
                decoration: const InputDecoration(
                  labelText: 'Prix',
                  labelStyle: TextStyle(
                    color: Color(0xFFfC9B92),
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      width: 1,
                      color: Color(0xFFfC9B92),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      width: 1,
                      color: Color(0xFFfC9B92),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: SizedBox(
                    width: 160,
                    height: 56,
                    child: ButtonProfil(
                      buttonColor: const Color(0xFFfC9B92),
                      buttonName: const SizedBox(
                        width: 200,
                        child: Center(
                          child: Text("Ajouter Vetement",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                      onPressed: () async {},
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
