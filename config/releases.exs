echo "import Config"

config :rerem, ReremWeb.Endpoint,
  server: true,
  url: [host: System.get_env("APP_NAME") <> ".gigalixirapp.com", port: 443]
