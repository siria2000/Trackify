<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Music Data Table</title>
    <link rel="stylesheet" type="text/css" href="Styles/table.css">
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .card {
            padding: 20px;
            margin: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .table-title {
            margin-bottom: 20px;
        }
        .button-container {
            margin-bottom: 20px;
        }
        .button-container span {
            margin-right: 10px;
        }
        .button-container button {
            margin-right: 10px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        table, th, td {
            border: 1px solid #ccc;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        .pagination {
            margin-top: 20px;
        }
        .pagination label {
            margin-right: 5px;
            cursor: pointer;
        }
        .pagination .disabled {
            cursor: not-allowed;
            color: grey;
        }
        .pagination .active {
            font-weight: bold;
        }
        input[type="radio"].table-radio {
            display: none;
        }
        input[type="radio"].table-radio:not(:checked) ~ .table-display,
        input[type="radio"].table-radio:not(:checked) ~ table,
        input[type="radio"].table-radio:not(:checked) ~ .pagination {
            display: none;
        }
    </style>
</head>
<body>

<div class="card">
    <div class="table-title">
        <h2>Music Data Table</h2>
    </div>
    <div class="button-container">
        <a href="insertData.jsp"><button class="primary" title="Add New Data"></button></a>
        <button class="danger" title="Delete Selected"></button>
    </div>
    <div class="table-concept">
        <!-- Table display -->
        <table id="music-table">
            <thead>
            <tr>
                <th>Select</th>
                <th>_id</th>
                <th>track_name</th>
                <th>artist_name</th>
                <th>streams</th>
                <th>acousticness</th>
                <th>danceability</th>
                <th>energy</th>
                <th>instrumentalness</th>
                <th>liveness</th>
                <th>speechiness</th>
                <th>valence</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody id="table-body">
            <!-- Sample data rows -->
            <!-- Data rows will be dynamically inserted here -->
            </tbody>
        </table>
        <div class="pagination">
            <button id="prev-page" class="freccSX" onclick="prevPage()"> < </button>
            <span id="page-info">Pagina 1 di 5</span>
            <button id="next-page" class="freccDX" onclick="nextPage()"> > </button>
        </div>
    </div>
</div>


<script>
    document.querySelector('.danger').addEventListener('click', function() {
        alert('Delete selected functionality to be implemented.');
    });
    document.querySelectorAll('.edit').forEach(button => {
        button.addEventListener('click', function() {
            alert('Edit functionality to be implemented.');
        });
    });
    document.querySelectorAll('.delete').forEach(button => {
        button.addEventListener('click', function() {
            alert('Delete functionality to be implemented.');
        });
    });
</script>

<script>
    const data = [{}];

    let currentPage = 1;
    const itemsPerPage = 20;

    function displayTablePage(page) {
        const tableBody = document.getElementById('table-body');
        tableBody.innerHTML = '';

        const startIndex = (page - 1) * itemsPerPage;
        const endIndex = startIndex + itemsPerPage;
        const pageData = data.slice(startIndex, endIndex);

        pageData.forEach(item => {
            const row = document.createElement('tr');
            row.innerHTML = `
                <td><input type="checkbox"></td>
                <td>${item.id}</td>
                <td>${item.track_name}</td>
                <td>${item.artist_name}</td>
                <td>${item.streams}</td>
                <td>${item.acousticness}</td>
                <td>${item.danceability}</td>
                <td>${item.energy}</td>
                <td>${item.instrumentalness}</td>
                <td>${item.liveness}</td>
                <td>${item.speechiness}</td>
                <td>${item.valence}</td>
                <td>
                    <a href = "update.jsp"><button class="edit" title="Edit">Edit</button></a>
                </td>
            `;
            tableBody.appendChild(row);
        });

        document.getElementById('page-info').innerText = `Pagina ${page} di ${Math.ceil(data.length / itemsPerPage)}`;
    }

    function prevPage() {
        if (currentPage > 1) {
            currentPage--;
            displayTablePage(currentPage);
        }
    }

    function nextPage() {
        if (currentPage < Math.ceil(data.length / itemsPerPage)) {
            currentPage++;
            displayTablePage(currentPage);
        }
    }

    // Visualizza la prima pagina al caricamento
    displayTablePage(currentPage);
</script>


</body>
</html>
