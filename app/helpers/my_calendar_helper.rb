module MyCalendarHelper
  def link_to_previous_week(year, week, options={})
    target_year, target_week = if week == 1
                                  [year - 1, 52]
                                else
                                  [year, week - 1]
                                end
    date = Date.commercial(target_year, target_week, 1)
    name = "#{1.day.ago(date).strftime('%b, %-d %Y')} - #{5.days.since(date).strftime('%b, %-d %Y')}"

    link_to_week(('&#171; ' + name), target_year, target_week, options)
  end

  def link_to_next_week(year, week, options={})
    target_year, target_week = if week == 52
                                  [year + 1, 1]
                                else
                                  [year, week + 1]
                                end

    date = Date.commercial(target_year, target_week, 1)
    name = "#{1.day.ago(date).strftime('%b, %-d %Y')} - #{5.days.since(date).strftime('%b, %-d %Y')}"
    
    link_to_week((name + ' &#187;'), target_year, target_week, options)
  end

  def link_to_week(link_name, year, week, options={})
    link_to_content_update(link_name, params.merge({:week => week, :year => year}))
  end
end
