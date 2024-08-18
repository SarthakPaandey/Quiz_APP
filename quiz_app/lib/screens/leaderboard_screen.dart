import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../default_players.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class LeaderboardScreen extends StatefulWidget {
  @override
  _LeaderboardScreenState createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen>
    with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> leaderboardData = [];
  bool isLoading = true;
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _loadLeaderboardData();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
    _colorAnimation = TweenSequence<Color?>(
      [
        TweenSequenceItem(
          weight: 1.0,
          tween: ColorTween(
            begin: Colors.blue,
            end: Colors.purple,
          ),
        ),
        TweenSequenceItem(
          weight: 1.0,
          tween: ColorTween(
            begin: Colors.purple,
            end: Colors.blue,
          ),
        ),
      ],
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadLeaderboardData() async {
    try {
      List<Map<String, dynamic>> apiData = await ApiService().getLeaderboard();
      List<Map<String, dynamic>> combinedData = [
        ...apiData,
        ...defaultPlayers.map((player) => {
              'name': player.name,
              'score': player.score,
              'health': player.health,
            }),
      ];
      combinedData.sort((a, b) => b['score'].compareTo(a['score']));
      setState(() {
        leaderboardData = combinedData;
        isLoading = false;
      });
    } catch (e) {
      print('Error loading leaderboard data: $e');
      setState(() {
        isLoading = false;
        leaderboardData = defaultPlayers
            .map((player) => {
                  'name': player.name,
                  'score': player.score,
                  'health': player.health,
                })
            .toList();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Failed to load online leaderboard. Showing default data.'),
          duration: Duration(seconds: 5),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaderboard 🏆',
            style: TextStyle(fontWeight: FontWeight.bold)),
        flexibleSpace: AnimatedBuilder(
          animation: _colorAnimation,
          builder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    _colorAnimation.value!,
                    _colorAnimation.value!.withOpacity(0.7)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            );
          },
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : AnimationLimiter(
              child: ListView.builder(
                itemCount: leaderboardData.length,
                itemBuilder: (context, index) {
                  final entry = leaderboardData[index];
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(_getRankEmoji(index)),
                            backgroundColor: _getColor(index),
                          ),
                          title: Text(entry['name']),
                          subtitle:
                              Text('❤️ Health: ${entry['health'] ?? 'N/A'}'),
                          trailing: AnimatedBuilder(
                            animation: _colorAnimation,
                            builder: (context, child) {
                              return Text(
                                '🎯 Score: ${entry['score']}',
                                style: TextStyle(
                                  color: index == 0
                                      ? _colorAnimation.value
                                      : Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }

  String _getRankEmoji(int index) {
    switch (index) {
      case 0:
        return '🥇';
      case 1:
        return '🥈';
      case 2:
        return '🥉';
      default:
        return '${index + 1}';
    }
  }

  Color _getColor(int index) {
    switch (index) {
      case 0:
        return Colors.yellow[700]!; // Use a golden shade of yellow
      case 1:
        return Colors.grey[300]!;
      case 2:
        return Colors.brown[300]!;
      default:
        return Colors.blue[100]!;
    }
  }
}
