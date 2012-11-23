def select_date(date, options = {})  
  raise ArgumentError, 'from is a required option' if options[:from].blank?
  field = options[:from].to_s
  select date.day.to_s,                :from => "#{field}_3i"
  select Date::MONTHNAMES[date.month], :from => "#{field}_2i"
  select date.year.to_s,               :from => "#{field}_1i"
end