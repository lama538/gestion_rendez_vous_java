package com.lama.gestion_rendez_vous.dao;

import com.lama.gestion_rendez_vous.Models.Agenda;
import com.lama.gestion_rendez_vous.Models.User;
import com.lama.gestion_rendez_vous.Utils.JPAUtil;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

import java.time.LocalDate;
import java.util.List;
import java.util.logging.Logger;
import java.util.logging.Level;

public class AgendaDAO {

    private static final Logger logger = Logger.getLogger(AgendaDAO.class.getName());

    public void save(Agenda agenda) {
        EntityManager em = null;
        EntityTransaction tx = null;

        try {
            em = JPAUtil.getEntityManager();
            tx = em.getTransaction();

            logger.info("Début de sauvegarde de l'agenda - Médecin: " +
                    (agenda.getMedecin() != null ? agenda.getMedecin().getUsername() : "null") +
                    ", Date: " + agenda.getDateAgenda());

            tx.begin();


            if (agenda.getMedecin() != null && !em.contains(agenda.getMedecin())) {
                User attachedMedecin = em.find(User.class, agenda.getMedecin().getId());
                if (attachedMedecin == null) {
                    throw new IllegalArgumentException("Médecin avec ID " + agenda.getMedecin().getId() + " introuvable");
                }
                agenda.setMedecin(attachedMedecin);
            }

            em.persist(agenda);
            em.flush();
            tx.commit();

            logger.info("Agenda sauvegardé avec succès - ID: " + agenda.getId());

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Erreur lors de la sauvegarde de l'agenda", e);
            if (tx != null && tx.isActive()) {
                try {
                    tx.rollback();
                    logger.info("Transaction rollback effectué");
                } catch (Exception rollbackEx) {
                    logger.log(Level.SEVERE, "Erreur lors du rollback", rollbackEx);
                }
            }
            throw new RuntimeException("Erreur lors de la sauvegarde de l'agenda: " + e.getMessage(), e);
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Agenda> findAll() {
        EntityManager em = null;
        try {
            em = JPAUtil.getEntityManager();
            TypedQuery<Agenda> query = em.createQuery(
                    "SELECT a FROM Agenda a LEFT JOIN FETCH a.medecin ORDER BY a.dateAgenda DESC",
                    Agenda.class
            );
            List<Agenda> agendas = query.getResultList();
            logger.info("Récupération de " + agendas.size() + " agendas");
            return agendas;
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Erreur lors de la récupération des agendas", e);
            throw new RuntimeException("Erreur lors de la récupération des agendas", e);
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }



    public Agenda findByMedecinAndDate(int medecinId, LocalDate date) {
        EntityManager em = null;
        try {
            em = JPAUtil.getEntityManager();
            TypedQuery<Agenda> query = em.createQuery(
                    "SELECT a FROM Agenda a LEFT JOIN FETCH a.medecin WHERE a.medecin.id = :medecinId AND a.dateAgenda = :date",
                    Agenda.class
            );
            query.setParameter("medecinId", medecinId);
            query.setParameter("date", date);

            List<Agenda> results = query.getResultList();
            return results.isEmpty() ? null : results.get(0);
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Erreur lors de la recherche par médecin et date", e);
            return null;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Agenda> findByMedecin(int medecinId) {
        EntityManager em = null;
        try {
            em = JPAUtil.getEntityManager();
            TypedQuery<Agenda> query = em.createQuery(
                    "SELECT a FROM Agenda a LEFT JOIN FETCH a.medecin WHERE a.medecin.id = :medecinId ORDER BY a.dateAgenda DESC",
                    Agenda.class
            );
            query.setParameter("medecinId", medecinId);
            return query.getResultList();
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Erreur lors de la recherche par médecin", e);
            throw new RuntimeException("Erreur lors de la recherche par médecin", e);
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public Agenda findById(int id) {
        EntityManager em = null;
        try {
            em = JPAUtil.getEntityManager();
            Agenda agenda = em.find(Agenda.class, id);
            if (agenda != null && agenda.getMedecin() != null) {

                agenda.getMedecin().getUsername();
            }
            return agenda;
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Erreur lors de la recherche par ID", e);
            return null;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public boolean existsByMedecinAndDate(int medecinId, LocalDate date) {
        return findByMedecinAndDate(medecinId, date) != null;
    }

    public List<Agenda> findFutureAgendas() {
        EntityManager em = null;
        try {
            em = JPAUtil.getEntityManager();
            TypedQuery<Agenda> query = em.createQuery(
                    "SELECT a FROM Agenda a LEFT JOIN FETCH a.medecin WHERE a.dateAgenda >= :today ORDER BY a.dateAgenda ASC",
                    Agenda.class
            );
            query.setParameter("today", LocalDate.now());
            return query.getResultList();
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Erreur lors de la recherche des agendas futurs", e);
            throw new RuntimeException("Erreur lors de la recherche des agendas futurs", e);
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }
}
