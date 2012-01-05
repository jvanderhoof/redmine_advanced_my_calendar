module MyControllerPatch
  def self.included(base) # :nodoc:
    base.send(:include, InstanceMethods)

    base.class_eval do
      alias_method_chain :page, :custom_page
      alias_method_chain :page_layout, :custom_page_layout
    end
  end

  module InstanceMethods
    
    BLOCKS = { 'issuesassignedtome' => :label_assigned_to_me_issues,
               'issuesreportedbyme' => :label_reported_issues,
               'issueswatched' => :label_watched_issues,
               'news' => :label_news_latest,
               'calendar' => :label_calendar,
               'documents' => :label_document_plural,
               'timelog' => :label_spent_time
             }.merge(Redmine::Views::MyPage::Block.additional_blocks).freeze
    
    DEFAULT_LAYOUT = {  'left' => ['issuesassignedtome'], 
                       'right' => ['issuesreportedbyme'] 
                    }.freeze
    

    def page_layout_with_custom_page_layout
      @year ||= Date.today.year
      @week ||= Date.today.cweek
      @user = User.current
      @blocks = @user.pref[:my_page_layout] || DEFAULT_LAYOUT.dup
      @block_options = []
      BLOCKS.each {|k, v| @block_options << [l("my.blocks.#{v}", :default => [v, v.to_s.humanize]), k.dasherize]}
    end
    
    
    def page_with_custom_page
      if params[:year] and params[:year].to_i > 1900
        @year = params[:year].to_i
        if params[:week] and params[:week].to_i > 0 and params[:week].to_i < 53
          @week = params[:week].to_i
        end    
      end
      @year ||= Date.today.year
      @week ||= Date.today.cweek
            
      @user = User.current
      @blocks = @user.pref[:my_page_layout] || DEFAULT_LAYOUT
      
    end
  end
end
