package com.syndic.dao;

import com.syndic.beans.Supplier;

import java.sql.SQLException;
import java.util.List;

public interface SupplierDAO {

    List<Supplier> getAllSuppliers(int syndicId);

    boolean insertSupplier(Supplier supplier);

    boolean updateSupplier(Supplier supplier);

    boolean deleteSupplier(int supplier_id);
    int getSupplierCount() throws SQLException;
    int getSupplierCountsyndic(int syndicid) throws SQLException;
    int getSupplierIdByName(String supplierName) throws SQLException;
}
