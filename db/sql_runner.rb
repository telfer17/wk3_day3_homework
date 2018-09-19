require("pg")

class SQLRunner
  # self. = class method
  def self.run(sql, values = [])
    begin # do stuff
      db = PG.connect({dbname: "music_machine", host: "localhost"})
      db.prepare("query", sql)
      result = db.exec_prepared("query", values)
    ensure # this will always run
      db.close() if db != nil
    end
      return result
  end
end
