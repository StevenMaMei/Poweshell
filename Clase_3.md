###1) Cree dos archivos de texto similares (con una o dos líneas diferentes). Compárelos empleando diff.
´´´R// Compare-Object -ReferenceObject (Get-Content .\holita.txt) -DifferenceObject (Get-Content .\holita1.txt)´´´
 
2)Qué ocurre si se ejecuta:
	get-service | export-csv servicios.csv | out-file
  Por qué?
  R// Sale error porque el tubo se queda sin salida
  
3) Cómo haría para crear un archivo delimitado por puntos y comas (;)? PISTA: Se emplea export-csv, pero con un parámetro adicional.
  R// Get-Process |Export-Csv -Delimiter ";" holita2
  
4)Export-cliXML y Export-CSV modifican el sistema, porque pueden crear y sobreescribir archivos. Existe algún parámetro que evite la sobreescritura de un archivo existente? Existe algún parámetro que permita que el comando pregunte antes de sobresscribir un archivo?

R// Se utiliza -NoClobber

5) Windows emplea configuraciones regionales, lo que incluye el separador de listas. En Windows en inglés, el separador de listas es la coma (,). Cómo se le dice a Export-CSV que emplee el separador del sistema en lugar de la coma?

R// Get-Process |Export-Csv -UseCulture holita

6) Identifique un cmdlet que permita generar un número aleatorio.
Get-Random

7) Identifique un cmdlet que despliegue la fecha y hora actuales
Get-Date

8) Qué tipo de objeto produce el cmdlet de la pregunta 7?

Un objeto de tipo DateTime

9)Usando el cmdlet de la pregunta 7 y select-object, despliegue solamente el día de la semana, así:

Get-Date | Select-Object DayOfWeek

10) Identifique un cmdlet que muestre información acerca de parches (hotfixes) instalados en el sistema.
Get-HotFix

11)Empleando el cmdlet de la pregunta 10, muestre una lista de parches instalados. Luego extienda la expresión para ordenar la lista por fecha de instalación, y muestre en pantalla únicamente la fecha de instalación, el usuario que instaló el parche, y el ID del parche. Recuerde examinar los nombres de las propiedades.

Get-HotFix | Select-Object InstalledOn, InstalledBy, HotFixId | Sort-Object installedOn

12) Complemente la solución a la pregunta 11, para que el sistema ordene los resultados por la descripción del parche, e incluya en el listado la descripción, el ID del parche, y la fecha de instalación. Escriba los resultados a un archivo HTML.


Get-HotFix | Select-Object Description,InstalledOn, InstalledBy, HotFixId | Sort-Object Description | convertto-html | Out-File res.html

13)Muestre una lista de las 50 entradas más nuevas del log de eventos System. Ordene la lista de modo que las entradas más antiguas aparezcan primero; las entradas producidas al mismo tiempo deben ordenarse por número índice. Muestre el número índice, la hora y la fuente para cada entrada. Escriba esta información en un archivo de texto plano.

Get-EventLog system -Newest 50 | Sort-Object TimeGenerated,index |Select-Object index, TimeGenerated ,source | Out-File salida.txt

