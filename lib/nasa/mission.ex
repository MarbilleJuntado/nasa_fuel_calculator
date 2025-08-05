defmodule NASA.Mission do
  @moduledoc "Holds and validates mission steps"

  alias NASA.Planet

  defstruct [:mass, :steps]

  def new(mass, steps) when is_integer(mass) and mass > 0 and is_list(steps) do
    with {:ok, steps} <- validate_steps(steps) do
      {:ok, %__MODULE__{mass: mass, steps: steps}}
    end
  end

  def new(_, _), do: {:error, :invalid}

  defp validate_steps(steps) do
    Enum.reduce_while(steps, {:ok, []}, fn
      {action, planet}, {:ok, acc} when action in [:launch, :land] ->
        case Planet.get(planet) do
          %Planet{} = p -> {:cont, {:ok, acc ++ [{action, p}]}}
          {:error, :unknown_planet} -> {:halt, {:error, {:unknown_planet, planet}}}
        end

      _, _ ->
        {:halt, {:error, :invalid_step}}
    end)
  end
end
