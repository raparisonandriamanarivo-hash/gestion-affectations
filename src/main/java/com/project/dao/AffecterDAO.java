package com.project.dao;

import com.project.models.Affecter;
import com.project.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import java.util.List;

public class AffecterDAO {

    public void save(Affecter affecter) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.saveOrUpdate(affecter);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null && transaction.isActive()) {
                try { transaction.rollback(); } catch (Exception rbEx) { rbEx.printStackTrace(); }
            }
            e.printStackTrace();
        }
    }

    public List<Affecter> getAll() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery(
                "FROM Affecter a JOIN FETCH a.employe JOIN FETCH a.lieu", Affecter.class)
                .list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public void supprimer(Long id) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            Affecter affecter = session.get(Affecter.class, id);
            if (affecter != null) {
                session.delete(affecter);
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null && transaction.isActive()) {
                try { transaction.rollback(); } catch (Exception rbEx) { rbEx.printStackTrace(); }
            }
            e.printStackTrace();
        }
    }
}