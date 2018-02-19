json.array!(@cities) do |city|
  json.ref city['Ref']
  json.label "#{city['Description']} - #{@areas[city['Area']]} обл."
end
