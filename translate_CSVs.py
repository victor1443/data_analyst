import csv
import os
from googletrans import Translator
translator = Translator(service_urls=['translate.googleapis.com'])

# path to the file to translate
filepath = 'C:/Users/.../Fahrraddiebstahl.csv'

# open the input CSV file and create an output CSV file
with open(filepath, 'r') as input_file, open('C:/Users/Victor/Desktop/proj1/sets/eng_full_Fahrraddiebstahl.csv', 'w', newline='') as output_file:
    reader = csv.reader(input_file)
    writer = csv.writer(output_file)
    
    # loop through each row in the input CSV file
    for row in reader:
        # translate each cell in the row to English
        translated_row = []
        for cell in row:
            translated_cell = translator.translate(cell, dest='en').text
            translated_row.append(translated_cell)
        
        # write the translated row to the output CSV file
        writer.writerow(translated_row)