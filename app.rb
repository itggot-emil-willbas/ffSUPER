require 'sinatra'
require 'sqlite3'
require 'json'

get('/') do

    db = SQLite3::Database.new('./db/fast_forward_db.sqlite')
    result = db.execute("SELECT * FROM courses")
    #result = result[0..-1]
    #Vi vill skicka två vars, en med alla kurnamn och en med info om collections  (namn + course_id)?
    print "REULT::"
    p result

    erb(:index, locals:{kurser:result})
end

#Hämta alla kommentarer från colllection

get('/comments/?') do
    collection_id = params["collection-select"]
    db = SQLite3::Database.new('./db/fast_forward_db.sqlite')
    result = db.execute("SELECT text FROM commments WHERE collection_id IN (SELECT id FROM collections WHERE id = ?)",collection_id)
    print "RESULT::"
    p result
    erb(:comments, locals:{comments:result})
end

#Hämta (via ajax), collections tillhörande courses
get('/collections/:courseid') do
    course_id = params[:courseid]
    db = SQLite3::Database.new('./db/fast_forward_db.sqlite')
    array = db.execute("SELECT id,collection_name FROM collections WHERE course_id = ?",course_id)
    object = {object_first_key:array}
return object.to_json  
end

get('/hello') do
    

    '42'
end

    


