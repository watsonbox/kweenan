module MerchantsHelper
  def business_hour_class(time, hour)
    if hour.day == 1
      'monday ' + time.to_s
    elsif hour.day != 0
      time.to_s
    else
      ''
    end
  end
end