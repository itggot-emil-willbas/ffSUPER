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

    #Hur skicka en hash ifrån jquery? Posta går, men bara JSON-object...
    
    obj = {"collection_name" => "Feedback",
        "course_id" => "1",
        "comments" => [["Tänk på ditten och datten HTML","red","konstr"],["Bra design","green","pos"]] }

    #i comments: lägg till text, color 
    #i collections: lägg till collection_name, course_id
   #array_array = [] 
   #array = [text, color, collection_id, collection_name, course_id]
   #arr = ["Tänk på ditten och datten HTML","red","Avstämning HTML","1"]
   #Debug: What if collection_name copy
  
   db = SQLite3::Database.new('./db/fast_forward_db.sqlite')
    
   db.execute("INSERT INTO collections (collection_name, course_id) VALUES (?,?)",obj["collection_name"],obj["course_id"])
   #Hämta id för nyligen tillagda collection här (blir "collection_id" nedan)
   collection_id = db.execute("SELECT id FROM collections WHERE collection_name = ?",obj["collection_name"])

   for comment in obj["comments"] do
        db.execute("INSERT INTO comments (text, color, collection_id) VALUES (?,?,?)",comment[0],comment[1],collection_id)
   end

   print "Tillagd collection med #{obj}"
end

    


