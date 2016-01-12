module TextUtils
  extend ActiveSupport::Concern

  def and_join(models)
    if models.size == 1
      return models.first
    elsif models.size == 2
      return models.first + " and " + models.last
    else
      commas = models[0..-2]
      return commas.join(", ") + ", and " + models.last
    end
  end
end
