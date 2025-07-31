package com.lama.gestion_rendez_vous.Models;

import jakarta.persistence.*;
import java.sql.Time;
import java.time.LocalDate;

@Entity
@Table(name = "agenda")
public class Agenda {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "medecin", referencedColumnName = "id", nullable = false)
    private User medecin;

    @Column(name = "date_agenda", nullable = false)
    private LocalDate dateAgenda;

    @Column(name = "heure_debut", nullable = false)
    private Time heureDebut;

    @Column(name = "heure_fin", nullable = false)
    private Time heureFin;

    public Agenda() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public User getMedecin() { return medecin; }
    public void setMedecin(User medecin) { this.medecin = medecin; }

    public LocalDate getDateAgenda() { return dateAgenda; }
    public void setDateAgenda(LocalDate dateAgenda) { this.dateAgenda = dateAgenda; }

    public Time getHeureDebut() { return heureDebut; }
    public void setHeureDebut(Time heureDebut) { this.heureDebut = heureDebut; }

    public Time getHeureFin() { return heureFin; }
    public void setHeureFin(Time heureFin) { this.heureFin = heureFin; }
}