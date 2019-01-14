class Spree::SalesSchedule < ActiveRecord::Base
  belongs_to :variant
  validates :start_time, :end_time, presence: true
  #validate :validate_correct_string
  validate :validate_correct_period
  validate :validate_past_period


  private

  def validate_correct_string
    if !(Date.strptime(start_time,'%Y-%m-%d %H:%M') rescue nil)
      errors.add(:start_time, I18n.t('sales_shedule.validate_correct_string_error'))
    end
    if !(Date.strptime(end_time,'%Y-%m-%d %H:%M') rescue nil)
      errors.add(:end_time, I18n.t('sales_shedule.validate_correct_string_error'))
    end  
  end
  
  def validate_correct_period
    if end_time < start_time
      errors.add(:end_time, I18n.t('sales_shedule.validate_correct_period_error'))
    end
  end

  def validate_past_period
    if start_time < Date.today
      errors.add(:start_time, I18n.t('sales_schedule.validate_past_period_error'))
    end
  end

end
