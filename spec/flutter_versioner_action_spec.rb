describe Fastlane::Actions::FlutterVersionerAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The flutter_versioner plugin is working!")

      Fastlane::Actions::FlutterVersionerAction.run(nil)
    end
  end
end
