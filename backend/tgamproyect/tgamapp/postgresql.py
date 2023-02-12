import psycopg2

ps_connection = psycopg2.connect(user="postgres",
                                     password="admin",
                                     host="localhost",
                                     database="TGAM")

def fn_count_procs(id):
    lista = []
    try:
        cursor = ps_connection.cursor()
        cursor.callproc('fn_count_procs', [id])
        result = cursor.fetchall()
        for row in result:            
            # print("No Deseados", row[0], )
            # print("Prob No Deseados", row[1])
            lista={'categoria':'procesos','No Deseados':row[0],'Prob No Deseados':row[1]}
    except (Exception, psycopg2.DatabaseError) as error:
        print("Error while connecting to PostgreSQL", error)    
    return lista

def fn_count_dirs(id):
    lista = []
    try:
        cursor = ps_connection.cursor()
        cursor.callproc('fn_count_dirs', [id])
        result = cursor.fetchall()
        for row in result:            
            # print("No Deseados", row[0], )
            # print("Prob No Deseados", row[1])
            lista={'categoria':'directorios','No Deseados':row[0],'Prob No Deseados':row[1]}
    except (Exception, psycopg2.DatabaseError) as error:
        print("Error while connecting to PostgreSQL", error)    
    return lista


def fn_count_regs(id):
    lista = []
    try:
        cursor = ps_connection.cursor()
        cursor.callproc('fn_count_regs', [id])
        result = cursor.fetchall()
        for row in result:            
            # print("No Deseados", row[0], )
            # print("Prob No Deseados", row[1])
            lista={'categoria':'registros','No Deseados':row[0],'Prob No Deseados':row[1]}
    except (Exception, psycopg2.DatabaseError) as error:
        print("Error while connecting to PostgreSQL", error)    
    return lista

def fn_count_all(id):
    lista = [{'id_session':id}]
    lista_all = [fn_count_procs(id),fn_count_dirs(id),fn_count_regs(id)]
    lista.append(lista_all)
    return lista

def fn_list_bad_procs(id):
    lista = []
    try:
        cursor = ps_connection.cursor()
        cursor.callproc('fn_list_bad_procs', [id])
        result = cursor.fetchall()
        for row in result:          
            fila={'proceso':row[0],'id_tipo':row[1],'porcentaje':row[2]}
            lista.append(fila)
    except (Exception, psycopg2.DatabaseError) as error:
        print("Error while connecting to PostgreSQL", error)    
    return lista

def fn_list_bad_dirs(id):
    lista = []
    try:
        cursor = ps_connection.cursor()
        cursor.callproc('fn_list_bad_dirs', [id])
        result = cursor.fetchall()
        for row in result:          
            fila={'directorio':row[0],'id_tipo':row[1],'porcentaje':row[2]}
            lista.append(fila)
    except (Exception, psycopg2.DatabaseError) as error:
        print("Error while connecting to PostgreSQL", error)    
    return lista

def fn_list_bad_regs(id):
    lista = []
    try:
        cursor = ps_connection.cursor()
        cursor.callproc('fn_list_bad_regs', [id])
        result = cursor.fetchall()
        for row in result:          
            fila={'registro':row[0],'id_tipo':row[1],'porcentaje':row[2]}
            lista.append(fila)
    except (Exception, psycopg2.DatabaseError) as error:
        print("Error while connecting to PostgreSQL", error)    
    return lista