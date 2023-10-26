defmodule CustomerIo.MixProject do
  use Mix.Project

  def project do
    [
      app: :customer_io,
      version: "0.1.0",
      elixir: "~> 1.13",
      consolidate_protocols: Mix.env() != :test,
      deps: deps(),
      aliases: aliases(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        check: :test,
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.html": :test
      ],
      dialyzer: [
        ignore_warnings: ".dialyzer_ignore.exs",
        plt_file: {:no_warn, "priv/plts/dialyzer.plt"},
        flags: [:error_handling, :unknown],
        # Error out when an ignore rule is no longer useful so we can remove it
        list_unused_filters: true
      ]
    ]
  end

  def application do
    []
  end

  defp deps do
    [
      {:ex_doc, "~> 0.27", only: :dev, runtime: false},
      {:telemetry, "~> 0.4.2 or ~> 1.0"},
      # Take my patch to allow discriminator without mapping
      {:oapi_generator,
       git: "https://github.com/s3cur3/open-api-generator.git", only: :dev, runtime: false},

      # HTTP stack
      {:jason, "~> 1.0"},
      {:httpoison, "~> 1.7 or ~> 2.0"},

      # Code quality
      {:credo, "~> 1.7.0", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.2", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.18.0", only: [:dev, :test], runtime: false}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      check: [
        "clean",
        "deps.unlock --check-unused",
        "compile --warnings-as-errors",
        "format --check-formatted",
        "test --warnings-as-errors",
        "credo"
      ]
    ]
  end
end
