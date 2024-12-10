<?php
try {
    $connect = mysqli_connect(
        'db', // Hostname (Docker service name)
        'myuser', // Username
        'mypassword', // Password
        'my_database' // Database name
    );
    
    $table_name = "user";
    
    $query = "SELECT * FROM $table_name";
    $response = mysqli_query($connect, $query);
    
} catch(Exception $e) {
    echo "Error: " . $e->getMessage();
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Data</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">

    <!-- Navbar -->
    <nav class="bg-blue-600 p-4">
        <div class="max-w-7xl mx-auto flex justify-between items-center text-white">
            <a href="#" class="text-lg font-bold">MyApp</a>
            <div>
                <a href="#" class="px-4 py-2 hover:bg-blue-500 rounded">Home</a>
                <a href="#about" class="px-4 py-2 hover:bg-blue-500 rounded">About</a>
            </div>
        </div>
    </nav>

    <!-- Table -->
    <div class="max-w-7xl mx-auto mt-8 px-4">
        <h1 class="text-2xl font-bold text-gray-900 mb-4">User Data</h1>
        <table class="min-w-full bg-white border border-gray-300 rounded-lg shadow-md">
            <thead>
                <tr class="bg-blue-100 text-gray-700">
                    <th class="px-6 py-3 border-b">Title</th>
                    <th class="px-6 py-3 border-b">Body</th>
                    <th class="px-6 py-3 border-b">Date Created</th>
                </tr>
            </thead>
            <tbody>
                <?php while($i = mysqli_fetch_assoc($response)): ?>
                    <tr class="text-gray-700">
                        <td class="px-6 py-3 border-b"><?= htmlspecialchars($i['title']); ?></td>
                        <td class="px-6 py-3 border-b"><?= htmlspecialchars($i['body']); ?></td>
                        <td class="px-6 py-3 border-b"><?= htmlspecialchars($i['date_created']); ?></td>
                    </tr>
                <?php endwhile; ?>
            </tbody>
        </table>
    </div>

    <!-- Footer -->
    <footer class="bg-blue-600 text-white text-center py-4 mt-8">
        <p>&copy; 2024 MyApp. All rights reserved.</p>
    </footer>

</body>
</html>
