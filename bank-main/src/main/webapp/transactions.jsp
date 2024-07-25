<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
    <title>Transactions</title>
    <style>
        table {
            width: 80%;
            border-collapse: collapse;
            margin: 20px auto;
        }
        th, td {
            padding: 8px;
            text-align: left;
            border: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
        }
        .download-btn {
            display: block;
            width: 200px;
            margin: 20px auto;
            padding: 10px;
            background-color: #4CAF50;
            color: white;
            text-align: center;
            border-radius: 5px;
            text-decoration: none;
            cursor: pointer;
        }
    </style>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.20/jspdf.plugin.autotable.min.js"></script>
    <script>
        function downloadPDF() {
            const { jsPDF } = window.jspdf;
            const doc = new jsPDF();
            

            const table = document.querySelector("table");
            const rows = Array.from(table.querySelectorAll("tr"));
            const tableData = rows.map(row => Array.from(row.querySelectorAll("th, td")).map(cell => cell.textContent));

            doc.autoTable({
                head: [tableData[0]],
                body: tableData.slice(1),
            });

            doc.save("transactions.pdf");
        }
    </script>
</head>
<body>
    <h1>Transactions</h1>
    <table>
        <thead>
            <tr>
                <th>Timestamp</th>
                <th>Type</th>
                <th>Amount</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="transaction" items="${transactions}">
                <c:set var="splitTransaction" value="${fn:split(transaction, ',')}" />
                <tr>
                    <td>${splitTransaction[0]}</td>
                    <td>${splitTransaction[1]}</td>
                    <td>${splitTransaction[2]}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <button class="download-btn" onclick="downloadPDF()">Download as PDF</button>
</body>
</html>
