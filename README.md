# customer_io

An Elixir wrapper for Customer.io's OpenAPI specification.

This library is automatically generated using [AJ Foster](https://github.com/aj-foster/)'s [open-api-generator](https://github.com/aj-foster/open-api-generator). Because Customer.io provides an extremely rich OpenAPI specification, this library is able to be quite comprehensive despite lacking official first-party support.

## Contributing

To regenerate the API from the latest OpenAPI spec:

1. Visit [the Customer.io App API docs](https://customer.io/docs/api/app/) and click the button labeled "Download OpenAPI specification"
2. Save that file to `priv/cio_journeys_app_api.json`
3. Also download [the track API schema](https://customer.io/docs/api/track/) and save it to `priv/cio_journeys_track_api.json`
4. Run the generator:
    ```sh
    mix api.gen app priv/cio_journeys_app_api.json 
    mix api.gen track priv/cio_journeys_track_api.json
    ```
5. Update the `.api-version` file if appropriate

If you run into any unexpected issues while generating the code, please open an issue.

