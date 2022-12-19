# frozen_string_literal: true
$capas_mode = "Random"
module Api
  module Chatbot
    module V1
      class GithubWebhooksController < ActionController::Base
        skip_forgery_protection
        include GithubWebhook::Processor

        # Handle issue comment event
        def github_issue_comment(payload)
          return unless payload['action'] == "created"

          return unless payload['comment']['body'].match(/switch/)

          case payload['comment']['body']
          when /Random/
            puts 'скорее всего нас попросили свитчнуться в рандом мод'
            $capas_mode = "Random"
          when /ML/
            puts 'скорее всего нас попросили свитчнуться в мл мод'
            $capas_mode = "Patterns"
          else
            # type code here
          end
        end

        private

        def webhook_secret(payload)
          'GITHUB_WEBHOOK_SECRET'
        end
      end
    end
  end
end