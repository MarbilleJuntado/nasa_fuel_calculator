defmodule NASA.CalculatorServer do
  use GenServer

  alias NASA.{Mission, Calculator}

  def start_link(_), do: GenServer.start_link(__MODULE__, %{}, name: __MODULE__)

  def init(state), do: {:ok, state}

  def calculate_fuel(mission), do: GenServer.call(__MODULE__, {:calculate, mission})

  def handle_call({:calculate, %Mission{mass: mass, steps: steps}}, _from, state) do
    result =
      steps
      |> Enum.reverse()
      |> Enum.reduce(Decimal.new(0), fn {action, planet}, acc ->
        mass
        |> Decimal.add(acc)
        |> Calculator.fuel_required(action, planet.gravity)
        |> Decimal.add(acc)
      end)

    {:reply, result, state}
  end
end
