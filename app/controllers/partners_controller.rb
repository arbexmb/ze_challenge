class PartnersController < ApplicationController
  def create
    @partner = Partner.new(partner_params)

    if @partner.save
      render json: @partner, status: 201
    else
      render json: @partner.errors, status: :unprocessable_entity
    end
  end

  def show
    @partner = Partner.find(params[:id])
    render json: @partner
  end

  private
    def partner_params
      params.require(:partner).permit(
        :tradingName,
        :ownerName,
        :document,
        :coverageArea => [:type, :coordinates => []],
        :address => [:type, :coordinates => []]
      )
    end
end
