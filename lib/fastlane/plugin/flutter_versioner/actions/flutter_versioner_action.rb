require 'fastlane/action'
require_relative '../helper/flutter_versioner_helper'

module Fastlane
  module Actions
    class FlutterVersionerAction < Action
      def self.run(params)
        UI.message("The flutter_versioner plugin is working!")
      end

      def self.description
        "Effortlessly manage and update your flutter project version."
      end

      def self.authors
        ["Abhijith K"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        "Flutter versioner is a powerful fastlane plugin designed to simplify the management of flutter project version. With this you can easily update project version to any specified major,minor,or patch level as well as adjust the version code/build number."
      end

      def self.available_options
        [
          # FastlaneCore::ConfigItem.new(key: :your_option,
          #                         env_name: "FLUTTER_VERSIONER_YOUR_OPTION",
          #                      description: "A description of your option",
          #                         optional: false,
          #                             type: String)
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
