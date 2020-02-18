require 'rgeo/geo_json'

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

  def search
    location = RGeo::Geographic.spherical_factory.point(params[:lng].to_f, params[:lat].to_f)
    
    partners_available = partners_inside_coverage_area(location)
    if partners_available == nil
      render json: { error: "Nenhum parceiro disponível" }
    else
      nearest_partner = find_nearest_partner(location, partners_available)
      byebug
    end
  end

  private
    def partners_inside_coverage_area(location)
      array = Array.new

      Partner.all.each do |partner|
        polygon = RGeo::GeoJSON.decode(partner.coverageArea)
        if polygon.contains?(location)
          array.push partner.id
        end
      end

      if array.length != 0
        Partner.find(array)
      else
        nil
      end
    end

    def find_nearest_partner(location, partners_available)
      @distances = {}
      partners_available.each do |partner|
        partner_address = RGeo::Geographic.spherical_factory.point(partner.address['coordinates'][0], partner.address['coordinates'][1])
        distance = location.distance(partner_address)
        @distances[partner.id] = distance
      end
      Partner.find(@distances.min_by{|k,v|v}.first)
    end

  def distance
    partner = Partner.find(params[:id])
    partner_address = RGeo::Geographic.spherical_factory.point(partner.address['coordinates'][0], partner.address['coordinates'][1])
    client_address = RGeo::Geographic.spherical_factory.point(-43.432034, -22.747707)
    @distance = client_address.distance(partner_address)
    render json: @distance
  end

  private
    def partner_params
      params.require(:partner).permit!
    end
end
