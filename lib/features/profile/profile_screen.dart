import 'package:flutter/material.dart';
import '../../model/quiz_model.dart';
import '../../services/home_service.dart';
import '../../services/user_service.dart';
import '../../model/user_activity_model.dart';
import '../../core/handlers/auth_handler.dart';
import '../../core/exceptions/api_exception.dart';
import '../../services/api.dart';

class ProfileScreen extends StatefulWidget {
  final int userId;
  final String email;

  const ProfileScreen({
    super.key,
    required this.userId,
    required this.email,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final HomeService _service = HomeService(Api());
  bool isLoading = true;
  String? error;
  UserActivity? activity;

  @override
  void initState() {
    super.initState();
    _fetchActivity();
  }

  Future<void> _fetchActivity() async {
    try {
      final response = await _service.fetchUserActivity();
  
      setState(() {
        activity = response as UserActivity;
        isLoading = false;
      });
    } on ApiException catch (e) {
      if (e.statusCode == 401){
           AuthHandler.redirectToLogin(context, e);
      }
      setState(() {
        error = 'Failed to load profile: $e';
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to load data")),
      );
    } catch (e) {
        print("Unknown error: $e");
    }
  }

  void _showEditProfileSheet() {
    final UserService _userService = UserService(Api());

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _EditProfileSheet(
        currentName: activity?.name ?? '',
        currentEmail: widget.email,
        onSaved: (name, email) async {
            try {
                await _userService.updateProfile(name, email);

                if (!mounted) return;
                
                ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile updated successfully')),
                );
            } on ApiException catch (e) {
                if (e.statusCode == 401){
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Unuthorized!')),
                    );
                } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Unable to update password!')),
                    );
                } 
            } catch (e) {
                print("Unknown error: $e");
            }
            
            await Future.delayed(const Duration(milliseconds: 500));
            setState(() {
            activity = UserActivity.fromJson({
                'name': name,
                'level': activity?.level ?? '',
                'totalQuizzes': activity?.totalQuizzes ?? 0,
                'completed': activity?.completed ?? 0,
                'badges': activity?.badges ?? [],
                'highestScorePercentage': activity?.highestScorePercentage ?? 0,
                'leaderboard': activity?.leaderboard ?? 0,
                'averageScore': activity?.averageScore ?? 0,
            });
            });
          
        },
      ),
    );
  }

  void _showChangePasswordSheet() {
    final UserService _userService = UserService(Api());
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _ChangePasswordSheet(
        onSaved: (current, newPass) async {
          try {
            await _userService.changePassword(widget.userId, current, newPass);

            if (!mounted) return;

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Password updated successfully')),
            );
          } on ApiException catch (e) {
            if (e.statusCode == 401){
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Unuthorized!')),
                );
            } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Unable to update password!')),
                );
            } 
          } catch (e) {
                print("Unknown error: $e");
          }
          
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colors.grey.shade200, height: 1),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline,
                          size: 48, color: Colors.red),
                      const SizedBox(height: 12),
                      Text(error!, textAlign: TextAlign.center),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                            error = null;
                          });
                          _fetchActivity();
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    setState(() { isLoading = true; error = null; });
                    await _fetchActivity();
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildProfileCard(),
                        const SizedBox(height: 16),
                        _buildStatsGrid(),
                        const SizedBox(height: 16),
                        if (activity!.badges.isNotEmpty) ...[
                          _buildBadgesCard(),
                          const SizedBox(height: 16),
                        ],
                        _buildSettingsCard(),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
    );
  }

  // ─── Profile Card ─────────────────────────────────────────────────────────────
  Widget _buildProfileCard() {
    final a = activity!;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          Stack(
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    a.name.isNotEmpty ? a.name[0].toUpperCase() : '?',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Level badge
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4F46E5),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                  child: Text(
                    'Lv ${a.level}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          // Name & email
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  a.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  widget.email,
                  style: TextStyle(
                      fontSize: 13, color: Colors.grey.shade500),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEF2FF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '🏆 Rank #${a.leaderboard} on Leaderboard',
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF4F46E5),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Edit button
          IconButton(
            onPressed: _showEditProfileSheet,
            icon: const Icon(Icons.edit_outlined),
            color: const Color(0xFF4F46E5),
            tooltip: 'Edit Profile',
          ),
        ],
      ),
    );
  }

  // ─── Stats Grid ───────────────────────────────────────────────────────────────
  Widget _buildStatsGrid() {
    final a = activity!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Activity Overview',
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black87),
        ),
        const SizedBox(height: 10),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.6,
          children: [
            _StatTile(
              icon: Icons.quiz_outlined,
              label: 'Total Quizzes',
              value: '${a.totalQuizzes}',
              color: const Color(0xFF4F46E5),
            ),
            _StatTile(
              icon: Icons.check_circle_outline,
              label: 'Completed',
              value: '${a.completed}',
              color: const Color(0xFF22C55E),
            ),
            _StatTile(
              icon: Icons.star_outline_rounded,
              label: 'Highest Score',
              value: '${a.highestScorePercentage.toInt()}%',
              color: const Color(0xFFEAB308),
            ),
            _StatTile(
              icon: Icons.bar_chart_rounded,
              label: 'Average Score',
              value: '${a.averageScore.toStringAsFixed(1)}%',
              color: const Color(0xFFEC4899),
            ),
          ],
        ),
      ],
    );
  }

  // ─── Badges Card ──────────────────────────────────────────────────────────────
  Widget _buildBadgesCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '🎖️ Badges Earned',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: activity!.badges.map((badge) {
              return Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3CD),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: const Color(0xFFD4A017).withOpacity(0.4)),
                ),
                child: Text(
                  '⭐ $badge',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFD4A017),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // ─── Settings Card ────────────────────────────────────────────────────────────
  Widget _buildSettingsCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _SettingsTile(
            icon: Icons.person_outline,
            label: 'Edit Profile',
            subtitle: 'Update your name and email',
            onTap: _showEditProfileSheet,
          ),
          Divider(height: 1, indent: 56, color: Colors.grey.shade100),
          _SettingsTile(
            icon: Icons.lock_outline,
            label: 'Change Password',
            subtitle: 'Update your password',
            onTap: _showChangePasswordSheet,
          ),
        ],
      ),
    );
  }
}

// ─── Stat Tile ────────────────────────────────────────────────────────────────

class _StatTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  label,
                  style: TextStyle(
                      fontSize: 11, color: Colors.grey.shade500),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Settings Tile ────────────────────────────────────────────────────────────

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFEEF2FF),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: const Color(0xFF4F46E5), size: 18),
      ),
      title: Text(
        label,
        style: const TextStyle(
            fontWeight: FontWeight.w600, fontSize: 14),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
      ),
      trailing: const Icon(Icons.chevron_right,
          color: Colors.grey, size: 20),
    );
  }
}

// ─── Edit Profile Bottom Sheet ────────────────────────────────────────────────

class _EditProfileSheet extends StatefulWidget {
  final String currentName;
  final String currentEmail;
  final Future<void> Function(String name, String email) onSaved;

  const _EditProfileSheet({
    required this.currentName,
    required this.currentEmail,
    required this.onSaved,
  });

  @override
  State<_EditProfileSheet> createState() => _EditProfileSheetState();
}

class _EditProfileSheetState extends State<_EditProfileSheet> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _emailCtrl;
  final _formKey = GlobalKey<FormState>();
  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.currentName);
    _emailCtrl = TextEditingController(text: widget.currentEmail);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => isSaving = true);
    try {
      await widget.onSaved(_nameCtrl.text.trim(), _emailCtrl.text.trim());
      if (mounted) Navigator.pop(context);
    } catch (e) {
      setState(() => isSaving = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _BottomSheet(
      title: 'Edit Profile',
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _InputField(
              controller: _nameCtrl,
              label: 'Full Name',
              icon: Icons.person_outline,
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'Name is required' : null,
            ),
            const SizedBox(height: 14),
            _InputField(
              controller: _emailCtrl,
              label: 'Email',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Email is required';
                if (!v.contains('@')) return 'Enter a valid email';
                return null;
              },
            ),
            const SizedBox(height: 24),
            _SaveButton(onPressed: _save, isSaving: isSaving),
          ],
        ),
      ),
    );
  }
}

// ─── Change Password Bottom Sheet ─────────────────────────────────────────────

class _ChangePasswordSheet extends StatefulWidget {
  final Future<void> Function(String current, String newPass) onSaved;

  const _ChangePasswordSheet({required this.onSaved});

  @override
  State<_ChangePasswordSheet> createState() => _ChangePasswordSheetState();
}

class _ChangePasswordSheetState extends State<_ChangePasswordSheet> {
  final _currentCtrl = TextEditingController();
  final _newCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isSaving = false;
  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _currentCtrl.dispose();
    _newCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => isSaving = true);
    try {
      await widget.onSaved(_currentCtrl.text, _newCtrl.text);
      if (mounted) Navigator.pop(context);
    } catch (e) {
      setState(() => isSaving = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _BottomSheet(
      title: 'Change Password',
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _InputField(
              controller: _currentCtrl,
              label: 'Current Password',
              icon: Icons.lock_outline,
              obscureText: _obscureCurrent,
              toggleObscure: () =>
                  setState(() => _obscureCurrent = !_obscureCurrent),
              validator: (v) => v == null || v.isEmpty
                  ? 'Current password is required'
                  : null,
            ),
            const SizedBox(height: 14),
            _InputField(
              controller: _newCtrl,
              label: 'New Password',
              icon: Icons.lock_reset_outlined,
              obscureText: _obscureNew,
              toggleObscure: () =>
                  setState(() => _obscureNew = !_obscureNew),
              validator: (v) {
                if (v == null || v.isEmpty) return 'New password is required';
                if (v.length < 6) return 'Minimum 6 characters';
                return null;
              },
            ),
            const SizedBox(height: 14),
            _InputField(
              controller: _confirmCtrl,
              label: 'Confirm New Password',
              icon: Icons.lock_outline,
              obscureText: _obscureConfirm,
              toggleObscure: () =>
                  setState(() => _obscureConfirm = !_obscureConfirm),
              validator: (v) => v != _newCtrl.text
                  ? 'Passwords do not match'
                  : null,
            ),
            const SizedBox(height: 24),
            _SaveButton(onPressed: _save, isSaving: isSaving),
          ],
        ),
      ),
    );
  }
}

// ─── Shared Sheet Wrapper ─────────────────────────────────────────────────────

class _BottomSheet extends StatelessWidget {
  final String title;
  final Widget child;

  const _BottomSheet({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
                fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }
}

// ─── Shared Input Field ───────────────────────────────────────────────────────

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final VoidCallback? toggleObscure;

  const _InputField({
    required this.controller,
    required this.label,
    required this.icon,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.toggleObscure,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 18, color: Colors.grey.shade500),
        suffixIcon: toggleObscure != null
            ? IconButton(
                onPressed: toggleObscure,
                icon: Icon(
                  obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  size: 18,
                  color: Colors.grey.shade400,
                ),
              )
            : null,
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF4F46E5), width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      ),
    );
  }
}

// ─── Save Button ──────────────────────────────────────────────────────────────

class _SaveButton extends StatelessWidget {
  final Future<void> Function() onPressed;
  final bool isSaving;

  const _SaveButton({required this.onPressed, required this.isSaving});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isSaving ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4F46E5),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: isSaving
            ? const SizedBox(
                height: 18,
                width: 18,
                child: CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 2),
              )
            : const Text('Save Changes',
                style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}