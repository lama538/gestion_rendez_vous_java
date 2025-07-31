package com.lama.gestion_rendez_vous.dao;

import com.lama.gestion_rendez_vous.Models.Agenda;
import com.lama.gestion_rendez_vous.Models.User;
import com.lama.gestion_rendez_vous.Utils.JPAUtil;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

import java.time.LocalDate;
import java.util.List;

public class AgendaDAO {

    public void save(Agenda agenda) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();
            em.persist(agenda);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    public List<Agenda> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        List<Agenda> agendas = em.createQuery("SELECT a FROM Agenda a", Agenda.class).getResultList();
        em.close();
        return agendas;
    }

    public Agenda findByMedecinAndJour(int medecinId, String jourSemaine) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Agenda> query = em.createQuery(
                    "SELECT a FROM Agenda a WHERE a.medecin.id = :medecinId AND a.jourSemaine = :jour",
                    Agenda.class
            );
            query.setParameter("medecinId", medecinId);
            query.setParameter("jour", jourSemaine);

            List<Agenda> results = query.getResultList();
            return results.isEmpty() ? null : results.get(0);
        } finally {
            em.close();
        }
    }


    public List<Agenda> findByMedecin(int medecinId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Agenda> query = em.createQuery(
                    "SELECT a FROM Agenda a WHERE a.medecin.id = :medecinId",
                    Agenda.class
            );
            query.setParameter("medecinId", medecinId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public Agenda findById(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Agenda.class, id);
        } finally {
            em.close();
        }
    }


}
