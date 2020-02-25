defmodule NewWay.Schema.Invoice do
  use Ecto.Schema
  @schema_prefix "nw"

  import NewWay.Macro.{EnumType, LookupKey}

  defenum(InvoiceStatus, [
    :unpaid,
    :paid,
    :cancelled,
    :fulfilled
  ])

  lookup_key(invoice_id)

  schema "invoice" do
    field(:event_created_at,         :naive_datetime)
    field(:invoice_id,               :string)
    field(:party_id,                 :string)
    field(:shop_id,                  :string)
    field(:party_revision,           :integer)
    field(:created_at,               :naive_datetime)
    field(:status,                   InvoiceStatus)
    field(:status_cancelled_details, :string)
    field(:status_fulfilled_details, :string)
    field(:details_product,          :string)
    field(:details_description,      :string)
    field(:due,                      :naive_datetime)
    field(:amount,                   :integer)
    field(:currency_code,            :string)
    field(:context,                  :binary)
    field(:template_id,              :string)
    field(:wtime,                    :naive_datetime)
    field(:current,                  :boolean)
    field(:sequence_id,              :integer)
    field(:change_id,                :integer)
    field(:external_id,              :string)
  end
end

defimpl Pathfinder.Protocol.Thrift, for: NewWay.Schema.Invoice do
  alias Pathfinder.Protocol.Thrift
  import Thrift.Header

  @spec encode(%NewWay.Schema.Invoice{}) :: Thrift.Header.t
  def encode(invoice) do
    pf_Invoice(
      id:
        Thrift.encode(invoice.id),
      event_created_at:
        Thrift.encode(invoice.event_created_at),
      invoice_id:
        Thrift.encode(invoice.invoice_id),
      party_id:
        Thrift.encode(invoice.party_id),
      shop_id:
        Thrift.encode(invoice.shop_id),
      party_revision:
        Thrift.encode(invoice.party_revision),
      created_at:
        Thrift.encode(invoice.created_at),
      status:
        Thrift.encode(invoice.status),
      status_cancelled_details:
        Thrift.encode(invoice.status_cancelled_details),
      status_fulfilled_details:
        Thrift.encode(invoice.status_fulfilled_details),
      details_product:
        Thrift.encode(invoice.details_product),
      details_description:
        Thrift.encode(invoice.details_description),
      due:
        Thrift.encode(invoice.due),
      amount:
        Thrift.encode(invoice.amount),
      currency_code:
        Thrift.encode(invoice.currency_code),
      context:
        Thrift.encode(invoice.context),
      template_id:
        Thrift.encode(invoice.template_id),
      wtime:
        Thrift.encode(invoice.wtime),
      current:
        Thrift.encode(invoice.current),
      sequence_id:
        Thrift.encode(invoice.sequence_id),
      change_id:
        Thrift.encode(invoice.change_id),
      external_id:
        Thrift.encode(invoice.external_id)
    )
  end
end
