require 'factory_bot_rails'
require 'shoulda-matchers'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.before(:all) do
    FactoryBot.reload
  end

  config.include(Shoulda::Matchers::ActiveRecord, type: :model)

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
