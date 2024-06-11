require 'fastlane/action'
require_relative '../helper/flutter_versioner_helper'

module Fastlane
  module Actions
    class FlutterVersionerAction < Action
      def self.run(params)
        new_value ||= params[:value]
        constant_name ||= params[:ext_constant_name]
        pubspec_file_path ||= params[:pubspec_file_path]
        version_component ||= params[:version_component]
        version_list = []

        if pubspec_file_path.nil?
          UI.user_error!("The pubspec file path given. Pass the `pubspec_file_path` to the action")
        else
          UI.message("The flutter_versioner plugin will use pubspec file at (#{pubspec_file_path})!")
          version_list = increment_version(pubspec_file_path, new_value, constant_name, version_component)
        end

        if version_list.length == 2
          # Store the version name in the shared hash
          UI.message("Previous Version : #{version_list[0]}")
          UI.success("Version has been changed to #{version_list[1]}")
        else
          UI.user_error!("Updating the version failed !!")
        end

        return new_value
      end

      def self.increment_version(path, new_value, constant_name, version_comp = 'version_code')
        unless File.file?(path)
          UI.user_error!("No file exist at path: (#{path})!")
          return -1
        end
        begin
          found_version_code = "false"
          new_version = nil
          old_verison = nil
          temp_file = Tempfile.new('fastlaneIncrementVersionCode')
          File.open(path, 'r') do |file|
            file.each_line do |line|
              if line.include?("#{constant_name}:") && found_version_code == "false"

                UI.message(" -> line: (#{line})!")
                old_version_name = get_version_name(line)
                old_version_code = get_version_code(line)
                new_version_code = old_version_code
                new_version_name = old_version_name

                if version_comp == 'version_code'
                  if new_value.instance_of?(Integer)
                    new_value = new_value.to_s
                  end
                  if new_value.nil? || (is_int(new_value) && new_value.to_i > 0)
                    new_version_code = increment_version_code(old_version_code, new_value)
                  else
                    UI.user_error!("Invalid version code.\nVersion code should be a positve integer")
                  end

                elsif ['patch', 'major', 'minor'].include?(version_comp)
                  if new_value.instance_of?(Integer)
                    new_value = new_value.to_s
                  end
                  if new_value.nil? || (is_int(new_value) && new_value.to_i >= 0)
                    new_version_name = increment_version_name(old_version_name, version_comp, new_value)
                  else
                    UI.user_error!("Invalid value.\nPatch, Minor, Major values should be a positve integer or 0")
                  end

                elsif version_comp == 'version_name'
                  if matches_version_name_pattern?(new_value)
                    new_version_name = new_value
                  else
                    UI.user_error!("Invalid version name.\n Version name mustbe in the from major.minor.patch (eg 1.2.3)")
                  end
                elsif version_comp == 'version'
                  if matches_version_pattern?(new_value)
                    new_version_name = get_version_name(new_value)
                    new_version_code = get_version_code(new_value)
                  else
                    UI.user_error!("Invalid version.\n Version mustbe in the from major.minor.patch+build_number (eg 1.2.3+1021)")
                  end
                else
                  UI.user_error!("Invalid version component.\nVersion Component must be any one of these -> version_code,  patch, minor,major")
                end
                new_version = "#{new_version_name}+#{new_version_code}"
                old_verison = "#{old_version_name}+#{old_version_code}"

                if !!(new_version_code =~ /\A[-+]?[0-9]+\z/)
                  line.replace(line.sub(old_verison, new_version))
                  found_version_code = "true"
                  update_lane_context(new_version)
                  temp_file.puts(line)
                end
              else
                temp_file.puts(line)
              end
            end
            file.close
          end
          temp_file.rewind
          temp_file.close
          FileUtils.mv(temp_file.path, path)
          temp_file.unlink
        end
        if found_version_code == "true"
          return [old_verison, new_version]
        end

        return -1
      end

      def self.update_lane_context(new_version)
        version_name = get_version_name(new_version)
        major, minor, patch = get_patch_minor_major(version_name)
        Actions.lane_context["VERSION"] = new_version
        Actions.lane_context["VERSION_NAME"] = version_name
        Actions.lane_context["VERSION_CODE"] = get_version_code(new_version)
        Actions.lane_context["PATCH"] = patch
        Actions.lane_context["MINOR"] = minor
        Actions.lane_context["MAJOR"] = major
      end

      def self.matches_version_pattern?(version)
        pattern = /^\d+\.\d+\.\d+\+\d+$/
        pattern.match?(version.to_s)
      end

      def self.matches_version_name_pattern?(version)
        pattern = /^\d+\.\d+\.\d+$/
        pattern.match?(version.to_s)
      end

      def self.get_version_code(line)
        version_components = line.strip.split('+')
        return version_components[version_components.length - 1].tr("\"", "")
      end

      def self.get_patch_minor_major(version_name)
        return version_name.split(".")
      end

      def self.increment_version_code(version, new_version_code = nil)
        if new_version_code.nil?
          new_version_code = version.to_i + 1
        end
        return new_version_code.to_s
      end

      def self.get_version_name(line)
        version_components_ver_string__build_no_list = line.strip.split('+')
        version_components_ver_key__maj_min_pat = version_components_ver_string__build_no_list[0].split(":")
        version_name = version_components_ver_key__maj_min_pat[version_components_ver_key__maj_min_pat.length - 1].strip
        return version_name
      end

      def self.increment_version_name(version_name, version_component = 'patch', new_value)
        major, minor, patch  = get_patch_minor_major(version_name)
        if version_component == 'major'
          major = new_value || (major.to_i + 1)
          minor = 0
          patch = 0
        elsif version_component == 'minor'
          minor = new_value || (minor.to_i + 1)
          patch = 0
        elsif version_component == "patch"
          patch = new_value || (patch.to_i + 1)
        end
        return "#{major}.#{minor}.#{patch}"
      end

      def self.is_int(value)
        return value.to_i.to_s == value
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
        "Flutter versioner is a powerful fastlane plugin designed to simplify the management of flutter project version. With this you can easily update project version to any specified major,minor,or patch level as well as adjust the version code/build number."
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :version_component,
                                       env_name: "FLUTTERVERSIONER_VERSION_COMPONENT",
                                       description: "The component of the version to be updated, version format :  major.minor.patch+version_code. (default : version_code)",
                                       optional: false,
                                       type: String,
                                       default_value: "version_code"),
          FastlaneCore::ConfigItem.new(key: :pubspec_file_path,
                                       env_name: "FLUTTERVERSIONER_PUBSPEC_FILE_PATH",
                                       description: "The relative path to the pubspec file containing the version parameter (default:../pubspec.yaml)",
                                       optional: false,
                                       type: String,
                                       default_value: "../pubspec.yaml"),
          FastlaneCore::ConfigItem.new(key: :value,
                                       env_name: "FLUTTERVERSIONER_VALUE",
                                       description: "Change to a specific version (optional)",
                                       optional: true,
                                       type: String,
                                       default_value: nil),
          FastlaneCore::ConfigItem.new(key: :ext_constant_name,
                                       env_name: "FLUTTERVERSIONER_EXT_CONSTANT_NAME",
                                       description: "If the version code is set in an ext constant, specify the constant name (optional)",
                                       optional: true,
                                       type: String,
                                       default_value: "version")
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
