require 'redmine'

require 'my_controller_patch'

Redmine::Plugin.register :redmine_advanced_my_calendar do
  name 'Redmine Advanced My Calendar plugin'
  author 'Jason Vanderhoof'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
end

Dispatcher.to_prepare :redmine_advanced_my_calendar do
  require_dependency 'my_controller'
  MyController.send(:helper, MyCalendarHelper)
  MyController.send(:include, MyControllerPatch)
end
