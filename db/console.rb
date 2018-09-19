require("pry")
require_relative("../models/albums")
require_relative("../models/artists")

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({"name" => "Eminem"})
artist1.save()

artist2 = Artist.new({"name" => "Oasis"})
artist2.save()

album1 = Album.new({
  "title" => "Recovery",
  "genre" => "Rap",
  "artist_id" => artist1.id
  })
album1.save()

album2 = Album.new({
  "title" => "Definitely Maybe",
  "genre" => "Rock",
  "artist_id" => artist2.id
  })
album2.save()

album3 = Album.new({
  "title" => "Marshall Mathers LP",
  "genre" => "Rap",
  "artist_id" => artist1.id
  })
album3.save()


artist1.albums()

album2.artists()

artist2.name = "Kanye West"
artist2.update()

album2.title = "Graduation"
album2.genre = "Rap"
album2.update()



binding.pry
nil
