defmodule NASA.CLI do
  @moduledoc false

  alias NASA.{Mission, CalculatorServer}

  def main(args) do
    Application.ensure_all_started(:nasa_fuel_calculator)

    case parse_args(args) do
      {:ok, mission} ->
        fuel = CalculatorServer.calculate_fuel(mission)

        IO.puts(
          "#{IO.ANSI.green()}Total fuel needed: #{Decimal.to_string(fuel)}#{IO.ANSI.reset()}"
        )

      {:error, {:unknown_planet, planet}} ->
        IO.puts("#{IO.ANSI.red()}Unknown planet: #{planet}#{IO.ANSI.reset()}")

      {:error, _} ->
        IO.puts(
          "#{IO.ANSI.red()}Invalid input. Usage: ./nasa <mass> <action:planet> ...#{IO.ANSI.reset()}"
        )
    end
  end

  defp parse_args([mass_str | step_strs]) do
    with {mass, ""} <- Integer.parse(mass_str),
         steps <- Enum.map(step_strs, &parse_step/1),
         {:ok, mission} <- Mission.new(mass, steps) do
      {:ok, mission}
    else
      {:error, {:unknown_planet, _} = err} -> {:error, err}
      _ -> {:error, :invalid}
    end
  end

  defp parse_step(str) do
    [action, planet] = String.split(str, ":")

    case action do
      "launch" -> {:launch, planet}
      "land" -> {:land, planet}
      _ -> {:error, :invalid}
    end
  end
end
