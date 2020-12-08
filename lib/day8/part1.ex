defmodule AdventOfCode.Day8.Part1 do
  alias AdventOfCode.Day8.CPU, as: CPU

  def run(input) do
    input
    |> Enum.map(&CPU.parse/1)
    |> CPU.new()
    |> run_until_repeat(MapSet.new([0]))
    |> IO.puts()
  end

  defp run_until_repeat(cpu, executed) do
    cpu2 = CPU.run_once(cpu)
    if MapSet.member?(executed, cpu2.next) do
      cpu2.acum
    else
      run_until_repeat(cpu2, MapSet.put(executed, cpu2.next))
    end
  end
end
