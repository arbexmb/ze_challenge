class PartnersController < ApplicationController
  def index
  end

  def create
    @partner = Partner.new(partner_params)

    if @partner.save
      render json: @partner, status: created, location: @partner
    else
      render json: @partner.errors, status: :unprocessable_entity
    end
  end

  def show
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
