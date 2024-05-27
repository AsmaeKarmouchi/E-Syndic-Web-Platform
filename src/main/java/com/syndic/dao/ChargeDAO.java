package com.syndic.dao;

import com.syndic.beans.Charge;
import com.syndic.beans.Incident;

import java.sql.Date;
import java.sql.SQLException;
import java.util.List;

public interface ChargeDAO {
    List<Charge> getCharges() throws SQLException;
    boolean insertCharge(Charge charge) throws SQLException;
    int getChargesCount() throws SQLException;
    boolean deleteCharge(int chargesId) throws SQLException;
    List<Charge> getChargesBySyndic(int syndicId) throws SQLException;

}
