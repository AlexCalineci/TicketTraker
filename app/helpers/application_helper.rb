module ApplicationHelper

def flash_class(level)
    case level
        when :notice then "alert alert-info"
        when :success then "alert alert-success"
        when :error then "alert alert-error"
        when :alert then "alert alert-error"
    end
end

#metode pt suprascriere button_to cu parametru - nefolosite inca dar utile
	def token_tag(token=nil)
    if token != false && protect_against_forgery?
      token ||= form_authenticity_token
      tag(:input, type: "hidden", name: request_forgery_protection_token.to_s, value: token)
    else
      ''
    end
  end

  def method_tag(method)
    tag('input', type: 'hidden', name: '_method', value: method.to_s)
  end

  def button_to_with_params(name = nil, options = nil, html_options = nil, &block)
    html_options, options = options, name if block_given?
    options      ||= {}
    html_options ||= {}

    html_options = html_options.stringify_keys
    convert_boolean_attributes!(html_options, %w(disabled))

    url    = options.is_a?(String) ? options : url_for(options)
    remote = html_options.delete('remote')
    params = html_options.delete('params') { Hash.new }

    method     = html_options.delete('method').to_s
    method_tag = %w{patch put delete}.include?(method) ? method_tag(method) : ''.html_safe

    form_method  = method == 'get' ? 'get' : 'post'
    form_options = html_options.delete('form') || {}
    form_options[:class] ||= html_options.delete('form_class') || 'button_to'
    form_options.merge!(method: form_method, action: url)
    form_options.merge!("data-remote" => "true") if remote

    request_token_tag = form_method == 'post' ? token_tag : ''

    html_options = convert_options_to_data_attributes(options, html_options)
    html_options['type'] = 'submit'

    button = if block_given?
      content_tag('button', html_options, &block)
    else
      html_options['value'] = name || url
      tag('input', html_options)
    end

    inner_tags = method_tag.safe_concat(button).safe_concat(request_token_tag)
    params.each do |name, value|
      inner_tags.safe_concat tag(:input, type: "hidden", name: name, value: value.to_param)
    end
    content_tag('form', content_tag('div', inner_tags), form_options)
  end
#end metode pt suprascriere button_to cu parametru - nefolosite inca dar utile

end
