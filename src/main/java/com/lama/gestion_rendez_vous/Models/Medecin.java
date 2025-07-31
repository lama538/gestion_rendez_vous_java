package com.lama.gestion_rendez_vous.Models;



import jakarta.persistence.*;

@Entity
@Table(name = "medecins")
public class Medecin {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String nom;
    private String specialite;
    private String email;
    private String telephone;

    public Medecin() {}

    public Medecin(String nom, String specialite, String email, String telephone) {
        this.nom = nom;
        this.specialite = specialite;
        this.email = email;
        this.telephone = telephone;
    }


    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }

    public String getSpecialite() { return specialite; }
    public void setSpecialite(String specialite) { this.specialite = specialite; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getTelephone() { return telephone; }
    public void setTelephone(String telephone) { this.telephone = telephone; }
}
