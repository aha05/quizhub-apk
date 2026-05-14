import 'package:flutter/material.dart';
import 'package:quizhub/features/home/presentation/theme/home_colors.dart';
import 'package:quizhub/features/notifications/domain/entities/app_notification.dart';

class NotificationPanel extends StatefulWidget {
  final LayerLink layerLink;
  final List<AppNotification> notifications;
  final VoidCallback onMarkAllRead;
  final ValueChanged<AppNotification> onMarkRead;
  final VoidCallback onClose;
  final VoidCallback onTapOutside;

  const NotificationPanel({
    super.key,
    required this.layerLink,
    required this.notifications,
    required this.onMarkAllRead,
    required this.onMarkRead,
    required this.onClose,
    required this.onTapOutside,
  });

  @override
  State<NotificationPanel> createState() => _NotificationPanelState();
}

class _NotificationPanelState extends State<NotificationPanel>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..forward();
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: widget.onTapOutside,
            behavior: HitTestBehavior.translucent,
            child: const SizedBox.expand(),
          ),
        ),
        CompositedTransformFollower(
          link: widget.layerLink,
          showWhenUnlinked: false,
          offset: const Offset(-260, 46),
          child: FadeTransition(
            opacity: _anim,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.92, end: 1.0).animate(_anim),
              alignment: Alignment.topRight,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 300,
                  decoration: BoxDecoration(
                    color: HomeColors.surface,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                    ],
                    border: Border.all(color: HomeColors.border, width: 1),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 14, 8, 10),
                        child: Row(
                          children: [
                            const Text(
                              'Notifications',
                              style: TextStyle(
                                color: HomeColors.textDark,
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                              ),
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: widget.onMarkAllRead,
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: const Text(
                                'Mark all read',
                                style: TextStyle(
                                  color: HomeColors.primary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: widget.onClose,
                              icon: const Icon(
                                Icons.close_rounded,
                                size: 18,
                                color: HomeColors.textLight,
                              ),
                              padding: const EdgeInsets.all(4),
                              constraints: const BoxConstraints(),
                            ),
                            const SizedBox(width: 4),
                          ],
                        ),
                      ),
                      const Divider(color: HomeColors.border, height: 1),
                      ...widget.notifications.map(
                        (n) => _NotifItem(
                          notif: n,
                          onMarkRead: () => widget.onMarkRead(n),
                        ),
                      ),
                      const Divider(color: HomeColors.border, height: 1),
                      TextButton(
                        onPressed: widget.onClose,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            'View all notifications',
                            style: TextStyle(
                              color: HomeColors.primary,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _NotifItem extends StatelessWidget {
  final AppNotification notif;
  final VoidCallback onMarkRead;
  const _NotifItem({required this.notif, required this.onMarkRead});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: notif.isRead
          ? Colors.transparent
          : HomeColors.primary.withOpacity(0.04),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 11, 14, 11),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: HomeColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(notif.icon, color: HomeColors.primary, size: 18),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notif.title,
                    style: TextStyle(
                      color: HomeColors.textDark,
                      fontSize: 13,
                      fontWeight: notif.isRead
                          ? FontWeight.w600
                          : FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    notif.subtitle,
                    style: const TextStyle(
                      color: HomeColors.textMid,
                      fontSize: 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    notif.time,
                    style: const TextStyle(
                      color: HomeColors.textLight,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            if (!notif.isRead) ...[
              const SizedBox(width: 8),
              GestureDetector(
                onTap: onMarkRead,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: HomeColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
