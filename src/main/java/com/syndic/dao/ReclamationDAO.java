package com.syndic.dao;

import com.syndic.beans.Reclamation;
import java.sql.SQLException;
import java.util.List;

public interface ReclamationDAO {
   // void ajouterReclamation(Reclamation reclamation) throws SQLException;
   boolean insertReclaim(Reclamation reclaim) throws SQLException;

   List<Reclamation> getAllReclamationsByMemberId(int memberId);
}
