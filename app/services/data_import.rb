require 'csv'

module DataImport
  ID = 'reference'

  def update_from_file(file_name)
    return unless File.file?(file_name)

    model = model_valid?(file_name)
    return unless model
    csv_text = File.read(file_name)
    csv = CSV.parse(csv_text, headers: true)
    csv.each do |row|
      attributes = row.to_hash
      record = model.find_or_create_by(ID => attributes[ID])
      record.update!(attributes)
    end
  end

  private

  def model_valid?(file_name)
    return unless /[a-zA-Z]+\.csv/.match?(file_name)

    file_name[0..-5].singularize.classify.constantize
  rescue NameError
    nil
  end
end
