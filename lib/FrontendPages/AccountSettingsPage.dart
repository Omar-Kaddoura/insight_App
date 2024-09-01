import 'package:flutter/material.dart';

class AccountSettingsPage extends StatefulWidget {
  @override
  _AccountSettingsPageState createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for each text field
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _occupationController = TextEditingController();
  final _jobTitleController = TextEditingController();
  final _jobDescriptionController = TextEditingController();
  final _companyController = TextEditingController();
  final _linkedInController = TextEditingController();
  final _instagramController = TextEditingController();

  String? _gender;
  String? _studentStatus;
  String? _studies;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        backgroundColor: Color.fromARGB(255, 0, 94, 132),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildCategoryTile(
                title: "Personal Information",
                icon: Icons.person,
                children: [
                  _buildTextField(
                    controller: _nameController,
                    label: "Name",
                    icon: Icons.person,
                  ),
                  _buildDropdown(
                    value: _gender,
                    label: "Gender",
                    items: ["Male", "Female"],
                    icon: Icons.wc,
                    onChanged: (value) => setState(() => _gender = value),
                  ),
                  _buildTextField(
                    controller: _emailController,
                    label: "Email",
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                ],
              ),
              _buildCategoryTile(
                title: "Educational Background",
                icon: Icons.school,
                children: [
                  _buildDropdown(
                    value: _studentStatus,
                    label: "Status",
                    items: ["Alumni", "Current Student"],
                    icon: Icons.school,
                    onChanged: (value) => setState(() => _studentStatus = value),
                  ),
                  _buildDropdown(
                    value: _studies,
                    label: "Studies",
                    items: ["Undergrad", "Grad", "PhD"],
                    icon: Icons.school_outlined,
                    onChanged: (value) => setState(() => _studies = value),
                  ),
                ],
              ),
              _buildCategoryTile(
                title: "Work Information",
                icon: Icons.work,
                children: [
                  _buildTextField(
                    controller: _occupationController,
                    label: "Occupation",
                    icon: Icons.work,
                  ),
                  _buildTextField(
                    controller: _jobTitleController,
                    label: "Job Title",
                    icon: Icons.title,
                  ),
                  _buildTextField(
                    controller: _jobDescriptionController,
                    label: "Job Description",
                    icon: Icons.description,
                  ),
                  _buildTextField(
                    controller: _companyController,
                    label: "Company",
                    icon: Icons.business,
                  ),
                ],
              ),
              _buildCategoryTile(
                title: "Social Media Links",
                icon: Icons.link,
                children: [
                  _buildTextField(
                    controller: _linkedInController,
                    label: "LinkedIn",
                    icon: Icons.linked_camera,
                  ),
                  _buildTextField(
                    controller: _instagramController,
                    label: "Instagram",
                    icon: Icons.camera,
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Save form data
                    // Handle form submission here
                  }
                },
                child: Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 0, 94, 132),
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryTile({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: ExpansionTile(
          leading: Icon(icon, color: Color.fromARGB(255, 0, 94, 132)),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 0, 94, 132),
            ),
          ),
          children: children,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        keyboardType: keyboardType,
      ),
    );
  }

  Widget _buildDropdown({
    required String? value,
    required String label,
    required List<String> items,
    required IconData icon,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onChanged: onChanged,
        items: items
            .map(
              (item) => DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          ),
        )
            .toList(),
      ),
    );
  }
}
