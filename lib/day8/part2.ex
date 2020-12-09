defmodule AdventOfCode.Day8.Part2 do
  alias AdventOfCode.Day8.CPU, as: CPU

  def run(input) do
    input
    |> Enum.map(&CPU.parse/1)
    |> CPU.new()
    |> find_ending_cpu(0)
    |> IO.puts()
  end

  def find_ending_cpu(cpu, line) do
    cpu
    |> switch_instruction(line, Enum.at(cpu.instructions, line))
    |> run_until_repeat(MapSet.new([0]))
    || find_ending_cpu(cpu, line + 1)
  end

  defp switch_instruction(cpu, line, {"jmp", argument}) do
    CPU.change_instruction(cpu, line, {"nop", argument})
  end
  defp switch_instruction(cpu, line, {"nop", argument}) do
    CPU.change_instruction(cpu, line, {"jmp", argument})
  end
  defp switch_instruction(_, _, {"acc", _}) do nil end

  defp run_until_repeat(nil, _) do nil end
  defp run_until_repeat(cpu, executed) do
    cpu2 = CPU.run_once(cpu)

    cond do
      cpu2.next == Enum.count(cpu.instructions) -> cpu2.acum
      MapSet.member?(executed, cpu2.next) -> nil
      true -> run_until_repeat(cpu2, MapSet.put(executed, cpu2.next))
    end
  end
end
