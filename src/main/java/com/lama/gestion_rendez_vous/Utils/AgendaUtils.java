package com.lama.gestion_rendez_vous.Utils;

import com.lama.gestion_rendez_vous.Models.Rdv;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.HashSet;
import java.util.List;
import java.util.ArrayList;
import java.util.Set;
import com.lama.gestion_rendez_vous.Models.Agenda;


public class AgendaUtils {


    private static final int DUREE_CRENEAU = 30;

    public static List<String> getCreneauxDisponibles(Agenda agenda, List<Rdv> rdvsPris, LocalDate date) {
        List<String> creneaux = new ArrayList<>();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");

        LocalTime debut = agenda.getHeureDebut().toLocalTime();
        LocalTime fin = agenda.getHeureFin().toLocalTime();

        Set<LocalTime> horairesPris = new HashSet<>();
        for (Rdv r : rdvsPris) {

            if (r.getDateRdv().toLocalDateTime().toLocalDate().equals(date)) {

                LocalTime heure = r.getDateRdv().toLocalDateTime().toLocalTime().withSecond(0).withNano(0);
                horairesPris.add(heure);
            }
        }

        for (LocalTime heure = debut; heure.isBefore(fin); heure = heure.plusMinutes(DUREE_CRENEAU)) {
            if (!horairesPris.contains(heure)) {
                creneaux.add(heure.format(formatter));
            }
        }

        return creneaux;
    }
}