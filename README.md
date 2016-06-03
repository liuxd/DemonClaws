X-Spider
============

> A customized crawler framework for `Ruby` and `Redis`.

## Requirements

+ redis
+ ruby

## Usage

#### Create Task

```
cd bin
./scaffold.rb #your_task_name
cd ../app
# develop your task.You have to implement the two methods: init, handle
```

#### Add Task

```
cd bin
./task.rb #your_task_name
```

#### Let's start!

```
cd bin
./daemon.rb start
```
