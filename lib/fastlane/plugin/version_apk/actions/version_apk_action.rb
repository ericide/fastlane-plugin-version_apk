require 'fastlane/action'
require_relative '../helper/version_apk_helper'

module Fastlane
  module Actions
    class VersionApkAction < Action
      def self.run(params)

        path = params[:apk_file]
        getVersions(path)
      end

      def self.getVersions(apk_file)
        require 'apktools/apkxml'

        # Load the XML data
        parser = ApkXml.new(apk_file)
        parser.parse_xml("AndroidManifest.xml", false, true)

        elements = parser.xml_elements

        versionCode = nil
        versionName = nil
        name = nil

        elements.each do |element|
          if element.name == "manifest"
            element.attributes.each do |attr|
              if attr.name == "versionCode"
                versionCode = attr.value
              elsif attr.name == "versionName"
                versionName = attr.value
              end
            end
          elsif element.name == "application"
            element.attributes.each do |attr|
              if attr.name == "label"
                name = attr.value
              end
            end
          end
        end

        if versionCode =~ /^0x[0-9A-Fa-f]+$/ #if is hex
          versionCode = versionCode.to_i(16)
        end

        [versionCode, versionName, name]
      end

      def self.description
        "get version from apk"
      end

      def self.authors
        ["eric"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        "get version from apk"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :apk_file,
                                  env_name: "FL_APK_GET_VERSION_NAME_GRADLE_FILE",
                               description: "Specify the path to your apk file",
                                  optional: false,
                                      type: String,
                             default_value: "file.apk",
                              verify_block: proc do |value|
                                UI.user_error!("Could not find app apk_file file") unless File.exist?(value) || Helper.test?
                              end)
        ]
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://docs.fastlane.tools/advanced/#control-configuration-by-lane-and-by-platform
        #
        # [:ios, :mac, :android].include?(platform)
        true
      end
    end
  end
end
