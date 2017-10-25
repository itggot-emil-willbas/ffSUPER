require 'sinatra'
require 'sqlite3'

get('/') do

    db = SQLite3::Database.new('db/fast_forward_db.sqlite')
    result = db.execute("SELECT name FROM courses")
    result = result[0..-1]
    erb(:index, locals:{kurser:result})
end

#Hämta alla kommentarer från colllection

get('/comments/:collectionid') do
    collection_id = params[:collectionid]
    db = SQLite3::Database.new('db/fast_forward_db.sqlite')
    result = db.execute("SELECT text FROM commments WHERE collection_id IN (SELECT id FROM collections WHERE id = ?)",collection_id).first
    print "RESULT::"
    p result
end


