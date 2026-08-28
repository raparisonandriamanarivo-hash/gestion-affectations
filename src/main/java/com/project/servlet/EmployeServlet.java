package com.project.servlet;

import com.project.dao.EmployeDAO;
import com.project.models.Employe;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/employes")
public class EmployeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private EmployeDAO employeDAO;

    @Override
    public void init() {
        employeDAO = new EmployeDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String recherche = request.getParameter("recherche");

        // ==========================
        // SUPPRESSION
        // ==========================
        if ("supprimer".equals(action)) {

            String operation = "suppr";

            try {

                String codeemp = request.getParameter("codeemp");

                if (codeemp == null || codeemp.trim().isEmpty()) {
                    response.sendRedirect(
                        "employes?op=" + operation + "&status=error"
                    );
                    return;
                }

                employeDAO.supprimer(codeemp);

                // Suppression réussie
                response.sendRedirect(
                    "employes?op=" + operation + "&status=success"
                );

            } catch (Exception e) {

                e.printStackTrace();

                // Suppression échouée
                response.sendRedirect(
                    "employes?op=" + operation + "&status=error"
                );
            }

        }

        // ==========================
        // MODIFICATION : afficher le formulaire
        // ==========================
        else if ("editer".equals(action)) {

            try {

                String codeemp = request.getParameter("codeemp");

                Employe employeToEdit = employeDAO.getByCode(codeemp);

                request.setAttribute(
                    "employeEditer",
                    employeToEdit
                );

            } catch (Exception e) {

                e.printStackTrace();
            }

            chargerListesEtRediriger(request, response);
        }

        // ==========================
        // RECHERCHE
        // ==========================
        else if (recherche != null && !recherche.trim().isEmpty()) {

            List<Employe> listEmployes =
                    employeDAO.rechercher(recherche);

            request.setAttribute(
                "employes",
                listEmployes
            );

            request.setAttribute(
                "recherche",
                recherche
            );

            request.getRequestDispatcher("/employes.jsp")
                   .forward(request, response);
        }

        // ==========================
        // AFFICHAGE NORMAL
        // ==========================
        else {

            chargerListesEtRediriger(request, response);
        }
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String operation;

        // Récupération de l'opération envoyée par le formulaire
        String opParam = request.getParameter("op");

        String codeemp = request.getParameter("codeemp");

        /*
         * Si le formulaire indique "modif", ou si un code employé
         * existe déjà, on considère qu'il s'agit d'une modification.
         */
        if ("modif".equals(opParam)) {

            operation = "modif";

        } else {

            operation = "ajout";
        }

        try {

            String nom = request.getParameter("nom");
            String prenom = request.getParameter("prenom");
            String poste = request.getParameter("poste");

            // ==========================
            // CRÉATION DE L'EMPLOYÉ
            // ==========================

            Employe employe = new Employe();

            if (codeemp != null && !codeemp.trim().isEmpty()) {
                employe.setCodeemp(codeemp);
            }

            employe.setNom(nom);
            employe.setPrenom(prenom);
            employe.setPoste(poste);

            // ==========================
            // SAUVEGARDE
            // ==========================

            employeDAO.save(employe);

            // ==========================
            // OPÉRATION RÉUSSIE
            // ==========================

            response.sendRedirect(
                "employes?op=" + operation + "&status=success"
            );

        } catch (Exception e) {

            e.printStackTrace();

            // ==========================
            // OPÉRATION ÉCHOUÉE
            // ==========================

            response.sendRedirect(
                "employes?op=" + operation + "&status=error"
            );
        }
    }

    // ==========================
    // CHARGEMENT DES DONNÉES
    // ==========================

    private void chargerListesEtRediriger(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        List<Employe> listEmployes =
                employeDAO.getAll();

        request.setAttribute(
            "employes",
            listEmployes
        );

        request.getRequestDispatcher("/employes.jsp")
               .forward(request, response);
    }
}