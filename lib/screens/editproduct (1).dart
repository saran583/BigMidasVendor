import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class EditProduct1 extends StatefulWidget {
  static String routeName = "/editproduct1";
  @override
  EditProduct1State createState() => EditProduct1State();
}

class EditProduct1State extends State<EditProduct1> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Center(child: RaisedButton( onPressed: (){_createPDF();}, child: Text("Create a PDF"),),),);
  }

  Future<void> _createPDF() async{
    PdfDocument document= PdfDocument();
    final page = document.pages.add();

    page.graphics.drawString("                    Bigmidas ", PdfStandardFont(PdfFontFamily.helvetica,30));

    PdfGrid grid = PdfGrid();
    grid.style = PdfGridStyle(font: PdfStandardFont(PdfFontFamily.helvetica,15),
                              cellPadding: PdfPaddings(left:10, right: 2, top:5, bottom:5));

    grid.columns.add(count: 4);
    grid.headers.add(1);

    PdfGridRow header = grid.headers[0];
    header.cells[0].value = "S.No"; 
    header.cells[1].value = "Product Name";
    header.cells[2].value = "Quantity";
    header.cells[3].value = "Amount";

    PdfGridRow row = grid.rows.add();
    row.cells[0].value="1";
    row.cells[1].value="Vivo something something something";
    row.cells[2].value="2";
    row.cells[3].value="Rs. 19,500";

    grid.draw(page: page,bounds: const Rect.fromLTWH(0,100,0,0) );






    List<int> bytes = document.save();
    document.dispose();

    final path = (await getExternalStorageDirectory()).path;
    print("this is external storage path $path");
    final file = File("$path/Bill of the orders.pdf");
    await file.writeAsBytes(bytes, flush:true);
    print("doc has been saved $path/Bill of the orders.pdf");

  }
  // Future<void> saveFile(List<int> bytes, String fileName) async {
  //   final path = (await getExternalStorageDirectory()).path;
  //   print("this is external storage path $path");
  //   final file = File("$path/$fileName");
  //   await file.writeAsBytes(bytes, flush:true);
  //   print("doc has been saved $path/$fileName");
  // }
 
}
