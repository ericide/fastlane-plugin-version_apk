describe Fastlane::Actions::VersionApkAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The version_apk plugin is working!")

      Fastlane::Actions::VersionApkAction.run(nil)
    end
  end
end
