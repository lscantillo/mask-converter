class Api::V1::ConverterController < Api::V1::ApplicationController
  before_action :authorize_request
  before_action :cidr_to_mask_params, only: [:cidr_to_mask]
  before_action :mask_to_cidr_params, only: [:mask_to_cidr]

  def cidr_to_mask
    @cidr = params[:cidr]
    @mask = IPAddr.new('255.255.255.255').mask(@cidr).to_s
    render json: {
      function: 'cidr_to_mask',
      input: @cidr,
      output: @mask
    }, status: :ok
  rescue StandardError => e
    render json: {
      function: 'cidr_to_mask',
      input: @cidr,
      error: e.message
    }, status: :unprocessable_entity
  end


  def mask_to_cidr
    @mask = params[:mask]
    mask_int = NetAddr.netmask_to_i(@mask)
    @cidr = NetAddr.mask_to_bits(mask_int)
    render json: {
      function: 'mask_to_cidr',
      input: @mask,
      output: @cidr
    }, status: :ok
  rescue StandardError => e
    render json: {
      function: 'mask_to_cidr',
      input: @mask,
      error: e.message
    }, status: :unprocessable_entity
  end

  private
  # Strong params to filter the input
  def cidr_to_mask_params
    params.permit(:cidr)
  end

  def mask_to_cidr_params
    params.permit(:mask)
  end
end
