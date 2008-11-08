require 'spec'

require 'spec/rails/extensions/object'

require 'spec/rails/extensions/spec/example/configuration'
require 'spec/rails/extensions/spec/matchers/have'

require 'spec/rails/extensions/active_record/base'
if defined?(ActionController::Base)
  require 'spec/rails/extensions/action_controller/base'
  require 'spec/rails/extensions/action_controller/rescue'
  require 'spec/rails/extensions/action_controller/test_response'
end
if defined?(ActionView::Base)
  require 'spec/rails/extensions/action_view/base'
end
