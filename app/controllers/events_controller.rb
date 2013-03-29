class EventsController < ApplicationController
    def new
        @event = Event.new
    end

    def create
        @event = Event.new(params[:event])
        if @event.save
            # Add derived EventInstance records
            flash[:success] = "Event created"
            redirect_to events_path
        else
            render 'new'
        end
    end

    def edit
        @event = Event.find(params[:id])
    end

    def update
        @event = Event.find(params[:id])
        if @event.update_attributes(params[:event])
            # Delete assoc. EventInstance records
            # Add derived EventInstance records
            flash[:success] = "Event updated"
            redirect_to events_path
        else
            render 'edit'
        end
    end

    def index
        @events = Event.order("name").paginate(page: params[:page], :per_page => 10)
    end

    def show
        @event = Event.find(params[:id])
    end

    def destroy
        # Delete assoc. EventInstance records
        Event.find(params[:id]).destroy
        flash[:success] = "Event deleted."
        redirect_to events_path
    end
end
