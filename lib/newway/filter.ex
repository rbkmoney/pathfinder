defmodule NewWay.Filter do
  @default_limit 10
  @default_offset 0

  defstruct [:is_current, limit: @default_limit, offset: @default_offset]
end
