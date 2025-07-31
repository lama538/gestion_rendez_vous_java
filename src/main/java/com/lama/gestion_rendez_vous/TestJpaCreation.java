package com.lama.gestion_rendez_vous;

import com.lama.gestion_rendez_vous.Utils.JPAUtil;
import com.lama.gestion_rendez_vous.Models.Medecin;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class TestJpaCreation {
    public static void main(String[] args) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("cabinetPU");
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        System.out.println(" JPA connecté !");
        em.getTransaction().commit();
        em.close();
        emf.close();
    }
}
