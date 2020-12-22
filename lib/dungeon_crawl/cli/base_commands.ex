defmodule DungeonCrawl.CLI.BaseCommands do
  @moduledoc false
  alias Mix.Shell.IO, as: Shell

  def display_options(options) do
    options
    |> Enum.with_index(1)
    |> Enum.each(fn {option, index} ->
                    Shell.info("#{index} - #{option}")
                  end)
    options
  end

  def generate_questions(option) do
    options = Enum.join(1..Enum.count(option), ", ")
    "which one? [#{options}]\n"
  end

  def generate_question(options) do
    options = Enum.join(1..Enum.count(options),",")
    "Which one? [#{options}]\n"
  end

  def retry(options) do
    display_error("Invalid option")
    ask_for_option(options)
  end

  def ask_for_option(options) do
    answer =
      options
        |> display_options
        |> generate_question
        |> Shell.prompt

    with {option, _} <- Integer.parse(answer),
        chosen when chosen != nil <- Enum.at(options, option - 1) do
          chosen
    else
      :error -> retry(options)
      nil -> retry(options)
    end
  end

  def display_error(message) do
    Shell.cmd("clear")
    Shell.error(message)
    Shell.prompt("Press Enter to continue.")
    Shell.cmd("clear")
  end
end
