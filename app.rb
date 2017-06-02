require "sinatra"
require "pg"
require "pry"
system "psql grocery_list_development < schema.sql"
system "psql grocery_list_development < data.sql"
set :bind, '0.0.0.0'  # bind to all interfaces

configure :development do
  set :db_config, { dbname: "grocery_list_development" }
end

configure :test do
  set :db_config, { dbname: "grocery_list_test" }
end

def db_connection
  begin
    connection = PG.connect(Sinatra::Application.db_config)
    yield(connection)
  ensure
    connection.close
  end
end

get "/" do
  redirect "/groceries"
end

get "/groceries" do
  @comment = params[:body]
  @id = params[:id]
  @groceries =  db_connection do |conn|
    conn.exec_params("SELECT name, groceries.id AS id, comments.body FROM groceries
    LEFT OUTER JOIN comments ON groceries.id = comments.id")
  end
  erb :groceries
end

get '/groceries/:id' do
  @id = params[:id]
  @name = params[:name]
  @comment = params[:body]
  @groceries =  db_connection do |conn|
    conn.exec_params("SELECT name, groceries.id AS id, comments.body FROM groceries
    LEFT OUTER JOIN comments ON groceries.id = comments.id")
  end
  @groceries.to_a
#somehow grab its primary key,
  @g_id = @groceries.find { |item| item["id"] == params["id"] }
  @items = db_connection do |conn|
    conn.exec_params("SELECT name, groceries.id, comments.body FROM groceries
    FULL OUTER JOIN comments ON groceries.id = comments.grocery_id
    ")
  end
  erb :show
end

post "/groceries" do
  @id = params[:id]
  @name = params[:name]
  @comment = params[:body] #why is it nil
  if @name == ""
    redirect "/groceries"
  elsif @comment == ""
    db_connection do |conn|
      conn.exec_params("INSERT INTO groceries (name) VALUES ($1)", [@name])
    end
    redirect "/groceries"
  else
    db_connection do |conn|
      conn.exec_params("INSERT INTO groceries (name) VALUES ($1)", [@name])
    end
    db_connection do |conn|
      conn.exec_params("INSERT INTO comments (body,grocery_id) VALUES ($1,$2)", [@comment,@g_id])
    end
    redirect "/groceries"
  end
  redirect "/groceries"
end
