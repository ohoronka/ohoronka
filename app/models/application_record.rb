class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  include Rails.application.routes.url_helpers
end
