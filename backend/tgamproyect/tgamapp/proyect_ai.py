import sys
import pandas as pd
import numpy as np
import tensorflow as tf
import keras
import os
import io
import json
from .models import *
from datetime import datetime

def test_procesos():
  # print(os.path.exists("ia_models\model_procesos"))
  # print(os.listdir())
  model = tf.keras.models.load_model('ia_models\\model_procesos')
  # model.summary()

  data = pd.read_csv('ia_tests\\ProcesosTest.txt', on_bad_lines='skip')

  tipos_num=["float64","int64"]

  for column in data:
    if (data[column].dtype in tipos_num):
      data[column].fillna(0, inplace = True)
      data[column] = data[column].astype(int)
    else:    
      data[column].fillna("", inplace = True)    
      data[column] = data[column].astype(str)
  # df.info()

  sample = data.loc[data['Results'] != 1].sample()
  print(sample.iloc[0][3])

  input_dict = {name: tf.convert_to_tensor([value]) for name, value in sample.items()}
  predictions = model.predict(input_dict)
  resultado= 100 * predictions[0]

  # print(resultado)
  # print(predictions)
  # print(predictions[0])
  print(
      "Proceso con %.4f de probabilidad "% (resultado)
  )

  sample = data.loc[data['Results'] != 0].sample()
  print(sample.iloc[0][3])

  input_dict = {name: tf.convert_to_tensor([value]) for name, value in sample.items()}
  predictions = model.predict(input_dict)
  # print(predictions[0])
  resultado= 100 * predictions[0]

  # print(resultado)
  print("Proceso con %.4f de probabilidad "% (resultado))

def fix_registers():
  #Verificar directorios y archivos en el programa
  # cwd = os.getcwd()  # Get the current working directory (cwd)
  # files = os.listdir(cwd)  # Get all the files in that directory
  # print("Files in %r: %s" % (cwd, files))
  if os.path.exists("ia_tests\\NuevosRegistros.txt"):
    os.remove("ia_tests\\NuevosRegistros.txt")
    
  file = open('ia_tests\\RegistrosTest.txt', 'r')
  # Creando nuevo archivo
  file_new = open('ia_tests\\NuevosRegistros.txt', 'w')
  line_new=""
  list_reg=["Registro,Result"]

  for line in file:
    if(line.strip() != ""):
      if(line[0:4]=="HKEY"):
        line=line.rstrip('\n')
        line_new+="\n"+line
      else:
        line=line.rstrip('\n')
        line_new+=line
    else:
      list_reg.append(line_new +",1")
      line_new=""

  file.close()

  for reg in list_reg:
    file_new.writelines(reg)
    file_new.writelines("")
  file_new.close()

def listar_procesos(file):
  lista=[]
  data = pd.read_csv(file, on_bad_lines='skip')
  data = data.drop(columns=['Results'])
  for ind in data.index:    
    proceso = Proceso()
    for column in data:
      col = str.lower(column)
      proceso.__dict__[col]=data[column][ind]
    lista.append(proceso)
  return lista

def analisis_test():
  return leer_archivo_ia_test()

def analisis_completo(id_sesion):
  return leer_archivo_ia(id_sesion)

def leer_procesos():
  f = open('tgamapp/ia_tests/ProcesosTest.txt', 'r')
  # data = pd.read_csv('tgamapp/ia_tests/ProcesosTest.txt', on_bad_lines='skip')
  data = pd.read_csv(f, on_bad_lines='skip')

  tipos_num=["float64","int64"]

  for column in data:
    if (data[column].dtype in tipos_num):
      data[column].fillna(0, inplace = True)
      data[column] = data[column].astype(int)
    else:    
      data[column].fillna("", inplace = True)    
      data[column] = data[column].astype(str)
  # data.info()
  df=data.drop(columns=['Results'])
  df.to_csv('tgamapp/ia_tests/ProcesosPC.txt', encoding='utf-8',sep=',',index=False)
  f.close()
  file = open('tgamapp/ia_tests/ProcesosTest.txt', 'r')   
  lista = listar_procesos(file)
  print(lista.__len__())  
  file.close()


def archivo_sin_result():
  if os.path.exists('tgamapp/ia_tests/NuevosDirectorios.txt'):
    os.remove('tgamapp/ia_tests/NuevosDirectorios.txt')

  file = open('tgamapp/ia_tests/DirectoriosTest.txt', 'r')
  # Creando nuevo archivo
  file_new = open('tgamapp/ia_tests/NuevosDirectorios.txt', 'w')
  string_borrar = [",Results", ",0", ",1"]
  for line in file:
    for text in string_borrar:
      if (text in line):
        line = line.replace(text, "")
    file_new.writelines(line)
  file.close()
  file_new.close()
  
def analisis_procesos_test(file):
  lista_no_deseados=[]
  lista_prob_no_deseados=[]
  model = tf.keras.models.load_model('tgamapp/ia_models/model_procesos')

  data = pd.read_csv(file, on_bad_lines='skip')

  tipos_num=["float64","int64"]

  for column in data:
    if (data[column].dtype in tipos_num):
      data[column].fillna(0, inplace = True)
      data[column] = data[column].astype(int)
    else:    
      data[column].fillna("", inplace = True)    
      data[column] = data[column].astype(str)

  for ind in data.index:
    sample = data.iloc[[ind]]
    input_dict = {name: tf.convert_to_tensor([value]) for name, value in sample.items()}
    predictions = model.predict(input_dict,verbose = 0)
    resultado= 100 * predictions[0]
    if(resultado<=50):      
      print(sample.iloc[0][3] +"  %.4f"%(resultado))
      if(resultado<=10):
        lista_no_deseados.append(sample.iloc[0][3])
      else:
        lista_prob_no_deseados.append(sample.iloc[0][3])
  lista_procesos=[{'categoria':'procesos'},{'tipo_lista':"prob_no_deseados",'lista':lista_prob_no_deseados}, {'tipo_lista':"no_deseados",'lista':lista_no_deseados}]  
  # lista = json.dumps(lista_procesos)
  # return lista
  return lista_procesos
  
def analisis_directorios_test(file):
  lista_no_deseados=[]
  lista_prob_no_deseados=[]
  model = tf.keras.models.load_model('tgamapp/ia_models/model_directorios')

  data = pd.read_csv(file, on_bad_lines='skip')

  for ind in data.index:
    sample = data.iloc[[ind]]["Directorio"]
    predictions = model.predict(sample,verbose = 0)
    resultado= 100 * predictions[0]
    if(resultado<=50):      
      print(sample.iloc[0] +"  %.4f"%(resultado))
      if(resultado<=10):
        lista_no_deseados.append(sample.iloc[0])
      else:
        lista_prob_no_deseados.append(sample.iloc[0])
  lista_directorios=[{'categoria':'directorios'},{'tipo_lista':"prob_no_deseados",'lista':lista_prob_no_deseados}, {'tipo_lista':"no_deseados",'lista':lista_no_deseados}]  
  # lista = json.dumps(lista_directorios)
  # return lista
  return lista_directorios

def analisis_registros_test(file):
  lista_no_deseados=[]
  lista_prob_no_deseados=[]
  model = tf.keras.models.load_model('tgamapp/ia_models/model_registros')

  data = pd.read_csv(file, on_bad_lines='skip')

  for ind in data.index:
    sample = data.iloc[[ind]]["Registro"]
    predictions = model.predict(sample,verbose = 0)
    resultado= 100 * predictions[0]
    if(resultado<=50):      
      print(sample.iloc[0] +"  %.4f"%(resultado))
      if(resultado<=10):
        lista_no_deseados.append(sample.iloc[0])
      else:
        lista_prob_no_deseados.append(sample.iloc[0])
  lista_registros=[{'categoria':'registros'},{'tipo_lista':"prob_no_deseados",'lista':lista_prob_no_deseados}, {'tipo_lista':"no_deseados",'lista':lista_no_deseados}]  
  # lista = json.dumps(lista_registros)
  # return lista
  return lista_registros

def leer_archivo_ia_test():
  file = open('tgamapp/ia_tests/ArchivoIAReducido.txt', 'r')
  myFile = io.StringIO(file.read())
  content = myFile.read()  
  file.close()
  file_procesos = io.StringIO(content[content.index("Node"):content.index("Directorio")-1])
  file_directorios = io.StringIO(content[content.index("Directorio"):content.index("Registro")-1])
  file_registros = io.StringIO(content[content.index("Registro"):])
  myFile.close()
  lista_procesos=analisis_procesos_test(file_procesos)
  lista_directorios = analisis_directorios_test(file_directorios)
  lista_registros = analisis_registros_test(file_registros)
  lista = json.dumps([lista_procesos,lista_directorios,lista_registros]) 
  file_procesos.close()
  file_directorios.close()
  file_registros.close()
  return lista

def procesos_bd_test(file):

  analisis = Analisis()
  fecha_actual = datetime.now()
  analisis.fecha = fecha_actual
  analisis.fk_sesion = Sesion.objects.first()
  analisis.save()

  model = tf.keras.models.load_model('tgamapp/ia_models/model_procesos')

  data = pd.read_csv(file, on_bad_lines='skip')

  tipos_num=["float64","int64"]

  for column in data:
    if (data[column].dtype in tipos_num):
      data[column].fillna(0, inplace = True)
      data[column] = data[column].astype(int)
    else:    
      data[column].fillna("", inplace = True)    
      data[column] = data[column].astype(str)

  for ind in data.index:
    sample = data.iloc[[ind]]
    input_dict = {name: tf.convert_to_tensor([value]) for name, value in sample.items()}
    predictions = model.predict(input_dict,verbose = 0)
    resultado= 100 * predictions[0]
    proceso = Proceso()
    proceso.fk_analisis = analisis
    for column in data:
      col = str.lower(column)
      proceso.__dict__[col]=data[column][ind]

    if(resultado<=50):      
      print(sample.iloc[0][3] +"  %.4f"%(resultado))
      if(resultado<=10):
        proceso.fk_tipo = Tipo.objects.get(nombre="No Deseado")
      else:
        proceso.fk_tipo = Tipo.objects.get(nombre="Prob No Deseado")
    else:
      proceso.fk_tipo = Tipo.objects.get(nombre="Deseado")
    proceso.save()
  

def save_bd_test():
  file = open('tgamapp/ia_tests/ArchivoIAReducido.txt', 'r')
  myFile = io.StringIO(file.read())
  content = myFile.read()  
  file.close()
  file_procesos = io.StringIO(content[content.index("Node"):content.index("Directorio")-1])
  myFile.close()
  procesos_bd_test(file_procesos)
  file_procesos.close()


def leer_archivo_ia(id_sesion):
  file = open('tgamapp/ia_tests/Archivo_IA.txt', 'r', errors='ignore')
  myFile = io.StringIO(file.read())
  content = myFile.read()  
  file.close()
  file_procesos = io.StringIO(content[content.index("Node"):content.index("Directorio_Columna")-1])
  file_directorios = io.StringIO(content[content.index("Directorio_Columna"):content.index("Registro_Columna")-1])
  file_registros = io.StringIO(content[content.index("Registro_Columna"):])
  myFile.close()
  # analisis = Analisis.objects.get(id=32)
  analisis = Analisis()
  fecha_actual = datetime.now()
  analisis.fecha = fecha_actual
  analisis.fk_sesion = Sesion.objects.get(id=id_sesion)
  analisis.save()

  lista_procesos=analisis_procesos(file_procesos,analisis)
  lista_directorios = analisis_directorios(file_directorios,analisis)
  lista_registros = analisis_registros(file_registros,analisis)
  lista = json.dumps([lista_procesos,lista_directorios,lista_registros])

  file_procesos.close()
  file_directorios.close()
  file_registros.close()

  return lista

def analisis_procesos(file,analisis):
  lista_no_deseados=[]
  lista_prob_no_deseados=[]
  model = tf.keras.models.load_model('tgamapp/ia_models/model_procesos')

  data = pd.read_csv(file, on_bad_lines='skip')

  tipos_num=["float64","int64"]
  nombre_pc =""

  for column in data:
    if (data[column].dtype in tipos_num):
      data[column].fillna(0, inplace = True)
      data[column] = data[column].astype(int)
    else:    
      data[column].fillna("", inplace = True)    
      data[column] = data[column].astype(str)

  for ind in data.index:
    sample = data.iloc[[ind]]
    input_dict = {name: tf.convert_to_tensor([value]) for name, value in sample.items()}
    predictions = model.predict(input_dict,verbose = 0)
    resultado= 100 * predictions[0]
    resultado=round(100 - resultado[0],2)
    proceso = Proceso()
    proceso.fk_analisis = analisis
    for column in data:
      col = str.lower(column)
      proceso.__dict__[col]=data[column][ind]

    if(nombre_pc == ""):
      node = proceso.__dict__["node"]
      node = node.strip()
      if (node!=""):
        nombre_pc = node
        analisis.nombrepc = nombre_pc
        analisis.save()
    if(resultado>=30):      
      print(sample.iloc[0][3] +"  %.4f"%(resultado))
      if(resultado>=70):
        lista_no_deseados.append(sample.iloc[0][3])
        proceso.fk_tipo = Tipo.objects.get(id=2)
      else:
        lista_prob_no_deseados.append(sample.iloc[0][3])
        proceso.fk_tipo = Tipo.objects.get(id=3)
    else:
      proceso.fk_tipo = Tipo.objects.get(id=1)    
    proceso.porcentaje_no = resultado
    proceso.save()

  lista_procesos=[{'categoria':'procesos'},{'tipo_lista':"prob_no_deseados",'lista':lista_prob_no_deseados}, {'tipo_lista':"no_deseados",'lista':lista_no_deseados}]  
  return lista_procesos
  
def analisis_directorios(file,analisis):
  lista_no_deseados=[]
  lista_prob_no_deseados=[]
  model = tf.keras.models.load_model('tgamapp/ia_models/model_directorios')
  data = pd.read_csv(file, on_bad_lines='skip')
  for ind in data.index:
    sample = data.iloc[[ind]]["Directorio_Columna"]
    predictions = model.predict(sample,verbose = 0)
    resultado= 100 * predictions[0]
    resultado=round(100 - resultado[0],2)

    directorio = Directorio()
    directorio.fk_analisis = analisis    
    directorio.nombre=sample.iloc[0]

    if(resultado>=30):      
      print(sample.iloc[0] +"  %.4f"%(resultado))
      if(resultado>=70):
        lista_no_deseados.append(sample.iloc[0])
        directorio.fk_tipo = Tipo.objects.get(id=2)
      else:
        lista_prob_no_deseados.append(sample.iloc[0])
        directorio.fk_tipo = Tipo.objects.get(id=3)
    else:
      directorio.fk_tipo = Tipo.objects.get(id=1)
    directorio.porcentaje_no = resultado
    directorio.save()

  lista_directorios=[{'categoria':'directorios'},{'tipo_lista':"prob_no_deseados",'lista':lista_prob_no_deseados}, {'tipo_lista':"no_deseados",'lista':lista_no_deseados}]  
  return lista_directorios

def analisis_registros(file,analisis):
  lista_no_deseados=[]
  lista_prob_no_deseados=[]
  model = tf.keras.models.load_model('tgamapp/ia_models/model_registros')

  data = pd.read_csv(file, on_bad_lines='skip')

  for ind in data.index:
    sample = data.iloc[[ind]]["Registro_Columna"]
    predictions = model.predict(sample,verbose = 0)
    resultado= 100 * predictions[0]
    resultado=round(100 - resultado[0],2)

    registro = Registro()
    registro.fk_analisis = analisis    
    registro.nombre=sample.iloc[0]

    if(resultado>=30):      
      print(sample.iloc[0] +"  %.4f"%(resultado))
      if(resultado>=70):
        lista_no_deseados.append(sample.iloc[0])
        registro.fk_tipo = Tipo.objects.get(id=2)
      else:
        lista_prob_no_deseados.append(sample.iloc[0])
        registro.fk_tipo = Tipo.objects.get(id=3)
    else:
      registro.fk_tipo = Tipo.objects.get(id=1)
    registro.porcentaje_no = resultado
    registro.save()

  lista_registros=[{'categoria':'registros'},{'tipo_lista':"prob_no_deseados",'lista':lista_prob_no_deseados}, {'tipo_lista':"no_deseados",'lista':lista_no_deseados}]
  return lista_registros

def analisis_procs_results(file,analisis,results):
  lista_no_deseados=[]
  lista_prob_no_deseados=[]
  model = tf.keras.models.load_model('tgamapp/ia_models/model_procesos')
  try:
    data = pd.read_csv(file, on_bad_lines='skip')

    tipos_num=["float64","int64"]
    nombre_pc =""

    for column in data:
      if (data[column].dtype in tipos_num):
        data[column].fillna(0, inplace = True)
        data[column] = data[column].astype(int)
      else:    
        data[column].fillna("", inplace = True)    
        data[column] = data[column].astype(str)

    for ind in data.index:
      sample = data.iloc[[ind]]
      input_dict = {name: tf.convert_to_tensor([value]) for name, value in sample.items()}
      predictions = model.predict(input_dict,verbose = 0)
      resultado= 100 * predictions[0]
      resultado=round(100 - resultado[0],2)
      proceso = Proceso()
      proceso.fk_analisis = analisis
      for column in data:
        col = str.lower(column)
        proceso.__dict__[col]=data[column][ind]

      if(nombre_pc == ""):
        node = proceso.__dict__["node"]
        node = node.strip()
        if (node!=""):
          nombre_pc = node
          analisis.nombrepc = nombre_pc
          analisis.save()
      if(resultado>=30):      
        print(sample.iloc[0][3] +"  %.4f"%(resultado))
        if(resultado>=70):
          lista_no_deseados.append(sample.iloc[0][3])
          proceso.fk_tipo = Tipo.objects.get(id=2)
        else:
          lista_prob_no_deseados.append(sample.iloc[0][3])
          proceso.fk_tipo = Tipo.objects.get(id=3)
      else:
        proceso.fk_tipo = Tipo.objects.get(id=1)    
      proceso.porcentaje_no = resultado
      proceso.save()
      lista_procesos=[{'categoria':'procesos'},{'tipo_lista':"prob_no_deseados",'lista':lista_prob_no_deseados}, {'tipo_lista':"no_deseados",'lista':lista_no_deseados}]  
      results.extend(lista_procesos)
      return lista_procesos
  except Exception as e:
    print(e)
    lista_procesos=[{'categoria':'procesos'},{'tipo_lista':"prob_no_deseados",'lista':lista_prob_no_deseados}, {'tipo_lista':"no_deseados",'lista':lista_no_deseados}]  
    results.extend(lista_procesos)
    return lista_procesos
  
def analisis_dirs_results(file,analisis,results):
  lista_no_deseados=[]
  lista_prob_no_deseados=[]
  model = tf.keras.models.load_model('tgamapp/ia_models/model_directorios')
  try:
  
    data = pd.read_csv(file, on_bad_lines='skip')
    for ind in data.index:
      sample = data.iloc[[ind]]["Directorio_Columna"]
      predictions = model.predict(sample,verbose = 0)
      resultado= 100 * predictions[0]
      resultado=round(100 - resultado[0],2)

      directorio = Directorio()
      directorio.fk_analisis = analisis    
      directorio.nombre=sample.iloc[0]

      if(resultado>=30):      
        print(sample.iloc[0] +"  %.4f"%(resultado))
        if(resultado>=70):
          lista_no_deseados.append(sample.iloc[0])
          directorio.fk_tipo = Tipo.objects.get(id=2)
        else:
          lista_prob_no_deseados.append(sample.iloc[0])
          directorio.fk_tipo = Tipo.objects.get(id=3)
      else:
        directorio.fk_tipo = Tipo.objects.get(id=1)
      directorio.porcentaje_no = resultado
      directorio.save()
  except Exception as e:
    print(e)
    lista_directorios=[{'categoria':'directorios'},{'tipo_lista':"prob_no_deseados",'lista':lista_prob_no_deseados}, {'tipo_lista':"no_deseados",'lista':lista_no_deseados}]  
    results.extend(lista_directorios)
    return lista_directorios
  lista_directorios=[{'categoria':'directorios'},{'tipo_lista':"prob_no_deseados",'lista':lista_prob_no_deseados}, {'tipo_lista':"no_deseados",'lista':lista_no_deseados}]  
  results.extend(lista_directorios)
  return lista_directorios

def analisis_regs_results(file,analisis,results):
  lista_no_deseados=[]
  lista_prob_no_deseados=[]
  model = tf.keras.models.load_model('tgamapp/ia_models/model_registros')
  try:
  
    data = pd.read_csv(file, on_bad_lines='skip')

    for ind in data.index:
      sample = data.iloc[[ind]]["Registro_Columna"]
      predictions = model.predict(sample,verbose = 0)
      resultado= 100 * predictions[0]
      resultado=round(100 - resultado[0],2)

      registro = Registro()
      registro.fk_analisis = analisis    
      registro.nombre=sample.iloc[0]

      if(resultado>=30):      
        print(sample.iloc[0] +"  %.4f"%(resultado))
        if(resultado>=70):
          lista_no_deseados.append(sample.iloc[0])
          registro.fk_tipo = Tipo.objects.get(id=2)
        else:
          lista_prob_no_deseados.append(sample.iloc[0])
          registro.fk_tipo = Tipo.objects.get(id=3)
      else:
        registro.fk_tipo = Tipo.objects.get(id=1)
      registro.porcentaje_no = resultado
      registro.save()
  except Exception as e:
    print(e)
    lista_registros=[{'categoria':'registros'},{'tipo_lista':"prob_no_deseados",'lista':lista_prob_no_deseados}, {'tipo_lista':"no_deseados",'lista':lista_no_deseados}]
    results.extend(lista_registros)
    return lista_registros
  lista_registros=[{'categoria':'registros'},{'tipo_lista':"prob_no_deseados",'lista':lista_prob_no_deseados}, {'tipo_lista':"no_deseados",'lista':lista_no_deseados}]
  results.extend(lista_registros)
  return lista_registros