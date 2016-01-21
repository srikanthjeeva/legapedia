class DataExtractorController < ApplicationController
  require 'elasticsearch'

  before_action :initialize_client

  def index
    @reader = PDF::Reader.new("public/Special-Marriage-Act-1954.pdf")

    @pdf_version =  @reader.pdf_version
    @info = @reader.info
    @metadata = @reader.metadata
    @page_count = @reader.page_count


    @reader.pages.each do |page|
        @client.index  index: 'legapedia', type: 'Special-Marriage-Act-1954.pdf', id: page.number, body: { data: page.text }
    end
  end

  def search
    if params[:query]
      Rails.logger.info "--------" + params[:query]
      @result = @client.search index: 'legapedia', body: { query: { match: { data: { query: params[:query], operator: "and" } } } }
    end
  end

  def initialize_client
    @client = Elasticsearch::Client.new log: true
  end
end
