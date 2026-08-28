<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Gestion des Lieux</title>
    <script>
        (function () {
            var t = localStorage.getItem('pm-theme') || 'dark';
            document.documentElement.setAttribute('data-theme', t);
        })();
    </script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,500;9..144,600;9..144,700&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --pm-bg: #0f1115;
            --pm-bg-soft: #161922;
            --pm-surface: #1c2029;
            --pm-surface-2: #21262f;
            --pm-border: rgba(255, 255, 255, 0.08);
            --pm-border-strong: rgba(255, 255, 255, 0.14);
            --pm-text: #eef1f6;
            --pm-muted: #98a1b3;
            --pm-gold: #c9a35b;
            --pm-gold-soft: rgba(201, 163, 91, 0.14);
            --pm-gold-strong: #d9b877;
            --pm-danger: #d8695f;
            --pm-danger-soft: rgba(216, 105, 95, 0.14);
            --pm-shadow: 0 20px 50px -20px rgba(0, 0, 0, 0.75);
        }

        html[data-theme="light"] {
            --pm-bg: #fafafa;
            --pm-bg-soft: #f4f5f7;
            --pm-surface: #ffffff;
            --pm-surface-2: #f0f2f5;
            --pm-border: rgba(0, 0, 0, 0.07);
            --pm-border-strong: rgba(0, 0, 0, 0.12);
            --pm-text: #1a1d20;
            --pm-muted: #656d78;
            --pm-gold: #b6893a;
            --pm-gold-soft: rgba(182, 137, 58, 0.10);
            --pm-gold-strong: #9c6f28;
            --pm-danger: #b5473d;
            --pm-danger-soft: rgba(181, 71, 61, 0.10);
            --pm-shadow: 0 14px 30px -15px rgba(0, 0, 0, 0.08);
        }

        * { box-sizing: border-box; }

        /* ===== Theme toggle ===== */
        .pm-theme-toggle {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            margin-left: 0.75rem;
            border-radius: 10px;
            border: 1px solid var(--pm-border-strong);
            background: var(--pm-surface-2);
            color: var(--pm-text);
            cursor: pointer;
            transition: color .2s ease, background .2s ease, transform .15s ease, border-color .2s ease;
        }
        .pm-theme-toggle:hover { transform: translateY(-1px); border-color: var(--pm-gold); color: var(--pm-gold-strong); }
        .pm-theme-toggle svg { width: 18px; height: 18px; }
        .pm-theme-toggle .pm-icon-sun { display: none; }
        html[data-theme="light"] .pm-theme-toggle .pm-icon-sun { display: block; }
        html[data-theme="light"] .pm-theme-toggle .pm-icon-moon { display: none; }

        body.pm-body {
            background:
                radial-gradient(1100px 520px at 88% -8%, rgba(201, 163, 91, 0.08), transparent 60%),
                radial-gradient(900px 500px at -6% 4%, rgba(90, 110, 160, 0.06), transparent 55%),
                var(--pm-bg);
            color: var(--pm-text);
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
            min-height: 100vh;
            letter-spacing: 0.1px;
        }

        /* ===== Navbar ===== */
        .pm-navbar {
            background: var(--pm-surface) !important;
            border-bottom: 1px solid var(--pm-border);
            padding-top: 0.9rem;
            padding-bottom: 0.9rem;
            box-shadow: 0 4px 20px -10px rgba(0,0,0,0.03);
        }
        .pm-navbar .navbar-brand {
            font-family: 'Fraunces', serif;
            font-weight: 600;
            font-size: 1.3rem;
            letter-spacing: 0.3px;
            color: var(--pm-text) !important;
            display: flex;
            align-items: center;
            gap: 0.6rem;
        }
        .pm-navbar .navbar-brand::before {
            content: "";
            width: 10px; height: 10px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--pm-gold-strong), var(--pm-gold));
            box-shadow: 0 0 0 4px var(--pm-gold-soft);
        }
        .pm-navbar .nav-link {
            color: var(--pm-muted) !important;
            font-weight: 500;
            font-size: 0.92rem;
            padding: 0.4rem 0.9rem !important;
            border-radius: 8px;
            transition: color .2s ease, background .2s ease;
        }
        .pm-navbar .nav-link:hover { color: var(--pm-text) !important; }
        .pm-navbar .nav-link.active {
            color: var(--pm-gold-strong) !important;
            background: var(--pm-gold-soft);
        }

        /* ===== Page heading ===== */
        .pm-heading {
            font-family: 'Fraunces', serif;
            font-weight: 600;
            font-size: 2.1rem;
            letter-spacing: 0.2px;
            margin-bottom: 0.25rem;
        }
        .pm-subtitle {
            color: var(--pm-muted);
            font-size: 0.95rem;
            margin-bottom: 2rem;
        }
        .pm-section-title {
            font-family: 'Fraunces', serif;
            font-weight: 600;
            font-size: 1.25rem;
            display: flex;
            align-items: center;
            gap: 0.6rem;
            margin-bottom: 1.25rem;
        }
        .pm-section-title .pm-kicker {
            font-family: 'Inter', sans-serif;
            font-size: 0.7rem;
            font-weight: 600;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            color: var(--pm-gold-strong);
            background: var(--pm-gold-soft);
            padding: 0.25rem 0.6rem;
            border-radius: 999px;
        }

        /* ===== Cards / surfaces ===== */
        .pm-card {
            background: linear-gradient(180deg, var(--pm-surface), var(--pm-bg-soft));
            border: 1px solid var(--pm-border);
            border-radius: 18px;
            box-shadow: var(--pm-shadow);
        }
        .pm-card .card-body { padding: 1.75rem; }

        .pm-sticky { position: sticky; top: 1.5rem; }

        /* ===== Form ===== */
        .pm-label {
            color: var(--pm-muted);
            font-size: 0.78rem;
            font-weight: 600;
            letter-spacing: 0.8px;
            text-transform: uppercase;
            margin-bottom: 0.45rem;
        }
        .pm-input {
            background: var(--pm-surface-2) !important;
            border: 1px solid var(--pm-border) !important;
            color: var(--pm-text) !important;
            border-radius: 11px !important;
            padding: 0.72rem 0.95rem !important;
            font-size: 0.95rem;
            transition: border-color .2s ease, box-shadow .2s ease, background .2s ease;
        }
        .pm-input::placeholder { color: var(--pm-muted); opacity: 0.7; }
        .pm-input:focus {
            background: var(--pm-surface-2) !important;
            border-color: var(--pm-gold) !important;
            box-shadow: 0 0 0 4px var(--pm-gold-soft) !important;
            outline: none;
        }

        /* ===== Buttons ===== */
        .pm-btn {
            border-radius: 11px !important;
            font-weight: 600 !important;
            letter-spacing: 0.2px;
            padding: 0.68rem 1.35rem !important;
            border: 1px solid transparent !important;
            transition: transform .15s ease, box-shadow .2s ease, background .2s ease, color .2s ease;
        }
        .pm-btn:hover { transform: translateY(-1px); }
        .pm-btn:active { transform: translateY(0); }

        .pm-btn-gold {
            background: linear-gradient(135deg, var(--pm-gold-strong), var(--pm-gold)) !important;
            color: #ffffff !important;
            box-shadow: 0 10px 20px -10px rgba(182, 137, 58, 0.5);
        }
        html[data-theme="dark"] .pm-btn-gold { color: #221a08 !important; }
        .pm-btn-gold:hover { opacity: 0.95; }

        .pm-btn-outline {
            background: transparent !important;
            color: var(--pm-text) !important;
            border-color: var(--pm-border-strong) !important;
        }
        .pm-btn-outline:hover { background: var(--pm-surface-2) !important; }

        .pm-btn-ghost {
            background: transparent !important;
            color: var(--pm-muted) !important;
            border-color: var(--pm-border) !important;
        }
        .pm-btn-ghost:hover { color: var(--pm-text) !important; background: var(--pm-surface-2) !important; }

        .pm-btn-edit {
            background: var(--pm-gold-soft) !important;
            color: var(--pm-gold-strong) !important;
            border-color: rgba(182, 137, 58, 0.25) !important;
        }
        .pm-btn-edit:hover { background: var(--pm-gold-soft) !important; opacity: 0.85; color: var(--pm-gold-strong) !important; }

        .pm-btn-del {
            background: var(--pm-danger-soft) !important;
            color: var(--pm-danger) !important;
            border-color: rgba(181, 71, 61, 0.25) !important;
        }
        .pm-btn-del:hover { background: var(--pm-danger-soft) !important; opacity: 0.85; color: var(--pm-danger) !important; }

        .pm-btn-sm { padding: 0.42rem 0.85rem !important; font-size: 0.82rem; }

        /* ===== Table ===== */
        .pm-table-wrap {
            border: 1px solid var(--pm-border);
            border-radius: 18px;
            overflow: hidden;
            box-shadow: var(--pm-shadow);
            background: var(--pm-surface);
        }
        .pm-table {
            width: 100%;
            margin: 0;
            border-collapse: separate;
            border-spacing: 0;
            color: var(--pm-text);
            font-size: 0.92rem;
        }
        .pm-table thead th {
            background: var(--pm-bg-soft);
            color: var(--pm-muted);
            font-size: 0.72rem;
            font-weight: 600;
            letter-spacing: 1px;
            text-transform: uppercase;
            padding: 0.95rem 1.1rem;
            border-bottom: 1px solid var(--pm-border-strong);
        }
        .pm-table tbody td {
            padding: 0.95rem 1.1rem;
            border-bottom: 1px solid var(--pm-border);
            vertical-align: middle;
        }
        .pm-table tbody tr { transition: background .18s ease; }
        .pm-table tbody tr:hover { background: var(--pm-surface-2); }
        .pm-table tbody tr:last-child td { border-bottom: none; }
        .pm-code-cell {
            font-variant-numeric: tabular-nums;
            font-weight: 600;
            color: var(--pm-gold-strong);
        }
        .pm-empty {
            text-align: center;
            color: var(--pm-muted);
            padding: 2.5rem 1rem !important;
            font-style: italic;
        }
        .pm-actions { display: flex; gap: 0.5rem; flex-wrap: wrap; }

        /* ===== Modals ===== */
        .pm-modal-overlay {
            position: fixed;
            inset: 0;
            z-index: 1080;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 1.5rem;
            background: rgba(0, 0, 0, 0.45);
            backdrop-filter: blur(6px);
            -webkit-backdrop-filter: blur(6px);
            opacity: 0;
            visibility: hidden;
            transition: opacity .25s ease, visibility .25s ease;
        }
        .pm-modal-overlay.is-open { opacity: 1; visibility: visible; }
        .pm-modal {
            width: 100%;
            max-width: 420px;
            background: linear-gradient(180deg, var(--pm-surface), var(--pm-bg-soft));
            border: 1px solid var(--pm-border);
            border-radius: 20px;
            box-shadow: var(--pm-shadow);
            padding: 2rem 1.9rem 1.75rem;
            text-align: center;
            transform: translateY(14px) scale(0.97);
            transition: transform .28s cubic-bezier(.16,1,.3,1);
        }
        .pm-modal-overlay.is-open .pm-modal { transform: translateY(0) scale(1); }
        .pm-modal-icon {
            width: 68px; height: 68px;
            margin: 0 auto 1.2rem;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .pm-modal-icon svg { width: 34px; height: 34px; stroke-width: 2.4; }
        .pm-modal[data-variant="success"] .pm-modal-icon {
            background: rgba(88, 173, 120, 0.16);
            color: #2e8b57;
            box-shadow: 0 0 0 6px rgba(88, 173, 120, 0.08);
        }
        .pm-modal[data-variant="error"] .pm-modal-icon {
            background: var(--pm-danger-soft);
            color: var(--pm-danger);
            box-shadow: 0 0 0 6px rgba(181, 71, 61, 0.08);
        }
        .pm-modal-title {
            font-family: 'Fraunces', serif;
            font-weight: 600;
            font-size: 1.4rem;
            margin-bottom: 0.5rem;
            color: var(--pm-text);
        }
        .pm-modal-text {
            color: var(--pm-muted);
            font-size: 0.95rem;
            margin-bottom: 1.6rem;
            line-height: 1.5;
        }
        .pm-modal .pm-btn { width: 100%; }
    </style>
</head>
<body class="pm-body">

    <!-- Barre de navigation -->
    <nav class="navbar navbar-expand-lg pm-navbar mb-4">
        <div class="container">
            <a class="navbar-brand" href="employes">Gestion des affectations</a>
            <div class="navbar-nav align-items-center">
                <a class="nav-link" href="employes"> Employ&eacute;s</a>
                <a class="nav-link active" href="lieux"> Lieux</a>
                <a class="nav-link" href="affectations"> Affectations</a>
                <button type="button" class="pm-theme-toggle" id="pmThemeToggle" aria-label="Changer de th&egrave;me" title="Changer de th&egrave;me">
                    <svg class="pm-icon-moon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"></path></svg>
                    <svg class="pm-icon-sun" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><circle cx="12" cy="12" r="5"></circle><line x1="12" y1="1" x2="12" y2="3"></line><line x1="12" y1="21" x2="12" y2="23"></line><line x1="4.22" y1="4.22" x2="5.64" y2="5.64"></line><line x1="18.36" y1="18.36" x2="19.78" y2="19.78"></line><line x1="1" y1="12" x2="3" y2="12"></line><line x1="21" y1="12" x2="23" y2="12"></line><line x1="4.22" y1="19.78" x2="5.64" y2="18.36"></line><line x1="18.36" y1="5.64" x2="19.78" y2="4.22"></line></svg>
                </button>
            </div>
        </div>
    </nav>

    <div class="container my-4">
        <p class="pm-subtitle">G&eacute;rez les sites et provinces de votre organisation avec pr&eacute;cision.</p>

        <div class="row g-4">

            <!-- ===== Colonne GAUCHE : Formulaire ===== -->
            <div class="col-lg-4">
                <div class="pm-card pm-sticky">
                    <div class="card-body">
                        <h5 class="pm-section-title">
                            <c:choose>
                                <c:when test="${not empty lieuEditer}">
                                    <span class="pm-kicker">&Eacute;dition</span> Modifier (${lieuEditer.codelieu})
                                </c:when>
                                <c:otherwise>
                                    <span class="pm-kicker">Nouveau</span> Lieu
                                </c:otherwise>
                            </c:choose>
                        </h5>

                        <form action="lieux" method="post">
                            <!-- Champ caché pour garder le code en cas de modification -->
                            <input type="hidden" name="codelieu" value="${lieuEditer.codelieu}" />

                            <div class="mb-3">
                                <label for="designation" class="pm-label d-block">D&eacute;signation</label>
                                <input type="text" name="designation" id="designation" class="form-control pm-input" value="${lieuEditer.designation}" placeholder="Ex : Si&egrave;ge central" required />
                            </div>

                            <div class="mb-3">
                                <label for="province" class="pm-label d-block">Province</label>
                                <input type="text" name="province" id="province" class="form-control pm-input" value="${lieuEditer.province}" placeholder="Ex : Antananarivo" required />
                            </div>

                            <div class="d-grid gap-2 mt-4">
                                <button type="submit" class="btn pm-btn ${not empty lieuEditer ? 'pm-btn-edit' : 'pm-btn-gold'}">
                                    ${not empty lieuEditer ? 'Modifier le lieu' : 'Enregistrer le lieu'}
                                </button>
                                <c:if test="${not empty lieuEditer}">
                                    <a href="lieux" class="btn pm-btn pm-btn-ghost">Annuler</a>
                                </c:if>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- ===== Colonne DROITE : Tableau ===== -->
            <div class="col-lg-8">
                <h4 class="pm-section-title"><span class="pm-kicker">Liste</span> Lieux</h4>
                <div class="pm-table-wrap">
                    <table class="pm-table">
                        <thead>
                            <tr>
                                <th>Code Lieu</th>
                                <th>D&eacute;signation</th>
                                <th>Province</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="lieu" items="${lieus}">
                                <tr>
                                    <td class="pm-code-cell">${lieu.codelieu}</td>
                                    <td>${lieu.designation}</td>
                                    <td>${lieu.province}</td>
                                    <td>
                                        <div class="pm-actions">
                                            <!-- Bouton Modifier -->
                                            <a href="lieux?action=editer&codelieu=${lieu.codelieu}" class="btn pm-btn pm-btn-sm pm-btn-edit">Modifier</a>
                                            <!-- Bouton Supprimer avec attribut data-href -->
                                            <a href="#" data-href="lieux?action=supprimer&codelieu=${lieu.codelieu}" class="btn pm-btn pm-btn-sm pm-btn-del btn-supprimer">Supprimer</a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty lieus}">
                                <tr>
                                    <td colspan="4" class="pm-empty">Aucun lieu trouv&eacute;.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>
    </div>

    <!-- ===== Modal de confirmation de suppression (Oui / Non) ===== -->
    <div class="pm-modal-overlay" id="pmConfirmOverlay" role="dialog" aria-modal="true">
        <div class="pm-modal" data-variant="error">
            <div class="pm-modal-icon">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"><path d="M3 6h18m-2 0v14c0 1-1 2-2 2H7c-1 0-2-1-2-2V6m3 0V4c0-1 1-2 2-2h4c1 0 2 1 2 2v2"></path></svg>
            </div>
            <h3 class="pm-modal-title">Confirmer la suppression</h3>
            <p class="pm-modal-text">&Ecirc;tes-vous s&ucirc;r de vouloir supprimer ce lieu ? Cette action est irr&eacuteversible.</p>
            <div class="d-flex gap-2">
                <button type="button" class="btn pm-btn pm-btn-ghost w-50" id="pmConfirmCancel">Non</button>
                <button type="button" class="btn pm-btn pm-btn-del w-50" id="pmConfirmYes">Oui</button>
            </div>
        </div>
    </div>

    <!-- ===== Modal de feedback ===== -->
    <div class="pm-modal-overlay" id="pmFeedbackOverlay" role="dialog" aria-modal="true" aria-labelledby="pmModalTitle">
        <div class="pm-modal" id="pmModal" data-variant="success">
            <div class="pm-modal-icon">
                <svg class="pm-icon-ok" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M20 6 9 17l-5-5"></path></svg>
                <svg class="pm-icon-ko" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true" style="display:none;"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>
            </div>
            <h3 class="pm-modal-title" id="pmModalTitle">Succ&egrave;s</h3>
            <p class="pm-modal-text" id="pmModalText"></p>
            <button type="button" class="btn pm-btn pm-btn-gold" id="pmModalClose">Continuer</button>
        </div>
    </div>

    <script>
        (function () {
            var btn = document.getElementById('pmThemeToggle');
            if (!btn) return;
            btn.addEventListener('click', function () {
                var current = document.documentElement.getAttribute('data-theme') === 'light' ? 'light' : 'dark';
                var next = current === 'light' ? 'dark' : 'light';
                document.documentElement.setAttribute('data-theme', next);
                localStorage.setItem('pm-theme', next);
            });
        })();
    </script>

    <!-- Gestion de la modale de confirmation (Oui / Non) -->
    <script>
        (function () {
            var confirmOverlay = document.getElementById('pmConfirmOverlay');
            var btnYes = document.getElementById('pmConfirmYes');
            var btnCancel = document.getElementById('pmConfirmCancel');
            var targetUrl = '';

            document.querySelectorAll('.btn-supprimer').forEach(function (btn) {
                btn.addEventListener('click', function (e) {
                    e.preventDefault();
                    targetUrl = this.getAttribute('data-href');
                    confirmOverlay.classList.add('is-open');
                });
            });

            function closeConfirm() {
                confirmOverlay.classList.remove('is-open');
                targetUrl = '';
            }

            if (btnCancel) btnCancel.addEventListener('click', closeConfirm);
            if (confirmOverlay) {
                confirmOverlay.addEventListener('click', function (e) {
                    if (e.target === confirmOverlay) closeConfirm();
                });
            }
            document.addEventListener('keydown', function (e) {
                if (e.key === 'Escape') closeConfirm();
            });

            if (btnYes) {
                btnYes.addEventListener('click', function () {
                    if (targetUrl) {
                        window.location.href = targetUrl;
                    }
                });
            }
        })();
    </script>

    <!-- Gestion de la modale de feedback -->
    <script>
        (function () {
            var params = new URLSearchParams(window.location.search);
            var op = params.get('op');
            var status = params.get('status');
            if (!op && !status) return;

            var messages = {
                ajout:  { success: 'Ajout avec succ\u00e8s',        error: "L'ajout a \u00e9chou\u00e9" },
                modif:  { success: 'Modification avec succ\u00e8s', error: 'La modification a \u00e9chou\u00e9' },
                suppr:  { success: 'Suppression avec succ\u00e8s',  error: 'La suppression a \u00e9chou\u00e9' }
            };

            var isError = status === 'error' || status === 'echec' || status === 'fail';
            var variant = isError ? 'error' : 'success';
            var opData = messages[op] || messages.ajout;
            var text = isError ? opData.error : opData.success;

            var overlay = document.getElementById('pmFeedbackOverlay');
            var modal = document.getElementById('pmModal');
            var title = document.getElementById('pmModalTitle');
            var textEl = document.getElementById('pmModalText');
            var iconOk = modal.querySelector('.pm-icon-ok');
            var iconKo = modal.querySelector('.pm-icon-ko');

            modal.setAttribute('data-variant', variant);
            title.textContent = isError ? 'Une erreur est survenue' : 'Op\u00e9ration r\u00e9ussie';
            textEl.textContent = text;
            iconOk.style.display = isError ? 'none' : 'block';
            iconKo.style.display = isError ? 'block' : 'none';

            requestAnimationFrame(function () { overlay.classList.add('is-open'); });

            function close() {
                overlay.classList.remove('is-open');
                var url = window.location.pathname;
                var keep = new URLSearchParams(window.location.search);
                keep.delete('op'); keep.delete('status');
                var qs = keep.toString();
                window.history.replaceState({}, document.title, url + (qs ? '?' + qs : ''));
            }

            document.getElementById('pmModalClose').addEventListener('click', close);
            overlay.addEventListener('click', function (e) { if (e.target === overlay) close(); });
            document.addEventListener('keydown', function (e) { if (e.key === 'Escape') close(); });
        })();
    </script>
</body>
</html>