defmodule Dbg do
  def trace(m, f, match_spec \\ []) do
    :dbg.tracer()
    :dbg.p(:all, :c)
    :dbg.tp(m, f, match_spec)
  end

  def stop_trace do
    :dbg.stop()
  end
end

defmodule T do
  def recompile_and_tests(test_files, recompile_targets \\ [], timeout \\ :infinity)

  def recompile_and_tests(test_file, recompile_targets, timeout) when is_binary(test_file) do
    [test_file | line_numbers] =  String.split(test_file, ":")

    if Enum.empty?(line_numbers) do
      [include: [], exclude: []]
    else
      included =
        line_numbers
        |> Enum.map(fn line_number -> [line: line_number] end)
        |> List.flatten()

      [include: included, exclude: [:test]]
    end
    |> ExUnit.configure()

    recompile_and_tests([test_file], recompile_targets, timeout)
  end

  def recompile_and_tests([test_file], recompile_targets, timeout) when is_binary(test_file) do
    if String.contains?(test_file, ":") do
      recompile_and_tests(test_file, recompile_targets, timeout)
    else
      do_recompile_and_tests([test_file], recompile_targets, timeout)
    end
  end

  def recompile_and_tests(test_files, recompile_targets, timeout) when is_list(test_files) do
    do_recompile_and_tests(test_files, recompile_targets, timeout)
  end

  def do_recompile_and_tests(test_files, recompile_targets, timeout) when is_list(test_files) do
    ExUnit.start(timeout: :infinity)
    task = Task.async(ExUnit, :run, [])

    List.wrap(recompile_targets)
    |> List.wrap()
    |> Enum.map(&Path.wildcard/1)
    |> List.flatten()
    |> Kernel.ParallelCompiler.compile()

    test_files
    |> List.wrap()
    |> Enum.map(&Path.wildcard/1)
    |> List.flatten()
    |> Enum.each(&Code.compile_file/1)

    ExUnit.Server.modules_loaded(:a)
    Task.await(task, timeout)
  end

  def inspect_sup_structure(pid) do
    inspect_sup_structure({"TOP LEVEL", pid, "", ""}, 0)
  end

  @offset_increment 3

  def inspect_sup_structure(list, offset) when is_list(list) do
    for {_, _, :supervisor, _} = elem <- list do
      inspect_sup_structure(elem, offset + @offset_increment)
    end
  end

  def inspect_sup_structure({_, pid, _, _} = input, offset) when is_pid(pid) do
    (String.duplicate(" ", offset) <> "INPUT: " <> inspect(input, pretty: true))
    |> IO.puts()

    children = Supervisor.which_children(pid)

    (String.duplicate(" ", offset) <> "CHILDREN: " <> inspect(children, pretty: true))
    |> IO.puts()

    inspect_sup_structure(children, offset)
  end

end

# Dbg.trace(ExUnit.Server, :handle_call, :x)
# Dbg.trace(ExUnit, :configure, :x)

IO.puts ""
IO.puts "To set breakpoint use: 'break! Module.function/n, break_count'"
IO.puts "To run test use: 'T.recompile_and_tests(\"test_file_name:line\")'"
