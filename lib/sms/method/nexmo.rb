require 'rubygems'
require 'nexmo'

class Sms
  module Method

    class Nexmo
      def initialize(account_sid, auth_token, default_from = nil)
        @account_sid = account_sid
        @auth_token = auth_token
        @from = default_from
      end

      # @param [Sms::Message] sms
      def deliver!(sms)
        from = sms.from || @from
        encoding = sms.encoding # Encoding type, for example: "unicode"
        client.send_message(from: from, to: sms.to, text: sms.text, type: encoding)
      end

      private
      # Set up a client to talk to the Nexmo REST API
      def client
        @client ||= ::Nexmo::Client.new(key: @account_sid, secret: @auth_token)
      end
    end

  end
end
