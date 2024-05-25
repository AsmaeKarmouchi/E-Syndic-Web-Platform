package com.syndic.dao;

import com.syndic.beans.Supplier;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SupplierDAOImpl implements SupplierDAO {

    private final Connection connection;

    private static final String COUNT_SUPPLIERS = "SELECT COUNT(*) FROM Suppliers";
    
    public SupplierDAOImpl(Connection connection) {
        this.connection = connection;
    }

    @Override
    public List<Supplier> getAllSuppliers() {
        List<Supplier> suppliers = new ArrayList<>();
        String sql = "SELECT * FROM Suppliers";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Supplier supplier = new Supplier();

                supplier.setSupplier_id(rs.getInt("supplier_id"));
                supplier.setSupplier_name(rs.getString("supplier_name"));
                supplier.setSupplier_email(rs.getString("supplier_email"));
                supplier.setSupplier_phone(rs.getString("supplier_phone"));
                supplier.setSupplier_type(rs.getString("supplier_type"));
                supplier.setSupplier_active(rs.getBoolean("supplier_active"));
                supplier.setSupplier_rating(rs.getString("supplier_rating"));
                supplier.setSupplier_s_id(rs.getInt("supplier_s_id"));

                suppliers.add(supplier);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return suppliers;
    }

    @Override
    public boolean insertSupplier(Supplier supplier) {
        String query = "INSERT INTO Suppliers (supplier_name, supplier_email, supplier_phone, supplier_type, supplier_active, supplier_rating, supplier_s_id) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, supplier.getSupplier_name());
            statement.setString(2, supplier.getSupplier_email());
            statement.setString(3, supplier.getSupplier_phone());
            statement.setString(4, supplier.getSupplier_type());
            statement.setBoolean(5, supplier.isSupplier_active());
            statement.setString(6, supplier.getSupplier_rating());
            statement.setInt(7, supplier.getSupplier_s_id());

            int rowsInserted = statement.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean updateSupplier(Supplier supplier) {
        String query = "UPDATE Suppliers SET supplier_name = ?, supplier_email = ?, supplier_phone = ?, supplier_type = ?, supplier_active = ?, supplier_rating = ? WHERE supplier_s_id = ?";

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, supplier.getSupplier_name());
            statement.setString(2, supplier.getSupplier_email());
            statement.setString(3, supplier.getSupplier_phone());
            statement.setString(4, supplier.getSupplier_type());
            statement.setBoolean(5, supplier.isSupplier_active());
            statement.setString(6, supplier.getSupplier_rating());
            statement.setInt(7, supplier.getSupplier_s_id());

            int rowsUpdated = statement.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }



    @Override
    public boolean deleteSupplier(int supplier_s_id) {
        String query = "DELETE FROM Suppliers WHERE supplier_s_id = ?";

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, supplier_s_id);

            int rowsDeleted = statement.executeUpdate();
            return rowsDeleted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public int getSupplierCount() throws SQLException {
        try (PreparedStatement preparedStatement = connection.prepareStatement(COUNT_SUPPLIERS);
             ResultSet resultSet = preparedStatement.executeQuery()) {
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
            return 0;
        }
    }
}
