require 'redmine'

require 'my_controller_patch'

Redmine::Plugin.register :redmine_advanced_my_calendar do
  name 'Redmine Advanced My Calendar plugin'
  author 'Jason Vanderhoof'
  description 'This is a Redmine plugin to filter the calendar on My Page, and provide paging by week.'
  version '0.0.1'
  url 'https://github.com/jvanderhoof/redmine_advanced_my_calendar'
  author_url ''
end

Dispatcher.to_prepare :redmine_advanced_my_calendar do
  require_dependency 'my_controller'
  MyController.send(:helper, MyCalendarHelper)
  MyController.send(:include, MyControllerPatch)
end
