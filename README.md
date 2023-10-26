# customer_io

An Elixir wrapper for Customer.io's OpenAPI specification.

This library is automatically generated using [AJ Foster](https://github.com/aj-foster/)'s [open-api-generator](https://github.com/aj-foster/open-api-generator). Because Customer.io provides an extremely rich OpenAPI specification, this library is able to be quite comprehensive despite lacking official first-party support.

## Installation

This library is still extremely alpha. Don't use it yet, because everything is subject to change and nothing is tested.

## Configuration

In your `config.exs`, `runtime.exs`, or environment-specific versions of one of those, you'll need to pass in your site ID and API keys. (Find these in Workspace Settings > API and webhook credentials, in the "Tracking API Keys" and "App API Keys" tabs.)

```elixir
config :customer_io,
  site_id: "your-side-id",
  track_api_key: "your-track-api-key",
  app_api_key: "your-app-api-key",
```

Optionally, you can also configure the base URLs for the API. This is useful if you're using a proxy or a local development server.

```elixir

config :customer_io,
  site_id: "your-side-id",
  track_api_key: "your-track-api-key",
  app_api_key: "your-app-api-key",
  track_base_url: "https://track.customer.io", # Or "http://localhost:3000", etc.
  api_base_url: "https://api.customer.io", # Or "http://localhost:3000", etc.
```

In test environments, you can skip making any real HTTP requests and always get an `:ok` response by setting your API keys to `"test"`:

```elixir
config :customer_io,
  site_id: "test",
  track_api_key: "test",
  app_api_key: "test",
```

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

