class BusinessHour < ActiveRecord::Base
  TIMES = [:start_time, :end_time, :start_time2, :end_time2]
  attr_accessible *(TIMES + [:day])
  
  belongs_to :merchant
  
  before_validation do
    if start_time.present? && end_time.blank?
      errors.add(:end_time, :blank)
    elsif start_time.blank? && end_time.present?
      errors.add(:start_time, :blank)
    end
    
    if start_time2.present? && end_time2.blank?
      errors.add(:end_time2, :blank)
    elsif start_time2.blank? && end_time2.present?
      errors.add(:start_time2, :blank)
    end
    
    TIMES.each do |time|
      if a = read_attribute(time) and a < 0
        errors.add(time)
      end
    end
  end

  # Followed http://stackoverflow.com/questions/538739/best-way-to-store-time-hhmm-in-a-database for times
  # Stored as integer number of seconds since midnight
  TIMES.each do |method|
    define_method method do
      if val = instance_variable_get("@#{method}_string")
        val
      elsif val = read_attribute(method)
        (val/60).to_s.rjust(2, '0') + ':' + (val%60).to_s.rjust(2, '0')
      else
        nil
      end
    end
    
    define_method method.to_s + '=' do |value|
      instance_variable_set("@#{method}_string", value)
      
      if value.blank?
        super(nil)
      else
        hour, min = value.match(/^(\d+):(\d\d)/).to_a.rotate

        if hour && min && (i = 60 * hour.to_i + min.to_i) < 1439 # Max time
          super(i)
        else
          super(-1) # Signals badly formed input to validator
        end
      end
    end
  end
  
  def open?
    !closed?
  end
  
  def closed?
    start_time.blank?
  end
  
  def closed_for_lunch?
    open? && start_time2.present?
  end
  
  def day_name
    I18n.t('date.day_names')[day]
  end
  
  def to_s
    day_name
  end
  
  def description
    if closed?
      I18n.t('merchants.hours.closed')
    elsif closed_for_lunch?
      I18n.t('merchants.show.business_hour_with_break',
        :start_time => start_time,
        :end_time => end_time,
        :start_time2 => start_time2,
        :end_time2 => end_time2
      )
    else
      I18n.t('merchants.show.business_hour',
        :start_time => start_time,
        :end_time => end_time
      )
    end
  end
end