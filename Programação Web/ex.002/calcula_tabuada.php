<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Resultado</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }

        header > h1 {
            text-align: center;
            margin-top: 40px;
            font-size: 2.5em;
            font-weight: bold;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        section {
            background-color: black;
            color: white;
            text-align: center;
            width: 35%;
            margin-top: 70px;
            border: 1px solid #ccc;
            border-radius: 20px;
            padding: 20px 40px;
            margin-left: 30%;
            font-size: 1.2em;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }

        table {
            width: 100%;
            font-size: 1.2em;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .cabecalho_tabuada {
            background-color: #4CAF50;
            color: white;
            font-size: 1.5em;
            font-weight: bold;
            border: 1px solid white;
            border-radius: 8px;
        }


        
    </style>
</head>
<body>
    <header>
        <h1>RESULTADO DA TABUADA:</h1>
    </header>
    <section>
        <table>
            <tr>
                <th colspan="5" class="cabecalho_tabuada">
                    <?php 
                        $num = $_GET['num'];
                        if (isset($num)) {
                            $num = $num;
                        } else {
                            $num = 0; // Valor padrão caso 'num' não esteja definido
                        }
                        echo "Tabuada do N° $num:";
                    ?>
                </th>
            </tr>
                <?php
                    for ($i = 1; $i <= 10; $i++) {
                        $resultado = $num * $i;
                        echo "<tr><td style='font-weight: bold;'>$num</td><td>x</td><td>$i</td><td>=</td><td>$resultado</td></tr>";
                    }      
                ?>
        </table>
    </section>
</body>
</html>