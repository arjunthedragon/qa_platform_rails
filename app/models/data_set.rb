class DataSet

  require 'csv'

  def self.generate_data

    csv_text = File.read("Tags.csv")
    csv = CSV.parse(csv_text, headers: true)
    csv.each do |row|
      Tags.create!()
    end 
  end


  def self.generate_data2
    lines = []
    IO.foreach('Tags.csv') do |line|
      lines << line
      if lines.size >= 1000
        lines = CSV.parse(lines.join, headers: true) rescue next
        
        lines.each do |row|
          #Tag.create!(id: row["Id"].to_i, name: row["name"])
          #puts "\n\n #{row[":Id"].to_i}"
          attr_array = row.to_s.split(",")
          id = attr_array[0].to_i
          name = attr_array[1].to_s

          t = Tag.new(id: id, name: name)
          if t.valid?
            t.save! rescue next
          else
            next
          end

          puts "\n Tag created #{id} and #{name}"
        end

        lines = []
      end
    end
    store lines
  end


  def self.generate_data3
    items = []
    CSV.foreach('link/to/file.csv', headers: true) do |row|
      items << Item.new(row.to_h)
    end
    Item.import(items)
  end

  def self.generate_data4

    csv_text = File.read("Tags.csv")
    #csv = CSV.parse(csv_text, headers: true)
    CSV.foreach(csv_text, header: true) do |row|
      #Tags.create!()
      #puts "\n\n #{row[:Id].class}"
      Tag.create!(id: row['Id'], name: row['Tag'])
    end 
  end


end