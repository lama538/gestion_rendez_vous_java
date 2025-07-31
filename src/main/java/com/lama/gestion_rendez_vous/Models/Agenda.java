package com.lama.gestion_rendez_vous.Models;

import jakarta.persistence.*;
import java.sql.Time;

@Entity
@Table(name = "agenda")
public class Agenda {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "medecin", referencedColumnName = "id", nullable = false)
    private User medecin;

    @Column(name = "jour_semaine", nullable = false)
    private String jourSemaine;

    @Column(name = "heure_debut", nullable = false)
    private Time heureDebut;

    @Column(name = "heure_fin", nullable = false)
    private Time heureFin;


    public Agenda() {}


    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public User getMedecin() { return medecin; }
    public void setMedecin(User medecin) { this.medecin = medecin; }

    public String getJourSemaine() { return jourSemaine; }
    public void setJourSemaine(String jourSemaine) { this.jourSemaine = jourSemaine; }

    public Time getHeureDebut() { return heureDebut; }
    public void setHeureDebut(Time heureDebut) { this.heureDebut = heureDebut; }

    public Time getHeureFin() { return heureFin; }
    public void setHeureFin(Time heureFin) { this.heureFin = heureFin; }
}
