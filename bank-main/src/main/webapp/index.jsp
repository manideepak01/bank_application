<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome Page</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.15/dist/tailwind.min.css" rel="stylesheet">
    <style>
        .slider {
            display: flex;
            overflow: hidden;
            width: 100%;
            height: 300px;
            position: relative;
        }
        .slider img {
            min-width: 100%;
            transition: transform 1s ease-in-out;
        }
        .slider-buttons {
            position: absolute;
            top: 50%;
            width: 100%;
            display: flex;
            justify-content: space-between;
            transform: translateY(-50%);
        }
        .slider-button {
            background-color: rgba(0, 0, 0, 0.5);
            color: white;
            border: none;
            padding: 10px;
            cursor: pointer;
        }
    </style>
</head>
<body class="bg-gray-100 flex flex-col items-center justify-center h-screen">
    <div class="bg-white p-8 rounded-lg shadow-lg text-center">
        <h1 class="text-4xl font-bold mb-4">Welcome!</h1>
        <p class="text-lg mb-8">Please select your role to login:</p>
        <ul class="space-y-4">
            <li><a href="customerLogin.jsp" class="block bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-lg">Customer Login</a></li>
            <li><a href="adminLogin.jsp" class="block bg-green-500 hover:bg-green-600 text-white py-2 px-4 rounded-lg">Admin Login</a></li>
        </ul>
    </div>

   

   
</body>
</html>
