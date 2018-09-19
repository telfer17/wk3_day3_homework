require("pg")
require_relative("../db/sql_runner")

class Album

  attr_accessor :title, :genre
  attr_reader :id, :artist_id

  def initialize(options)
    @id = options["id"].to_i if options ["id"]
    @title = options["title"]
    @genre = options["genre"]
    @artist_id = options['artist_id'].to_i
  end

  def save()
    sql = "INSERT INTO albums (title, genre, artist_id)
    VALUES ($1, $2, $3)
    RETURNING id"
    values = [@title, @genre, @artist_id]
    result = SQLRunner.run(sql, values)
    @id = result[0]["id"].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM albums"
    SQLRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM albums"
    albums = SQLRunner.run(sql)
    # turn array of hashes into array of objects
    return albums.map {|album_hash| Album.new(album_hash)}
  end

  def artists()
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [@artist_id]
    result = SQLRunner.run(sql, values)
    return result.map {|result_hash| Artist.new(result_hash)}
  end


end
