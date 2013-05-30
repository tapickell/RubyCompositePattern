class Task
  attr_accessor :name, :parent

  def initialize(name)
    @name = name
    @parent = nil
  end

  def time_required
    0.0
  end

  def total_tasks
    1
  end
end

class CompositeTask < Task
  attr_accessor :subtasks

  def initialize(name)
    super(name)
    @subtasks = []
  end

  def add_sub_task(task)
    @subtasks << task
    task.parent = self
  end

  def remove_sub_task(task)
    @subtasks.delete(task)
    task.parent = nil
  end

  def <<(task)
    add_sub_task(task)
  end

  def time_required
    time = 0.0
    @subtasks.each do |task|
      time += task.time_required
    end
    time
  end

  def total_tasks
    total = 0
    @subtasks.each do |task|
      total += task.total_tasks
    end
    total
  end
end