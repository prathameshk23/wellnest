import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:wellcare/models/medicine.dart';
import 'package:wellcare/modules/dashboard/dashboard_module.dart';
import 'package:wellcare/resources/r.dart';
import 'package:wellcare/widgets/custom_button.dart';

import '../../../store/app_store.dart';
import '../../../utils/logger.dart';
import '../services/dash_services.dart';

class GratitudeScreen extends StatefulWidget {
  const GratitudeScreen({super.key});

  static String get linkRoute => "/gratitudeScreen";
  static String get toRoute => "${DashboardModule.moduleRoute}/gratitudeScreen";

  @override
  State<GratitudeScreen> createState() => _GratitudeScreenState();
}

class _GratitudeScreenState extends State<GratitudeScreen> {
  final TextEditingController _medicineController = TextEditingController();
  final TextEditingController _dosageController = TextEditingController();
  final AppStore store = Modular.get<AppStore>();
  final DashServices apiServices = DashServices();
  List<Medicine> medicineList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMedicines();
  }

  @override
  void dispose() {
    _medicineController.dispose();
    _dosageController.dispose();
    super.dispose();
  }

  Future<void> fetchMedicines() async {
    setState(() {
      isLoading = true;
    });

    try {
      final data = await apiServices.getMedicine(store.user.id);
      medicineList = data;
      logger.i("Fetched ${medicineList.length} medicines");
    } catch (e) {
      logger.e("Error fetching medicines: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _addMedicine() async {
    if (_medicineController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a medicine name")),
      );
      return;
    }

    final medicine = {
      "name": _medicineController.text.trim(),
      "dosage": _dosageController.text.trim(),
      "date": DateFormat('yyyy-MM-dd').format(DateTime.now()),
      "user": store.user.id,
    };

    try {
      await apiServices.postMedicine(medicine);
      _medicineController.clear();
      _dosageController.clear();
      await fetchMedicines();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Medicine added successfully")),
      );
    } catch (e) {
      logger.e("Error adding medicine: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to add medicine")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.settings_outlined,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: R.colors.bgPrimary,
        foregroundColor: R.colors.black,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: -80,
              left: 0,
              right: 0,
              child: Transform.scale(
                scale: 1.1,
                child: SvgPicture.asset(R.assets.topVector),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 1,
                width: double.infinity,
                color: R.colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: SvgPicture.asset(R.assets.backIcon),
                        ),
                        const SizedBox(width: 30),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat.yMMMMd('en_US')
                                    .format(DateTime.parse(store.selectedDate)),
                                style: GoogleFonts.publicSans(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                  color: R.colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Medicine Tracker",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: R.colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.35,
                    ),
                    child: SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: R.colors.white,
                          borderRadius: BorderRadius.circular(32),
                          boxShadow: [
                            BoxShadow(
                              color: R.colors.neutral300,
                              spreadRadius: 1,
                              blurRadius: 2,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.lightBlue.shade50,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.medication,
                                          size: 16, color: Colors.blue),
                                      const SizedBox(width: 8),
                                      Text(
                                        "Medicine I took...",
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            TextField(
                              controller: _medicineController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade300),
                                ),
                                labelText: "Medicine Name",
                                hintText: "Enter medicine name",
                              ),
                            ),
                            const SizedBox(height: 12),
                            TextField(
                              controller: _dosageController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade300),
                                ),
                                labelText: "Dosage",
                                hintText: "E.g., 10mg, 1 pill",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : medicineList.isEmpty
                            ? Center(
                                child: Text(
                                  "No medicines added yet",
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                itemCount: medicineList.length,
                                itemBuilder: (context, index) {
                                  final medicine = medicineList[index];
                                  return Card(
                                    margin: const EdgeInsets.only(bottom: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: ListTile(
                                      leading: const CircleAvatar(
                                        child: Icon(Icons.medication_outlined),
                                      ),
                                      title: Text(medicine.name ?? ""),
                                      subtitle: Text(medicine.dosage ?? ""),
                                    ),
                                  );
                                },
                              ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: CustomButton(
                      goTo: _addMedicine,
                      elevation: 0,
                      rounded: 50,
                      buttonText: "Add Medicine",
                      buttonWidth: double.infinity,
                      buttonColor: R.colors.bgPrimary,
                      textStyle: GoogleFonts.inter(
                        fontSize: 16,
                        color: R.colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
