require "socket"
require "date"

server = TCPServer.open(3030)
puts "サーバー起動"
puts "http://localhost:3030/"
puts "クライアントからの接続を待っています。"

begin
  socket = server.accept

  # "\r\n"だけの行になるまで、1行ずつsocketへの書き込みを読み込む
  while (line = socket.gets) != "\r\n"
    path = line.split(" ")[1] if line&.start_with?("GET")
  end

  # Dateヘッダー用に現在時刻をUTCで取得し、形式を整える
  utc_date_string = DateTime.now.new_offset.strftime("%a, %d, %b %Y %H:%M:%S %Z GMT")

  # HTTPレスポンスヘッダーの書き込み
  socket.write("HTTP/1.1 OK\n")
  socket.write("Date: #{utc_date_string}\n")
  socket.write("Server: RubySimpleServer\n")
  socket.write("Connection: close\n")
  socket.write("Content-type: text/html\n")

  # 空白行　ヘッダーの終わりを示す
  socket.write("\r\n")

  # HTTPレスポンスボディの書き込み
  File.foreach("src/#{path}") do |line|
    socket.write(line)
  end
rescue => e
  puts e
ensure
  socket.close
  server.close
end
