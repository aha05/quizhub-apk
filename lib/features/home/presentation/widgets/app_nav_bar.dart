import 'package:flutter/material.dart';
import 'package:quizhub/features/home/domain/entities/user_activity.dart';
import 'package:quizhub/features/home/presentation/theme/home_colors.dart';
import 'package:quizhub/features/notifications/domain/entities/app_notification.dart';
import 'package:quizhub/features/home/presentation/widgets/nav_icon_btn.dart';
import 'package:quizhub/features/notifications/presentation/screens/notification_panel.dart';
import 'package:quizhub/features/home/presentation/widgets/search_bar_widget.dart';
import 'package:quizhub/features/home/presentation/widgets/search_dropdown.dart';
import 'package:quizhub/features/home/presentation/widgets/temp-data/category.dart';
import 'package:quizhub/features/home/presentation/widgets/temp-data/home_data.dart';

class AppNavBar extends StatefulWidget implements PreferredSizeWidget {
  const AppNavBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(128);

  @override
  State<AppNavBar> createState() => _AppNavBarState();
}

class _AppNavBarState extends State<AppNavBar> with TickerProviderStateMixin {
  bool _searchActive = false;
  late AnimationController _fadeController;
  late AnimationController _pulseController;
  late Animation<double> _fadeAnim;
  late Animation<double> _pulseAnim;

  final homeData = dummyHomeData;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _fadeAnim = CurvedAnimation(parent: _fadeController, curve: Curves.easeOut);
    _pulseAnim = Tween<double>(begin: 0.97, end: 1.03).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  final LayerLink _notifLayerLink = LayerLink();
  OverlayEntry? _notifOverlay;
  bool _notifOpen = false;

  void _toggleNotifPanel() =>
      _notifOpen ? _closeNotifPanel() : _openNotifPanel();

  void _openNotifPanel() {
    _notifOpen = true;
    _notifOverlay = OverlayEntry(
      builder: (_) => NotificationPanel(
        layerLink: _notifLayerLink,
        notifications: _notifications,
        onMarkAllRead: () {
          setState(() {
            for (final n in _notifications) n.isRead = true;
          });
          _closeNotifPanel();
        },
        onMarkRead: (n) {
          setState(() => n.isRead = true);
          _closeNotifPanel();
        },
        onClose: _closeNotifPanel,
        onTapOutside: _closeNotifPanel,
      ),
    );
    Overlay.of(context).insert(_notifOverlay!);
    setState(() {});
  }

  void _closeNotifPanel() {
    _notifOverlay?.remove();
    _notifOverlay = null;
    if (mounted) setState(() => _notifOpen = false);
  }

  int get _unreadCount => _notifications.where((n) => !n.isRead).length;
  final LayerLink _searchLayerLink = LayerLink();
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  OverlayEntry? _searchOverlay;

  List<Category> get _searchResults {
    if (_searchQuery.trim().isEmpty) return [];
    return homeData.categories
        .where((c) => c.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  void _openSearchOverlay() {
    _closeSearchOverlay();
    _searchOverlay = OverlayEntry(
      builder: (_) => SearchDropdown(
        results: _searchResults,
        onDismiss: _dismissSearch,
        searchQuery: _searchQuery,
        searchLayerLink: _searchLayerLink,
      ),
    );
    Overlay.of(context).insert(_searchOverlay!);
  }

  void _closeSearchOverlay() {
    _searchOverlay?.remove();
    _searchOverlay = null;
  }

  void _refreshSearchOverlay() {
    if (_searchOverlay != null) {
      _searchOverlay!.markNeedsBuild();
    }
  }

  void _onSearchChanged(String v) {
    setState(() => _searchQuery = v);
    if (v.trim().isEmpty) {
      _closeSearchOverlay();
    } else {
      _openSearchOverlay();
      _refreshSearchOverlay();
    }
  }

  void _dismissSearch() {
    _closeSearchOverlay();
    setState(() {
      _searchActive = false;
      _searchQuery = '';
      _searchController.clear();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _pulseController.dispose();
    _searchController.dispose();
    _closeSearchOverlay();
    _closeNotifPanel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: HomeColors.surface,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 64,
            decoration: const BoxDecoration(
              color: HomeColors.surface,
              border: Border(
                bottom: BorderSide(color: HomeColors.border, width: 1),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  icon: const Icon(
                    Icons.menu_rounded,
                    color: HomeColors.textDark,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 7),
                const Text(
                  'QuizHub',
                  style: TextStyle(
                    color: HomeColors.textDark,
                    fontSize: 21,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                  ),
                ),
                const Spacer(),
                // Search toggle
                NavIconBtn(
                  icon: _searchActive
                      ? Icons.close_rounded
                      : Icons.search_rounded,
                  active: _searchActive,
                  onTap: () {
                    if (_searchActive) {
                      _dismissSearch();
                    } else {
                      setState(() => _searchActive = true);
                    }
                  },
                ),
                const SizedBox(width: 4),
                CompositedTransformTarget(
                  link: _notifLayerLink,
                  child: NavIconBtn(
                    icon: Icons.notifications_outlined,
                    badge: _unreadCount > 0 ? _unreadCount : null,
                    active: _notifOpen,
                    onTap: _toggleNotifPanel,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  margin: const EdgeInsets.only(right: 6),
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [HomeColors.accent, HomeColors.primary],
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'AR',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Inline search bar (anchored, no sliver gap)
          if (_searchActive)
            CompositedTransformTarget(
              link: _searchLayerLink,
              child: Container(
                color: HomeColors.surface,
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                child: SearchBarWidget(
                  controller: _searchController,
                  query: _searchQuery,
                  onClear: _searchController.clear,
                  onChanged: _onSearchChanged,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

final List<AppNotification> _notifications = [
  AppNotification(
    title: 'New Quiz Available',
    subtitle: 'A new Science quiz has been added!',
    time: '2m ago',
    icon: Icons.quiz_rounded,
  ),
  AppNotification(
    title: "You're on a streak!",
    subtitle: '5 days in a row. Keep it up 🔥',
    time: '1h ago',
    icon: Icons.local_fire_department_rounded,
  ),
  AppNotification(
    title: 'Leaderboard Update',
    subtitle: 'You moved up to #7 globally!',
    time: '3h ago',
    icon: Icons.leaderboard_rounded,
  ),
  AppNotification(
    title: 'Badge Earned',
    subtitle: 'You earned the Speed Demon badge ⚡',
    time: 'Yesterday',
    icon: Icons.military_tech_rounded,
  ),
];

final dummyHomeData = HomeData(
  userActivity: const UserActivity(
    name: 'Alex Rivera',
    level: 'Knowledge Seeker',
    totalQuizzes: 48,
    completed: 35,
    badges: [
      '🔥 Streak Master',
      '⚡ Speed Demon',
      '🎯 Sharpshooter',
      '🏆 Top 10',
    ],
    highestScorePercentage: 96.5,
    leaderboard: 7,
    averageScore: 78.4,
  ),
  categories: const [
    Category(
      name: 'Science',
      icon: '🔬',
      questions: 120,
      color: Color(0xFF6C63FF),
    ),
    Category(
      name: 'History',
      icon: '🏛️',
      questions: 85,
      color: Color(0xFFFF6584),
    ),
    Category(name: 'Tech', icon: '💻', questions: 95, color: Color(0xFF2ECC71)),
    Category(
      name: 'Geography',
      icon: '🌍',
      questions: 70,
      color: Color(0xFFFA8231),
    ),
    Category(
      name: 'Sports',
      icon: '⚽',
      questions: 60,
      color: Color(0xFF4FACFE),
    ),
    Category(name: 'Art', icon: '🎨', questions: 55, color: Color(0xFFD63CE8)),
  ],
);
