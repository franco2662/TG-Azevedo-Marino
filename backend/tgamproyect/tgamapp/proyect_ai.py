import pandas as pd
import numpy as np
import tensorflow as tf
import keras
import os

# print(os.path.exists("ia_models\model_procesos"))
model = tf.keras.models.load_model('ia_models\model_procesos')
# model.summary()

data = pd.read_csv('ia_tests\ProcesosTest.txt', on_bad_lines='skip')

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
print(
    "Proceso con %.4f de probabilidad "% (resultado)
)
