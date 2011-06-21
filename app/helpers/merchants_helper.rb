module MerchantsHelper
  def business_hour_class(time, hour)
    classes = []
    classes << 'monday' if hour.day == 1
    classes << time.to_s
    classes.join(' ')
  end
end