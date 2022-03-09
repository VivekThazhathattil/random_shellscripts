from bs4 import BeautifulSoup as BS
import requests
from datetime import date, datetime, timedelta
import time
import csv

FROM_DATE = "January 1 2021"
TO_DATE = "March 8 2022"

# sample url: "https://affairscloud.com/current-affairs-quiz-1-march-2022"

URL_prefix = "https://affairscloud.com/current-affairs-quiz-"

from_date = datetime.strptime(FROM_DATE, '%B %d %Y')
to_date = datetime.strptime(TO_DATE, '%B %d %Y')
day_increment = timedelta(days=1)

with open('output.csv', 'a') as csvfile:
    csvwriter = csv.writer(csvfile) 
    curr_date = from_date
    while curr_date <= to_date:
        day_string = curr_date.strftime("%d-%B-%Y").lower().lstrip('0')
    
        url = URL_prefix + day_string

        #print(url)
        request = requests.get(url)
        if request.status_code != 404:
            soup = BS(request.text,'html.parser')
            
            ol_element = soup.find_all('ol')
            li_elements = ol_element[0].find_all('li')

            for li_element in li_elements:
                strong_elements = li_element.find_all('strong')
                contents = li_element.contents
                question = ""
                answer = ""
                for content in contents:
                    if content.name not in ['div', 'br', 'table']:
                        question += content.text    

                answer += strong_elements[1].text

                div_element = li_element.find('div',{'class':'content'})
                div_contents = div_element.contents
                div_contents.pop(0)
                explanation = ""
                for div_content in div_contents:
                    if div_content.name not in ['table','div','strong','br']:
                        explanation += div_content.text

                answer += '\n' + explanation
                csvwriter.writerow([question.strip(), answer.strip()])
            
            #time.sleep(5)

        else:
            print('Error 404: skipping (' + day_string + ')')
            time.sleep(2)
        
        curr_date += day_increment
