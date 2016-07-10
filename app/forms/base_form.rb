class BaseForm
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include Virtus.model

  def persisted?
    false
  end
end
