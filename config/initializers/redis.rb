REDIS_CLIENT = Redis.new(
  url: ENV.fetch("REDIS_URL", "redis://localhost:6379/0"),
  timeout: 2,
  reconnect_attempts: 1
)
