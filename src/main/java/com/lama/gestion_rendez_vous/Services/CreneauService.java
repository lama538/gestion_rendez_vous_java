package com.lama.gestion_rendez_vous.Services;

import com.lama.gestion_rendez_vous.Models.Agenda;

import java.sql.Time;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

public class CreneauService {

    public List<String> generateCreneauxDisponibles(Agenda agenda) {
        List<String> creneaux = new ArrayList<>();

        LocalTime start = agenda.getHeureDebut().toLocalTime();
        LocalTime end = agenda.getHeureFin().toLocalTime();

        while (start.isBefore(end)) {
            creneaux.add(start.toString());
            start = start.plusMinutes(30);
        }

        return creneaux;
    }
}
