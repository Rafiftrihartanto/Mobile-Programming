import 'package:flutter/material.dart';

void main() {
  runApp(ThemeApp());
}

// DATA THEME
class AppTheme {
  bool isDarkMode = false;

  ThemeData get themeData {
    if (isDarkMode) {
      return ThemeData.dark().copyWith(
        primaryColor: Colors.blue[700],
        scaffoldBackgroundColor: Colors.grey[900],
        colorScheme: ColorScheme.dark(
          primary: Colors.blue[600]!,
          secondary: Colors.blue[300]!,
          surface: Colors.grey[800]!,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[900],
          elevation: 0,
          foregroundColor: Colors.white,
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        listTileTheme: ListTileThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    } else {
      return ThemeData.light().copyWith(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[50],
        colorScheme: ColorScheme.light(
          primary: Colors.blue,
          secondary: Colors.blue[300]!,
          surface: Colors.white,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          foregroundColor: Colors.grey[900],
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        listTileTheme: ListTileThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }
  }

  Color get backgroundColor {
    return isDarkMode ? Colors.grey[900]! : Colors.grey[50]!;
  }

  Color get cardColor {
    return isDarkMode ? Colors.grey[800]! : Colors.white;
  }

  Color get textColor {
    return isDarkMode ? Colors.white : Colors.grey[900]!;
  }

  Color get secondaryTextColor {
    return isDarkMode ? Colors.grey[300]! : Colors.grey[600]!;
  }
}

// INHERITED WIDGET UNTUK THEME
class ThemeInheritedWidget extends InheritedWidget {
  final AppTheme appTheme;
  final VoidCallback toggleTheme;

  const ThemeInheritedWidget({
    Key? key,
    required this.appTheme,
    required this.toggleTheme,
    required Widget child,
  }) : super(key: key, child: child);

  static ThemeInheritedWidget of(BuildContext context) {
    final ThemeInheritedWidget? result = 
        context.dependOnInheritedWidgetOfExactType<ThemeInheritedWidget>();
    assert(result != null, 'No ThemeInheritedWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ThemeInheritedWidget oldWidget) {
    return appTheme.isDarkMode != oldWidget.appTheme.isDarkMode;
  }
}

// APLIKASI UTAMA
class ThemeApp extends StatefulWidget {
  @override
  _ThemeAppState createState() => _ThemeAppState();
}

class _ThemeAppState extends State<ThemeApp> {
  AppTheme appTheme = AppTheme();

  void toggleTheme() {
    setState(() {
      appTheme.isDarkMode = !appTheme.isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemeInheritedWidget(
      appTheme: appTheme,
      toggleTheme: toggleTheme,
      child: MaterialApp(
        theme: appTheme.themeData,
        home: HomeScreen(),
        routes: {
          '/users': (context) => UsersScreen(),
          '/salary': (context) => SalaryFormScreen(),
          '/check-clock': (context) => CheckClockSettingsScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

// MODEL DATA
class User {
  final int id;
  String email;
  String password;
  bool isAdmin;

  User({
    required this.id,
    required this.email,
    required this.password,
    required this.isAdmin,
  });
}

class Salary {
  final int id;
  final int userId;
  final String type;
  final double rate;
  final DateTime effectiveDate;

  Salary({
    required this.id,
    required this.userId,
    required this.type,
    required this.rate,
    required this.effectiveDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'type': type,
      'rate': rate,
      'effective_date': effectiveDate.toIso8601String(),
    };
  }
}

class CheckClockSetting {
  final int id;
  final String name;
  final String type;

  CheckClockSetting({
    required this.id,
    required this.name,
    required this.type,
  });
}

// HOME SCREEN
class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> menuItems = [
    {
      'title': 'Users',
      'subtitle': 'Manage user accounts',
      'icon': Icons.people_alt_rounded,
      'route': '/users',
      'color': Colors.blue,
      'iconColor': Colors.blue,
    },
    {
      'title': 'Salary',
      'subtitle': 'Add salary information',
      'icon': Icons.attach_money_rounded,
      'route': '/salary',
      'color': Colors.green,
      'iconColor': Colors.green,
    },
    {
      'title': 'Clock Settings',
      'subtitle': 'Time & attendance',
      'icon': Icons.access_time_filled_rounded,
      'route': '/check-clock',
      'color': Colors.orange,
      'iconColor': Colors.orange,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final themeInherited = ThemeInheritedWidget.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: themeInherited.appTheme.backgroundColor,
      appBar: AppBar(
        title: Text(
          'WorkSpace',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: themeInherited.appTheme.textColor,
          ),
        ),
        backgroundColor: themeInherited.appTheme.cardColor,
        elevation: 0,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: themeInherited.appTheme.backgroundColor,
            ),
            child: IconButton(
              icon: Icon(
                themeInherited.appTheme.isDarkMode
                    ? Icons.light_mode_rounded
                    : Icons.dark_mode_rounded,
                color: themeInherited.appTheme.textColor,
              ),
              onPressed: themeInherited.toggleTheme,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Welcome
            _buildWelcomeHeader(themeInherited),
            SizedBox(height: 32),
            
            // Quick Stats
            _buildQuickStats(themeInherited, size),
            SizedBox(height: 32),
            
            // Features Grid
            Text(
              'Features',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: themeInherited.appTheme.textColor,
              ),
            ),
            SizedBox(height: 16),
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: size.width > 600 ? 3 : 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.1,
              ),
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final item = menuItems[index];
                return _buildFeatureCard(
                  context,
                  title: item['title'] as String,
                  subtitle: item['subtitle'] as String,
                  icon: item['icon'] as IconData,
                  color: item['color'] as Color,
                  iconColor: item['iconColor'] as Color,
                  onTap: () {
                    Navigator.pushNamed(context, item['route'] as String);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeHeader(ThemeInheritedWidget themeInherited) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hello, Admin! 👋',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: themeInherited.appTheme.textColor,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Welcome to Employee Management System',
          style: TextStyle(
            fontSize: 16,
            color: themeInherited.appTheme.secondaryTextColor,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickStats(ThemeInheritedWidget themeInherited, Size size) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            themeInherited,
            icon: Icons.people_rounded,
            value: '24',
            label: 'Employees',
            color: Colors.blue,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            themeInherited,
            icon: Icons.schedule_rounded,
            value: '98%',
            label: 'Attendance',
            color: Colors.green,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            themeInherited,
            icon: Icons.attach_money_rounded,
            value: '\$4.2K',
            label: 'Payroll',
            color: Colors.orange,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    ThemeInheritedWidget themeInherited, {
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: themeInherited.appTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: themeInherited.appTheme.textColor,
            ),
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: themeInherited.appTheme.secondaryTextColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    final themeInherited = ThemeInheritedWidget.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withOpacity(0.1),
              color.withOpacity(0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: color.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 24,
                ),
              ),
              SizedBox(height: 16),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: themeInherited.appTheme.textColor,
                ),
              ),
              SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: themeInherited.appTheme.secondaryTextColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// USERS SCREEN
class UsersScreen extends StatefulWidget {
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  List<User> users = [
    User(id: 1, email: 'admin@company.com', password: 'admin123', isAdmin: true),
    User(id: 2, email: 'john.doe@company.com', password: 'user123', isAdmin: false),
    User(id: 3, email: 'jane.smith@company.com', password: 'user456', isAdmin: false),
    User(id: 4, email: 'mike.wilson@company.com', password: 'user789', isAdmin: false),
  ];

  void _editUser(User user) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => UserEditSheet(
        user: user,
        onSave: (updatedUser) {
          setState(() {
            final index = users.indexWhere((u) => u.id == updatedUser.id);
            if (index != -1) {
              users[index] = updatedUser;
            }
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeInherited = ThemeInheritedWidget.of(context);

    return Scaffold(
      backgroundColor: themeInherited.appTheme.backgroundColor,
      appBar: AppBar(
        title: Text(
          'User Management',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: themeInherited.appTheme.textColor,
          ),
        ),
        backgroundColor: themeInherited.appTheme.cardColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: themeInherited.appTheme.textColor),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add_rounded, color: Colors.blue),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Search Bar
            _buildSearchBar(themeInherited),
            SizedBox(height: 20),
            
            // Users List
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return _buildUserCard(user, themeInherited);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(ThemeInheritedWidget themeInherited) {
    return Container(
      decoration: BoxDecoration(
        color: themeInherited.appTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search users...',
          hintStyle: TextStyle(color: themeInherited.appTheme.secondaryTextColor),
          prefixIcon: Icon(Icons.search_rounded, color: themeInherited.appTheme.secondaryTextColor),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  Widget _buildUserCard(User user, ThemeInheritedWidget themeInherited) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: themeInherited.appTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.lightBlue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Icon(
            user.isAdmin ? Icons.admin_panel_settings_rounded : Icons.person_rounded,
            color: Colors.white,
            size: 24,
          ),
        ),
        title: Text(
          user.email,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: themeInherited.appTheme.textColor,
          ),
        ),
        subtitle: Text(
          user.isAdmin ? 'Administrator' : 'Regular User',
          style: TextStyle(
            color: themeInherited.appTheme.secondaryTextColor,
          ),
        ),
        trailing: Container(
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: Icon(Icons.edit_rounded, color: Colors.blue, size: 20),
            onPressed: () => _editUser(user),
          ),
        ),
      ),
    );
  }
}

// USER EDIT BOTTOM SHEET
class UserEditSheet extends StatefulWidget {
  final User user;
  final Function(User) onSave;

  const UserEditSheet({Key? key, required this.user, required this.onSave}) : super(key: key);

  @override
  _UserEditSheetState createState() => _UserEditSheetState();
}

class _UserEditSheetState extends State<UserEditSheet> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late bool isAdmin;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: widget.user.email);
    passwordController = TextEditingController(text: widget.user.password);
    isAdmin = widget.user.isAdmin;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeInherited = ThemeInheritedWidget.of(context);
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.85,
      decoration: BoxDecoration(
        color: themeInherited.appTheme.cardColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: themeInherited.appTheme.secondaryTextColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Edit User',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: themeInherited.appTheme.textColor,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Update user information',
              style: TextStyle(
                color: themeInherited.appTheme.secondaryTextColor,
              ),
            ),
            SizedBox(height: 32),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildFormField(
                      icon: Icons.email_rounded,
                      label: 'Email Address',
                      controller: emailController,
                      themeInherited: themeInherited,
                    ),
                    SizedBox(height: 20),
                    _buildFormField(
                      icon: Icons.lock_rounded,
                      label: 'Password',
                      controller: passwordController,
                      themeInherited: themeInherited,
                      isPassword: true,
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: themeInherited.appTheme.backgroundColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.admin_panel_settings_rounded, color: Colors.blue),
                          SizedBox(width: 12),
                          Text(
                            'Administrator Access',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: themeInherited.appTheme.textColor,
                            ),
                          ),
                          Spacer(),
                          Switch(
                            value: isAdmin,
                            onChanged: (value) {
                              setState(() {
                                isAdmin = value;
                              });
                            },
                            activeColor: Colors.blue,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      side: BorderSide(color: Colors.grey),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: themeInherited.appTheme.textColor),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final updatedUser = User(
                        id: widget.user.id,
                        email: emailController.text,
                        password: passwordController.text,
                        isAdmin: isAdmin,
                      );
                      widget.onSave(updatedUser);
                      Navigator.pop(context);
                      
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('User updated successfully!'),
                          backgroundColor: Colors.green,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      'Save Changes',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormField({
    required IconData icon,
    required String label,
    required TextEditingController controller,
    required ThemeInheritedWidget themeInherited,
    bool isPassword = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: themeInherited.appTheme.backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: themeInherited.appTheme.secondaryTextColor),
          prefixIcon: Icon(icon, color: themeInherited.appTheme.secondaryTextColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: themeInherited.appTheme.backgroundColor,
        ),
      ),
    );
  }
}

// SALARY FORM SCREEN
class SalaryFormScreen extends StatefulWidget {
  @override
  _SalaryFormScreenState createState() => _SalaryFormScreenState();
}

class _SalaryFormScreenState extends State<SalaryFormScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Form controllers
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _effectiveDateController = TextEditingController();
  
  String _selectedType = 'Monthly';
  DateTime _selectedDate = DateTime.now();
  
  // List of salary types
  final List<String> _salaryTypes = ['Monthly', 'Hourly', 'Weekly', 'Bi-weekly'];
  
  // List of users for dropdown
  final List<Map<String, dynamic>> _users = [
    {'id': 1, 'name': 'John Doe', 'email': 'john.doe@company.com'},
    {'id': 2, 'name': 'Jane Smith', 'email': 'jane.smith@company.com'},
    {'id': 3, 'name': 'Mike Wilson', 'email': 'mike.wilson@company.com'},
    {'id': 4, 'name': 'Sarah Johnson', 'email': 'sarah.johnson@company.com'},
  ];
  
  int? _selectedUserId;

  @override
  void initState() {
    super.initState();
    _effectiveDateController.text = _formatDate(_selectedDate);
  }

  @override
  void dispose() {
    _userIdController.dispose();
    _rateController.dispose();
    _effectiveDateController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _effectiveDateController.text = _formatDate(picked);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_selectedUserId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please select a user'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
        return;
      }

      // Create salary object
      final salary = Salary(
        id: DateTime.now().millisecondsSinceEpoch, // Temporary ID
        userId: _selectedUserId!,
        type: _selectedType,
        rate: double.parse(_rateController.text),
        effectiveDate: _selectedDate,
      );

      // Simulate sending to database
      _sendToDatabase(salary);
    }
  }

  void _sendToDatabase(Salary salary) {
    // Simulate API call delay
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );

    Future.delayed(Duration(seconds: 2), () {
      Navigator.pop(context); // Close loading dialog
      
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Salary data saved successfully!'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );

      // Reset form
      _formKey.currentState!.reset();
      setState(() {
        _selectedUserId = null;
        _selectedType = 'Monthly';
        _selectedDate = DateTime.now();
        _effectiveDateController.text = _formatDate(_selectedDate);
      });

      // Print data to console (simulate database save)
      print('Salary Data Saved:');
      print('User ID: ${salary.userId}');
      print('Type: ${salary.type}');
      print('Rate: \$${salary.rate}');
      print('Effective Date: ${_formatDate(salary.effectiveDate)}');
      print('JSON Data: ${salary.toJson()}');
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeInherited = ThemeInheritedWidget.of(context);

    return Scaffold(
      backgroundColor: themeInherited.appTheme.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Add Salary',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: themeInherited.appTheme.textColor,
          ),
        ),
        backgroundColor: themeInherited.appTheme.cardColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: themeInherited.appTheme.textColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              _buildFormHeader(themeInherited),
              SizedBox(height: 32),
              
              // User Selection
              _buildUserDropdown(themeInherited),
              SizedBox(height: 20),
              
              // Salary Type
              _buildSalaryTypeDropdown(themeInherited),
              SizedBox(height: 20),
              
              // Rate Input
              _buildRateInput(themeInherited),
              SizedBox(height: 20),
              
              // Effective Date
              _buildDatePicker(themeInherited),
              SizedBox(height: 40),
              
              // Submit Button
              _buildSubmitButton(themeInherited),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormHeader(ThemeInheritedWidget themeInherited) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Salary Information',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: themeInherited.appTheme.textColor,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Fill in the salary details for the employee',
          style: TextStyle(
            fontSize: 16,
            color: themeInherited.appTheme.secondaryTextColor,
          ),
        ),
      ],
    );
  }

  Widget _buildUserDropdown(ThemeInheritedWidget themeInherited) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select User *',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: themeInherited.appTheme.textColor,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: themeInherited.appTheme.backgroundColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: DropdownButtonFormField<int>(
            value: _selectedUserId,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: themeInherited.appTheme.backgroundColor,
              prefixIcon: Icon(Icons.person_rounded, color: themeInherited.appTheme.secondaryTextColor),
            ),
            items: _users.map((user) {
              return DropdownMenuItem<int>(
                value: user['id'],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      user['name'],
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: themeInherited.appTheme.textColor,
                      ),
                    ),
                    Text(
                      user['email'],
                      style: TextStyle(
                        fontSize: 12,
                        color: themeInherited.appTheme.secondaryTextColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedUserId = value;
              });
            },
            validator: (value) {
              if (value == null) {
                return 'Please select a user';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSalaryTypeDropdown(ThemeInheritedWidget themeInherited) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Salary Type *',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: themeInherited.appTheme.textColor,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: themeInherited.appTheme.backgroundColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: DropdownButtonFormField<String>(
            value: _selectedType,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: themeInherited.appTheme.backgroundColor,
              prefixIcon: Icon(Icons.attach_money_rounded, color: themeInherited.appTheme.secondaryTextColor),
            ),
            items: _salaryTypes.map((type) {
              return DropdownMenuItem<String>(
                value: type,
                child: Text(
                  type,
                  style: TextStyle(
                    color: themeInherited.appTheme.textColor,
                  ),
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedType = value!;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select salary type';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRateInput(ThemeInheritedWidget themeInherited) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rate *',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: themeInherited.appTheme.textColor,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: themeInherited.appTheme.backgroundColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextFormField(
            controller: _rateController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              hintText: 'Enter amount',
              prefixIcon: Icon(Icons.money_rounded, color: themeInherited.appTheme.secondaryTextColor),
              suffixText: _selectedType == 'Hourly' ? '/hour' : '/month',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: themeInherited.appTheme.backgroundColor,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter rate amount';
              }
              if (double.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDatePicker(ThemeInheritedWidget themeInherited) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Effective Date *',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: themeInherited.appTheme.textColor,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: themeInherited.appTheme.backgroundColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextFormField(
            controller: _effectiveDateController,
            readOnly: true,
            decoration: InputDecoration(
              hintText: 'Select date',
              prefixIcon: Icon(Icons.calendar_today_rounded, color: themeInherited.appTheme.secondaryTextColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: themeInherited.appTheme.backgroundColor,
            ),
            onTap: () => _selectDate(context),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select effective date';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(ThemeInheritedWidget themeInherited) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _submitForm,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 2,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.save_rounded, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'Save Salary Data',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// CHECK CLOCK SETTINGS SCREEN
class CheckClockSettingsScreen extends StatelessWidget {
  final List<CheckClockSetting> settings = [
    CheckClockSetting(id: 1, name: 'Office Hours', type: 'Regular'),
    CheckClockSetting(id: 2, name: 'Flexible Time', type: 'Flexible'),
    CheckClockSetting(id: 3, name: 'Remote Work', type: 'Remote'),
    CheckClockSetting(id: 4, name: 'Shift Work', type: 'Shift'),
  ];

  @override
  Widget build(BuildContext context) {
    final themeInherited = ThemeInheritedWidget.of(context);

    return Scaffold(
      backgroundColor: themeInherited.appTheme.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Clock Settings',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: themeInherited.appTheme.textColor,
          ),
        ),
        backgroundColor: themeInherited.appTheme.cardColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: themeInherited.appTheme.textColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Info Card
            _buildInfoCard(themeInherited),
            SizedBox(height: 20),
            
            // Settings List
            Expanded(
              child: ListView.builder(
                itemCount: settings.length,
                itemBuilder: (context, index) {
                  final setting = settings[index];
                  return _buildSettingCard(setting, themeInherited);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(ThemeInheritedWidget themeInherited) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blue.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.info_rounded, color: Colors.blue, size: 24),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              'Configure different clock-in settings for various work arrangements',
              style: TextStyle(
                color: themeInherited.appTheme.textColor,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingCard(CheckClockSetting setting, ThemeInheritedWidget themeInherited) {
    Color getColorByType(String type) {
      switch (type) {
        case 'Regular': return Colors.blue;
        case 'Flexible': return Colors.green;
        case 'Remote': return Colors.orange;
        case 'Shift': return Colors.purple;
        default: return Colors.grey;
      }
    }

    final color = getColorByType(setting.type);

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: themeInherited.appTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(0.1),
          ),
          child: Icon(
            Icons.settings_rounded,
            color: color,
            size: 24,
          ),
        ),
        title: Text(
          setting.name,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: themeInherited.appTheme.textColor,
          ),
        ),
        subtitle: Text(
          setting.type,
          style: TextStyle(
            color: themeInherited.appTheme.secondaryTextColor,
          ),
        ),
        trailing: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            'Configure',
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}