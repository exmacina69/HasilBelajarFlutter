import 'package:flutter/material.dart';

class OrderStatusPage extends StatelessWidget {
  final String orderId;

  OrderStatusPage()
      : orderId = DateTime.now().millisecondsSinceEpoch.toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 248, 107, 20),
        title: Text('Status Pengajuan'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(
                strokeWidth: 8,
                backgroundColor: Colors.black,
                valueColor: AlwaysStoppedAnimation<Color>(
                    Color.fromARGB(255, 248, 107, 20)),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(height: 20),
                  Text('ID Pengajuan: $orderId',
                      style: TextStyle(fontSize: 24),
                      textAlign: TextAlign.center),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Status: Diproses Oleh Perusahaan Terkait',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Tambahkan logika untuk tombol kembali ke halaman sebelumnya
                  Navigator.pop(context);
                },
                child: Text('Kembali'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 248, 107, 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
