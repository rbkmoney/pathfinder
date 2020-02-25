defmodule NewWay.Schema.Payment do
  use Ecto.Schema
  @schema_prefix "nw"

  import NewWay.Macro.{EnumType, LookupKey}

  defenum(PaymentStatus, [
    :pending,
    :processed,
    :captured,
    :cancelled,
    :refunded,
    :failed
  ])

  defenum(PayerType, [
    :payment_resource,
    :customer,
    :recurrent
  ])

  defenum(PaymentToolType, [
    :bank_card,
    :payment_terminal,
    :digital_wallet,
    :crypto_currency,
    :mobile_commerce
  ])

  defenum(PaymentFlowType, [
    :instant,
    :hold
  ])

  defenum(RiskScore, [
    :low,
    :high,
    :fatal
  ])

  lookup_key(payment_id)

  schema "payment" do
    field(:event_created_at,                                 :naive_datetime)
    field(:payment_id,                                       :string)
    field(:created_at,                                       :naive_datetime)
    field(:invoice_id,                                       :string)
    field(:party_id,                                         :string)
    field(:shop_id,                                          :string)
    field(:domain_revision,                                  :integer)
    field(:party_revision,                                   :integer)
    field(:status,                                           PaymentStatus)
    field(:status_cancelled_reason,                          :string)
    field(:status_captured_reason,                           :string)
    field(:status_failed_failure,                            :string)
    field(:amount,                                           :integer)
    field(:currency_code,                                    :string)
    field(:payer_type,                                       PayerType)
    field(:payer_payment_tool_type,                          PaymentToolType)
    field(:payer_bank_card_token,                            :string)
    field(:payer_bank_card_payment_system,                   :string)
    field(:payer_bank_card_bin,                              :string)
    field(:payer_bank_card_masked_pan,                       :string)
    field(:payer_bank_card_token_provider,                   :string)
    field(:payer_payment_terminal_type,                      :string)
    field(:payer_digital_wallet_provider,                    :string)
    field(:payer_digital_wallet_id,                          :string)
    field(:payer_payment_session_id,                         :string)
    field(:payer_ip_address,                                 :string)
    field(:payer_fingerprint,                                :string)
    field(:payer_phone_number,                               :string)
    field(:payer_email,                                      :string)
    field(:payer_customer_id,                                :string)
    field(:payer_customer_binding_id,                        :string)
    field(:payer_customer_rec_payment_tool_id,               :string)
    field(:context,                                          :binary)
    field(:payment_flow_type,                                PaymentFlowType)
    field(:payment_flow_on_hold_expiration,                  :string)
    field(:payment_flow_held_until,                          :naive_datetime)
    field(:risk_score,                                       RiskScore)
    field(:route_provider_id,                                :integer)
    field(:route_terminal_id,                                :integer)
    field(:wtime,                                            :naive_datetime)
    field(:current,                                          :boolean)
    field(:session_payload_transaction_bound_trx_id,         :string)
    field(:session_payload_transaction_bound_trx_extra_json, :string)
    field(:fee,                                              :integer)
    field(:provider_fee,                                     :integer)
    field(:external_fee,                                     :integer)
    field(:guarantee_deposit,                                :integer)
    field(:make_recurrent,                                   :boolean)
    field(:payer_recurrent_parent_invoice_id,                :string)
    field(:payer_recurrent_parent_payment_id,                :string)
    field(:recurrent_intention_token,                        :string)
    field(:sequence_id,                                      :integer)
    field(:change_id,                                        :integer)
    field(:trx_additional_info_rrn,                          :string)
    field(:trx_additional_info_approval_code,                :string)
    field(:trx_additional_info_acs_url,                      :string)
    field(:trx_additional_info_pareq,                        :string)
    field(:trx_additional_info_md,                           :string)
    field(:trx_additional_info_term_url,                     :string)
    field(:trx_additional_info_pares,                        :string)
    field(:trx_additional_info_eci,                          :string)
    field(:trx_additional_info_cavv,                         :string)
    field(:trx_additional_info_xid,                          :string)
    field(:trx_additional_info_cavv_algorithm,               :string)
    field(:trx_additional_info_three_ds_verification,        :string)
    field(:payer_crypto_currency_type,                       :string)
    field(:status_captured_started_reason,                   :string)
    field(:payer_mobile_phone_cc,                            :string)
    field(:payer_mobile_phone_ctn,                           :string)
    field(:capture_started_params_cart_json,                 :string)
    field(:external_id,                                      :string)
    field(:payer_issuer_country,                             :string)
    field(:payer_bank_name,                                  :string)
  end
end

defimpl Pathfinder.Protocol.Thrift, for: NewWay.Schema.Payment do
  alias Pathfinder.Protocol.Thrift
  import Thrift.Header

  @spec encode(%NewWay.Schema.Payment{}) :: Thrift.Header.t
  def encode(payment) do
    pf_Payment(
      id:
        Thrift.encode(payment.id),
      event_created_at:
        Thrift.encode(payment.event_created_at),
      payment_id:
        Thrift.encode(payment.payment_id),
      created_at:
        Thrift.encode(payment.created_at),
      invoice_id:
        Thrift.encode(payment.invoice_id),
      party_id:
        Thrift.encode(payment.party_id),
      shop_id:
        Thrift.encode(payment.shop_id),
      domain_revision:
        Thrift.encode(payment.domain_revision),
      party_revision:
        Thrift.encode(payment.party_revision),
      status:
        Thrift.encode(payment.status),
      status_cancelled_reason:
        Thrift.encode(payment.status_cancelled_reason),
      status_captured_reason:
        Thrift.encode(payment.status_captured_reason),
      status_failed_failure:
        Thrift.encode(payment.status_failed_failure),
      amount:
        Thrift.encode(payment.amount),
      currency_code:
        Thrift.encode(payment.currency_code),
      payer_type:
        Thrift.encode(payment.payer_type),
      payer_payment_tool_type:
        Thrift.encode(payment.payer_payment_tool_type),
      payer_bank_card_token:
        Thrift.encode(payment.payer_bank_card_token),
      payer_bank_card_payment_system:
        Thrift.encode(payment.payer_bank_card_payment_system),
      payer_bank_card_bin:
        Thrift.encode(payment.payer_bank_card_bin),
      payer_bank_card_masked_pan:
        Thrift.encode(payment.payer_bank_card_masked_pan),
      payer_bank_card_token_provider:
        Thrift.encode(payment.payer_bank_card_token_provider),
      payer_payment_terminal_type:
        Thrift.encode(payment.payer_payment_terminal_type),
      payer_digital_wallet_provider:
        Thrift.encode(payment.payer_digital_wallet_provider),
      payer_digital_wallet_id:
        Thrift.encode(payment.payer_digital_wallet_id),
      payer_payment_session_id:
        Thrift.encode(payment.payer_payment_session_id),
      payer_ip_address:
        Thrift.encode(payment.payer_ip_address),
      payer_fingerprint:
        Thrift.encode(payment.payer_fingerprint),
      payer_phone_number:
        Thrift.encode(payment.payer_phone_number),
      payer_email:
        Thrift.encode(payment.payer_email),
      payer_customer_id:
        Thrift.encode(payment.payer_customer_id),
      payer_customer_binding_id:
        Thrift.encode(payment.payer_customer_binding_id),
      payer_customer_rec_payment_tool_id:
        Thrift.encode(payment.payer_customer_rec_payment_tool_id),
      context:
        Thrift.encode(payment.context),
      payment_flow_type:
        Thrift.encode(payment.payment_flow_type),
      payment_flow_on_hold_expiration:
        Thrift.encode(payment.payment_flow_on_hold_expiration),
      payment_flow_held_until:
        Thrift.encode(payment.payment_flow_held_until),
      risk_score:
        Thrift.encode(payment.risk_score),
      route_provider_id:
        Thrift.encode(payment.route_provider_id),
      route_terminal_id:
        Thrift.encode(payment.route_terminal_id),
      wtime:
        Thrift.encode(payment.wtime),
      current:
        Thrift.encode(payment.current),
      session_payload_transaction_bound_trx_id:
        Thrift.encode(payment.session_payload_transaction_bound_trx_id),
      session_payload_transaction_bound_trx_extra_json:
        Thrift.encode(payment.session_payload_transaction_bound_trx_extra_json),
      fee:
        Thrift.encode(payment.fee),
      provider_fee:
        Thrift.encode(payment.provider_fee),
      external_fee:
        Thrift.encode(payment.external_fee),
      guarantee_deposit:
        Thrift.encode(payment.guarantee_deposit),
      make_recurrent:
        Thrift.encode(payment.make_recurrent),
      payer_recurrent_parent_invoice_id:
        Thrift.encode(payment.payer_recurrent_parent_invoice_id),
      payer_recurrent_parent_payment_id:
        Thrift.encode(payment.payer_recurrent_parent_payment_id),
      recurrent_intention_token:
        Thrift.encode(payment.recurrent_intention_token),
      sequence_id:
        Thrift.encode(payment.sequence_id),
      change_id:
        Thrift.encode(payment.change_id),
      trx_additional_info_rrn:
        Thrift.encode(payment.trx_additional_info_rrn),
      trx_additional_info_approval_code:
        Thrift.encode(payment.trx_additional_info_approval_code),
      trx_additional_info_acs_url:
        Thrift.encode(payment.trx_additional_info_acs_url),
      trx_additional_info_pareq:
        Thrift.encode(payment.trx_additional_info_pareq),
      trx_additional_info_md:
        Thrift.encode(payment.trx_additional_info_md),
      trx_additional_info_term_url:
        Thrift.encode(payment.trx_additional_info_term_url),
      trx_additional_info_pares:
        Thrift.encode(payment.trx_additional_info_pares),
      trx_additional_info_eci:
        Thrift.encode(payment.trx_additional_info_eci),
      trx_additional_info_cavv:
        Thrift.encode(payment.trx_additional_info_cavv),
      trx_additional_info_xid:
        Thrift.encode(payment.trx_additional_info_xid),
      trx_additional_info_cavv_algorithm:
        Thrift.encode(payment.trx_additional_info_cavv_algorithm),
      trx_additional_info_three_ds_verification:
        Thrift.encode(payment.trx_additional_info_three_ds_verification),
      payer_crypto_currency_type:
        Thrift.encode(payment.payer_crypto_currency_type),
      status_captured_started_reason:
        Thrift.encode(payment.status_captured_started_reason),
      payer_mobile_phone_cc:
        Thrift.encode(payment.payer_mobile_phone_cc),
      payer_mobile_phone_ctn:
        Thrift.encode(payment.payer_mobile_phone_ctn),
      capture_started_params_cart_json:
        Thrift.encode(payment.capture_started_params_cart_json),
      external_id:
        Thrift.encode(payment.external_id),
      payer_issuer_country:
        Thrift.encode(payment.payer_issuer_country),
      payer_bank_name:
        Thrift.encode(payment.payer_bank_name)
    )
  end
end
