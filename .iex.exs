defmodule Dbg do
  def trace(m, f, match_spec \\ []) do
    :dbg.tracer()
    :dbg.p(:all, :c)
    :dbg.tp(m, f, match_spec)
  end

  def stop_trace do
    :dbg.stop_clear()
  end
end
