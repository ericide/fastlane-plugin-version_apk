require 'fastlane_core/ui/ui'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?("UI")

  module Helper
    class VersionApkHelper
      # class methods that you define here become available in your action
      # as `Helper::VersionApkHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the version_apk plugin helper!")
      end
    end
  end
end
