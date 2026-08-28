package com.project.models;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "lieu")
public class Lieu {

    @Id
    @Column(name = "codelieu", length = 50)
    private String codelieu;

    @Column(name = "designation")
    private String designation;

    @Column(name = "province")
    private String province;

    @OneToMany(mappedBy = "lieu", cascade = CascadeType.ALL)
    private List<Affecter> affectations;

    public Lieu() {}

    public Lieu(String codelieu, String designation, String province) {
        this.codelieu = codelieu;
        this.designation = designation;
        this.province = province;
    }

    public String getCodelieu() { return codelieu; }
    public void setCodelieu(String codelieu) { this.codelieu = codelieu; }

    public String getDesignation() { return designation; }
    public void setDesignation(String designation) { this.designation = designation; }

    public String getProvince() { return province; }
    public void setProvince(String province) { this.province = province; }
}	