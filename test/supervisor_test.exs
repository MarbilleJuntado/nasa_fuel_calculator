defmodule NASA.SupervisorTest do
  use ExUnit.Case

  alias NASA.CalculatorServer

  setup_all do
    Application.ensure_all_started(:nasa_fuel_calculator)
    :ok
  end

  test "starts CalculatorServer process" do
    assert Process.whereis(CalculatorServer) |> is_pid()
    assert Process.alive?(Process.whereis(CalculatorServer))
  end

  test "restarts CalculatorServer when it crashes" do
    pid_before = Process.whereis(CalculatorServer)

    # Simulate a crash
    Process.exit(pid_before, :kill)

    # Wait a moment for the supervisor to restart it
    Process.sleep(100)

    pid_after = Process.whereis(CalculatorServer)

    assert is_pid(pid_after)
    assert pid_before != pid_after
    assert Process.alive?(pid_after)
  end
end
