module Spree
  module Admin
    class SalesSchedulesController < ResourceController
      
      def index
        #session[:return_to] = request.url

        #respond_with(@collection)
        
        @sales_schedules = Spree::SalesSchedule.all
        @sales_schedules = @sales_schedules.joins({:variant => :product}).where("spree_products.name LIKE '%#{params[:q][:title_cont]}%'") if params[:q][:title_cont]
        @sales_schedules = @sales_schedules.where("spree_products.discontinue_on > NOW()") if params[:q][:not_discontinued] == '1'
        @sales_schedules = @sales_schedules.order(params[:q][:s]) if params[:q][:s]
        @sales_schedules = @sales_schedules.page(params[:page]).per(params[:per_page])
        
      end

      def new
        @variant = Spree::Variant.find(params['v']) if params[:v]
      end
      
      def create

        @sales_schedule = Spree::SalesSchedule.new(schedule_params)
        
        if schedule_params[:return_to_product]
          variant = Spree::Variant.find(schedule_params[:variant_id])
          product = variant.product
        end 
        
        if @sales_schedule.save
          flash[:success] = flash_message_for(@sales_schedule, :successfully_created)
          redirect_to schedule_params[:return_to_product]='1' ? sales_schedules_admin_product_url(product) + "#{schedule_params[:lesson].blank? ? '' : "#sales-schedule-"+schedule_params[:lesson]}" : edit_admin_sales_schedule_path(@sales_schedule)
        else
          render :new
        end        
        
      end

      def edit
        @return_to_product = params['l'].blank? ? '0' : '1'
      end
      
      def update
        invoke_callbacks(:update, :before)
        if @sales_schedule.update_attributes(schedule_params)
          invoke_callbacks(:update, :after)
          flash[:success] = flash_message_for(@sales_schedule, :successfully_updated)
          if schedule_params[:return_to_product]
            variant = Spree::Variant.find(schedule_params[:variant_id])
            product = variant.product
          end 

          respond_with(@sales_schedule) do |format|
            format.html { redirect_to schedule_params[:return_to_product]=='1' ? sales_schedules_admin_product_url(product) + "#{schedule_params[:lesson].blank? ? '' : "#sales-schedule-"+schedule_params[:lesson]}" : location_after_save }
            format.js   { render layout: false }
          end
        else
          # Stops people submitting blank slugs, causing errors when they try to
          # update the product again
          invoke_callbacks(:update, :fails)
          respond_with(@sales_schedule)
        end
      end
      
      private

      def collection
        return @collection if @collection.present?

        params[:q] ||= {}        
               
        @collection = super
        @search = @collection.ransack(params[:q])
        @collection = @search.result.page(params[:page]).per(params[:per_page])
        
      end
      
      def schedule_params
        params.require(:sales_schedule).permit(:variant_id, :start_time, :end_time, :number, :title, :description, :return_to_product, :lesson)
      end

    end

  end
end