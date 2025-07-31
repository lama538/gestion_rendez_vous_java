package com.lama.gestion_rendez_vous.dao;

import com.lama.gestion_rendez_vous.Models.Rdv;
import com.lama.gestion_rendez_vous.Utils.JPAUtil;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

public class RdvDAO {

    public void save(Rdv rdv) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();
            em.persist(rdv);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            System.err.println("Erreur lors de l'enregistrement du rendez-vous : " + e.getMessage());
            e.printStackTrace();
        } finally {
            em.close();
        }
    }


    public List<Rdv> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT r FROM Rdv r", Rdv.class).getResultList();
        } finally {
            em.close();
        }
    }


    public List<Rdv> getRdvsByMedecinAndDate(int medecinId, LocalDate date) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            LocalDateTime start = date.atStartOfDay();
            LocalDateTime end = date.atTime(23, 59, 59);

            String jpql = """
                SELECT r FROM Rdv r
                WHERE r.medecinId = :medecinId
                AND r.dateRdv BETWEEN :startOfDay AND :endOfDay
                AND r.statut <> 'annule'
            """;

            TypedQuery<Rdv> query = em.createQuery(jpql, Rdv.class);
            query.setParameter("medecinId", medecinId);
            query.setParameter("startOfDay", Timestamp.valueOf(start));
            query.setParameter("endOfDay", Timestamp.valueOf(end));

            return query.getResultList();
        } finally {
            em.close();
        }
    }


    public Rdv findByConfirmationCode(String code) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT r FROM Rdv r WHERE r.confirmationCode = :code", Rdv.class)
                    .setParameter("code", code)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }


    public void confirmerRendezVous(Rdv rdv) {
        if (rdv == null) return;

        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();
            Rdv managedRdv = em.find(Rdv.class, rdv.getId());
            if (managedRdv != null) {
                managedRdv.setStatut("confirme");
                managedRdv.setConfirmed(true);
                managedRdv.setConfirmationCode(null);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }



}
