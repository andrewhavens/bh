require 'action_view'

module Bh
  module BaseHelper
    include ActionView::Helpers::TagHelper # for content_tag
    include ActionView::Context # for capture
    include ActionView::Helpers::OutputSafetyHelper # for safe_join
    include ActionView::Helpers::RenderingHelper # for render
    include ActionView::Helpers::UrlHelper # for link_to

  private

    def append_class!(hash, new_class, attribute = :class)
      existing_class = hash[attribute]
      hash[attribute] = [existing_class, new_class].compact.join ' '
    end

    def append_class_as!(attribute, new_class, *args, &block)
      html_options = (block_given? ? args[1] : args[2]) || {}
      append_class! html_options, new_class, attribute
      block_given? ? args[1] = html_options : args[2] = html_options
      args
    end

    def context_for(context = nil, options = {})
      context = case context.to_s
        when 'notice' then 'success'
        when 'alert' then 'danger'
        else context.to_s
      end

      if options.fetch(:valid, []).map(&:to_s).include? context
        context
      else
        options.fetch :default, 'default'
      end
    end
  end
end