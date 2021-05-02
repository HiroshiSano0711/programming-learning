require 'pry'

# 0 を返す
# p exit
# Kernel#at_exitで定義されたブロックを実行する
# at_exit { puts 'Last!' }
# exit
# => Last!

# 1を返す
# exit!

# 任意の値を返すこともできる
# exit 22

# Kernel#exitとKernel#exit!の違い
# exit!は1を返すがexitは0を返す
# exit!はKernel#at_exitで定義されたブロックを実行しない

# Kernel#abortは問題のあったプロセスを終了させる場合によく使われる
# 終了コード1を返す
# abort

# Kernel#at_exitで定義されたブロックは実行される
# at_exit { puts 'Last!' }
# abort 'something went wrong'

# => something went wrong
#    Last!

# raiseで送出された例外が補足されない場合にプロセスが終了される
# Kernel#raiseはプロセスを終了してもすぐには終了しない
# 例外がどこでも補足されなかった場合、結果としてプロセスが終了することになる。
# at_exitで定義されたブロックは実行される、バックトレースと例外メッセージがSTDERRに出力される
# raise 'hell'

# at_exit { puts 'Last!' }
# raise 'error'
# Last!
# Traceback (most recent call last):
# main.rb:35:in `<main>': error (RuntimeError)

### fork

# if fork
#   puts 'if block'
# else
#   puts 'else block'
# end

# puts "pid: #{Process.pid}"
# if fork
#   # 親プロセスによって実行される
#   puts "if block pid: #{Process.pid}"
# else
#   # 子プロセスによって実行される
#   puts "else block pid: #{Process.pid}"
# end

# pid: 33159
# if block pid: 33159
# else block pid: 33172

# forkはブロックとともによく使われる
# fork do
  # 子プロセスで実行する処理をここに記述する
# end

# 親プロセスで実行する処理をここに記述する

# 孤児プロセス
# fork do
#   5.times do
#     sleep 1
#     puts 'hello'
#   end
# end

# abort 'parent process died...'

# CoW（Copy on Write）によって、必要になるまでメモリーにコピーされない
# 変更せず読み込みだけなら親子間で共有すれば良い
# MRIはGCのアルゴリズムにマーク・スイープを採用している
# GC実行時に全てのオブジェクトが走査されて、そこに破棄すべきかどうか否かがマークされる。

# プロセスは待つことができる。　
# fork do
#   5.times do
#     sleep 1
#     puts 'hello'
#   end
# end

# Process.wait
# abort 'parent process died...'
# hello
# hello
# hello
# hello
# hello
# parent process died...

# Process.waitは子プロセスのどれか1つが終了するまでの間、親プロセスをブロックして待つ。
# 複数の子プロセスを管理する場合は、それぞれどの子プロセスが終了したのか知りたい。
# 3.times do
#   fork do
#     sleep rand(5)
#   end
# end

# 3.times do
#   puts Process.wait
# end

# wait2はpidと終了ステータスの2つの情報を返す
# 終了ステータスはProcess::Statusクラスのインスタンス
# Process::Statusオブジェクトはどのようにプロセスが終了したのかを正確に知るために有用な情報をたくさん保持している
# 5.times do
#   fork do
#     if rand(5).even?
#       exit 111
#     else
#       exit 112
#     end
#   end
# end

# 5.times do
#   pid, status = Process.wait2

#   if status.exitstatus == 111
#     puts "#{pid} encoutered an even number"
#   else
#     puts "#{pid} encoutered an odd number"
#   end
# end

# Process.waitpid, Process.waitpid2
# favourite = fork do
#   puts "favourite #{Process.pid}"
#   exit 77
# end

# middle_child = fork do
#   puts "middle_child #{Process.pid}"
#   abort 'waited on'
# end

# pid, status = Process.waitpid2 favourite
# puts pid 
# puts status.class
# puts status
# puts status.exitstatus

# 競合したりProcess.waitに辿り着く前に子プロセスが終了した場合どうなるのか
# 2.times do
#   fork do
#     abort 'finished'
#   end
# end

# 親プロセスは最初のプロセスの終了を待ってか5秒間スリープする
# puts Process.wait
# sleep 5

# puts Process.wait

# finished
# finished
# 78280 このあと5秒間待つ
# 78279
# カーネルは終了したプロセスの情報をキューに入れておく
# 親プロセスは子プロセスの終了時点の情報を必ず受け取ることができる。

# 終了を待つ子プロセスが1つもない状態でProcess.waitを呼び出すとErrno::ECHILD例外が送出される。
# 生成した子プロセス数を控えておいて、この例外が送出されないようにしておこう。

# ゾンビプロセス
# pid = fork { sleep 1 }
# puts pid

# ステータスがゾンビ状態を示すzかZ+が出力される
# $ ps -ho pid,state -p <出力されたpid>
# sleep 5

# シグナル受信
# child_procs = 3
# dead_procs = 0

# child_procs.times do
#   fork do
#     sleep 3
#   end
# end

# trap(:CHLD) do
#   puts Process.wait
#   dead_procs += 1
#   exit if dead_procs == child_procs
# end

# loop do
#   (Math.sqrt(rand(44)) ** 8).floor
#   sleep 10
# end

# シグナルの配信は信用できない
# もしCHLDシグナルを処理している最中に別の子プロセスが終了した場合、次のCHLDシグナルを捕捉できるかどうか保証がない

# child_procs = 3
# dead_procs = 0

# child_procs.times do
#   fork do
#     sleep 3
#   end
# end

# # CHLDハンドラの中で、putsの出力をバッファリングしないよう、$stdoutの出力を同期モードにする
# $stdout.sync = true


# trap(:CHLD) do
#   begin
#     while pid = Process.wait(-1, Process::WNOHANG)
#       puts pid
#       dead_procs += 1
#     end
#   rescue Errno::ECHILD
#   end
# end

# loop do
#   exit if dead_procs == child_procs
#   sleep 10
# end

# puts Process.pid
# sleep

# reader, writer = IO.pipe # => [#<IO:fd 11>, #<IO:fd 12>]
# writer.write('into the pipe')
# writer.close
# puts reader.read

# パイプは単方向
# reader.write('into the pipe')
# => into the pipe
# Traceback (most recent call last):
# 	1: from main.rb:246:in `<main>'
# main.rb:246:in `write': not opened for writing (IOError)

# reader, writer = IO.pipe

# fork do
#   reader.close
#   10.times do
#     writer.puts 'another one bites the dust'
#   end
# end

# writer.close
# while mesage = reader.gets
#   $stdout.puts mesage
# end

# require 'socket'
# child_socket, parent_sockt = Socket.pair(:UNIX, :DGRAM, 0)
# maxlen = 100

# fork do
#   parent_sockt.close

#   4.times do
#     inst = child_socket.recv(maxlen)
#     child_socket.send("#{inst} accomplished!", 0)
#   end
# end

# child_socket.close

# 2.times do
#   parent_sockt.send('heavy lifting', 0)
# end

# 2.times do
#   parent_sockt.send('feather lifting', 0)
# end

# 4.times do
#   $stdout.puts parent_sockt.recv(maxlen)
# end

# def daemonize_app
#   if RUBY_VERSION < '1.9'
#     # forkメソッドの戻り値をうまく活用している
#     # 親プロセスから戻ってきた場合はtrueに、子プロセスから戻ってきたときはfalseになる。
#     # つまり、子プロセスは孤児プロセスとなりそのまま継続する
#     # 孤児プロセスのppidは常にinitプロセスの1になる。
#     exit if fork

#     # 1. プロセスを新しいセッションのセッションリーダーにする
#     # 2. プロセスから新しいプロセスグループのプロセスグループリーダーにする
#     # 3. プロセスから制御端末を外す
#     Process.setsid
#     exit if fork
#     Dir.chdir '/'
#     STDIN.reopen '/dev/null'
#     STDOUT.reopen '/dev/null', 'a'
#     STDERR.reopen '/dev/null', 'a'
#   else
#     Process.daemon
#   end
# end

# puts Process.pid
# puts Process.getpgrp

# fork {
#   puts Process.pid
#   puts Process.getpgrp
# }
# 55180
# 55180
# 55193
# 55180
