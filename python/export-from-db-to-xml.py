import MySQLdb
import time
import os

# Datos de conexion a la BBDD
bd = "BBDD"
usuario = "USUARIO"
passwd = "CONTRASEÑA"
host = "SERVIDOR"
puerto = "3306"

# Exportar datos a fichero en formato xml
cabecera = '<?xml version="1.0" encoding="UTF-8"?>'
project_init = '<project>'
project_end = '</project>'
salto = "\n"

# Crear fichero de backup de los nodos
nodos_backup = "nodos_"+time.strftime("%Y%m%d")+".xml"

# Backup del listado en formato texto
os.system('mv /ruta/fichero/listado /ruta/fichero/historico/listado_'+time.strftime("%Y%m%d"))

# Backup del fichero formato xml
os.system('mv /ruta/fichero/listado.xml /ruta/fichero/historico/listado'+time.strftime("%Y%m%d")+'.xml')

# Query para cruzar datos
query = """select plataforma,correo_reg from BBDD.redes_sociales where nombre = %s"""

try:
        # Establece la cadena de conexion
        conexion1 = MySQLdb.connect(host = host, user = usuario, passwd = passwd, db = bd)

        conexion2 = MySQLdb.connect(host = host, user = usuario, passwd = passwd, db = bd)

        # Cursor para la tabla personas
        personas = conexion1.cursor()
        # Cursor para la tabla redes_sociales
        redes_info = conexion2.cursor()

        #Creacion del fichero XML de los nodos
        fichero_nodos = "/ruta/fichero/listado.xml"
        nodos = open(fichero_nodos,"w")
        nodos.write(cabecera)
        nodos.write(salto)
        nodos.write(project_init)
        nodos.write(salto)
        nodos.close()

        personas.execute ("select * from BBDD.personas where CORREO like '%hotmail%' ")

        for persona in listado.fetchall():
                NOMBRE = persona[0]
                APELLIDOS = persona[1]
                DIRECCION = persona[2]
                CORREO = persona[3]
                BIOGRAFIA = persona[4]
                #Se extraen los datos del persona de otra tabla
                redes_info.execute (query, (NOMBRE,))
                datos = redes_info.fetchone()
                PLATAFORMA = datos[0]
                CORREO_REG = datos[1]

                newline = "<node name=""'"+NOMBRE+"'"" email=""'"+CORREO+"'""  />"
                nodos = open(fichero_nodos,"a")
                nodos.write(newline)
                nodos.write(salto)

                inventario = open ("/ruta/fichero/listado","a")

                # Se crea fichero de inventario de ansible
                if (NOMBRE != "persona-123"):
                        elemento = NOMBRE+" CORREO='"+CORREO+"' PLATAFORMA='"+PLATAFORMA+"'"
                        inventario.write(elemento)
                        inventario.write(salto)

except Exception as error:
        print ("Error en la conexion:", error)

finally:
        if conexion1:
                conexion1.close()
        if conexion2:
                conexion2.close()
        # Se termina de cerrar el fichero XML 
        nodos.write(project_end)
        nodos.close()
        inventario.close()
