require 'rgeo/geo_json'

class PartnersController < ApplicationController
  def create
    if params['pdvs'].present? && params['pdvs'].count > 1
      before_count = Partner.count
      mass_create(params['pdvs'])
      if Partner.count > before_count
        render json: { success: "Records created" }, status: 201
      else
        render json: { error: "No record created" }, status: :unprocessable_entity
      end
    else
      @partner = Partner.new(partner_params)

      if @partner.save
        render json: @partner, status: 201
      else
        render json: @partner.errors, status: :unprocessable_entity
      end
    end
  end

  def show
    @partner = Partner.find(params[:id])
    render json: @partner
  end

  def search
    if params[:lng] == nil || params[:lat] == nil
      return render json: {error: "Please, inform longitude and latitude"}
    end
    if validateLngLat(params[:lng], params[:lat]) == false
      return render json: {error: "Unsupported values"}
    end
    location = RGeo::Geographic.spherical_factory.point(params[:lng].to_f, params[:lat].to_f)
    
    partners_available = partners_inside_coverage_area(location)
    if partners_available == nil
      render json: { error: "No partner available" }
    else
      nearest_partner = find_nearest_partner(location, partners_available)
      render json: { success: "The nearest partner is #{nearest_partner[:partner]['tradingName']}, at #{nearest_partner[:distance].round(2)} meters" }
    end
  end

  def validateLngLat(lng, lat)
    if valid_float?(lng) && valid_float?(lat)
      true
    else
      false
    end
  end

  protected
    def mass_create(objects)
      objects.each do |partner|
        partner.delete(:id)
        partner.permit!
        @partner = Partner.new(partner)
        @partner.save
      end
    end

    def valid_float?(string)
      !!Float(string) rescue false
    end

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
      found = Partner.find(@distances.min_by{|k,v|v}.first)
      { partner: found.attributes, distance: @distances[found.id] }
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
