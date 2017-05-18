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
      return enum_for(__method__) unless block_given?

      nt = nil
      begin
        resp = @support.describe_cases(case_option(nt))
        nt = resp.next_token
        resp.cases.each {|c| yield c}
      end while nt
    end

    def communications
      return enum_for(__method__) unless block_given?

      nt = nil
      begin
        cases do |c|
          describe_communications(c) do |cc|
            yield c.display_id, cc
          end
        end
      end while nt
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
      return enum_for(__method__, case_detail) unless block_given?

      nt = nil
      begin
        resp = @support.describe_communications(communication_option(case_detail.case_id, nt))
        nt = resp.next_token
        resp.communications.each do |c|
          yield c
        end
      end while nt
    end
  end
end
