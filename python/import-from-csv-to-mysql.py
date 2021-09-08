import csv
import MySQLdb

bd = "BBDD"
usuario = "USUARIO"
passwd = "CONTRASEÑA"
host = "SERVIDOR"
puerto = "3306"
sql = 'INSERT INTO my_table values (%s, %s, %s, %s, %s)'


def drop_table():
    conn.execute("DROP TABLE IF EXISTS my_table")
    print("TABLA ELIMINADA")


def create_table():
    conn.execute(
        "create table my_table (NOMBRE VARCHAR(20), APPELIDOS VARCHAR(50), DIRECCION VARCHAR(150), CORREO VARCHAR(150), BIOGRAFIA VARCHAR(150))")
    print("TABLA CREADA")


def insert_data_from_csv():
    with open('my_file.csv') as csv_file:
        reader = csv.reader(csv_file, delimiter=';', quotechar='|')

        for row in reader:

            if not row[0]:
                row[0] = "DESCONOCIDO"

            if not row[1]:
                row[1] = "DESCONOCIDO"

            if not row[2]:
                row[2] = "DESCONOCIDO"

            if not row[3]:
                row[3] = "DESCONOCIDO"

            if not row[4]:
                row[4] = "DESCONOCIDO"

            conn.execute(sql, (row[0], row[1], row[2], row[3], row[4]))

    print("TABLA ACTUALIZADA")


try:
    connection = MySQLdb.connect(host=host, user=usuario, passwd=passwd, db=bd)
    conn = connection.cursor()

    drop_table()
    create_table()
    insert_data_from_csv()

except Exception as error:
    print("Error:", error)

finally:
    if connection:
        connection.commit()
        connection.close()
