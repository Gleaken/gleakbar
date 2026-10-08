import requests


APIKEY = 'fa6da36213b436ae15d73dc5f61271a5'
HOST = 'http://api.openweathermap.org'
LAT = '54.353716'
LON = '18.582298'

def get_coordinates(city):
    response = requests.get(HOST + "/geo/1.0/direct?q=" + city + "&limit=10&appid=" + APIKEY)
    print(response.json())


def get_weather(lat, lon):
    response = requests.get(HOST + "/data/2.5/weather?lat=" + lat + "&lon=" + lon + "&units=metric&&appid=" + APIKEY)
    j = response.json()
    #print(j)
    print("{}".format(int(round(j['main']['temp'],0))) + " " +j['weather'][0]['main'])
    #print(j['main']['temp'])


if __name__ == '__main__':
#    get_coordinates("Gdansk")
    get_weather(LAT, LON)


