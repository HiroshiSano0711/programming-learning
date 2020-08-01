require 'date'
require 'pry'
#
# タスクの個々のデータのクラス
#
class Task
  COLUMNS = %i[id name limit_date updated_at created_at].freeze
  attr_accessor(*COLUMNS)
  @@tasks = []

  def initialize(**columns)
    self.attributes = columns
  end

  def self.find(id)
    target_task = @@tasks.find { |task| task.id == id.to_i }
  end

  def self.all
    @@tasks
  end

  def save
    self.updated_at = Time.now
    return if id
    self.created_at = Time.now
    self.id = @@tasks.map(&:id).max.to_i + 1
    @@tasks << self
  end

  def update
    self.updated_at = Time.now
  end

  def destroy
    @@tasks.delete_at(@@tasks.index(Task.find(id)))
  end

  def attributes=(**columns)
    valid_columns(columns).each do |key, val|
      instance_variable_set("@#{key}", val)
    end
  end

  private

  def valid_columns(columns)
    columns.select { |key, _val| (COLUMNS - [:id]).include?(key) }
  end
end
#
# 動作の指揮をするクラス
#
class TasksController
  attr_accessor :view_name

  def initialize
    @params = {}
  end

  def index
    @tasks = Task.all
  end

  def index_view
    if @tasks.count.zero?
      puts 'まだ登録されたタスクは有りません。'
      return
    end
    puts Task::COLUMNS.join(' | ')
    @tasks.each do |task|
      puts Task::COLUMNS.map { |column| task.send(column) }.join(' | ')
    end
  end

  def new
    prompt 'タスクの名前を入力してください。'
    @params[:name] = gets.strip.chomp
    prompt 'タスクの日時を入力してください。'
    @params[:limit_date] = gets.strip.chomp
    create
  end

  def create
    @task = Task.new(permit_params)
    @task.save
    redirect_to :index
  end

  def edit
    return redirect_to :index if Task.all.empty?
    validate_input_id('更新するタスクのidを入力してください。')
    prompt 'タスクの名前を入力してください。（未入力でそのまま）'
    name = gets.strip
    @params[:name] = name unless name.empty?
    prompt 'タスクの日時を入力してください。（未入力でそのまま）'
    @params[:limit_date] = gets.strip.chomp
    @params[:limit_date] = Task.find(@params[:id]).limit_date if @params[:limit_date].empty?
    update
  end

  def update
    @task = Task.find(@params[:id])
    @task.attributes = @params
    redirect_to :index
  end

  def destroy
    return redirect_to :index if Task.all.empty?
    validate_input_id('削除するタスクのidを入力してください。')
    @task = Task.find(@params[:id])
    @task.destroy
    puts '削除しました！！！'
    redirect_to :index
  end

  private

  def prompt(str)
    puts str
    print '> '
  end

  def permit_params
    @params.select { |k, v| %i[name limit_date].include?(k) && v }
  end

  def redirect_to(view_name)
    @view_name = view_name
    send(view_name.to_sym)
  end

  def validate_input_id(guidance)
    while @params[:id].nil? do
      prompt(guidance)
      input_id = gets.strip.to_i
      next puts '不正な値です！' if input_id.zero?
      if Task.all.any? { |task| task.id == input_id }
        @params[:id] = input_id
      else
        puts '該当のidは存在しません！'
      end
    end
  end
end
#
# 動作のコマンドとの紐付けを行うクラス
#
class ActionCommandRouter
  class << self

    def get_command_to_action
      100.times do
        display_command_menu
        actions = case gets.to_i
                  when 1 then %i[tasks index]
                  when 2 then %i[tasks new]
                  when 3 then %i[tasks edit]
                  when 4 then %i[tasks destroy]
                  when 5 then [false,  false]
                  else
                    display_command_error
                    next
                  end
        return actions
      end
      puts '試行回数が多すぎる為終了します。'
      [false, false]
    end

    def display_command_error
      puts "コマンドが誤っています。もう一度入力してください。\n"
    end

    def display_command_menu
      puts <<~EOS
        =========================
        =  MENU
        =  1. 一覧表示
        =  2. タスク追加
        =  3. タスク更新
        =  4. タスク削除
        =  5. 終了
        =========================
        実行する内容を選択してください。
      EOS
      print '> '
    end
  end
end
#
# アプリ本体のクラス
#
class TodoApp
  def initialize
    puts 'TODOアプリを開始します。'
  end

  def run
    loop do
      break unless set_controller_and_action
      exec_action
    end
    puts 'TODOアプリを終了します。'
  end

  private

  def set_controller_and_action
    @controller_name, @action_name = ActionCommandRouter.get_command_to_action
    @controller_name && @action_name
  end

  def exec_action
    controller = Object.const_get(controller_full_name).new
    controller.respond_to?(@action_name) || raise_unknown_action!
    controller.send(@action_name)
    view_name = "#{controller.view_name || @action_name}_view".to_sym
    controller.respond_to?(view_name) || raise_no_template!
    controller.send(view_name)
  end

  def controller_full_name
    classify(@controller_name) + 'Controller'
  end

  def classify(class_name)
    class_name.to_s.split('_').map(&:capitalize).join
  end

  def raise_unknown_action!
    raise "Unknown action The action '#{@action_name}' could not be found for #{controller_full_name}"
  end

  def raise_no_template!
    raise "No template found for #{controller_full_name}##{@action_name}"
  end
end

TodoApp.new.run
