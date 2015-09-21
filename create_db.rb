# -*- coding: utf-8 -*-
require 'rubygems'
require 'sqlite3'

class CreatedDB
  def initialize
    @filename = ARGV[0]
    @created_at = @filename.split("/")[1]
    doc = File.open(File.absolute_path(@filename))
    @documents = doc.read.split("\n")
    doc.close

    if File.exists?("database.db")
      @db = SQLite3::Database.new("database.db")
    else
      make_db()
    end
  end

  def make_db
    @db = SQLite3::Database.new("database.db")
    sql = <<-SQL
       CREATE TABLE document(
         device_number integer,
         inode integer,
         permissions integer,
         hardlinks integer,
         user integer,
         groupp integer,
         special_files_device_number integer,
         size integer,
         atime text,
         mtime text,
         ctime text,
         type text,
         optimal_block_size integer,
         blocks integer,
         file_flags integer,
         path text,
         created_at text);
      SQL
    @db.execute(sql)
  end

  def close_db
    @db.close
  end

  def parse_documents
    @documents_hash = []
    @documents.each do |doc|
      d = doc.split("\\t")
      @documents_hash <<
        {"device_number" => d[0],
        "inode" => d[1],
        "permissions" => d[2],
        "hardlinks" => d[3],
        "user" => d[4],
        "group" => d[5],
        "special_files_device_number" => d[6],
        "size" => d[7],
        "atime" => d[8],
        "mtime" => d[9],
        "ctime" => d[10],
        "type" => d[11],
        "optimal_block_size" => d[12],
        "blocks" => d[13],
        "file_flags" => d[14],
        "path" => d[15],
        "created_at" => @created_at
      }
    end
  end

  def write_db
    @documents_hash.each do |doc|
      if doc["type"] != "Directory"
        @db.execute("INSERT INTO document values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
                    [doc["device_number"].to_i,
                     doc["inode"].to_i,
                     doc["permissions"].to_i,
                     doc["hardlinks"].to_i,
                     doc["user"].to_i,
                     doc["group"].to_i,
                     doc["special_files_device_number"].to_i,
                     doc["size"].to_i,
                     doc["atime"],
                     doc["mtime"],
                     doc["ctime"],
                     doc["type"],
                     doc["optimal_block_size"].to_i,
                     doc["blocks"].to_i,
                     doc["file_flags"].to_i,
                     doc["path"],
                     doc["created_at"]
                    ])
      end
    end
  end
end

db = CreatedDB.new
db.parse_documents
db.write_db
db.close_db
