defmodule MsgBoardTest do
  use ExUnit.Case
  doctest MsgBoard

  test "greets the world" do
    assert MsgBoard.hello() == :world
  end
end
