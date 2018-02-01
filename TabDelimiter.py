# import csv

# with open('/home/testssis/2valuations.csv', 'rb') as fin, \
#      open('/home/testssis/OutputFile.txt', 'wb') as fout:
#     reader = csv.DictReader(fin)
#     writer = csv.DictWriter(fout, reader.fieldnames, delimiter='|')
#     writer.writeheader()
#     writer.writerows(reader)

# import csv

# with open('C:/Users/EnriqueLopez/Documents/Valuations/file.csv', 'rb') as fin, \
#      open('C:/Users/EnriqueLopez/Documents/Valuations/OutputFile.csv', 'wb') as fout:
#     reader = csv.DictReader(fin)
#     writer = csv.DictWriter(fout, reader.fieldnames, delimiter='|')
#     writer.writeheader()
#     writer.writerows(reader)

import argparse
import csv

parser = argparse.ArgumentParser(description='Converts a regular CSV to a piple delimited file with no quotes.')

parser.add_argument('csv_file', help='The CSV file to parse.')

args  =  parser.parse_args()

csv_reader = csv.reader(open(args.csv_file, 'rb'), delimiter=',', quotechar='"')

for row in csv_reader:
    row  =  '|'.join(row)

    row  =  row.replace('\n', '')
    row  =  row.replace('\r', '')

    print row
