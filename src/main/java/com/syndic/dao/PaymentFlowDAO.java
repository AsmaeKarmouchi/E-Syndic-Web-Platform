package com.syndic.dao;
import com.syndic.beans.PaymentFlow;

import java.sql.SQLException;
import java.util.List;
public interface PaymentFlowDAO {
    void addPaymentFlow(PaymentFlow paymentFlow) throws SQLException;
    List<PaymentFlow> getAllPaymentFlows() throws SQLException;
    List<PaymentFlow> getPaymentFlowsBySyndicId(int syndicId) throws SQLException;
   // PaymentFlow getPaymentFlowById(int id) throws SQLException;
    //void updatePaymentFlow(PaymentFlow paymentFlow) throws SQLException;
    //void deletePaymentFlow(int id) throws SQLException;
}
