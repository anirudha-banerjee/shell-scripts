import csv
import os
from os import error, link
import sys
sys.path.append('../')
from colorama.ansi import Style
import datetime
import pandas as pd
import subprocess
import requests
import re
import math
import json
import colorama
from colorama import Fore, Style
import urllib.request

#Global
info_file = None
bookid = ""
resid = ""
chapterid = ""
link = ""
book_data = []
category_data = []
Output = []
csvRows = []
DATA_FILENAME_OUTPUT = 'vimeo-aggregated-final.csv'
video_id = ""
List = []
data_file_path = 'aggregated-csv.csv'
video_output_path = '/home/godslayer69/Videos/single-videos/'


# csv field names 
fields = ['ResId', 'ChapterId', 'BookId', 'Link', 'Valid']

#Functions
def get_current_date_time():
    today = datetime.datetime.now()
    date_time = today.strftime("%-d %B %Y, %I:%M:%S%p")
    return date_time    

def init_output_file():
    with open(DATA_FILENAME_OUTPUT, 'w') as csvfile:
        # creating a csv writer object 
        csvwriter = csv.writer(csvfile)

        # writing the fields 
        csvwriter.writerow(fields)

        # close the file object
        csvfile.close()
        
def convert_size(size_bytes):
   if size_bytes == 0:
       return "0B"
   size_name = ("B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB")
   i = int(math.floor(math.log(size_bytes, 1024)))
   p = math.pow(1024, i)
   s = round(size_bytes / p, 2)
   return "%s %s" % (s, size_name[i])

        
def network_handler(id):
    # Handle network call
    url = "https://api.vimeo.com/videos/{}?fields=files" \
        .format(id)
    payload = {}
    headers = {
        'Accept': 'application/json',
        'Authorization': 'bearer 0a40256d92bee3750b4bd3d4c5fecf88'
    }
    response = requests.request("GET", url, headers=headers, data=payload, stream=True)
    return response.json()

def file_aggregator(path):
    all_single_record_filenames = []
    single_record_count = 0
    duplicate_record_count = 0
    directory = os.fsencode(path)
    for file in os.listdir(directory):
        filename = os.fsdecode(file)
        complete_filename = 'grouped-vimeo-videos/' + filename
        if '.csv' in complete_filename:
            with open(complete_filename,"r") as f:
                reader = csv.reader(f,delimiter = ",")
                data = list(reader)
                row_count = len(data)
                if row_count > 2:
                    continue
                else:
                    os.remove(complete_filename)
                    
def file_downloader(download_path):
    s = os.statvfs('/')
    s_bytes = (s.f_bavail * s.f_frsize) / 1024
    s_gb = convert_size(s_bytes)
    print("Available Space: ", s_gb, end='\n\n')
    index = 0
    with open(data_file_path,"r") as f:
                    reader = csv.reader(f,delimiter = ",")
                    data = list(reader)
                    row_count = len(data)
                    for v_data in data:
                        print('Download Index: ', index, end='\n\n')
                        row_data = data[index]
                        if row_data[3] == 'Link':
                            index = index + 1
                            continue
                        elif row_data[4] != "":
                            continue
                        file_title = download_path + row_data[0] + "-" + row_data[1] + "-" + row_data[2] + ".mp4"
                        response_json = network_handler(row_data[3])
                        media_file_urls = response_json["files"]
                        for item in media_file_urls:
                            if '720p' in item['public_name']:
                                print('file: ', item['link'], end='\n\n')
                                try:
                                    print("Downloading starts...\n")
                                    urllib.request.urlretrieve(item['link'], file_title)
                                    print("Download completed..!!")
                                except Exception as e:
                                    print(e)
                        index = index + 1
        
                    
                    
    
    
        
#Python script starts
#Get the data file path
print('Starting CSV Parser...\n\n')
print('Execution Date & Time: ', get_current_date_time(), end='\n\n')
#init_output_file()


# reading data from a csv file
file_downloader(video_output_path)
        
        
print('Refined CSVs have been created in output directory', end='\n')
print('CSV Parser has finished', end='\n\n')

tool_exit_status = 0

#End of script
sys.exit(tool_exit_status)

#Python script ends
