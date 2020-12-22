defmodule DungeonCrawl.CLI.Main do
  @moduledoc false
  alias Mix.Shell.IO, as: Shell
  @room_chance 100

  def start_game do
    welcome_message()
    Shell.prompt("Press enter to continue")
    crawl(hero_choice(), DungeonCrawl.Room.all())
  end

  defp crawl(%{hit_points: 0}, _) do
    Shell.prompt("")
    Shell.cmd("clear")
    Shell.info("Unfortunately your wounds are too many to keep walking.")
    Shell.info("You fall on to the floor without strength to carry on.")
    Shell.info("Gameover!")
    Shell.prompt("")
  end

  defp crawl(character, rooms) do
    Shell.info("You keep moving forward to the next room.")
    Shell.prompt("Press enter to continue")
    Shell.cmd("clear")

    Shell.info(DungeonCrawl.Character.current_stats(character))

    rooms
    |> choose_room
    |> List.first
    |> DungeonCrawl.CLI.RoomActionChoice.start
    |> trigger_action(character)
    |> handle_action_result

  end

  defp choose_room(rooms) do
    room_rng = Enum.random(0..@room_chance)
    room = Enum.filter(rooms, &in_range(&1, room_rng))
  end

  defp in_range(room, room_rng) do
    first..last = room.room_appearance_chance
    room_rng >= first && room_rng <= last
  end

  defp trigger_action({room, action}, character) do
    Shell.cmd("clear")
    room.trigger.run(character, action)
  end

  defp handle_action_result({_, :exit}),
    do: Shell.info("You found the exit. You won the game. Congratulations")

  defp handle_action_result({character, _}),
    do: crawl(character, DungeonCrawl.Room.all())

  defp welcome_message do
    Shell.info("==Dungeon Crawl==")
    Shell.info("You awake in a dungeon full of monsters")
    Shell.info("You need to survive and find the exit")
  end

  defp hero_choice do
    hero = DungeonCrawl.CLI.HeroChoice.start()
    %{hero | name: "You"}
  end
end
