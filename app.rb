require 'sinatra'
require 'sqlite3'

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

get('/comments/:collectionid') do
    collection_id = params[:collectionid]
    db = SQLite3::Database.new('./db/fast_forward_db.sqlite')
    result = db.execute("SELECT text FROM commments WHERE collection_id IN (SELECT id FROM collections WHERE id = ?)",collection_id).first
    print "RESULT::"
    p result
end

#Hämta (via ajax), collections tillhörande courses
get('/collections/:courseid') do
    course_id = params[:courseid]
    db = SQLite3::Database.new('./db/fast_forward_db.sqlite')
    resultbanan = db.execute("SELECT id,collection_name FROM collections WHERE course_id = ?",course_id)
    print "Result (course_id):"
    p resultbanan
    options = ""
    for coll in resultbanan do
        options << "<option value=" + coll[0].to_s + ">" + coll[1].to_s + "</option>"
    end

    options
    #resultbanan = resultbanan[1][1]
    #meddelande = "<h1>Lite h1-text som skickas</h1><h2>"  + resultbanan + "</h2>"
    #print "Meddelande:"
    #p meddelande
   # meddelande.to_s

    ##############HUR SKICKA EN ARRAY TILL index.erb??
    #erb(:index, locals:{results:resultbanan})
    
    #erb(:index, locals:{returned:result})
end

get('/hello') do
    

    '42'
end

    


