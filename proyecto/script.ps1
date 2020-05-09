$option = read-host "Introduzca la opcion: `n
1. Desplegar los cinco procesos que mas CPU este consumiendo en ese momento.`n
2. Desplegar los filesystems o discos conectados a la maquina. Incluir para cada disco su
tamano y la cantidad de espacio libre (en bytes).`n
3. Desplegar el nombre y el tamano del archivo mas grande almacenado en un disco o
filesystem que el usuario debera especificar. El archivo debe aparecer con su trayectoria
completa.`n
4. Cantidad de memoria libre y cantidad del espacio de swap en uso (en bytes y porcentaje).`n
5. Numero de conexiones de red activas actualmente (en estado ESTABLISHED).`n "

while (true) {
	if($option -eq 1){
		Get-Process | Sort-Object cpu -Descending | Select-Object -first 5;
	}
	elseif($option -eq 2){
		Get-WmiObject -Class Win32_LogicalDisk | Select-Object name,@{n='Tamaño (Bytes)'; e={$_.size}},@{n='Espacio libre (Bytes)'; e={$_.freespace}};
	}
	elseif($option -eq 3){
		$disk = read-host "Indique el disco o filesystem.`n"
		Get-ChildItem -Path $disk | Sort-Object -Property Length -Descending | Select-Object FullName, Length -First 1;
	}
	elseif($option -eq 4){

	}
	elseif($option -eq 5){
		(Get-WmiObject Win32_NetworkAdapter -Filter "netconnectionstatus = 2").Count
	}

}
