import 'package:flutter/material.dart';
import '../../core/api_client.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<dynamic> _disputes = [];
  Map<String, dynamic> _financeStats = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final apiClient = ApiClient();
      final disputesRes = await apiClient.get('/disputes');
      final financeRes = await apiClient.get('/finance/stats');

      if (mounted) {
        setState(() {
          _disputes = disputesRes.data;
          _financeStats = financeRes.data;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erreur chargement: $e')));
      }
    }
  }

  Future<void> _resolveDispute(int id) async {
    try {
      final apiClient = ApiClient();
      await apiClient.post('/disputes/$id/resolve');
      _fetchData();
      if (mounted) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Litige résolu ! ✅')));
      }
    } catch (e) {
      if (mounted) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erreur résolution: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard 🛡️'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Litiges', icon: Icon(Icons.warning)),
            Tab(text: 'Finance', icon: Icon(Icons.attach_money)),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                // Disputes Tab
                _disputes.isEmpty
                    ? const Center(child: Text('Aucun litige en cours 🎉'))
                    : ListView.builder(
                        itemCount: _disputes.length,
                        itemBuilder: (context, index) {
                          final dispute = _disputes[index];
                          final isResolved = dispute['status'] == 'RESOLVED';
                          return Card(
                            margin: const EdgeInsets.all(8),
                            color: isResolved
                                ? Colors.green[50]
                                : Colors.red[50],
                            child: ListTile(
                              title: Text('Litige #${dispute['id']}'),
                              subtitle: Text(dispute['reason']),
                              trailing: isResolved
                                  ? const Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                    )
                                  : ElevatedButton(
                                      onPressed: () =>
                                          _resolveDispute(dispute['id']),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                      ),
                                      child: const Text('Résoudre'),
                                    ),
                            ),
                          );
                        },
                      ),
                // Finance Tab
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildStatCard(
                        'Volume Total',
                        '${_financeStats['totalVolume'] ?? 0} DA',
                        Colors.blue,
                      ),
                      _buildStatCard(
                        'Commission (10%)',
                        '${_financeStats['platformCommission'] ?? 0} DA',
                        Colors.green,
                      ),
                      _buildStatCard(
                        'Gains Livreurs',
                        '${_financeStats['courierEarnings'] ?? 0} DA',
                        Colors.orange,
                      ),
                      _buildStatCard(
                        'Gains Cuisinières',
                        '${_financeStats['cookEarnings'] ?? 0} DA',
                        Colors.purple,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: const Icon(Icons.attach_money, color: Colors.white),
        ),
        title: Text(title),
        trailing: Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
