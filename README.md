# Distant Skies

This is a simple web frontend for OpenWeatherMap, allowing you to specify a location, returning the current weather at that location. There's some stuff still missing:

- There's a field for entering the country which I don't use yet. The next step would be to get a list of countries with their country codes - probably as a CSV file - wrap this in a helper class and render an appropriate dropdown field. Providing this as an optional argument to the query would be trivial.
- Caching ruby objects is not such a good idea, it's better to have a stable serialization method - or cache the raw http response instead and parse it later, which doesn't work with RestClient out of the box.
- The frontend lacks polish.
- The error handling is simplistic, sometimes there's information in the API response I could pass on, for a start.
- Display more information.
- Have a contract test for the OpenWeatherMap API.
- Remove my appid in the VCR cassette.
- Mocking RestClient in one place and using VCR in another feels awkward.
