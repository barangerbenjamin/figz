class RoutesController < ApplicationController
    before_action :set_route, only: [:show, :edit, :update, :destroy]

    def index
        @routes = Route.all
    end

    def show
        @comment = Comment.new
        @comments = @route.comments
    end

    def new
        @route = Route.new
    end

    def create
        @route = Route.new(route_params)
        @route.user = current_user
        if @route.save
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

    def destroy
        @route.destroy
        redirect_to routes_path
    end
    
    

    private

    def set_route
        @route = Route.find(params[:id])
    end
    
    def route_params
        params.require(:route).permit(:name, :start_location, :start_latitude, :start_longitude, :end_location, :end_latitude, :end_longitude, :distance, :elevation, :road_type)
    end
end
