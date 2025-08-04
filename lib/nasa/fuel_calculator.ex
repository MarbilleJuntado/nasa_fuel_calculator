defmodule NASA.Calculator do
  @moduledoc "Recursive fuel calculation logic"

  alias Decimal, as: D

  @launch_factor "0.042"
  @launch_offset 33

  @land_factor "0.033"
  @land_offset 42

  def fuel_required(mass, :launch, gravity),
    do: compute_fuel(mass, gravity, D.new(@launch_factor), @launch_offset)

  def fuel_required(mass, :land, gravity),
    do: compute_fuel(mass, gravity, D.new(@land_factor), @land_offset)

  defp compute_fuel(mass, gravity, factor, offset) do
    mass
    |> compute_step(gravity, factor, offset)
    |> total_fuel(gravity, factor, offset, D.new(0))
  end

  defp compute_step(mass, gravity, factor, offset) do
    mass
    |> D.mult(gravity)
    |> D.mult(factor)
    |> D.sub(D.new(offset))
    |> D.round(0, :floor)
  end

  defp total_fuel(fuel, gravity, factor, offset, acc) do
    cond do
      D.compare(fuel, 0) in [:lt, :eq] ->
        acc

      true ->
        total_fuel(
          compute_step(fuel, gravity, factor, offset),
          gravity,
          factor,
          offset,
          D.add(acc, fuel)
        )
    end
  end
end
