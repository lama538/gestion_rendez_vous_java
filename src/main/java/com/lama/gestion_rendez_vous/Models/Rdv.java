package com.lama.gestion_rendez_vous.Models;

import jakarta.persistence.*;
import java.sql.Timestamp;

@Entity
@Table(name = "rdvs")
public class Rdv {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "patient_id", nullable = false)
    private int patientId;

    @Column(name = "medecin_id", nullable = false)
    private int medecinId;

    @Column(name = "date_rdv", nullable = false)
    private Timestamp dateRdv;

    @Column(nullable = false)
    private String statut;
    @Column(unique = true)
    private String confirmationCode;

    @Column(nullable = false)
    private boolean isConfirmed = false;
    public Rdv() {}

    public Rdv(int id, int patientId, int medecinId, Timestamp dateRdv, String statut,String confirmationCode, boolean isConfirmed) {
        this.id = id;
        this.patientId = patientId;
        this.medecinId = medecinId;
        this.dateRdv = dateRdv;
        this.statut = statut;
        this.confirmationCode = confirmationCode;
        this.isConfirmed = isConfirmed;
    }


    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getPatientId() { return patientId; }
    public void setPatientId(int patientId) { this.patientId = patientId; }

    public int getMedecinId() { return medecinId; }
    public void setMedecinId(int medecinId) { this.medecinId = medecinId; }

    public Timestamp getDateRdv() { return dateRdv; }
    public void setDateRdv(Timestamp dateRdv) { this.dateRdv = dateRdv; }

    public String getStatut() { return statut; }
    public void setStatut(String statut) { this.statut = statut; }

    public String getConfirmationCode() { return confirmationCode; }
    public void setConfirmationCode(String confirmationCode) { this.confirmationCode = confirmationCode; }

    public boolean isConfirmed() { return isConfirmed; }
    public void setConfirmed(boolean confirmed) { isConfirmed = confirmed; }
}
