RSpec.describe 'Monkeypatches' do
  context String do
    it '#to_pascalcase' do
      expect('uno_dos_tres'.to_pascalcase).to eq 'UnoDosTres'
    end

    it '#to_singular' do
      expect('perros'.to_singular).to eq 'perro'
    end
  end

  context Symbol do
    it '#to_pascalcase' do
      expect(:uno_dos_tres.to_pascalcase).to eq 'UnoDosTres'
    end

    it '#to_singular' do
      expect(:perros.to_singular).to eq 'perro'
    end
  end
end
