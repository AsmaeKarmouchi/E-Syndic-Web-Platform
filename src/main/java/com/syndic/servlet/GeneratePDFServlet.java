package com.syndic.servlet;

import com.itextpdf.io.image.ImageDataFactory;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.borders.Border;
import com.itextpdf.layout.element.Image;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.element.Table;
import com.itextpdf.layout.properties.TextAlignment;
import com.itextpdf.layout.properties.UnitValue;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.awt.*;
import java.io.IOException;
import java.io.OutputStream;
import com.itextpdf.layout.element.Cell;
import com.itextpdf.kernel.colors.ColorConstants;
import com.itextpdf.kernel.colors.DeviceRgb;
import com.itextpdf.layout.Style;
import com.itextpdf.layout.properties.HorizontalAlignment;

public class GeneratePDFServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final String PDF_FILENAME = "generated.pdf";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("generatePDF.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=" + PDF_FILENAME);

        try (OutputStream outputStream = response.getOutputStream();
             PdfWriter pdfWriter = new PdfWriter(outputStream);
             PdfDocument pdfDocument = new PdfDocument(pdfWriter);
             Document document = new Document(pdfDocument)) {

            // Adding header table
            Table headerTable = new Table(UnitValue.createPercentArray(new float[]{1, 2}));
            headerTable.setWidth(UnitValue.createPercentValue(100));
            headerTable.addCell(createCell("Invoice No", true));
            headerTable.addCell(createCell("XE1234", false));
            headerTable.addCell(createCell("Invoice Date", true));
            headerTable.addCell(createCell("13-Mar-2016", false));
            document.add(headerTable);

            // Adding Bill To section
            document.add(new Paragraph("Bill To"));
            document.add(new Paragraph("Mr.Venkateswara Rao\n9652886877\nKuchipudi,Movva"));

            // Adding bill table
            Table billTable = new Table(UnitValue.createPercentArray(new float[]{1, 2, 5, 2, 1, 2}));
            billTable.setWidth(UnitValue.createPercentValue(100));
            billTable.addCell(createCell("Index", true));
            billTable.addCell(createCell("Item", true));
            billTable.addCell(createCell("Description", true));
            billTable.addCell(createCell("Unit Price", true));
            billTable.addCell(createCell("Qty", true));
            billTable.addCell(createCell("Amount", true));
            billTable.addCell(createCell("1", false));
            billTable.addCell(createCell("Product A", false));
            billTable.addCell(createCell("Description of Product A", false));
            billTable.addCell(createCell("$100", false));
            billTable.addCell(createCell("2", false));
            billTable.addCell(createCell("$200", false));
            document.add(billTable);

            // Adding footer
            Paragraph footer = new Paragraph("Goods once sold will not be taken back or exchanged || Subject to product justification || Product damage no one responsible || Service only at concerned authorized service centers");
            footer.setFontSize(8);
            document.add(footer);

            // Adding syndic signature
            Paragraph syndicSignature = new Paragraph("Syndic signature");
            syndicSignature.setTextAlignment(TextAlignment.RIGHT);
            document.add(syndicSignature);


// Creating a table
            float [] pointColumnWidths = {200F, 200F};
            Table table = new Table(pointColumnWidths);

            // Populating row 1 and adding it to the table
            Cell c1 = new Cell();                        // Creating cell 1
            c1.add(new Paragraph("Name"));                              // Adding name to cell 1
            c1.setBackgroundColor(ColorConstants.DARK_GRAY);      // Setting background color
            c1.setBorder(Border.NO_BORDER);              // Setting border
            c1.setTextAlignment(TextAlignment.CENTER);   // Setting text alignment
            table.addCell(c1);                           // Adding cell 1 to the table

            Cell c2 = new
                    Cell();
            c2.add(new Paragraph("Raju"));
            c2.setBackgroundColor(ColorConstants.GRAY);
            c2.setBorder(Border.NO_BORDER);
            c2.setTextAlignment(TextAlignment.CENTER);
            table.addCell(c2);

            // Populating row 2 and adding it to the table
            Cell c3 = new Cell();
            c3.add(new Paragraph("Id"));
            c3.setBackgroundColor(ColorConstants.WHITE);
            c3.setBorder(Border.NO_BORDER);
            c3.setTextAlignment(TextAlignment.CENTER);
            table.addCell(c3);

            Cell c4 = new Cell();
            c4.add(new Paragraph("001"));
            c4.setBackgroundColor(ColorConstants.WHITE);
            c4.setBorder(Border.NO_BORDER);
            c4.setTextAlignment(TextAlignment.CENTER);
            table.addCell(c4);

            // Populating row 3 and adding it to the table
            Cell c5 = new Cell();
            c5.add(new Paragraph("Designation"));
            c5.setBackgroundColor(ColorConstants.DARK_GRAY);
            c5.setBorder(Border.NO_BORDER);
            c5.setTextAlignment(TextAlignment.CENTER);
            table.addCell(c5);

            Cell c6 = new Cell();
            c6.add(new Paragraph("Programmer"));
            c6.setBackgroundColor(ColorConstants.GRAY);
            c6.setBorder(Border.NO_BORDER);
            c6.setTextAlignment(TextAlignment.CENTER);
            table.addCell(c6);

            // Adding Table to document
            document.add(table);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error generating PDF.");
        }
    }

    private Cell createCell(String text, boolean isHeader) {
        Cell cell = new Cell();
        Paragraph paragraph = new Paragraph(text);
        Style style = new Style();
        if (isHeader) {
            style.setBackgroundColor(new DeviceRgb(230, 230, 230));
            style.setFontColor(ColorConstants.BLACK);
            style.setFontSize(12);
            style.setBold();
            style.setHorizontalAlignment(HorizontalAlignment.CENTER);
        } else {
            style.setFontSize(10);
            style.setHorizontalAlignment(HorizontalAlignment.LEFT);
        }
        cell.addStyle(style);
        cell.add(paragraph);
        return cell;
    }
}
