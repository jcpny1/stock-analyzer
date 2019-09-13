# This file was generated by the `rails generate rspec:install` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# The generated `.rspec` file contains `--require spec_helper` which will cause
# this file to always be loaded, without a need to explicitly require it in any
# files.
#
# Given that it is always loaded, you are encouraged to keep this file as
# light-weight as possible. Requiring heavyweight dependencies from this file
# will add to the boot time of your test suite on EVERY test run, even for an
# individual file that may not need all of that loaded. Instead, consider making
# a separate helper file that requires the additional dependencies and performs
# the additional setup, and require it from the spec files that actually need
# it.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  require 'capybara/rspec'
  Capybara.server = :puma
  # Capybara.server = :puma, { Silent: true }
  Capybara.current_driver = :selenium
  Capybara.app_host = 'http://localhost:3000'
  Capybara.server_host = 'localhost'
  Capybara.server_port = '3001'

  require 'sidekiq/testing'
  Sidekiq::Testing.inline!

  require 'simplecov'
  SimpleCov.start

  require 'webmock/rspec'
  WebMock.disable_net_connect!(allow_localhost: true)
  config.before(:each) do
    Sidekiq::Worker.clear_all  # Makes sure jobs don't linger between tests:

    ## WebMock Reponse Setups ##

    # Request for news.
    stub_request(:get, 'https://newsapi.org/v1/articles?apikey&sortBy=top&source=bloomberg').
      with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.15.4'}).
      to_return(
        status: 200,
        body: '{
          "status": "ok",
          "articles": [{
            "source": {"id": "bloomberg", "name": "Bloomberg"},
            "author": "Shannon Pettypiece",
            "title": "Trump to Pay His Own Legal Bills, Set Up Fund to Cover Staff",
            "description": "President Donald Trump has started paying his own legal bills related to the Russia probe, rather than charging them to his campaign or the Republican National Committee, and is finalizing a plan to use personal funds to help current and former White House staff with their legal costs.",
            "url": "http://www.bloomberg.com/news/articles/2017-11-17/trump-to-pay-his-own-legal-bills-set-up-fund-to-cover-staff",
            "urlToImage": "https://assets.bwbx.io/images/users/iqjWHBFdfxIU/i5_F2CKD0NVI/v1/1200x675.jpg",
            "publishedAt": "2017-11-17T16:51:29Z"
          }]
        }',
        headers: {})
    # Request for data feed symbology.
    stub_request(:get, 'https://cloud.iexapis.com/stable/ref-data/region/US/symbols?token').
      with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.15.4'}).
      to_return(
        status: 200,
        body: '[
                {"symbol":"A",   "name":"Agilent Technologies Inc.","date":"2018-03-19", "isEnabled":true, "type":"cs", "iexId":"2"},
                {"symbol":"AA",  "name":"Alcoa Corporation",        "date":"2018-03-19", "isEnabled":true, "type":"cs", "iexId":"12042"},
                {"symbol":"AABA","name":"Altaba Inc.",              "date":"2018-03-19", "isEnabled":true, "type":"cs", "iexId":"7653"}
              ]',
        headers: {})
    # Request instrument prices.
    stub_request(:get, "https://cloud.iexapis.com/stable/stock/AAPL/quote?token=").
      with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.15.4'}).
      to_return(
        status: 200,
        body: '{"symbol": "AAPL", "latestPrice": 175.6, "change": -2.42, "latestUpdate": 1521473015555}',
        headers: {})
    stub_request(:get, "https://cloud.iexapis.com/stable/stock/AMZN/quote?token=").
      with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.15.4'}).
      to_return(
        status: 200,
        body: '{"symbol": "AMZN", "latestPrice": 1547.75, "change": -23.93, "latestUpdate": 1521472989944}',
        headers: {})
    stub_request(:get, "https://cloud.iexapis.com/stable/stock/BABA/quote?token=").
      with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.15.4'}).
      to_return(
        status: 200,
        body: '{"symbol": "BABA", "latestPrice": 196.58, "change": -3.7, "latestUpdate": 1521473025985}',
        headers: {})
    stub_request(:get, "https://cloud.iexapis.com/stable/stock/COF/quote?token=").
      with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.15.4'}).
      to_return(
        status: 200,
        body: '{"symbol": "COF", "latestPrice": 98.31, "change": -1.05, "latestUpdate": 1521472812505}',
        headers: {})
    stub_request(:get, "https://cloud.iexapis.com/stable/stock/DIA/quote?token=").
      with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.15.4'}).
      to_return(
        status: 200,
        body: '{"symbol": "DIA", "latestPrice": 246.66, "change": -2.44, "latestUpdate": 1521472967711}',
        headers: {})
    stub_request(:get, "https://cloud.iexapis.com/stable/stock/FBGX/quote?token=").
      with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.15.4'}).
      to_return(
        status: 200,
        body: '{"symbol": "FBGX", "latestPrice": 247.99, "change": -5.4, "latestUpdate": 1521471289078}',
        headers: {})
    stub_request(:get, "https://cloud.iexapis.com/stable/stock/GOOG/quote?token=").
      with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.15.4'}).
      to_return(
        status: 200,
        body: '{"symbol": "GOOG", "latestPrice": 1097.865, "change": -37.865, "latestUpdate": 1521473007173}',
        headers: {})
    stub_request(:get, "https://cloud.iexapis.com/stable/stock/GOOGL/quote?token=").
      with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.15.4'}).
      to_return(
        status: 200,
        body: '{"symbol": "GOOGL", "latestPrice": 1098.8, "change": -35.62, "latestUpdate": 1521473025840}',
        headers: {})
    stub_request(:get, "https://cloud.iexapis.com/stable/stock/GSK/quote?token=").
      with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.15.4'}).
      to_return(
        status: 200,
        body: '{"symbol": "GSK", "latestPrice": 37.165, "change": -0.115, "latestUpdate": 1521472921890}',
        headers: {})
    stub_request(:get, "https://cloud.iexapis.com/stable/stock/HD/quote?token=").
      with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.15.4'}).
      to_return(
        status: 200,
        body: '{"symbol": "HD", "latestPrice": 178.44, "change": -0.52, "latestUpdate": 1521473018188}',
        headers: {})
    stub_request(:get, "https://cloud.iexapis.com/stable/stock/INTC/quote?token=").
      with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.15.4'}).
      to_return(
        status: 200,
        body: '{"symbol": "INTC", "latestPrice": 50.51, "change": -0.66, "latestUpdate": 1521473018049}',
        headers: {})
    stub_request(:get, "https://cloud.iexapis.com/stable/stock/IWM/quote?token=").
      with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.15.4'}).
      to_return(
        status: 200,
        body: '{"symbol": "IWM", "latestPrice": 155.85, "change": -1.95, "latestUpdate": 1521473021918}',
        headers: {})
    stub_request(:get, "https://cloud.iexapis.com/stable/stock/JNJ/quote?token=").
      with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.15.4'}).
      to_return(
        status: 200,
        body: '{"symbol": "JNJ", "latestPrice": 131.73, "change": -1.95, "latestUpdate": 1521472959823}',
        headers: {})
    stub_request(:get, "https://cloud.iexapis.com/stable/stock/QQQ/quote?token=").
      with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.15.4'}).
      to_return(
        status: 200,
        body: '{"symbol": "QQQ", "latestPrice": 167.37, "change": -3.65, "latestUpdate": 1521473019483}',
        headers: {})
    stub_request(:get, "https://cloud.iexapis.com/stable/stock/SNY/quote?token=").
      with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.15.4'}).
      to_return(
        status: 200,
        body: '{"symbol": "SNY", "latestPrice": 41.14, "change": 0.18, "latestUpdate": 1521472948422}',
        headers: {})
    stub_request(:get, "https://cloud.iexapis.com/stable/stock/SPY/quote?token=").
      with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.15.4'}).
      to_return(
        status: 200,
        body: '{"symbol": "SPY", "latestPrice": 271.32, "change": -2.88, "latestUpdate": 1521473026531}',
        headers: {})
    stub_request(:get, "https://cloud.iexapis.com/stable/stock/URTH/quote?token=").
      with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.15.4'}).
      to_return(
        status: 200,
        body: '{"symbol": "URTH", "latestPrice": 88.822, "change": -0.698, "latestUpdate": 1521472050165}',
        headers: {})
    # Request monthly price series.
    # stub_request(:get, /https:\/\/www\.alphavantage\.co\/query\?apikey\&function\=TIME_SERIES_MONTHLY_ADJUSTED\&symbol=\w+/).
    #   with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.15.4'}).
    stub_request(:get, /https:\/\/www\.alphavantage\.co\/query\?apikey\&function=TIME_SERIES_MONTHLY_ADJUSTED\&symbol=\w+/).
      with(query: hash_excluding({'symbol'=>['AMZN','DIA']}), headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.15.4'}).
      to_return(status: 200, body: '', headers: {})
    stub_request(:get, 'https://www.alphavantage.co/query?apikey&function=TIME_SERIES_MONTHLY_ADJUSTED&symbol=AMZN').
      with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.15.4'}).
      to_return(
        status: 200,
        body:   '{
                  "Meta Data": {
                    "1. Information": "Monthly Adjusted Prices and Volumes",
                    "2. Symbol": "AMZN",
                    "3. Last Refreshed": "2018-04-05",
                    "4. Time Zone": "US/Eastern"
                  },
                  "Monthly Adjusted Time Series": {
                    "2018-03-29": {
                      "1. open": "1513.6000",
                      "2. high": "1617.5400",
                      "3. low": "1365.2000",
                      "4. close": "1447.3400",
                      "5. adjusted close": "1447.3400",
                      "6. volume": "128401298",
                      "7. dividend amount": "0.0000"
                    },
                    "2018-02-28": {
                      "1. open": "1445.0000",
                      "2. high": "1528.7000",
                      "3. low": "1265.9300",
                      "4. close": "1512.4500",
                      "5. adjusted close": "1512.4500",
                      "6. volume": "133362428",
                      "7. dividend amount": "0.0000"
                    },
                    "2018-01-31": {
                      "1. open": "1172.0000",
                      "2. high": "1472.5800",
                      "3. low": "1170.5100",
                      "4. close": "1450.8900",
                      "5. adjusted close": "1450.8900",
                      "6. volume": "94145634",
                      "7. dividend amount": "0.0000"
                    }
                  }
                }',
        headers: {})
    stub_request(:get, "https://www.alphavantage.co/query?apikey&function=TIME_SERIES_MONTHLY_ADJUSTED&symbol=DIA").
      with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.15.4'}).
      to_return(
        status: 200,
        body:   '{
                  "Meta Data": {
                    "1. Information": "Monthly Adjusted Prices and Volumes",
                    "2. Symbol": "DIA",
                    "3. Last Refreshed": "2018-03-16",
                    "4. Time Zone": "US/Eastern"
                  },
                  "Monthly Adjusted Time Series": {
                    "2018-02-28": {
                      "1. open": "259.9500",
                      "2. high": "262.9000",
                      "3. low": "233.7600",
                      "4. close": "250.2000",
                      "5. adjusted close": "249.7448",
                      "6. volume": "183041900",
                      "7. dividend amount": "0.6448"
                    }
                  }
                }',
        headers: {})
    # Request for DJIA index value.
    stub_request(:get, 'https://www.alphavantage.co/query?apikey&function=TIME_SERIES_DAILY&symbol=DJIA').
      with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.15.4'}).
      to_return(
        status: 200,
        body:   '{
                  "Meta Data": {
                    "1. Information": "Daily Prices (open, high, low, close) and Volumes",
                    "2. Symbol": "Dow Jones Industrial Average Index",
                    "3. Last Refreshed": "2018-03-19",
                    "4. Output Size": "Compact",
                    "5. Time Zone": "US/Eastern"
                  },
                  "Time Series (Daily)": {
                    "2018-03-19": {
                      "1. open": "24893.6895",
                      "2. high": "24893.6895",
                      "3. low": "24658.6191",
                      "4. close": "24686.0898",
                      "5. volume": "103013890"
                    },
                    "2018-03-16": {
                      "1. open": "24877.3398",
                      "2. high": "25031.0000",
                      "3. low": "24857.0898",
                      "4. close": "24946.5098",
                      "5. volume": "654240000"
                    }
                  }
                }',
        headers: {})
  end

  # rspec-expectations config goes here. You can use an alternate
  # assertion/expectation library such as wrong or the stdlib/minitest
  # assertions if you prefer.
  config.expect_with :rspec do |expectations|
    # This option will default to `true` in RSpec 4. It makes the `description`
    # and `failure_message` of custom matchers include text for helper methods
    # defined using `chain`, e.g.:
    #     be_bigger_than(2).and_smaller_than(4).description
    #     # => "be bigger than 2 and smaller than 4"
    # ...rather than:
    #     # => "be bigger than 2"
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # rspec-mocks config goes here. You can use an alternate test double
  # library (such as bogus or mocha) by changing the `mock_with` option here.
  config.mock_with :rspec do |mocks|
    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended, and will default to
    # `true` in RSpec 4.
    mocks.verify_partial_doubles = true
  end

  # This option will default to `:apply_to_host_groups` in RSpec 4 (and will
  # have no way to turn it off -- the option exists only for backwards
  # compatibility in RSpec 3). It causes shared context metadata to be
  # inherited by the metadata hash of host groups and examples, rather than
  # triggering implicit auto-inclusion in groups with matching metadata.
  config.shared_context_metadata_behavior = :apply_to_host_groups

# The settings below are suggested to provide a good initial experience
# with RSpec, but feel free to customize to your heart's content.
=begin
  # This allows you to limit a spec run to individual examples or groups
  # you care about by tagging them with `:focus` metadata. When nothing
  # is tagged with `:focus`, all examples get run. RSpec also provides
  # aliases for `it`, `describe`, and `context` that include `:focus`
  # metadata: `fit`, `fdescribe` and `fcontext`, respectively.
  config.filter_run_when_matching :focus

  # Allows RSpec to persist some state between runs in order to support
  # the `--only-failures` and `--next-failure` CLI options. We recommend
  # you configure your source control system to ignore this file.
  config.example_status_persistence_file_path = "spec/examples.txt"

  # Limits the available syntax to the non-monkey patched syntax that is
  # recommended. For more details, see:
  #   - http://rspec.info/blog/2012/06/rspecs-new-expectation-syntax/
  #   - http://www.teaisaweso.me/blog/2013/05/27/rspecs-new-message-expectation-syntax/
  #   - http://rspec.info/blog/2014/05/notable-changes-in-rspec-3/#zero-monkey-patching-mode
  config.disable_monkey_patching!

  # Many RSpec users commonly either run the entire suite or an individual
  # file, and it's useful to allow more verbose output when running an
  # individual spec file.
  if config.files_to_run.one?
    # Use the documentation formatter for detailed output,
    # unless a formatter has already been configured
    # (e.g. via a command-line flag).
    config.default_formatter = "doc"
  end

  # Print the 10 slowest examples and example groups at the
  # end of the spec run, to help surface which specs are running
  # particularly slow.
  config.profile_examples = 10

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = :random

  # Seed global randomization in this process using the `--seed` CLI option.
  # Setting this allows you to use `--seed` to deterministically reproduce
  # test failures related to randomization by passing the same `--seed` value
  # as the one that triggered the failure.
  Kernel.srand config.seed
=end
end
