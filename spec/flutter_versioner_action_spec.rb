require 'fastlane/plugin/flutter_versioner'

describe Fastlane::Actions::FlutterVersionerAction do
  describe '#run' do
    # Stubbing UI.message and UI.success to capture messages
    before do
      allow(Fastlane::UI).to receive(:message)
      allow(Fastlane::UI).to receive(:success)
    end
    it 'should update_version_code' do
      # Setting up test parameters
      params = {
        pubspec_file_path: './example/pubspec.yaml',
        version_component: 'version_code',
        ext_constant_name: "version"
      }

      # Running the action
      result = Fastlane::Actions::FlutterVersionerAction.run(params)

      # Expecting the correct new value in the lane context
      expect(Fastlane::Actions.lane_context["VERSION_CODE"]).to eq("2")

      new_version = "1.0.0+2"
      expect(Fastlane::UI).to have_received(:success).with("Version has been changed to #{new_version}")
      expect(result).to eq(new_version)

      # Clean up any stubs or mocks
      Fastlane::Actions.lane_context.delete("VERSION_CODE")
    end
    it 'should set_version_code - integer' do
      # Setting up test parameters
      params = {
        pubspec_file_path: './example/pubspec.yaml',
        value: 3,
        version_component: 'version_code',
        ext_constant_name: "version"
      }

      # Running the action
      result = Fastlane::Actions::FlutterVersionerAction.run(params)

      # Expecting the correct new value in the lane context
      expect(Fastlane::Actions.lane_context["VERSION_CODE"]).to eq("3")

      new_version = "1.0.0+3"
      expect(Fastlane::UI).to have_received(:success).with("Version has been changed to #{new_version}")
      expect(result).to eq(new_version)

      # Clean up any stubs or mocks
      Fastlane::Actions.lane_context.delete("VERSION_CODE")
    end

    it 'should set_version_code' do
      # Setting up test parameters
      params = {
        pubspec_file_path: './example/pubspec.yaml',
        value: "4",
        version_component: 'version_code',
        ext_constant_name: "version"
      }

      # Running the action
      result = Fastlane::Actions::FlutterVersionerAction.run(params)

      # Expecting the correct new value in the lane context
      expect(Fastlane::Actions.lane_context["VERSION_CODE"]).to eq("4")

      new_version = "1.0.0+4"
      expect(Fastlane::UI).to have_received(:success).with("Version has been changed to #{new_version}")
      expect(result).to eq(new_version)

      # Clean up any stubs or mocks
      Fastlane::Actions.lane_context.delete("VERSION_CODE")
    end

    it 'should set_version_code - invalid value ' do
      # Setting up test parameters
      params = {
        pubspec_file_path: './example/pubspec.yaml',
        value: "non_integer_string",
        version_component: 'version_code',
        ext_constant_name: "version"
      }

      expect do
        Fastlane::Actions::FlutterVersionerAction.run(params)
      end.to raise_error(FastlaneCore::Interface::FastlaneError, "Invalid version code.\nVersion code should be a positve integer")
    end
    # Patch
    it 'should set_version_patch - integer value' do
      # Setting up test parameters
      params = {
        pubspec_file_path: './example/pubspec.yaml',
        value: 99,
        version_component: 'patch',
        ext_constant_name: "version"
      }

      # Running the action
      result = Fastlane::Actions::FlutterVersionerAction.run(params)

      # Expecting the correct new value in the lane context
      expect(Fastlane::Actions.lane_context["PATCH"]).to eq("99")

      new_version = "1.0.99+4"
      expect(Fastlane::UI).to have_received(:success).with("Version has been changed to #{new_version}")
      expect(result).to eq(new_version)

      # Clean up any stubs or mocks
      Fastlane::Actions.lane_context.delete("PATCH")
    end
    it 'should set_version_patch' do
      # Setting up test parameters
      params = {
        pubspec_file_path: './example/pubspec.yaml',
        value: "100",
        version_component: 'patch',
        ext_constant_name: "version"
      }

      # Running the action
      result = Fastlane::Actions::FlutterVersionerAction.run(params)

      # Expecting the correct new value in the lane context
      expect(Fastlane::Actions.lane_context["PATCH"]).to eq("100")

      new_version = "1.0.100+4"
      expect(Fastlane::UI).to have_received(:success).with("Version has been changed to #{new_version}")
      expect(result).to eq(new_version)

      # Clean up any stubs or mocks
      Fastlane::Actions.lane_context.delete("PATCH")
    end


    it 'should update_version_patch' do
      # Setting up test parameters
      params = {
        pubspec_file_path: './example/pubspec.yaml',
        version_component: 'patch',
        ext_constant_name: "version"
      }

      # Running the action
      result = Fastlane::Actions::FlutterVersionerAction.run(params)

      # Expecting the correct new value in the lane context
      expect(Fastlane::Actions.lane_context["PATCH"]).to eq("101")

      new_version = "1.0.101+4"
      expect(Fastlane::UI).to have_received(:success).with("Version has been changed to #{new_version}")
      expect(result).to eq(new_version)

      # Clean up any stubs or mocks
      Fastlane::Actions.lane_context.delete("PATCH")
    end
    it 'should set_version_patch - invalid value ' do
      # Setting up test parameters
      params = {
        pubspec_file_path: './example/pubspec.yaml',
        value: "non_integer_string",
        version_component: 'patch',
        ext_constant_name: "version"
      }

      expect do
        Fastlane::Actions::FlutterVersionerAction.run(params)
      end.to raise_error(FastlaneCore::Interface::FastlaneError, "Invalid value.\nPatch, Minor, Major values should be a positve integer or 0")
    end

    # Minor
    it 'should set_version_minor - integer' do
      # Setting up test parameters
      params = {
        pubspec_file_path: './example/pubspec.yaml',
        value: "99",
        version_component: 'minor',
        ext_constant_name: "version"
      }

      # Running the action
      result = Fastlane::Actions::FlutterVersionerAction.run(params)

      # Expecting the correct new value in the lane context
      expect(Fastlane::Actions.lane_context["MINOR"]).to eq("99")

      new_version = "1.99.0+4"
      expect(Fastlane::UI).to have_received(:success).with("Version has been changed to #{new_version}")
      expect(result).to eq(new_version)

      # Clean up any stubs or mocks
      Fastlane::Actions.lane_context.delete("MINOR")
    end
    it 'should set_version_minor' do
      # Setting up test parameters
      params = {
        pubspec_file_path: './example/pubspec.yaml',
        value: "200",
        version_component: 'minor',
        ext_constant_name: "version"
      }

      # Running the action
      result = Fastlane::Actions::FlutterVersionerAction.run(params)

      # Expecting the correct new value in the lane context
      expect(Fastlane::Actions.lane_context["MINOR"]).to eq("200")

      new_version = "1.200.0+4"
      expect(Fastlane::UI).to have_received(:success).with("Version has been changed to #{new_version}")
      expect(result).to eq(new_version)

      # Clean up any stubs or mocks
      Fastlane::Actions.lane_context.delete("MINOR")
    end

    it 'should update_version_minor' do
      # Setting up test parameters
      params = {
        pubspec_file_path: './example/pubspec.yaml',
        version_component: 'minor',
        ext_constant_name: "version"
      }

      # Running the action
      result = Fastlane::Actions::FlutterVersionerAction.run(params)

      # Expecting the correct new value in the lane context
      expect(Fastlane::Actions.lane_context["MINOR"]).to eq("201")

      new_version = "1.201.0+4"
      expect(Fastlane::UI).to have_received(:success).with("Version has been changed to #{new_version}")
      expect(result).to eq(new_version)

      # Clean up any stubs or mocks
      Fastlane::Actions.lane_context.delete("MINOR")
    end

    it 'should set_version_minor - invalid value ' do
      # Setting up test parameters
      params = {
        pubspec_file_path: './example/pubspec.yaml',
        value: "non_integer_string",
        version_component: 'patch',
        ext_constant_name: "version"
      }

      expect do
        Fastlane::Actions::FlutterVersionerAction.run(params)
      end.to raise_error(FastlaneCore::Interface::FastlaneError, "Invalid value.\nPatch, Minor, Major values should be a positve integer or 0")
    end

    # MAJOR
    it 'should set_version_patch - integer' do
      # Setting up test parameters
      params = {
        pubspec_file_path: './example/pubspec.yaml',
        value: "299",
        version_component: 'major',
        ext_constant_name: "version"
      }

      # Running the action
      result = Fastlane::Actions::FlutterVersionerAction.run(params)

      # Expecting the correct new value in the lane context
      expect(Fastlane::Actions.lane_context["MAJOR"]).to eq("299")

      new_version = "299.0.0+4"
      expect(Fastlane::UI).to have_received(:success).with("Version has been changed to #{new_version}")
      expect(result).to eq(new_version)

      # Clean up any stubs or mocks
      Fastlane::Actions.lane_context.delete("MAJOR")
    end

    it 'should set_version_major' do
      # Setting up test parameters
      params = {
        pubspec_file_path: './example/pubspec.yaml',
        value: "300",
        version_component: 'major',
        ext_constant_name: "version"
      }

      # Running the action
      result = Fastlane::Actions::FlutterVersionerAction.run(params)

      # Expecting the correct new value in the lane context
      expect(Fastlane::Actions.lane_context["MAJOR"]).to eq("300")

      new_version = "300.0.0+4"
      expect(Fastlane::UI).to have_received(:success).with("Version has been changed to #{new_version}")
      expect(result).to eq(new_version)

      # Clean up any stubs or mocks
      Fastlane::Actions.lane_context.delete("MAJOR")
    end

    it 'should update_version_major' do
      # Setting up test parameters
      params = {
        pubspec_file_path: './example/pubspec.yaml',
        version_component: 'major',
        ext_constant_name: "version"
      }

      # Running the action
      result = Fastlane::Actions::FlutterVersionerAction.run(params)

      # Expecting the correct new value in the lane context
      expect(Fastlane::Actions.lane_context["MAJOR"]).to eq("301")

      new_version = "301.0.0+4"
      expect(Fastlane::UI).to have_received(:success).with("Version has been changed to #{new_version}")
      expect(result).to eq(new_version)

      # Clean up any stubs or mocks
      Fastlane::Actions.lane_context.delete("MAJOR")
    end

    it 'should set_version_major - invalid value ' do
      # Setting up test parameters
      params = {
        pubspec_file_path: './example/pubspec.yaml',
        value: "non_integer_string",
        version_component: 'major',
        ext_constant_name: "version"
      }

      expect do
        Fastlane::Actions::FlutterVersionerAction.run(params)
      end.to raise_error(FastlaneCore::Interface::FastlaneError, "Invalid value.\nPatch, Minor, Major values should be a positve integer or 0")
    end
    # VERSION_NAME

    it 'should update_version_name' do
      # Setting up test parameters
      version_name = "400.401.403"
      params = {
        pubspec_file_path: './example/pubspec.yaml',
        version_component: 'version_name',
        ext_constant_name: "version",
        value: version_name
      }

      # Running the action
      result = Fastlane::Actions::FlutterVersionerAction.run(params)

      # Expecting the correct new value in the lane context
      expect(Fastlane::Actions.lane_context["VERSION_NAME"]).to eq(version_name)

      new_version = "#{version_name}+4"
      expect(Fastlane::UI).to have_received(:success).with("Version has been changed to #{new_version}")
      expect(result).to eq(new_version)

      # Clean up any stubs or mocks
      Fastlane::Actions.lane_context.delete("VERSION_NAME")
    end

    it 'should set_version_name - nil value' do
      # Setting up test parameters
      params = {
        pubspec_file_path: './example/pubspec.yaml',
        version_component: 'version_name',
        ext_constant_name: "version"
      }

      expect do
        Fastlane::Actions::FlutterVersionerAction.run(params)
      end.to raise_error(FastlaneCore::Interface::FastlaneError, "Invalid version name.\n Version name mustbe in the from major.minor.patch (eg 1.2.3)")
    end

    it 'should set_version_name - invalid value ' do
      # Setting up test parameters
      params = {
        pubspec_file_path: './example/pubspec.yaml',
        value: "10s.10.2",
        version_component: 'version_name',
        ext_constant_name: "version"
      }

      expect do
        Fastlane::Actions::FlutterVersionerAction.run(params)
      end.to raise_error(FastlaneCore::Interface::FastlaneError, "Invalid version name.\n Version name mustbe in the from major.minor.patch (eg 1.2.3)")
    end

    # VERSION

    it 'should set_version' do
      # Setting up test parameters
      version = "500.501.503+600"
      params = {
        pubspec_file_path: './example/pubspec.yaml',
        version_component: 'version',
        ext_constant_name: "version",
        value: version
      }

      # Running the action
      result = Fastlane::Actions::FlutterVersionerAction.run(params)

      # Expecting the correct new value in the lane context
      expect(Fastlane::Actions.lane_context["VERSION"]).to eq(version)

      new_version = version
      expect(Fastlane::UI).to have_received(:success).with("Version has been changed to #{new_version}")
      expect(result).to eq(new_version)

      # Clean up any stubs or mocks
      Fastlane::Actions.lane_context.delete("VERSION")
    end

    it 'should set_version_name - nil value' do
      # Setting up test parameters
      params = {
        pubspec_file_path: './example/pubspec.yaml',
        version_component: 'version',
        ext_constant_name: "version"
      }

      expect do
        Fastlane::Actions::FlutterVersionerAction.run(params)
      end.to raise_error(FastlaneCore::Interface::FastlaneError, "Invalid version.\n Version mustbe in the from major.minor.patch+build_number (eg 1.2.3+1021)")
    end

    it 'should set_version_name - invalid value ' do
      # Setting up test parameters
      params = {
        pubspec_file_path: './example/pubspec.yaml',
        value: "10s.10.2",
        version_component: 'version',
        ext_constant_name: "version"
      }

      expect do
        Fastlane::Actions::FlutterVersionerAction.run(params)
      end.to raise_error(FastlaneCore::Interface::FastlaneError, "Invalid version.\n Version mustbe in the from major.minor.patch+build_number (eg 1.2.3+1021)")
    end

    # Add more test cases as needed
  end
end
