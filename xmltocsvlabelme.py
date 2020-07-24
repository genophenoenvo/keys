#! /usr/bin/env python
import xml.etree.ElementTree as ET
import csv

trees = ET.parse('output.xml')
root = tree.getroot()

shapes = root[2]
labels = []
xmin = []
xmax = []
ymax = []
ymin = []
images = []
image_path = '/path/to/image.png'
for item in shapes:
	labels.append(item[0].text)
	xmin.append(item[1][0][0].text)
	ymin.append(item[1][0][1].text)
	xmax.append(item[1][1][0].text)
	ymax.append(item[1][1][1].text)
	images.append(image_path)
sorted_list = []

for index, item in enumerate(labels):
	p = []
	p.append(images[index])
	p.append(xmin[index])
	p.append(ymin[index])
	p.append(xmax[index])
	p.append(ymax[index])
	p.append(item)
	sorted_list.append(p)


file_path = open('output.csv', 'w')
with file:
	write = csv.writer(file_path)
	write.writerows(sorted_list)




