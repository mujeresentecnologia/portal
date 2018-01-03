require 'rspec'

describe 'Site Map' do
  context 'cuando el sitio es generado' do
	subject { File.file?('_site/sitemap.xml') }

    it 'un archivo sitemap.xml en la raiz debe ser creado' do
      is_expected.to be true
    end

  end
end