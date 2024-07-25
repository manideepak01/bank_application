<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer Details</title>
<link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.15/dist/tailwind.min.css" rel="stylesheet">
<script>
function toggleEdit() {
    var editBtn = document.getElementById('editBtn');
    var saveBtn = document.getElementById('saveBtn');
    var staticFields = document.getElementsByClassName('static-field');
    var editableFields = document.getElementsByClassName('editable-field');

    if (editBtn.style.display !== 'none') {
        // Switch to edit mode
        editBtn.style.display = 'none';
        saveBtn.style.display = 'inline-block';

        // Show editable fields, hide static fields
        for (var i = 0; i < staticFields.length; i++) {
            staticFields[i].style.display = 'none';
        }
        for (var i = 0; i < editableFields.length; i++) {
            editableFields[i].style.display = 'block';
        }
    } else {
        // Switch to view mode
        editBtn.style.display = 'inline-block';
        saveBtn.style.display = 'none';

        // Show static fields, hide editable fields
        for (var i = 0; i < staticFields.length; i++) {
            staticFields[i].style.display = 'block';
        }
        for (var i = 0; i < editableFields.length; i++) {
            editableFields[i].style.display = 'none';
        }
    }
}

// Function to show success or error message popup
function showMessage(message, isSuccess) {
    var className = isSuccess ? 'bg-green-500' : 'bg-red-500';
    var textColor = isSuccess ? 'text-white' : 'text-red-500';
    
    var popup = document.createElement('div');
    popup.className = 'fixed top-0 left-0 right-0 bottom-0 flex items-center justify-center z-50';
    
    var innerHTML = '<div class="bg-white p-8 rounded-lg shadow-lg ' + className + ' ' + textColor + '">' +
                    '<p class="text-xl">' + message + '</p>' +
                    '</div>';
    
    popup.innerHTML = innerHTML;
    document.body.appendChild(popup);
    
    // Remove the popup after 3 seconds
    setTimeout(function() {
        popup.remove();
    }, 3000);
}
</script>
</head>
<body class="bg-gray-100">
<div class="container mx-auto mt-10">
    <div class="bg-white p-8 rounded-lg shadow-lg">
        <h1 class="text-3xl font-bold mb-4 text-center">Customer Details</h1>
        <form action="SearchCustomerServlet" method="get" class="mb-4">
            <label for="accountNo">Enter Account Number:</label>
            <input type="text" id="accountNo" name="accountno" class="px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-blue-500">
            <button type="submit" class="bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-lg cursor-pointer">Search</button>
        </form>
        <c:if test="${not empty accountno}">
            <form action="EditCustomerServlet" method="post" onsubmit="showMessage('Updating customer details...', false)">
                <div class="mb-4"><strong>Account Number:</strong> <span class="static-field">${accountno}</span><input type="hidden" name="accountno" value="${accountno}"></div>
                <div class="mb-4"><strong>First Name:</strong> <span class="static-field">${firstname}</span><input type="text" name="firstname" value="${firstname}" class="editable-field hidden w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-blue-500"></div>
                <div class="mb-4"><strong>Last Name:</strong> <span class="static-field">${lastname}</span><input type="text" name="lastname" value="${lastname}" class="editable-field hidden w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-blue-500"></div>
                <div class="mb-4"><strong>Email:</strong> <span class="static-field">${email}</span><input type="text" name="email" value="${email}" class="editable-field hidden w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-blue-500"></div>
                <div class="mb-4"><strong>Phone Number:</strong> <span class="static-field">${phoneno}</span><input type="text" name="phoneno" value="${phoneno}" class="editable-field hidden w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-blue-500"></div>
                <div class="mb-4"><strong>Address:</strong> <span class="static-field">${address}</span><input type="text" name="address" value="${address}" class="editable-field hidden w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-blue-500"></div>
                <div class="mb-4"><strong>Date of Birth:</strong> <span class="static-field">${dob}</span><input type="date" name="dob" value="${dob}" class="editable-field hidden w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-blue-500"></div>
                <div class="mb-4"><strong>Account Type:</strong>
                    <span class="static-field">${accounttype}</span>
                    <select name="accounttype" class="editable-field hidden w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-blue-500">
                        <option value="Saving" ${accounttype eq 'Saving' ? 'selected' : ''}>Saving</option>
                        <option value="Current" ${accounttype eq 'Current' ? 'selected' : ''}>Current</option>
                    </select>
                </div>
                <div class="mb-4"><strong>ID Proof:</strong> <span class="static-field">${idproof}</span><input type="text" name="idproof" value="${idproof}" class="editable-field hidden w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-blue-500"></div>

                <button id="editBtn" type="button" onclick="toggleEdit()" class="bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-lg cursor-pointer">Edit</button>
                <button id="saveBtn" type="submit" class="bg-green-500 hover:bg-green-600 text-white py-2 px-4 rounded-lg cursor-pointer hidden">Save Changes</button>
            </form>
        </c:if>
        <c:if test="${empty accountno}">
            <p class="text-red-500">${message}</p>
        </c:if>
    </div>
</div>
<script>
    // JavaScript block to handle popup messages
    <c:if test="${not empty successMessage}">
        showMessage("${successMessage}", true);
    </c:if>
    <c:if test="${not empty errorMessage}">
        showMessage("${errorMessage}", false);
    </c:if>
</script>

<!-- Role-based access control -->
<c:if test="${empty sessionScope.admin}">
    <script>
        // Redirect to dashboard or login page if not admin
        window.location.href = 'adminLogin.jsp';
    </script>
</c:if>

</body>
</html>
