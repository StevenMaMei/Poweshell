1) Cree dos archivos de texto similares (con una o dos líneas diferentes). Compárelos empleando diff.
 R// Compare-Object -ReferenceObject (Get-Content .\holita.txt) -DifferenceObject (Get-Content .\holita1.txt)
 
2)Qué ocurre si se ejecuta:
	get-service | export-csv servicios.csv | out-file
  Por qué?
  R// Sale error porque el tubo se queda sin salida
  
3) Cómo haría para crear un archivo delimitado por puntos y comas (;)? PISTA: Se emplea export-csv, pero con un parámetro adicional.
  R// Get-Process |Export-Csv -Delimiter ";" holita2
  
4)Export-cliXML y Export-CSV modifican el sistema, porque pueden crear y sobreescribir archivos. Existe algún parámetro que evite la sobreescritura de un archivo existente? Existe algún parámetro que permita que el comando pregunte antes de sobresscribir un archivo?

R// Se utilizar -NoClobber
