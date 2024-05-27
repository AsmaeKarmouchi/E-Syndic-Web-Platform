package com.syndic.dao;

import com.syndic.beans.Member;
import com.syndic.beans.Payment;
import com.syndic.beans.Task;

import java.sql.SQLException;
import java.util.List;

public interface TaskDAO {
    List<Task> getAllTasks();
    boolean insertTask(Task task);
    boolean updateTask(Task task);
    boolean deleteTask(int taskId);
    int getTaskCount() throws SQLException;
    float getTaskSum() throws SQLException;
    public List<Task> getTasksBySyndic(int syndicId)throws SQLException;

    List<Member> getMembersBySyndic(int syndicId) throws SQLException;
}
