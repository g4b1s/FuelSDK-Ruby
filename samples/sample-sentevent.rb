require 'marketingcloudsdk'
require_relative 'sample_helper'

begin
	stubObj = MarketingCloudSDK::Client.new auth

	## Modify the date below to reduce the number of results returned from the request
	## Setting this too far in the past could result in a very large response size
	retrieveDate = '2013-01-15T13:00:00.000'

	p '>>> Retrieve Filtered SentEvents with GetMoreResults'
	getSentEvent = MarketingCloudSDK::SentEvent.new()
	getSentEvent.authStub = stubObj
	getSentEvent.props = ["SendID","SubscriberKey","EventDate","Client.ID","EventType","BatchID","TriggeredSendDefinitionObjectID","ListID","PartnerKey","SubscriberID"]
	getSentEvent.filter = {'Property' => 'EventDate','SimpleOperator' => 'greaterThan','DateValue' => retrieveDate}
	getResponse = getSentEvent.get
	p 'Retrieve Status: ' + getResponse.status.to_s
	p 'Code: ' + getResponse.code.to_s
	p 'Message: ' + getResponse.message.to_s
	p 'MoreResults: ' + getResponse.more?.to_s
	p 'RequestID: ' + getResponse.request_id.to_s
	p 'Results Length: ' + getResponse.results.length.to_s
	# Since this could potentially return a large number of results, we do not want to print the results
	#p 'Results: ' + getResponse.results.to_s
  raise 'Failure retrieving sent events' unless getResponse.success?

	while getResponse.more? do
		p '>>> Continue Retrieve Filtered SentEvents with GetMoreResults'
		getResponse = getSentEvent.continue
		p 'Retrieve Status: ' + getResponse.status.to_s
		p 'Code: ' + getResponse.code.to_s
		p 'Message: ' + getResponse.message.to_s
		p 'MoreResults: ' + getResponse.more?.to_s
		p 'RequestID: ' + getResponse.request_id.to_s
		p 'Results Length: ' + getResponse.results.length.to_s
	end

	#  The following request could potentially bring back large amounts of data if run against a production account
=begin
	p '>>> Retrieve All SentEvents with GetMoreResults'
	getSentEvent = MarketingCloudSDK::SentEvent.new()
	getSentEvent.authStub = stubObj
	getSentEvent.props = ["SendID","SubscriberKey","EventDate","Client.ID","EventType","BatchID","TriggeredSendDefinitionObjectID","ListID","PartnerKey","SubscriberID"]
	getResponse = getSentEvent.get
	p 'Retrieve Status: ' + getResponse.status.to_s
	p 'Code: ' + getResponse.code.to_s
	p 'Message: ' + getResponse.message.to_s
	p 'MoreResults: ' + getResponse.more?.to_s
	p 'RequestID: ' + getResponse.request_id.to_s
	p 'Results Length: ' + getResponse.results.length.to_s
	# Since this could potentially return a large number of results, we do not want to print the results
	#p 'Results: ' + getResponse.results.to_s

	while getResponse.more? do
		p '>>> Continue Retrieve All SentEvents with GetMoreResults'
		getResponse = getSentEvent.continue
		p 'Retrieve Status: ' + getResponse.status.to_s
		p 'Code: ' + getResponse.code.to_s
		p 'Message: ' + getResponse.message.to_s
		p 'MoreResults: ' + getResponse.more?.to_s
		p 'RequestID: ' + getResponse.request_id.to_s
		p 'Results Length: ' + getResponse.results.length.to_s
	end
=end

rescue => e
	p "Caught exception: #{e.message}"
	p e.backtrace
end

