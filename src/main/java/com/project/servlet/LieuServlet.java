package com.project.servlet;

import com.project.dao.LieuDAO;
import com.project.models.Lieu;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/lieux")
public class LieuServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private LieuDAO lieuDAO;

    @Override
    public void init() {
        lieuDAO = new LieuDAO();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        // ==========================
        // SUPPRESSION
        // ==========================
        if ("supprimer".equals(action)) {

            String operation = "suppr";

            try {

                String codelieu = request.getParameter("codelieu");

                if (codelieu == null || codelieu.trim().isEmpty()) {

                    response.sendRedirect(
                        "lieux?op=" + operation + "&status=error"
                    );
                    return;
                }

                lieuDAO.supprimer(codelieu);

                // Suppression réussie
                response.sendRedirect(
                    "lieux?op=" + operation + "&status=success"
                );

            } catch (Exception e) {

                e.printStackTrace();

                // Suppression échouée
                response.sendRedirect(
                    "lieux?op=" + operation + "&status=error"
                );
            }

        }

        // ==========================
        // MODIFICATION
        // ==========================
        else if ("editer".equals(action)) {

            try {

                String codelieu = request.getParameter("codelieu");

                Lieu lieuToEdit = lieuDAO.getByCode(codelieu);

                request.setAttribute(
                    "lieuEditer",
                    lieuToEdit
                );

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
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String operation;

        // Récupération de l'opération envoyée par le formulaire
        String opParam = request.getParameter("op");

        /*
         * Le JSP envoie :
         *
         * op=ajout  -> nouveau lieu
         * op=modif  -> modification
         *
         * Si le paramètre op n'existe pas, on utilise
         * la présence du codelieu comme sécurité supplémentaire.
         */

        String codelieu = request.getParameter("codelieu");

        if ("modif".equals(opParam)
                || (codelieu != null && !codelieu.trim().isEmpty())) {

            operation = "modif";

        } else {

            operation = "ajout";
        }

        try {

            String designation =
                    request.getParameter("designation");

            String province =
                    request.getParameter("province");

            // ==========================
            // CRÉATION DU LIEU
            // ==========================

            Lieu lieu = new Lieu();

            /*
             * Si le code existe, il s'agit d'une modification.
             * Sinon, le DAO peut générer le code automatiquement.
             */
            if (codelieu != null && !codelieu.trim().isEmpty()) {

                lieu.setCodelieu(codelieu);
            }

            lieu.setDesignation(designation);
            lieu.setProvince(province);

            // ==========================
            // SAUVEGARDE
            // ==========================

            lieuDAO.save(lieu);

            // ==========================
            // SUCCÈS
            // ==========================

            response.sendRedirect(
                "lieux?op=" + operation + "&status=success"
            );

        } catch (Exception e) {

            e.printStackTrace();

            // ==========================
            // ERREUR
            // ==========================

            response.sendRedirect(
                "lieux?op=" + operation + "&status=error"
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

        List<Lieu> listLieus =
                lieuDAO.getAll();

        request.setAttribute(
            "lieus",
            listLieus
        );

        request.getRequestDispatcher("/lieux.jsp")
               .forward(request, response);
    }
}