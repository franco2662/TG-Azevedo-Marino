import psycopg2
from .models import *
from django.db.models import Count,Avg
from decimal import *

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
    lista = [{'id_analisis':id}]
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
        lista = sorted(lista, key = lambda x: x['porcentaje'], reverse = True)[:10]
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
        lista = sorted(lista, key = lambda x: x['porcentaje'], reverse = True)[:10]
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
        lista = sorted(lista, key = lambda x: x['porcentaje'], reverse = True)[:10]
    except (Exception, psycopg2.DatabaseError) as error:
        print("Error while connecting to PostgreSQL", error)    
    return lista

def fn_list_bad_all(id):
    lista = [{'id_analisis':id}]
    lista_all = [fn_list_bad_procs(id),fn_list_bad_dirs(id),fn_list_bad_regs(id)]
    lista.append(lista_all)
    return lista

def fn_bad_proc_avg(lista_completa):
    lista = lista_completa[1][0]
    resultado=[]
    for p in lista:
        proc = p['proceso']
        try:
            cursor = ps_connection.cursor()
            cursor.callproc('fn_bad_proc_avg', [proc])
            result = cursor.fetchall()
            for row in result:
                avg = float(format(float(row[2]), ".2f"))       
                fila={'proceso':row[0],'cantidad':row[1],'promedio':avg}
                resultado.append(fila)
        except (Exception, psycopg2.DatabaseError) as error:
            print("Error while connecting to PostgreSQL", error)
    resultado = sorted(resultado, key = lambda x: (x['cantidad'],x['promedio']), reverse = True)[:10]    
    return resultado

def fn_bad_dir_avg(lista_completa):
    lista = lista_completa[1][1]
    resultado=[]
    for d in lista:
        directorio = d['directorio']
        dirs = Directorio.objects.filter(nombre__contains=directorio)
        count = dirs.count()
        avg_value = dirs.aggregate(Avg('porcentaje_no'))['porcentaje_no__avg']
        if avg_value is None:
            avg = float(0.00)
        else:
            avg=float(format(float(Decimal(avg_value)), ".2f"))
        fila={'directorio':directorio,'cantidad':count,'promedio':avg}
        resultado.append(fila)
    resultado = sorted(resultado, key = lambda x: (x['cantidad'],x['promedio']), reverse = True)[:10]
    return resultado
    

def fn_bad_reg_avg(lista_completa):
    lista = lista_completa[1][2]
    resultado=[]
    for r in lista:
        registro = r['registro']
        regs = Registro.objects.filter(nombre__contains=registro)
        count = regs.count()
        avg_value = regs.aggregate(Avg('porcentaje_no'))['porcentaje_no__avg']
        if avg_value is None:
            avg = float(0.00)
        else:
            avg=float(format(float(Decimal(avg_value)), ".2f"))
        fila={'registro':registro,'cantidad':count,'promedio':avg}
        resultado.append(fila)
    resultado = sorted(resultado, key = lambda x: (x['cantidad'],x['promedio']), reverse = True)[:10]
    return resultado

def fn_bad_all_avg(id,lista_completa):
    lista = [{'id_analisis':id}]
    lista_all = [fn_bad_proc_avg(lista_completa),fn_bad_dir_avg(lista_completa),fn_bad_reg_avg(lista_completa)]
    lista.append(lista_all)
    return lista

def get_analisis_by_user(id):    
    sesiones = Sesion.objects.filter(fk_usuario=id).values_list('id', flat=True)
    analisis = Analisis.objects.filter(fk_sesion__in=sesiones).order_by('-id').values()
    listado=[]
    for a in analisis:
        texto = a['nombrepc'] + ' - ' + str(a['fecha'])
        item = {'id_analisis':a['id'],'analisis':texto}
        listado.append(item)
    return listado

def last_analisis_by_user(id):
    sesiones = Sesion.objects.filter(fk_usuario=id).values_list('id', flat=True)
    id_analisis = Analisis.objects.filter(fk_sesion__in=sesiones).latest('id').id    
    return id_analisis    
    
def save_virus_list():
    file = open('tgamapp/ia_tests/ArregladoVirusMalwareLessColumn.csv', 'r', errors='ignore')
    lineas = file.readlines()[1:]
    # registro = {'nombre':'','ruta':'','descripcion':''}
    virus = Virus()
    for line in lineas:
        archivo = line.split(',')
        # registro['descripcion'] = archivo[3]
        # registro['nombre'] = archivo[8]
        # registro['ruta'] = archivo[9]
        virus = Virus()
        virus.nombre = archivo[8]
        virus.ruta = archivo[9]
        virus.descripcion = archivo[3]
        virus.save()

    
