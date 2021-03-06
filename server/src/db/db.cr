require "json"

require "sqlite3"

require "./cluster"
require "./node"
require "./task"
require "./volume"
require "./brick"

module MoanaDB
  @@conn : DB::Database | Nil = nil

  def self.get_connection
    @@conn.not_nil!
  end

  def self.init(workdir : String)
    @@conn = DB.open("sqlite3://#{workdir}/moana.db")
    @@conn.not_nil!.exec "PRAGMA journal_mode=WAL;"
    create_table_clusters
    create_table_nodes
    create_table_tasks
    create_table_volumes
    create_table_bricks
  end
end
