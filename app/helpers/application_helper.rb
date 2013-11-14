module ApplicationHelper
  # Usage:
  #   <%= glyphicon('glyphicon-remove') %>
  #
  # See also: http://getbootstrap.com/components/
  def glyphicon(name, text="")
    return "<span class='glyphicon "+name+"'></span>" + text
  end
  
  def link_to_add(body, f, association, partial, options={})
    unless f.object.respond_to?("#{association}_attributes=")
      raise ArgumentError, "Invalid association. Make sure that accepts_nested_attributes_for is used for #{association.inspect} association."
    end

    options[:class] = [options[:class], "add_nested_fields"].compact.join(" ")
    options["data-association"] = association
    options["data-blueprint"] = generate_blueprint(f, association, partial, generate_model_object(f, association, options))

    args = [
      body, # Link's HTML body.
      (options.delete(:href) || "javascript:void(0)"), # No "#" link in URL, instead, fake it with the execution of an empty Javascript function.
      options # Propagate options passed by the user.
    ]
    link_to(*args)
  end

  def link_to_remove(body, f, options={})
    options[:class] = [options[:class], "remove_nested_fields"].compact.join(" ")

    args = [
      body, # Link's HTML body.
      (options.delete(:href) || "javascript:void(0)"), # No "#" link in URL, instead, fake it with the execution of an empty Javascript function.
      options # Propagate options passed by the user.
    ]
    f.hidden_field(:_destroy) << link_to(*args)
  end

  private 

  def generate_blueprint(f, association, partial, model_object)
    blueprint_body = f.fields_for(association, model_object) do |builder|
      render(partial, f: builder)
    end
    content_tag(:div, blueprint_body, class: "fields").to_str
  end 

  def generate_model_object(f, association, options)
    model_object = options.delete(:model_object) do
      reflection = f.object.class.reflect_on_association(association)
      reflection.klass.new
    end
    model_object
  end
end
