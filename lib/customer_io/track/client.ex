defmodule CustomerIo.Track.Client do
  @moduledoc """
  The internal HTTP client for Customer.io's Track API.
  """
  def request(%{opts: opts, method: method, url: path} = info) do
    metadata = %{
      client: __MODULE__,
      info: info,
      request_method: method,
      request_url: path,
      call: info[:call]
    }

    base_url = Application.get_env(:customer_io, :track_base_url, "https://track.customer.io")

    body =
      case info[:body] do
        nil -> nil
        body -> Jason.encode!(body)
      end

    :telemetry.span([:customer_io, :request], metadata, fn ->
      out =
        with token when token != "test" <- auth_token(),
             headers <- headers(token),
             {:ok, resp} <- HTTPoison.request(method, base_url <> path, body, headers, opts) do
          process_response(resp, info.response)
        else
          {:error, error} -> {:error, %{source: "Customer.io HTTP", error: error, request: info}}
          "test" -> :ok
        end

      {out, %{}}
    end)
  end

  defp process_response(%{status_code: status, body: body}, response_rules) do
    Enum.find_value(response_rules, fn
      {^status, val} -> val
      _ -> nil
    end)
    |> case do
      nil -> {:error, :unexpected_result}
      :null -> status_code_to_ok_or_error(status)
      :map -> {status_code_to_ok_or_error(status), Jason.decode!(body)}
    end
  end

  defp status_code_to_ok_or_error(status) when status < 400, do: :ok
  defp status_code_to_ok_or_error(_), do: :error

  defp headers(token) do
    [{"Content-Type", "application/json"}, {"authorization", token}]
  end

  defp auth_token do
    {site_id, api_key} =
      case {Application.get_env(:customer_io, :site_id),
            Application.get_env(:customer_io, :track_api_key)} do
        {site_id, key} when byte_size(site_id) > 0 and byte_size(key) > 0 -> {site_id, key}
        {nil, nil} -> raise "Must configure :site_id or :track_api_key for :customer_io"
        {nil, _} -> raise "Must configure :site_id for :customer_io"
        {_, nil} -> raise "Must configure :track_api_key for :customer_io"
        _ -> raise ":site_id and :track_api_key must be non-empty"
      end

    if api_key == "test" do
      api_key
    else
      bearer_token = Base.encode64("#{site_id}:#{api_key}")
      "Basic #{bearer_token}"
    end
  end
end
