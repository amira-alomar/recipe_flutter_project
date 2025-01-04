// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class CalorieCalculator extends StatefulWidget {
  const CalorieCalculator({super.key});

  @override
  State<CalorieCalculator> createState() => _CalorieCalculatorState();
}

class _CalorieCalculatorState extends State<CalorieCalculator> {
  String? selectedGender;
  String selectedActivityLevel = "Low";
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  String? result;

  void calculateCalories() {
    // Parse input values
    final weight = double.tryParse(weightController.text) ?? 0;
    final height = double.tryParse(heightController.text) ?? 0;
    final age = int.tryParse(ageController.text) ?? 0;

    if (weight <= 0 || height <= 0 || age <= 0 || selectedGender == null) {
      setState(() {
        result = "Please enter valid inputs for all fields.";
      });
      return;
    }

    // Calculate BMR using Mifflin-St Jeor Equation
    double bmr;
    if (selectedGender == "Male") {
      bmr = 10 * weight + 6.25 * height - 5 * age + 5;
    } else {
      bmr = 10 * weight + 6.25 * height - 5 * age - 161;
    }

    // Adjust for activity level
    double activityFactor;
    switch (selectedActivityLevel) {
      case "Low":
        activityFactor = 1.2;
        break;
      case "Moderate":
        activityFactor = 1.55;
        break;
      case "High":
        activityFactor = 1.725;
        break;
      default:
        activityFactor = 1.2;
    }

    final dailyCalories = bmr * activityFactor;

    // Update result
    setState(() {
      result =
          "Your daily calorie needs: ${dailyCalories.toStringAsFixed(2)} kcal";
    });
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text(
          "Calorie Calculator",
          style: TextStyle(color: Color(0xFFdcd2eb)),
        ),
        backgroundColor:Color(0xFF5f2d8c) ,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Title Section
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.local_fire_department,
                      color: Color(0xFF5f2d8c), size: 24),
                  SizedBox(width: 8),
                  Text(
                    "Calorie Calculator",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5f2d8c),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),

              // Input Form Section
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildInputField(
                        controller: weightController,
                        label: "Weight (kg):",
                        hint: "Enter your weight in Kg",
                        icon: Icons.monitor_weight,
                      ),
                      SizedBox(height: 15),
                      buildInputField(
                        controller: heightController,
                        label: "Height (cm):",
                        hint: "Enter your height in cm",
                        icon: Icons.height,
                      ),
                      SizedBox(height: 15),
                      buildInputField(
                        controller: ageController,
                        label: "Age (years):",
                        hint: "Enter your age",
                        icon: Icons.calendar_today,
                      ),
                      SizedBox(height: 20),

                      // Gender Selection (Radio Buttons)
                      Text(
                        "Gender:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5f2d8c),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Radio<String>(
                                  value: "Male",
                                  groupValue: selectedGender,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedGender = value;
                                    });
                                  },
                                  activeColor: Color(0xFF5f2d8c),
                                ),
                                Text("Male"),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Radio<String>(
                                  value: "Female",
                                  groupValue: selectedGender,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedGender = value;
                                    });
                                  },
                                  activeColor: Color(0xFF5f2d8c),
                                ),
                                Text("Female"),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),

                      // Activity Level Dropdown
                      Text(
                        "Activity Level:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5f2d8c),
                        ),
                      ),
                      SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: selectedActivityLevel,
                        items: [
                          DropdownMenuItem(value: "Low", child: Text("Low")),
                          DropdownMenuItem(
                              value: "Moderate", child: Text("Moderate")),
                          DropdownMenuItem(value: "High", child: Text("High")),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedActivityLevel = value!;
                          });
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Color(0xFF5f2d8c),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Calculate Button
              ElevatedButton(
                onPressed: calculateCalories,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  backgroundColor: Color(0xFF5f2d8c),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  "Calculate",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Result Display
              if (result != null)
                Text(
                  result!,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5f2d8c),
                  ),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF5f2d8c),
          ),
        ),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Color(0xFF5f2d8c),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              prefixIcon: Icon(icon, color: Color(0xFF5f2d8c)),
            ),
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    );
  }
}
