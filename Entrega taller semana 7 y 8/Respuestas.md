# SEMANA 7
	
  ### 1) Mostrar una tabla de procesos que incluya únicamente los nombres de los procesos, sus IDs, y si están respondiendo a Windows (la propiedad Responding muestra eso). Haga que la tabla tome el mínimo de espacio horizontal, pero no permita que la información se trunque.
	
```Powershell
Get-Process | select name,id,responding | ft -Wrap
```
	
### 2) Muestre una tabla de procesos que incluya los nombres de los procesos y sus IDs. También incluya columnas para uso de memoria virtual y física; exprese dichos valores en megabytes (MB).

```Powershell
Get-Process | ft -Property name, id, @{n='VM (MB)'; e={$_.VM / 1MB -as [int]}}, @{n='PM (MB)' ; e={$_.PM / 1MB -as [int]}}
```
	
### 3) Emplee Get-EventLog para mostrar una lista de los logs de eventos disponibles (revise la ayuda para encontrar el parámetro que le permitirá obtener dicha información). Formatee la salida como una tabla que incluya el nombre de despliegue del log y el período de retención. Los encabezados de columna deben ser NombreLog y Per-Retencion.

```Powershell
Get-EventLog -List | fl -Property @{n='nombreLog'; e={$_.Log}}, @{n='Per-Retencion';e={$_.minimumRetentionDays}}
```
	
### 4) Muestre una lista de servicios, de tal manera que aparezcan agrupados los servicios que están iniciados y los que están detenidos. Los que están iniciados deben aparecer primero.

```Powershell
Get-Service |Sort-Object status | fl -GroupBy status
```
	
### 5) Mostrar una lista a cuatro columnas de todos los directorios que están en el raíz de la unidad C:

```Powershell
ls -Path C:\ -Attributes directory| fw -Column 4
```
	
### 6) Cree una lista formateada de todos los archivos .exe del directorio C:\Windows. Debe mostrarse el nombre, la información de versión, y el tamaño del archivo. La propiedad de tamaño se llama length en Powershell, pero para mayor claridad, la columna se debe llamar Tamaño en su listado.
```Powershell
ls -Path C:\Windows |where -filter {$_.Name -like "*.exe"} | fl -Property name, @{n='tamaño';e={$_.length}}, versionInfo
```

### 7) Importe el módulo NetAdapter (empleando el comando Import-Module NetAdapter). Empleando el cmdlet Get-NetAdapter, muestre una lista de adaptadores no virtuales (adaptadores cuya propiedad Virtual sea falsa. El valor lógico falso es representado por Powershell como $False).
	
```Powershell
 Get-NetAdapter | Where -filter {$_.Virtual -eq $false} |fl
```
	
### 8) Importe el módulo DnsClient. Empleando el cmdlet Get-DnsClientCache, muestre una lista de los registros A y AAAA que estén en el caché. Sugerencia: Si el caché está vacío, visite algunos sitios web para poblarlo.
	
```Powershell
 Get-DnsClientCache | where -filter {$_.Type -eq (28 ) -or $_.Type -eq 1} |fl
```
	
### 9) Genere una lista de todos los archivos .exe del directorio C:\Windows\System32 que tengan más de 5 MB.

```Powershell
ls -Path C:\Windows\System32 | where -filter {$_.Name -like "*exe"} | WHERE -filter {$_.length/1MB -gt 5} |fl
```
	
### 10) Muestre una lista de parches que sean actualizaciones de seguridad.

```Powershell
Get-HotFix | where -filter {$_.description -like "*security*"} |fl
```
	
### 11) Muestre una lista de parches que hayan sido instalados por el usuario Administrador, que sean actualizaciones. Si no tiene ninguno, busque parches instalados por el usuario System. Note que algunos parches no tienen valor en el campo Installed By.
	
```Powershell
 Get-HotFix | where -filter {$_.installedBy -like "*SYSTEM*"} |fl
```
	
### 12) Genere una lista de todos los procesos que estén corriendo con el nombre Conhost o Svchost.
	
```Powershell
 Get-Process | where -filter {$_.Name -eq "Conhost" -or $_.Name -eq "Svchost"} | fl
```
  
# SEMANA 8

### 1) ¿Cuál clase puede emplearse para consultar la dirección IP de un adaptador de red? ¿Posee dicha clase algún método para liberar un préstamo de dirección (lease) DHCP?


R// Sí, la clase **win32_NetworkAdapterconfiguration**. Sin embargo no posee un método para liberar un préstamo de dirección DHCP
	
```
Get-CimInstance win32_networkadapterconfiguration | Select-Object IP -> Así se consultaría la IP de los adaptadores
	
Alternativamente ->  Get-WmiObject  win32_networkadapterconfiguration | Select-Object IP
```


### 2) Despliegue una lista de parches empleando WMI (Microsoft se refiere a los parches con el nombre quick-fix engineering). Es diferente el listado al que produce el cmdlet Get-Hotfix?
	

R//
si se usa  **Get-WmiObject win32_quickfixengineering** todo sería igual a get-hotfix
	
Sin embargo, si se usa **Get-CimInstance win32_quickfixengineering**. En primer instancia, el listado producido por ambos comandos no difiere. Sin embargo, cuando se hace GM, sí hay pequeñas diferencias en cuanto a los métodos y propiedades

### 3)  Empleando WMI, muestre una lista de servicios, que incluya su status actual, su modalidad de inicio, y las cuentas que emplean para hacer login.
	
```Powershell 
Get-WmiObject win32_service | Select-Object status, startmode, systemname
```
	
### 4) Empleando cmdlets de CIM, liste todas las clases del namespace SecurityCenter2, que tengan product como parte del nombre.

```Powershell
Get-CimClass -Namespace root/SecurityCenter2 | where -Filter {$_.CimClassName -like "*product*"}
```
	
### 5) Empleando cmdlets de CIM, y los resultados del ejercicio anterior, muestre los nombres de las aplicaciones antispyware instaladas en el sistema. También puede consultar si hay productos antivirus instalados en el sistema.
	

R// Para mirar los **antispyware** se usa
```Powershell 
Get-CimInstance -Namespace root/SecurityCenter2 -ClassName AntiSpywareProduct | Select-Object displayName 
```
	
Para mirar los **antivirus** se usa
	
```Powershell 
Get-CimInstance -Namespace root/SecurityCenter2 -ClassName AntiVirusProduct | Select-Object displayName 
```

