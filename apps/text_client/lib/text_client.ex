defmodule TextClient do
  @spec start() :: :ok
  defdelegate start(), to: TextClient.Player
end
