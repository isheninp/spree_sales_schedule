class Spree::SalesSchedule < ActiveRecord::Base
  belongs_to :variant
  validates :start_time, :end_time, presence: true
  validate :validate_correct_period
  validate :validate_past_period

  private

  def validate_correct_period
    if end_time < start_time
      errors.add(:end_time, I18n.t('sales_schedule.validate_correct_period_error'))
    end
  end

  def validate_past_period
    if start_time < Date.today
      errors.add(:start_time, I18n.t('sales_schedule.validate_past_period_error'))
    end
  end

end
