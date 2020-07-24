#!/usr/bin/env/ python


#import statements
#pip install json2xml if you're missing it

from json2xml import json2xml
from json2xml.utils import readfromstring
#import regular expressions

import re

#name of .json file to be read#
filepath = 'annotations.json'
#get all non-whitespace characters
list_to_parse = re.findall(open(filepath).read(), '\S')
string_to_parse = ""
for s in list_to_parse:
	string_to_parse = string_to_parse +s

data = readfromstring(string_to_parse)

#write to output file
file_output = open("output.xml", 'w')

file_output.write(json2xml.Json2xml(file_output).to_xml())

