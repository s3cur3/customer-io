import Config

config :oapi_generator,
  app: [
    output: [
      base_module: CustomerIo.App,
      location: "lib/customer_io/app"
    ]
  ],
  track: [
    output: [
      base_module: CustomerIo.Track,
      location: "lib/customer_io/track"
    ]
  ]
