<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.15/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 flex items-center justify-center h-screen">
    <div class="bg-white p-8 rounded-lg shadow-lg w-full max-w-md">
        <h1 class="text-3xl font-bold mb-6 text-center">Admin Login</h1>
        <form action="AdminServlet" method="post" class="space-y-4">
            <div>
                <label for="username" class="block text-gray-700">Username:</label>
                <input type="text" id="username" name="username" required class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-blue-500">
            </div>
            <div>
                <label for="password" class="block text-gray-700">Password:</label>
                <input type="password" id="password" name="password" required class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-blue-500">
            </div>
            <div class="flex justify-center">
                <input type="submit" value="Login" class="bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-lg cursor-pointer">
            </div>
        </form>
    </div>
</body>
</html>
