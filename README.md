# Distant Skies

This is a simple web frontend for OpenWeatherMap, allowing you to specify a location, returning the current weather at that location. There's some stuff still missing:

- The list of countries is incomplete.

- Caching ruby objects is not such a good idea, it's better to have a
  stable serialization method - or cache the raw http response instead
  and parse it later, which doesn't work with RestClient out of the
  box.

- The frontend lacks polish.

- The error handling is simplistic, sometimes there's information in
  the API response I could pass on, for a start.

- Display more information, about the weather and the location found.

- Have a contract test for the OpenWeatherMap API: this should not be
  mocked out but hit their API every time. It would run independently
  of the main test suite, because it's only supposed to fail when
  OpenWeatherMap makes changes to their API.

- Mocking RestClient in one place and using VCR in another feels
  awkward.

