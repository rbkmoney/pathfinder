defmodule Pathfinder do
  @type id :: binary
  @type namespace ::
    :adjustments |
    :destinations |
    :invoices |
    :payments |
    :payouts |
    :refunds |
    :wallets |
    :withdrawals
end
