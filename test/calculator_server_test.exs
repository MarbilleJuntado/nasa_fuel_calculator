defmodule NASA.CalculatorServerTest do
  use ExUnit.Case
  alias NASA.{CalculatorServer, Mission}

  setup_all do
    Application.ensure_all_started(:nasa_fuel_calculator)
    :ok
  end

  test "calculates full mission fuel" do
    steps = [
      {:launch, "earth"},
      {:land, "moon"},
      {:launch, "moon"},
      {:land, "earth"}
    ]

    {:ok, mission} = Mission.new(28801, steps)
    fuel = CalculatorServer.calculate_fuel(mission)

    assert Decimal.equal?(fuel, Decimal.new(51898))
  end

  test "calculates mars mission" do
    steps = [
      {:launch, "earth"},
      {:land, "mars"},
      {:launch, "mars"},
      {:land, "earth"}
    ]

    {:ok, mission} = Mission.new(14606, steps)
    fuel = CalculatorServer.calculate_fuel(mission)

    assert Decimal.equal?(fuel, Decimal.new(33388))
  end
end
