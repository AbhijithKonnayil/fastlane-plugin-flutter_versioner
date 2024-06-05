require 'fastlane/plugin/flutter_versioner'

describe Fastlane::Actions::FlutterVersionerAction do
  describe '#run' do
    it 'should change the version code' do
      # Mocking the lane context
      allow(Fastlane::Actions).to receive(:lane_context).and_return({})

      # Stubbing UI.message and UI.success to capture messages
      allow(Fastlane::UI).to receive(:message)
      allow(Fastlane::UI).to receive(:success)

      # Setting up test parameters
      params = {
        pubspec_file_path: './example/pubspec.yaml',
        value: 10,
        ext_constant_name: 'version',
        version_component: 'version_code'
      }

      # Running the action
      result = Fastlane::Actions::FlutterVersionerAction.run(params)

      # Expecting the correct new value in the lane context
      expect(Fastlane::Actions.lane_context["VERSION_CODE"]).to eq(10)
      new_version = "1.0.0+10"
      # Expecting success message
      expect(Fastlane::UI).to have_received(:success).with("Version has been changed to #{new_version}")

      # Clean up any stubs or mocks
      Fastlane::Actions.lane_context.delete("VERSION_CODE")
    end

    it 'should handle invalid version component' do
      # Stubbing UI.message to capture messages
      allow(Fastlane::UI).to receive(:message)

      # Setting up test parameters with invalid version component
      params = {
        pubspec_file_path: './example/pubspec.yaml',
        value: 10,
        ext_constant_name: 'version',
        version_component: 'invalid_component'
      }

      # Running the action
      expect do
        Fastlane::Actions::FlutterVersionerAction.run(params)
      end.to raise_error(FastlaneCore::Interface::FastlaneError, "Invalid version component.\nVersion Component must be any one of these -> version_code,  patch, minor,major")
    end

    # Add more test cases as needed
  end
end
