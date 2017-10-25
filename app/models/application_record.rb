class ApplicationRecord < ActiveRecord::Base
  ALL_STATUSES = {
    idle: 1,
    protected: 2,
    alarm: 3,
    ok: 4,
    online: 5,
    offline: 6
  }

  self.abstract_class = true

  include Rails.application.routes.url_helpers
end
