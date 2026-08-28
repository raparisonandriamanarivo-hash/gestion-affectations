package com.project.models;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "employe")
public class Employe {

    @Id
    @Column(name = "codeemp", length = 50)
    private String codeemp;

    @Column(name = "nom")
    private String nom;

    @Column(name = "prenom")
    private String prenom;

    @Column(name = "poste")
    private String poste;

    @OneToMany(mappedBy = "employe", cascade = CascadeType.ALL)
    private List<Affecter> affectations;

    public Employe() {}

    public Employe(String codeemp, String nom, String prenom, String poste) {
        this.codeemp = codeemp;
        this.nom = nom;
        this.prenom = prenom;
        this.poste = poste;
    }

    public String getCodeemp() { return codeemp; }
    public void setCodeemp(String codeemp) { this.codeemp = codeemp; }

    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }

    public String getPrenom() { return prenom; }
    public void setPrenom(String prenom) { this.prenom = prenom; }

    public String getPoste() { return poste; }
    public void setPoste(String poste) { this.poste = poste; }
}