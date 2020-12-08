defmodule AdventOfCode.Day8.CPU do
  defstruct instructions: [], next: 0, acum: 0

  def new(instructions) do
    %AdventOfCode.Day8.CPU{
      instructions: instructions,
      next: 0,
      acum: 0
    }
  end

  def parse(instruction) do
    instruction
    |> (& Regex.scan(~r"(...) ((\+|-)\d+)", &1)).()
    |> List.flatten()
    |> (fn(parts) -> { parts |> Enum.at(1), parts |> Enum.at(2) |> String.to_integer() } end).()
  end

  def run_once(cpu) do
    cpu.instructions
    |> Enum.at(cpu.next)
    |> execute(cpu)
  end

  def change_instruction(cpu, line, instruction) do
    %{ cpu | instructions: cpu.instructions |> List.replace_at(line, instruction) }
  end

  defp execute({"acc", argument}, cpu) do %{cpu | next: cpu.next + 1, acum: cpu.acum + argument} end
  defp execute({"jmp", argument}, cpu) do %{cpu | next: cpu.next + argument} end
  defp execute({"nop", _}, cpu)        do %{cpu | next: cpu.next + 1} end
end
