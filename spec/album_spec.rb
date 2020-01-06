require('spec_helper.rb')


  describe('.all') do
    it("returns an empty array when there are no albums") do
      expect(Album.all).to(eq([]))
    end
  end
  describe('#save') do
    it("saves an album") do
      album = Album.new({name: "Giant Steps",id: nil, year: '1990'}) # nil added as second argument
      album.save()
      album2 = Album.new({name: "Blue",id: nil, year: '1992'}) # nil added as second argument
      album2.save()
      expect(Album.all).to(eq([album, album2]))
    end
  end
  describe('#==') do
    it("is the same album if it has the same attributes as another album") do
      album = Album.new({name: "Giant Steps",id: nil, year: '1990'})
      album2 = Album.new({name: "Giant Steps",id: nil, year: '1990'})
      expect(album).to(eq(album2))
    end
  end
  describe('.clear') do
    it("clears all albums") do
      album = Album.new({name: "Giant Steps",id: nil, year: '1990'})
      album.save()
      album2 = Album.new({name: "Blue",id: nil, year: '1990'})
      album2.save()
      Album.clear()
      expect(Album.all).to(eq([]))
    end
  end
  describe('.find') do
    it("finds an album by id") do
      album = Album.new({name: "Blue",id: nil, year: '1990'})
      album.save()
      expect(Album.find(album.id)).to(eq(album))
    end
  end
  describe('#update') do
  it("updates an album by id") do
    album = Album.new({name: "Blue",id: nil, year: '1990'})
    album.save()
    album.update("Giant Steps")
    expect(album.name).to(eq("Giant Steps"))
  end
end
describe('#delete') do
    it("deletes an album by id") do
      album = Album.new({name: "Blue",id: nil, year: '1990'})
      album.save()
      album2 = Album.new({name: "Giant Steps",id: nil, year: '1990'})
      album2.save()
      album.delete()
      expect(Album.all).to(eq([album2]))
    end
  end
describe("#random")do
  it('grabs a random album')do
  album = Album.new({name: "Blue",id: nil, year: '1990'})
  album.save()
  album2 = Album.new({name: "Giant Steps",id: nil, year: '1990'})
  album2.save()
  # this test works just the spec doesnt make sense in what it returns
  expect(Album.random).to(eq('1'))
  end
end
