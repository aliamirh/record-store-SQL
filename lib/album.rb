class Album
   attr_accessor :name, :id, :year

  def initialize(attributes)
     @name = attributes.fetch(:name)
     @id = attributes.fetch(:id) # Note that this line has been changed.
     @year = attributes.fetch(:year)
   end

  def self.all
    returned_albums = DB.exec("SELECT * FROM albums;")
    albums = []
    returned_albums.each() do |album|
      name = album.fetch("name")
      id = album.fetch("id").to_i
      year = album.fetch("year")
      albums.push(Album.new({name: name, id: id, year: year}))
    end
    return albums.sort_by { |album| album.name.downcase }
  end

  def save
    result = DB.exec("INSERT INTO albums (name, year) VALUES ('#{@name}', '#{@year}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def ==(album_to_compare)
    self.name() == album_to_compare.name()
  end
  #
  def self.clear
    DB.exec("DELETE FROM albums *;")
  end
  #
  def self.find(id)
  album = DB.exec("SELECT * FROM albums WHERE id = #{id};").first
  name = album.fetch("name")
  id = album.fetch("id").to_i
  year = album.fetch("year")
  Album.new({:name => name, :id => id, :year => year})
  end
  #
  # def self.search(x)
  #   @@albums.values().select { |element| /#{x}/i.match? element.name}
  # end
  #
  def update(name, year)
    @name = name
    @year = year
    DB.exec("UPDATE albums SET name ='#{@name}' WHERE id = #{@id}")
    DB.exec("UPDATE albums SET year ='#{@year}' WHERE id = #{@id}")
  end
  #
  def delete
    DB.exec("DELETE FROM albums WHERE id = #{@id};")
    DB.exec("DELETE FROM songs WHERE album_id = #{@id};") # new code
  end
  #
  def songs
    Song.find_by_album(self.id)
  end
  def self.random
    Album.all.sample
  end
end
