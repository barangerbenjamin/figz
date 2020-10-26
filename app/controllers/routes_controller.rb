class RoutesController < ApplicationController
    before_action :set_route, only: [:show, :edit, :update, :destroy]

    def index
        @routes = Route.all
    end

    def show
        @comment ||= Comment.new
        @comments = @route.comments
        @likes_count = @route.get_likes.size
        if @route.gpx
            key = @route.gpx.key
            fetch_and_parse = FetchAndParseGpx.new(key)
            fetch_and_parse.fetch_gpx
            points = fetch_and_parse.parse_gpx
            @points = points.map { |point| { lat: point[0], lng: point[1]}}
        end
    end

    def new
        @route = Route.new
    end

    def create
        @route = Route.new(route_params)
        @route.user = current_user
        @route.gpx.attach(params[:file]) if params[:file]
        if @route.save
            @route.liked_by current_user
            redirect_to route_path(@route), notice: "Route created"
        else
            render :new
        end
    end

    def edit; end

    def update
        if @route.update(route_params)
            redirect_to route_path(@route), notice: "Route updated"
        else
            render :edit
        end
    end  
    
    private

    def set_route
        @route = Route.find(params[:id])
    end
    
    def route_params
        params.require(:route).permit(:name, :start_location, :start_latitude, :start_longitude, :end_location, :end_latitude, :end_longitude, :distance, :elevation, :road_type, :gpx)
    end
end
