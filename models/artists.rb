require("pg")
require_relative("../db/sql_runner")

class Artist

  attr_accessor :name, :id

  def initialize(options)
    @id = options["id"].to_i if options ["id"]
    @name = options["name"]
  end

  def save()
    sql = "INSERT INTO artists (name) VALUES ($1) RETURNING id"
    values = [@name]
    result = SQLRunner.run(sql, values)
    @id = result[0]["id"].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM artists"
    SQLRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM artists"
    artists = SQLRunner.run(sql)
    # turn array of hashes into array of objects
    return artists.map {|artist_hash| Artist.new(artist_hash)}
  end

  def albums()
    sql = "SELECT * FROM albums WHERE artist_id = $1"
    values = [@id]
    result = SQLRunner.run(sql, values)
    return result.map {|result_hash| Album.new(result_hash)}
  end


  def update()
    sql = "UPDATE artists SET name = $1 WHERE id = $2"
    values = [@name, @id]
  end

end
