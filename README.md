# Distant Skies

This is a simple web frontend for OpenWeatherMap. 

# Dev notes
## OpenWeatherMap API

See API docs at http://openweathermap.org/current.

Example query:

    curl http://api.openweathermap.org/data/2.5/weather?q=London&appid=YOURAPPID
    
Seems I have to register and get a token. This can be passed as an environment variable, the dotenv gem will come in handy here.
