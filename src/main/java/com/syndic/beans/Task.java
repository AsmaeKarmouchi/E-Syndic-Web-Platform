package com.syndic.beans;

import java.util.Date;

public class Task {
    private int taskId;
    private String taskName;
    private String taskDescription;
    private String taskDueDate;
    private String taskStatus;
    private int taskSId;
    private double taskamount;
    private int taskSupplierId;

    // Getters and Setters

    public int getTaskId() {
        return taskId;
    }

    public void setTaskId(int taskId) {
        this.taskId = taskId;
    }

    public String getTaskName() {
        return taskName;
    }

    public void setTaskName(String taskName) {
        this.taskName = taskName;
    }

    public String getTaskDescription() {
        return taskDescription;
    }

    public void setTaskDescription(String taskDescription) {
        this.taskDescription = taskDescription;
    }

    public  String getTaskDueDate() {
        return taskDueDate;
    }

    public void setTaskDueDate(String taskDueDate) {
        this.taskDueDate = taskDueDate;
    }

    public String getTaskStatus() {
        return taskStatus;
    }

    public void setTaskStatus(String taskStatus) {
        this.taskStatus = taskStatus;
    }

    public int getTaskSId() {
        return taskSId;
    }

    public void setTaskSId(int taskSId) {
        this.taskSId = taskSId;
    }

    public  double getTaskAmount() {
        return taskamount;
    }

    public void setTaskAmount( double taskamount) {
        this.taskamount = taskamount;
    }
    public int getTaskSupplierId() {
        return taskSupplierId;
    }

    public void setTaskSupplierId(int taskSupplierId) {
        this.taskSupplierId = taskSupplierId;
    }
}
