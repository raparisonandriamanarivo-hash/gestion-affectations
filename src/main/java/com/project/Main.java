package com.project;

import com.project.dao.AffecterDAO;
import com.project.dao.EmployeDAO;
import com.project.dao.LieuDAO;

public class Main {
    public static void main(String[] args) {
        EmployeDAO employeDAO = new EmployeDAO();
        LieuDAO lieuDAO = new LieuDAO();
        AffecterDAO affecterDAO = new AffecterDAO();

        /* 
         * L'insertion automatique est commentée ici pour éviter 
         * de réinsérer des données en boucle à chaque test.
         
        Employe emp = new Employe();
        emp.setCodeemp("EMP01");
        emp.setNom("Raparison");
        emp.setPrenom("Andry");
        employeDAO.save(emp);

        Lieu lieu = new Lieu();
        lieu.setCodelieu("L01"); 
        lieu.setDesignation("Antananarivo");
        lieuDAO.save(lieu);
        */

        System.out.println("-> Classe Main exécutée sans insertion automatique.");
    }
}