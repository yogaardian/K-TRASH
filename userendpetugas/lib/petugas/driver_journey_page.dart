import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

const String _backendBaseUrl = 'http://10.53.84.142:3000';

class DriverJourneyPage extends StatefulWidget {
  final int driverId;
  final int orderId;

  const DriverJourneyPage({
    super.key,
    required this.driverId,
    required this.orderId,
  });

  @override
  State<DriverJourneyPage> createState() => _DriverJourneyPageState();
}

class _DriverJourneyPageState extends State<DriverJourneyPage> {
  Timer? _locationTimer;
  Position? _currentPosition;
  String _orderStatus = 'assigned';
  String? _message;
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    _startDriverWorkflow();
  }

  Future<void> _startDriverWorkflow() async {
    await _requestLocationPermission();
    await _updateOrderStatus('on_the_way');
    _startLocationTimer();
  }

  Future<void> _requestLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _message = 'Layanan lokasi tidak aktif. Aktifkan GPS.';
      });
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      setState(() {
        _message = 'Izin lokasi ditolak. Tidak dapat mengirim lokasi.';
      });
    }
  }

  void _startLocationTimer() {
    _locationTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      _sendLocation();
    });
  }

  Future<void> _sendLocation() async {
    if (_isSending) return;
    setState(() {
      _isSending = true;
      _message = null;
    });

    try {
      final position = await Geolocator.getCurrentPosition();
      _currentPosition = position;

      final response = await http.post(
        Uri.parse('$_backendBaseUrl/driver/location'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'driver_id': widget.driverId,
          'order_id': widget.orderId,
          'lat': position.latitude,
          'lng': position.longitude,
        }),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode != 200 || data['status'] == 'fail') {
        setState(() {
          _message = data['message'] ?? 'Gagal mengirim lokasi';
        });
      }
    } catch (e) {
      setState(() {
        _message = 'Error saat mengirim lokasi: $e';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isSending = false;
        });
      }
    }
  }

  Future<void> _updateOrderStatus(String newStatus) async {
    try {
      final response = await http.patch(
        Uri.parse('$_backendBaseUrl/orders/status/${widget.orderId}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'driver_id': widget.driverId, 'status': newStatus}),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['status'] == 'success') {
        setState(() {
          _orderStatus = newStatus;
          _message = 'Status diperbarui: $newStatus';
        });
      } else {
        setState(() {
          _message = data['message'] ?? 'Gagal memperbarui status';
        });
      }
    } catch (e) {
      setState(() {
        _message = 'Error status: $e';
      });
    }
  }

  @override
  void dispose() {
    _locationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perjalanan Driver'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Order: ${widget.orderId}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text('Driver ID: ${widget.driverId}'),
            const SizedBox(height: 12),
            Text(
              'Status order: $_orderStatus',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _currentPosition != null
                ? Text(
                    'Lokasi saat ini: ${_currentPosition!.latitude.toStringAsFixed(5)}, ${_currentPosition!.longitude.toStringAsFixed(5)}',
                  )
                : const Text('Menunggu lokasi GPS...'),
            const SizedBox(height: 8),
            _isSending
                ? const Text(
                    'Mengirim lokasi...',
                    style: TextStyle(color: Colors.blue),
                  )
                : const SizedBox.shrink(),
            const SizedBox(height: 8),
            if (_message != null)
              Text(_message!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed:
                  _orderStatus == 'assigned' || _orderStatus == 'on_the_way'
                  ? () => _updateOrderStatus('arrived')
                  : null,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: const Text('Tandai Tiba di Lokasi'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _orderStatus == 'arrived'
                  ? () => _updateOrderStatus('completed')
                  : null,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('Selesaikan Order'),
            ),
          ],
        ),
      ),
    );
  }
}
