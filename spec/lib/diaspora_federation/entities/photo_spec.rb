module DiasporaFederation
  describe Entities::Photo do
    let(:data) { FactoryGirl.attributes_for(:photo_entity) }

    let(:xml) {
      <<-XML
<photo>
  <guid>#{data[:guid]}</guid>
  <diaspora_handle>#{data[:author]}</diaspora_handle>
  <public>#{data[:public]}</public>
  <created_at>#{data[:created_at]}</created_at>
  <remote_photo_path>#{data[:remote_photo_path]}</remote_photo_path>
  <remote_photo_name>#{data[:remote_photo_name]}</remote_photo_name>
  <text>#{data[:text]}</text>
  <status_message_guid>#{data[:status_message_guid]}</status_message_guid>
  <height>#{data[:height]}</height>
  <width>#{data[:width]}</width>
</photo>
XML
    }

    it_behaves_like "an Entity subclass"

    it_behaves_like "an XML Entity"

    context "default values" do
      let(:minimal_xml) {
        <<-XML
<photo>
  <guid>#{data[:guid]}</guid>
  <author>#{data[:author]}</author>
  <created_at>#{data[:created_at]}</created_at>
  <remote_photo_path>#{data[:remote_photo_path]}</remote_photo_path>
  <remote_photo_name>#{data[:remote_photo_name]}</remote_photo_name>
  <status_message_guid>#{data[:status_message_guid]}</status_message_guid>
  <height>#{data[:height]}</height>
  <width>#{data[:width]}</width>
</photo>
        XML
      }

      it "uses default values" do
        parsed_instance = DiasporaFederation::Salmon::XmlPayload.unpack(Nokogiri::XML::Document.parse(minimal_xml).root)
        expect(parsed_instance.public).to be_falsey
        expect(parsed_instance.text).to be_nil
      end
    end
  end
end
