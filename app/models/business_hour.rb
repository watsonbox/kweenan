class BusinessHour < ActiveRecord::Base
  TIMES = [:start_time, :end_time, :break_start_time, :break_end_time]
  attr_accessible *(TIMES + [:day])
  
  belongs_to :merchant
  
  before_validation do
    if start_time.present? && end_time.blank?
      errors.add(:end_time, :blank)
    elsif start_time.blank? && end_time.present?
      errors.add(:start_time, :blank)
    end
    
    if break_start_time.present? && break_end_time.blank?
      errors.add(:break_end_time, :blank)
    elsif break_start_time.blank? && break_end_time.present?
      errors.add(:break_start_time, :blank)
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
      elsif val = super()
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
  
  def day_name
    I18n.t('date.day_names')[day]
  end
  
  def to_s
    day_name
  end
end