package com.lama.gestion_rendez_vous.dao;

import com.lama.gestion_rendez_vous.Models.Medecin;
import com.lama.gestion_rendez_vous.Utils.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.List;

public class MedecinDAO {

    private EntityManager em;


    public MedecinDAO() {
        this.em = JPAUtil.getEntityManager();
    }

    public MedecinDAO(EntityManager em) {
        this.em = em;
    }

    public void ajouterMedecin(Medecin medecin) {
        em.getTransaction().begin();
        em.persist(medecin);
        em.getTransaction().commit();
    }


    public List<Medecin> getAllMedecins() {
        TypedQuery<Medecin> query = em.createQuery("SELECT m FROM Medecin m", Medecin.class);
        return query.getResultList();
    }

    public Medecin getMedecinById(int id) {
        return em.find(Medecin.class, id);
    }

    public void supprimerMedecin(int id) {
        Medecin m = em.find(Medecin.class, id);
        if (m != null) {
            em.getTransaction().begin();
            em.remove(m);
            em.getTransaction().commit();
        }
    }
}
