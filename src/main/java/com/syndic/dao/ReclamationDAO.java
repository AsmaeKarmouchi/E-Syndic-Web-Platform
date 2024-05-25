package com.syndic.dao;

import com.syndic.beans.Reclamation;
import java.sql.SQLException;

public interface ReclamationDAO {
    void ajouterReclamation(Reclamation reclamation) throws SQLException;
}
