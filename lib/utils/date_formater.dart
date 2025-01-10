import 'package:intl/intl.dart';

String formatDateTime(String? inputDate) {
  try {
    // Розпізнавання вхідного формату
    DateTime parsedDate = DateTime.parse(inputDate ?? '');
    
    // Форматування в новий формат
    String formattedDate = DateFormat("E MM/dd/yyyy hh:mm a 'EST'")
        .format(parsedDate.toLocal());
    
    return formattedDate;
  } catch (e) {
    // Обробка помилок при некоректному форматі дати
    return 'ASAP';
  }
}