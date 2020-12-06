class Api::V1::EntriesController < ApiController

    before_action :set_entry, only: [:update, :destroy]

    def index
        @entries = Entry.select("strftime('%m/%d/%Y',created_at) as entry_date, count(*) as count").where("user_id = ?", @current_user.id).group("date(created_at)")
        render json: @entries
    end

    def daily
        @dateString = params[:month] + "/" + params[:day] + "/" + params[:year]
        @entries = Entry.where("user_id = ? and strftime('%m/%d/%Y',created_at) = ?", @current_user.id, @dateString)

        render json: @entries
    end

    def create
        @entry = Entry.new(entry_params)

        @entry.user = @current_user

        if @entry.save
            render json: @entry
        else
            render json: {:message => "Something went wrong! Please try again."}
        end
    end
    def update
        if @entry.update(entry_params)
            render json: @entry
        else
            render json: {:message => "Something went wrong! Please try again."}
        end
    end
    def destroy
        @entry.destroy
        render json: {:message => "Entry was removed"}
    end

    private

        def set_entry
            @entry = Entry.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def entry_params
            params.require(:entry).permit(:content, :user_id)
        end
end