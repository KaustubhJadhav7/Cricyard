import 'package:flutter/material.dart';

class InviteItemWidget extends StatefulWidget {
  final Map<String, dynamic> inviteItem;
  final Function onAccept;
  final Function onIgnore;

  const InviteItemWidget({
    required this.inviteItem,
    required this.onAccept,
    required this.onIgnore,
    Key? key,
  }) : super(key: key);

  @override
  _InviteItemWidgetState createState() => _InviteItemWidgetState();
}

class _InviteItemWidgetState extends State<InviteItemWidget> {
  bool isAccepted = false;

  void _accept() {
    setState(() {
      isAccepted = true;
    });
    widget.onAccept(widget.inviteItem);
  }

  void _ignore() {
    setState(() {
      isAccepted = false;
    });
    widget.onIgnore(widget.inviteItem);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ref: ${widget.inviteItem['ref']}'),
            const SizedBox(height: 8.0),
            isAccepted
                ? const Text('Accepted', style: TextStyle(color: Colors.green))
                : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: _accept,
                        child: const Text('Accept',
                            style: TextStyle(color: Colors.green)),
                      ),
                      const SizedBox(width: 8.0),
                      ElevatedButton(
                        onPressed: _ignore,
                        child: const Text('Ignore'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}

class InviteListWidget extends StatefulWidget {
  @override
  _InviteListWidgetState createState() => _InviteListWidgetState();
}

class _InviteListWidgetState extends State<InviteListWidget> {
  late Future<List<Map<String, dynamic>>> _futureInvites;
  final List<Map<String, dynamic>> _invites = [];

  @override
  void initState() {
    super.initState();
    _futureInvites = _fetchInvites();
  }

  Future<List<Map<String, dynamic>>> _fetchInvites() async {
    // Simulate an API call
    await Future.delayed(const Duration(seconds: 2));
    return [
      {'ref': 'INV123', 'accepted': false},
      {'ref': 'INV124', 'accepted': false},
      {'ref': 'INV125', 'accepted': true},
    ];
  }

  void _handleAccept(Map<String, dynamic> invite) {
    setState(() {
      invite['accepted'] = true;
    });
  }

  void _handleIgnore(Map<String, dynamic> invite) {
    setState(() {
      invite['accepted'] = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Invites')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _futureInvites,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No invites found'));
          } else {
            _invites.addAll(snapshot.data!);
            return ListView.builder(
              itemCount: _invites.length,
              itemBuilder: (context, index) {
                final invite = _invites[index];
                return InviteItemWidget(
                  inviteItem: invite,
                  onAccept: _handleAccept,
                  onIgnore: _handleIgnore,
                );
              },
            );
          }
        },
      ),
    );
  }
}
