def load_organization(id)
  organizations = YAML.load_file("_data/organizaciones.yml")

  for org in organizations do
    if org['id'] == id
      return org
    end
  end
end