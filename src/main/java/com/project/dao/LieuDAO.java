package com.project.dao;

import com.project.models.Lieu;
import com.project.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import java.util.List;

public class LieuDAO {

    // Méthode pour générer automatiquement un code unique (ex: L001, L002...)
    private String generateNewCodeLieu(Session session) {
        Long count = session.createQuery("SELECT COUNT(l) FROM Lieu l", Long.class).uniqueResult();
        int nextId = (count != null ? count.intValue() : 0) + 1;
        String newCode;
        
        // Boucle de sécurité au cas où des éléments ont été supprimés (évite les doublons)
        while (true) {
            newCode = String.format("L%03d", nextId);
            Lieu existing = session.get(Lieu.class, newCode);
            if (existing == null) {
                break; // Le code est libre
            }
            nextId++;
        }
        return newCode;
    }

    public void save(Lieu lieu) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            
            // Si le code est vide ou null (donc nouvelle création), on le génère automatiquement
            if (lieu.getCodelieu() == null || lieu.getCodelieu().trim().isEmpty()) {
                lieu.setCodelieu(generateNewCodeLieu(session));
            }
            
            session.saveOrUpdate(lieu);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null && transaction.isActive()) {
                try { transaction.rollback(); } catch (Exception rbEx) { rbEx.printStackTrace(); }
            }
            e.printStackTrace();
        }
    }

    public List<Lieu> getAll() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("FROM Lieu", Lieu.class).list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public Lieu getByCode(String codelieu) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.get(Lieu.class, codelieu);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public void supprimer(String codelieu) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            Lieu lieu = session.get(Lieu.class, codelieu);
            if (lieu != null) {
                session.delete(lieu);
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