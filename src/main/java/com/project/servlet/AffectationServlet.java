package com.project.servlet;

import com.project.dao.AffecterDAO;
import com.project.dao.EmployeDAO;
import com.project.dao.LieuDAO;
import com.project.models.Affecter;
import com.project.models.Employe;
import com.project.models.Lieu;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/affectations")
public class AffectationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private AffecterDAO affecterDAO;
    private EmployeDAO employeDAO;
    private LieuDAO lieuDAO;

    @Override
    public void init() {
        affecterDAO = new AffecterDAO();
        employeDAO = new EmployeDAO();
        lieuDAO = new LieuDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        // ==========================
        // SUPPRESSION
        // ==========================
        if ("supprimer".equals(action)) {

            String operation = "suppr";

            try {
                String idParam = request.getParameter("id");

                if (idParam == null || idParam.trim().isEmpty()) {
                    response.sendRedirect("affectations?op=" + operation + "&status=error");
                    return;
                }

                Long id = Long.parseLong(idParam);

                affecterDAO.supprimer(id);

                // Suppression réussie
                response.sendRedirect("affectations?op=" + operation + "&status=success");

            } catch (Exception e) {
                e.printStackTrace();

                // Suppression échouée
                response.sendRedirect("affectations?op=" + operation + "&status=error");
            }

        }

        // ==========================
        // MODIFICATION : afficher le formulaire
        // ==========================
        else if ("editer".equals(action)) {

            try {

                Long id = Long.parseLong(request.getParameter("id"));

                Affecter affectationToEdit = null;

                List<Affecter> allAffectations = affecterDAO.getAll();

                for (Affecter aff : allAffectations) {

                    if (aff.getId().equals(id)) {
                        affectationToEdit = aff;
                        break;
                    }
                }

                request.setAttribute("affectationEditer", affectationToEdit);

            } catch (Exception e) {
                e.printStackTrace();
            }

            chargerListesEtRediriger(request, response);
        }

        // ==========================
        // AFFICHAGE NORMAL
        // ==========================
        else {
            chargerListesEtRediriger(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String operation;

        // On récupère l'opération envoyée par le formulaire
        String opParam = request.getParameter("op");

        // Sécurité supplémentaire :
        // si op n'est pas envoyé, on détermine grâce à l'ID.
        String idStr = request.getParameter("id");

        if ("modif".equals(opParam)
                || (idStr != null && !idStr.trim().isEmpty())) {

            operation = "modif";

        } else {

            operation = "ajout";
        }

        try {

            String codeemp = request.getParameter("codeemp");
            String codelieu = request.getParameter("codelieu");
            String dateAff = request.getParameter("dateAffectation");

            // ==========================
            // RÉCUPÉRATION EMPLOYÉ
            // ==========================

            Employe emp = employeDAO.getByCode(codeemp);

            if (emp == null) {
                response.sendRedirect(
                    "affectations?op=" + operation + "&status=error"
                );
                return;
            }

            // ==========================
            // RÉCUPÉRATION LIEU
            // ==========================

            Lieu lieu = lieuDAO.getByCode(codelieu);

            if (lieu == null) {
                response.sendRedirect(
                    "affectations?op=" + operation + "&status=error"
                );
                return;
            }

            // ==========================
            // CRÉATION AFFECTATION
            // ==========================

            Affecter affectation = new Affecter();

            // Si modification, on récupère l'ID
            if (idStr != null && !idStr.trim().isEmpty()) {

                affectation.setId(Long.parseLong(idStr));
            }

            affectation.setEmploye(emp);
            affectation.setLieu(lieu);
            affectation.setDateAffectation(dateAff);

            // ==========================
            // SAUVEGARDE
            // ==========================

            affecterDAO.save(affectation);

            // ==========================
            // OPÉRATION RÉUSSIE
            // ==========================

            response.sendRedirect(
                "affectations?op=" + operation + "&status=success"
            );

        } catch (Exception e) {

            e.printStackTrace();

            // ==========================
            // OPÉRATION ÉCHOUÉE
            // ==========================

            response.sendRedirect(
                "affectations?op=" + operation + "&status=error"
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

        List<Affecter> listAffectations = affecterDAO.getAll();
        List<Employe> listEmployes = employeDAO.getAll();
        List<Lieu> listLieus = lieuDAO.getAll();

        request.setAttribute("affectations", listAffectations);
        request.setAttribute("employes", listEmployes);
        request.setAttribute("lieus", listLieus);

        request.getRequestDispatcher("/affectations.jsp")
               .forward(request, response);
    }
}