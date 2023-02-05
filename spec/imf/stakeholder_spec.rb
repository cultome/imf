RSpec.describe IMF::Stakeholder do

  it 'instance a client' do
    email = IMF.build_email_contact 'test@example.com'
    client = IMF.build_client 'Tester', [email]

    expect(client.name).to eq 'Tester'
    expect(client.contacts.first.email).to eq 'test@example.com'
  end
end
