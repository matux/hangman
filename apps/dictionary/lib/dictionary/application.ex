defmodule Dictionary.Application do
  use Application

  def start(_type, _args) do
    Supervisor.start_link(
      [
        {Dictionary.Server, []}
      ],
      name: Dictionary.Supervisor,
      strategy: :one_for_one
    )
  end
end
