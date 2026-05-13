import 'dart:convert';
import 'dart:io';

Future<void> main() async {
  try {
    final url = Uri.parse('https://www.quanthockey.com/shl/seasons/2025-26-shl-players-stats.html');
    final client = HttpClient();
    client.userAgent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36';
    final request = await client.getUrl(url);
    final response = await request.close();
    
    if (response.statusCode != 200) {
      print('Status: \${response.statusCode}');
      return;
    }
    
    final body = await response.transform(utf8.decoder).join();
    print('Length: \${body.length}');
    
    // Quick regex to find player rows if possible
    // Wait, let's just save the html to a file so we can inspect it or parse it properly
    await File('tool/shl_raw.html').writeAsString(body);
    print('Saved to shl_raw.html');
    
  } catch (e) {
    print('Error: \$e');
  }
}
