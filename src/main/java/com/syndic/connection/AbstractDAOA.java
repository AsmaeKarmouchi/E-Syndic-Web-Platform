package com.syndic.connection;
//pfa
import java.sql.Connection;

public class AbstractDAOA {
    protected Connection connection = Syndic_con.getConnection();
}
