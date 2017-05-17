require 'thor'
require 'thor/aws'
require 'casecollect/client'

module Casecollect
  class CLI < Thor
    include Thor::Aws

    def initialize(*args)
      super(*args)
      @@case_headers = ["display_id", "subject", "status", "service_code", "category_code", "severity_code", "submitted_by", "time_created"]
      @@case_display_headers = ["ケースID", "件名", "状態", "サービス", "カテゴリ", "優先度", "投稿者", "作成日時"]
    end

    class_option :verbose, type: :boolean, default: false, aliases: [:v]

    desc :cases, "Collect AWS Support cases"
    def cases
      puts tsv_heaader
      client.cases.each do |c|
        puts tsv(c)
      end
    end

    private
    def case_tsv_heaader
      @@case_display_headers.join("\t")
    end

    def case_tsv(case_detail)
      @@case_headers.collect {|h| case_detail[h] }.join("\t")
    end

    def client
      @client ||= Client.new options, aws_configuration
    end
  end
end

