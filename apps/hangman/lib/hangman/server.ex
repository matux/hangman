defmodule Hangman.Server do
  @moduledoc """
  The server for the Hangman game.
  """
  alias Hangman.Game

  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [])
  end

  def init(_) do
    {:ok, Game.new_game()}
  end

  def handle_call({:guess, guess}, _from, game) do
    {updated_game, tally} = Game.guess(game, guess)
    {:reply, tally, updated_game}
  end

  def handle_call({:tally}, _from, game) do
    {:reply, Game.tally(game), game}
  end
end
