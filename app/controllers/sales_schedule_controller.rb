module Spree
  module Admin
    class SalesScheduleController < ResourceController
      def index
        @sales_schedule = Spree::SalesSchedule.all
      end
    end
  end
end