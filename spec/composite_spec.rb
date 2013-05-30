require "composite.rb"

describe Task do
  before(:each) do
    @task = Task.new("test")
  end

  it "should be initialized with a name" do
    @task.name.should == "test"
  end

  it "should be initialized with a nil parent" do
    @task.parent.should == nil
  end

  describe "time_required" do
    it "should return 0.0" do
      @task.time_required.should == 0.0
    end
  end

  describe "total tasks" do
    it "should return 1" do
      @task.total_tasks.should == 1
    end
  end
end

describe CompositeTask do
  before(:each) do
    @composite = CompositeTask.new("testing")
  end

  it "should be initialized with a name" do
    @composite.name.should == "testing"
  end

  it "should be initialized with an empty sub tasks array" do
    @composite.subtasks.should == []
  end

  describe "adding and removing" do
    before(:each) do
      @task = Task.new("test")
      @composite.add_sub_task(@task)
    end

    describe "add_sub_task" do
      it "should add a task to the subtasks" do
        @composite.subtasks.should == [@task]
      end
    
      it "should set the task parent to the composite task" do
        @task.parent.should == @composite
      end
    end

    describe "remove_sub_task" do
      before(:each) do
        @composite.remove_sub_task(@task)
      end

      it "should remove a task from the subtasks" do
        @composite.subtasks.should == []
      end

      it "should set task parent to nil" do
        @task.parent.should == nil
      end
    end

    describe "<<" do
      before(:each) do
        @other_task = Task.new("other")
        @composite << @other_task
      end

      it "should add a task to the subtasks" do
        @composite.subtasks.should == [@task, @other_task]
      end
    
      it "should set the task parent to the composite task" do
        @other_task.parent.should == @composite
      end
    end
  end

  describe "accessory methods" do
    before(:each) do
      @sub1 = double("sub1")
      @sub2 = double("sub2")
      @sub1.stub(:time_required).and_return(2.5)
      @sub2.stub(:time_required).and_return(3.4)
      @sub1.stub(:total_tasks).and_return(1)
      @sub2.stub(:total_tasks).and_return(1)
      @sub1.stub(:parent=)
      @sub2.stub(:parent=)
      @composite = CompositeTask.new("test")
      @composite.add_sub_task(@sub1)
      @composite.add_sub_task(@sub2)
    end

    describe "time_required" do
      it "should return sum of time for all subtasks" do
        @composite.time_required.should == 5.9
      end
    end

    describe "total tasks" do
      it "should return 2" do
        @composite.total_tasks.should == 2
      end
    end
  end
end













