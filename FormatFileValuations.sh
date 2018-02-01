#!/bin/bash

# Se agrega el comando para ejecutar el script en python que va a poner en pipes el archivo
python TabDelimiter.py ~/Documents/Cursos/testssis/valuations.csv > file.csv
# Variable para saber la fecha
tiempo=`date`
# Variable que almacena la ruta del archivo que sera procesado
file="file.csv"
#Imprime el tiempo
echo "$tiempo"

#Inicia proceso de conversion de archivo
echo "Inicia conversion de archivo"

#Imprimir los headers que se ocupan en la tabla fact_valuations en la base de datos WH_DEV_Macquarie
echo "fact_validation_id,valuation_desc,day_id,validation_building_excel,currency_cd,asset_reciclyn_program,Reversionary_Terminal_Cap_Rate,Capex_US_Sqft_yr,Discount_Rate,Cap_Rate,IRR,Going_In_Cap_Rate,NOI_Budget_USD,NOI_Budget_MXN,NOI_1_year_USD,NOI_1_year_MXN,Leasing_Managers_Rent,DCF_USD,DCF_MXN,YR_1_NOI_STABILIZED_USD,YR_1_NOI_STABILIZED_MXN,Market_Rent_APP,Comparison_Approach_USD,Comparison_Approach_MXN,Final_Val_USD,Final_Val_MXN," > header.txt

# Sustituye comillas por
sed "s/\"//g" $file > tempo


# Elimina los 5 primeros registros
sed "1,3d" tempo > tempo2

# Agregar una columna vacia a la izquierda
awk -F\| '{print " |"$0}' tempo2 > tempo3


# Reemplazar los #N/A por nada
sed "s/\#N\/A//g" tempo3 > tempo4
# Reemplazar los N/A por nadaea
sed "s/N\/A//g" tempo4 > tempo5

# Reemplazar los NA
sed "s/N\A//g" tempo5 > tempo6

# Elimina las columnas que no pertenecen al archivo de carga
# awk -F\, '{print $1","$3","$4","$5","sub(/,/,"",$34)","$12","$13","$16","$17","$18","$19","$20","$21","$22","$23","$24","$25","$26","$27","$28","$29","$30","$31","$32","$33","$34","$35","}' tempo6 > tempo7

awk -F\| '{print $1","$3","$4","$5","$11","$12","$15","$16","$17","$18","$19","$20","$21","$22","$23","$24","$25","$26","$27","$28","$29","$30","$31","$32","$33","$34","$35","}' tempo6 > tempo7


# #Pegar los header como primera fila y enviar el output
cat header.txt tempo7 > valuations_$file

# # Elimina todos los archivo de tempo* que se ocupan para procesar la informacion
rm -R tempo*

# # Elimina el header.txt
rm -R header.txt

# Configurar el package
