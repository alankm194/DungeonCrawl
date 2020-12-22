defmodule DungeonCrawl.Room do
  @moduledoc false
  alias DungeonCrawl.Room
  alias DungeonCrawl.Room.Triggers
  import DungeonCrawl.Room.Action

  defstruct description: nil, actions: [], trigger: nil, room_appearance_chance: nil

  def all, do: [
    %Room {
      description: "You can see the light of day. You found the exit!",
      actions: [forward()],
      trigger: Triggers.Exit,
      room_appearance_chance: 0..4
    },
    %Room {
      description: "You see an empty room, it looks safe to take a rest",
      actions: [forward(), rest()],
      trigger: Triggers.Rest,
      room_appearance_chance: 5..14
    },
     %Room {
      description: "You see an empty room, it looks safe to take a rest",
      actions: [forward(), rest()],
      trigger: Triggers.EnemyHidden,
      room_appearance_chance: 15..24
    },
     %Room {
       description: "You can see an enemy blocking your path.",
       actions: [forward()],
       trigger: Triggers.Enemy,
       room_appearance_chance: 25..65
     },
    %Room {
      description: "You see an empty room with some barrels and chests",
      actions: [forward(), search()],
      trigger: Triggers.Trap,
      room_appearance_chance: 66..100
    },
  ]
end
