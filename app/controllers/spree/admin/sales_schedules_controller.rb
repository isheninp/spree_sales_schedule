module Spree
  module Admin
    class SalesSchedulesController < ResourceController
      def index
        #session[:return_to] = request.url

        respond_with(@collection)
      #@sales_schedules = Spree::SalesSchedule.all
      end

      def new

      end

      private

      def collection
        return @collection if @collection.present?

        # params[:q] can be blank upon pagination
        params[:q] = {} if params[:q].blank?

        @collection = super
        @search = @collection.ransack(params[:q])
        @collection = @search.result.
                      page(params[:page]).
                      per(10)
      end

    end

  end
end