package com.lama.gestion_rendez_vous.Utils;

import jakarta.persistence.*;

public class JPAUtil {
    private static final EntityManagerFactory emf =
            Persistence.createEntityManagerFactory("cabinetPU");

    public static EntityManager getEntityManager() {
        return emf.createEntityManager();
    }
}
