package com.project.models;

import javax.persistence.*;

@Entity
@Table(name = "affecter")
public class Affecter {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "codeemp", nullable = false)
    private Employe employe;

    @ManyToOne
    @JoinColumn(name = "codelieu", nullable = false)
    private Lieu lieu;

    @Column(name = "date_affectation")
    private String dateAffectation;

    public Affecter() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Employe getEmploye() { return employe; }
    public void setEmploye(Employe employe) { this.employe = employe; }

    public Lieu getLieu() { return lieu; }
    public void setLieu(Lieu lieu) { this.lieu = lieu; }

    public String getDateAffectation() { return dateAffectation; }
    public void setDateAffectation(String dateAffectation) { this.dateAffectation = dateAffectation; }
}