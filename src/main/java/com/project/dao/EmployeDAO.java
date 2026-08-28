package com.project.dao;

import com.project.models.Employe;
import com.project.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import java.util.List;

public class EmployeDAO {

    private String generateNewCodeEmploye(Session session) {
        Long count = session.createQuery("SELECT COUNT(e) FROM Employe e", Long.class).uniqueResult();
        int nextId = (count != null ? count.intValue() : 0) + 1;
        String newCode;
        
        while (true) {
            newCode = String.format("EMP%03d", nextId);
            Employe existing = session.get(Employe.class, newCode);
            if (existing == null) {
                break;
            }
            nextId++;
        }
        return newCode;
    }

    public void save(Employe employe) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            
            if (employe.getCodeemp() == null || employe.getCodeemp().trim().isEmpty()) {
                employe.setCodeemp(generateNewCodeEmploye(session));
            }
            
            session.saveOrUpdate(employe);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null && transaction.isActive()) {
                try { transaction.rollback(); } catch (Exception rbEx) { rbEx.printStackTrace(); }
            }
            e.printStackTrace();
        }
    }

    public List<Employe> getAll() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("FROM Employe", Employe.class).list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public Employe getByCode(String codeemp) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.get(Employe.class, codeemp);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public void supprimer(String codeemp) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            Employe employe = session.get(Employe.class, codeemp);
            if (employe != null) {
                session.delete(employe);
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null && transaction.isActive()) {
                try { transaction.rollback(); } catch (Exception rbEx) { rbEx.printStackTrace(); }
            }
            e.printStackTrace();
        }
    }

    public List<Employe> rechercher(String keyword) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "FROM Employe WHERE codeemp LIKE :kw OR nom LIKE :kw OR prenom LIKE :kw OR poste LIKE :kw";
            return session.createQuery(hql, Employe.class)
                          .setParameter("kw", "%" + keyword + "%")
                          .list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}