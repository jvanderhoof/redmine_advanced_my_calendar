module MyControllerPatch
  def self.included(base) # :nodoc:
    base.send(:include, InstanceMethods)

    base.class_eval do
      alias_method_chain :page, :custom_page
    end
  end

  module InstanceMethods
    def page_with_custom_page
      Rails.logger.info "page_with_custom_page (params): #{params.inspect}"      
      #raise params[:week].to_i.class.to_s
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
