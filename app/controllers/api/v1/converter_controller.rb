class Api::V1::ConverterController < ApplicationController
  before_action :authorize_request
  before_action :cidr_to_mask_params, only: [:cidr_to_mask]
  before_action :mask_to_cidr_params, only: [:mask_to_cidr]

  def cidr_to_mask
    @cidr = params[:cidr]
    @mask = @cidr.to_i.to_s(2).count('1').to_s
    render json: {
      function: 'cidr_to_mask',
      input: @cidr,
      output: @mask
    }, status: :ok
  end

  def mask_to_cidr
    @mask = params[:mask]
    mask_int = NetAddr.netmask_to_i(@mask)
    @cidr = NetAddr.mask_to_bits(mask_int)
    render json: {
      function: 'mask_to_cidr',
      input: @cidr,
      output: @mask
    }, status: :ok
  end

  private

  def cidr_to_mask_params
    params.permit(:cidr)
  end

  def mask_to_cidr_params
    params.permit(:mask)
  end
end
