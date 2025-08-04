defmodule NASA.CalculatorServerTest do
  use ExUnit.Case
  alias NASA.{CalculatorServer, Mission}

  setup do
    {:ok, pid} = CalculatorServer.start_link(nil)
    %{pid: pid}
  end

  test "calculates full mission fuel", %{pid: _} do
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

  test "calculates mars mission", %{pid: _} do
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
