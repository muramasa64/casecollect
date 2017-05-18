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
      @@communication_headers = ["submitted_by", "time_created", "body"]
      @@communication_display_headers = ["ケースID", "投稿者", "作成日時", "本文"]
    end

    class_option :verbose, type: :boolean, default: false, aliases: [:v]

    desc :cases, "Collect AWS Support cases"
    def cases
      puts case_tsv_heaader
      client.cases do |c|
        puts case_tsv(c)
      end
    end

    desc :communications, "Collect AWS Support communications"
    def communications
      puts communication_tsv_heaader
      client.communications do |case_id, cc|
        puts "#{case_id}\t#{communication_tsv(cc)}"
      end
    end

    private
    def case_tsv_heaader
      @@case_display_headers.join("\t")
    end

    def case_tsv(case_detail)
      @@case_headers.collect {|h| %!"#{case_detail[h].gsub('"', '""')}"! }.join("\t")
    end

    def communication_tsv_heaader
      @@communication_display_headers.join("\t")
    end

    def communication_tsv(communication)
      @@communication_headers.collect {|h| %!"#{communication[h].gsub('"', '""')}"! }.join("\t")
    end

    def client
      @client ||= Client.new options, aws_configuration
    end
  end
end

