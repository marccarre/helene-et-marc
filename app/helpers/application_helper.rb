module ApplicationHelper
  # Usage:
  #   <%= glyphicon('glyphicon-remove') %>
  #
  # See also: http://getbootstrap.com/components/
  def glyphicon(name, text='', options={})
    content_tag(:span, '', class: 'glyphicon '+name, options: options) + text
  end


  def phone_to(text)
    if text.include? '+'
      link_to text, 'tel:#{text}'

    else
      sets_of_numbers = text.scan(/[0-9]+/)
      length = sets_of_numbers.join.length

      if length == 10 # French number
        number = '+33-#{sets_of_numbers.join("-")}'
        link_to text, 'tel:#{number}'

      elsif length == 11 # British number
        number = '+44-#{sets_of_numbers.join("-")}'
        link_to text, 'tel:#{number}'

      else # Unknown, print as it is
        link_to text, 'tel:#{text}'
      end
    end
  end


  def mail_to_or_default(email, options={})
    options[:prefix] ||= ''
    options[:default] ||= 'N/A'

    if email.present?
      options[:prefix].html_safe + mail_to(email)
    else
      options[:default].html_safe
    end
  end


  def tbs3_inline_text_field(f, field, name, options={})
    options[:class] = [options[:class], 'form-control input-sm'].compact.join(' ')
    options[:placeholder] = name

    content_tag(:div, class: 'form-group') do
      f.label(field, name, class: 'sr-only') +
      f.text_field(field, options)
    end 
  end

  def tbs3_inline_email_field(f, field, name, options={})
    options[:class] = [options[:class], 'form-control input-sm'].compact.join(' ')
    options[:placeholder] = name

    content_tag(:div, class: 'form-group') do
      f.label(field, name, class: 'sr-only') +
      f.email_field(field, options)
    end 
  end

  def tbs3_inline_telephone_field(f, field, name, options={})
    options[:class] = [options[:class], 'form-control input-sm'].compact.join(' ')
    options[:placeholder] = name

    content_tag(:div, class: 'form-group') do
      f.label(field, name, class: 'sr-only') +
      f.telephone_field(field, options)
    end 
  end

  def tbs3_inline_select(f, field, name, datasource, options={})
    options[:class] = [options[:class], 'form-control input-sm'].compact.join(' ')
    options[:placeholder] = name
    hide_label = options[:hide_label]
    options.delete(:hide_label)

    content_tag(:div, class: 'form-group') do
      if hide_label
        f.select(field, datasource, options)
      else
        f.label(field, name) +
        f.select(field, datasource, options)
      end
    end 
  end

  def tbs3_inline_submit(f, name, options={})
    options[:class] = [options[:class], 'btn btn-default btn-sm'].compact.join(' ')
    content_tag(:div, class: 'form-group actions') do
      f.submit name, options
    end
  end


  def link_to_add(body, f, association, partial, options={})
    unless f.object.respond_to?('#{association}_attributes=')
      raise ArgumentError, 'Invalid association. Make sure that accepts_nested_attributes_for is used for #{association.inspect} association.'
    end

    options[:class] = [options[:class], 'add_nested_fields'].compact.join(' ')
    options['data-association'] = association
    options['data-blueprint'] = generate_blueprint(f, association, partial, generate_model_object(f, association, options))

    args = [
      body, # Link's HTML body.
      (options.delete(:href) || 'javascript:void(0)'), # No '#' link in URL, instead, fake it with the execution of an empty Javascript function.
      options # Propagate options passed by the user.
    ]
    link_to(*args)
  end


  def link_to_remove(body, f, options={})
    options[:class] = [options[:class], 'remove_nested_fields'].compact.join(' ')

    args = [
      body, # Link's HTML body.
      (options.delete(:href) || 'javascript:void(0)'), # No '#' link in URL, instead, fake it with the execution of an empty Javascript function.
      options # Propagate options passed by the user.
    ]
    f.hidden_field(:_destroy) << link_to(*args)
  end


  private 


  def generate_blueprint(f, association, partial, model_object)
    blueprint_body = f.fields_for(association, model_object) do |builder|
      render(partial, f: builder)
    end
    blueprint_body.to_str
  end 


  def generate_model_object(f, association, options)
    model_object = options.delete(:model_object) do
      reflection = f.object.class.reflect_on_association(association)
      reflection.klass.new
    end
    model_object
  end
end
