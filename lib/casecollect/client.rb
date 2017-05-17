require 'aws-sdk'

module Casecollect
  class Client
    attr_reader :logger

    def initialize(cli_options = {}, aws_configuration = {})
      @cli_options = cli_options
      @logger ||= Logger.new STDOUT

      aws_configuration[:logger] = Logger.new STDOUT if @cli_options.verbose
      @aws_configuration = aws_configuration
      @support = Aws::Support::Client.new aws_configuration
    end

    def cases
      nt = nil
      cs = []
      begin
        resp = @support.describe_cases(case_option(nt))
        nt = resp.next_token
        cs += resp.cases
      end while nt

      return cs
    end

    def communications
      nt = nil
      cs = {}
      begin
        resp = @support.describe_cases(case_option(nt))
        nt = resp.next_token
        resp.cases.each do |c|
          cs[c.display_id] = describe_communications(c)
        end
      end while nt
      cs
    end

    private

    def case_option(next_token = '')
      {
        include_resolved_cases: true,
        next_token: next_token,
        max_results: 100,
        language: "ja",
        include_communications: false,
      }
    end

    def communication_option(case_id, next_token = '')
      {
        case_id: case_id,
        next_token: next_token,
        max_results: 100,
      }
    end

    def describe_communications(case_detail)
      nt = nil
      cs = []
      begin
        resp = @support.describe_communications(communication_option(case_detail.case_id, nt))
        nt = resp.next_token
        cs += resp.communications
      end while nt
      cs
    end
  end
end
