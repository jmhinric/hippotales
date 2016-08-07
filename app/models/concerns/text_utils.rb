module TextUtils
  extend ActiveSupport::Concern

  def and_join(models)
    if models.size == 1
      return models.first
    elsif models.size == 2
      return models.first + ' and ' + models.last
    else
      commas = models[0..-2]
      return commas.join(', ') + ', and ' + models.last
    end
  end

  def capitalize_attrs(attrs)
    attrs.each { |attr| write_attribute(attr, capitalize(send(attr))) }
  end

  def capitalize(str)
    return unless str
    str.to_s.split.map(&:capitalize)*' '
  end
end
