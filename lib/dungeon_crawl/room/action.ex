defmodule DungeonCrawl.Room.Action do
  @moduledoc false
  alias DungeonCrawl.Room.Action
  defstruct id: nil, label: nil

  @type t :: %Action{id: atom, label: String.t()}

  def forward, do: %Action{id: :forward, label: "Move forward."}
  def search, do: %Action{id: :search, label: "Search the room."}
  def rest, do: %Action{id: :rest, label: "Take a better look and rest."}

  defimpl String.Chars do
    def to_string(action),do: action.label
  end

end
