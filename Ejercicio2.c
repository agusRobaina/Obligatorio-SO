#include <pthread.h>
#include <semaphore.h>
#include <stdio.h>

//Ejercicio2 288469/ 269622

// Definición de semáforos para cada materia
<<<<<<< HEAD
sem_t SI_CS, SO_SD, SO_CS, RC_SD, RC_SO, RC_DW, RC_SI, BD_BigD, BD_DW, BD_SI, F2_RC, F2_RO, IP_ED, F1_F2, M1_M2, M2_PA, M2_AA, M2_IA, M2_BigD, ED_PA, ED_BD, F2_CG, PA_CG, PA_RC, PA_RO, PA_SO, PA_IS, PA_IA, PA_AA; 
=======
sem_t SI_CS, SO_SD, SO_CS, RC_SD, RC_SO, RC_DW, RC_SI, BD_BigD, BD_DW, BD_SI, F2_RC, F2_RO, IP_ED, F1_F2, M1_M2, M2_PA, M2_AA, M2_IA, M2_BigD, ED_PA, ED_BD, F2_CG, PA_CG, PA_RC, PA_RO, PA_SO, PA_IS, PA_IA, PA_AA ;
>>>>>>> 71208c0448bbdc608f01e71327a43e0a120cc7e7
// Funciones de los threads (una por materia)
void *tIP_function(void *arg) {
    printf("Introducción a la Programación\n");
    sem_post(&IP_ED);
    return NULL;
}

void *tF1_function(void *arg) {
    printf("Física 1\n");
    sem_post(&F1_F2);
    return NULL;
}

void *tM1_function(void *arg) {
    printf("Matematica 1\n");
    sem_post(&M1_M2);
    return NULL;
}

void *tM2_function(void *arg) {
    sem_wait(&M1_M2);
    printf("Matematica 2\n");
    sem_post(&M2_PA);
    sem_post(&M2_AA);
    sem_post(&M2_IA);
    sem_post(&M2_BigD);
    return NULL;
}

void *tED_function(void *arg) {
    sem_wait(&IP_ED);
    printf("Estructuras de Datos\n");
    sem_post(&ED_PA);
    sem_post(&ED_BD);
    return NULL;
}

void *tF2_function(void *arg) {
    sem_wait(&F1_F2);
    printf("Fisica 2\n");
    sem_post(&F2_CG);
    sem_post(&F2_RO);
    sem_post(&F2_RC);
    return NULL;
}

void *tBD_function(void *arg) {
    sem_wait(&ED_BD);
    printf("Bases de Datos\n");
    sem_post(&BD_SI);
    sem_post(&BD_DW);
    sem_post(&BD_BigD);
    return NULL;
}

void *tPA_function(void *arg) {
    sem_wait(&M2_PA);
    sem_wait(&ED_PA);
    printf("Programacion Avanzada\n");
    sem_post(&PA_CG);
    sem_post(&PA_RC);
    sem_post(&PA_RO);
    sem_post(&PA_SO);
    sem_post(&PA_IS);
    sem_post(&PA_IA);
    sem_post(&PA_AA);
    return NULL;
}

void *tAA_function(void *arg) {
    sem_wait(&M2_AA);
    sem_wait(&PA_AA);
    printf("Analisis de Algoritmos\n");
    return NULL;
}

void *tIA_function(void *arg) {
    sem_wait(&M2_IA);
    sem_wait(&PA_IA);
    printf("Inteligencia Artificial\n");
    return NULL;
}

void *tIS_function(void *arg) {
    sem_wait(&PA_IS);
    printf("Ingenieria de Software\n");
    return NULL;
}

void *tBigD_function(void *arg) {
    sem_wait(&M2_BigD);
    sem_wait(&BD_BigD);
    printf("Big Data\n");
    return NULL;
}

void *tCG_function(void *arg) {
    sem_wait(&F2_CG);
    sem_wait(&PA_CG);
    printf("Computacion Grafica\n");
    return NULL;
}

void *tRC_function(void *arg) {
    sem_wait(&F2_RC);
    sem_wait(&PA_RC);
    printf("Redes de Computadoras\n");
    sem_post(&RC_SI);
    sem_post(&RC_DW);
    sem_post(&RC_SO);
    sem_post(&RC_SD);
    return NULL;
}

void *tSI_function(void *arg) {
    sem_wait(&RC_SI);
    sem_wait(&BD_SI);
    printf("Seguridad Informática\n");
    sem_post(&SI_CS);
    return NULL;
}

void *tSO_function(void *arg) {
    sem_wait(&PA_SO);
    sem_wait(&RC_SO);
    printf("Sistemas Operativos\n");
    sem_post(&SO_SD);
    sem_post(&SO_CS);
    return NULL;
}

void *tRO_function(void *arg) {
    sem_wait(&PA_RO);
    sem_wait(&F2_RO);
    printf("Robótica\n");
    return NULL;
}

void *tDW_function(void *arg) {
    sem_wait(&RC_DW);
    sem_wait(&BD_DW);
    printf("Desarrollo Web\n");
    return NULL;
}

void *tSD_function(void *arg) {
    sem_wait(&SO_SD);
    sem_wait(&RC_SD);
    printf("Sistemas Distribuidos\n");
    return NULL;
}

void *tCS_function(void *arg) {
    sem_wait(&SI_CS);
    sem_wait(&SO_CS);
    printf("Ciberseguridad\n");
    return NULL;
}

int main()
{
    // Inicialización de semáforos
    sem_init(&SO_SD, 0, 0);
    sem_init(&SO_CS, 0, 0);
    sem_init(&RC_SD, 0, 0);
    sem_init(&RC_SO, 0, 0);
    sem_init(&RC_DW, 0, 0);
    sem_init(&RC_SI, 0, 0);
    sem_init(&BD_BigD, 0, 0);
    sem_init(&BD_DW, 0, 0);
    sem_init(&BD_SI, 0, 0);
    sem_init(&F2_RC, 0, 0);
    sem_init(&F2_RO, 0, 0);
    sem_init(&IP_ED, 0, 0);
    sem_init(&F1_F2, 0, 0);
    sem_init(&M1_M2, 0, 0);
    sem_init(&M2_PA, 0, 0);
    sem_init(&M2_AA, 0, 0);
    sem_init(&M2_IA, 0, 0);
    sem_init(&M2_BigD, 0, 0);
    sem_init(&ED_PA, 0, 0);
    sem_init(&ED_BD, 0, 0);
    sem_init(&F2_CG, 0, 0);
    sem_init(&PA_CG, 0, 0);
    sem_init(&PA_RC, 0, 0);
    sem_init(&PA_RO, 0, 0);
    sem_init(&PA_SO, 0, 0);
    sem_init(&PA_IS, 0, 0);
    sem_init(&PA_IA, 0, 0);
    sem_init(&PA_AA, 0, 0);
<<<<<<< HEAD
    sem_init(&SI_CS, 0, 0);
=======
>>>>>>> 71208c0448bbdc608f01e71327a43e0a120cc7e7

    // Declaración de threads
    pthread_t TM1, TIP, TF1, TM2, TED, TPA, TBD, TF2, TAA, TIA, TIS, TRC, TCG, TSO, TSI, TBigD, TSD, TDW, TRO, TCS;
    pthread_attr_t attr;

    // Inicialización de atributos de threads
    pthread_attr_init(&attr);

    // Creación de threads
    pthread_create(&TM1, &attr, tM1_function, NULL);
    pthread_create(&TIP, &attr, tIP_function, NULL);
    pthread_create(&TF1, &attr, tF1_function, NULL);
    pthread_create(&TM2, &attr, tM2_function, NULL);
    pthread_create(&TED, &attr, tED_function, NULL);
    pthread_create(&TPA, &attr, tPA_function, NULL);
    pthread_create(&TBD, &attr, tBD_function, NULL);
    pthread_create(&TF2, &attr, tF2_function, NULL);
    pthread_create(&TAA, &attr, tAA_function, NULL);
    pthread_create(&TIA, &attr, tIA_function, NULL);
    pthread_create(&TIS, &attr, tIS_function, NULL);
    pthread_create(&TRC, &attr, tRC_function, NULL);
    pthread_create(&TCG, &attr, tCG_function, NULL);
    pthread_create(&TSO, &attr, tSO_function, NULL);
    pthread_create(&TSI, &attr, tSI_function, NULL);
    pthread_create(&TBigD, &attr, tBigD_function, NULL);
    pthread_create(&TSD, &attr, tSD_function, NULL);
    pthread_create(&TDW, &attr, tDW_function, NULL);
    pthread_create(&TRO, &attr, tRO_function, NULL);
    pthread_create(&TCS, &attr, tCS_function, NULL);

    // Esperar a que los threads terminen
    pthread_join(TM1, NULL);
    pthread_join(TIP, NULL);
    pthread_join(TF1, NULL);
    pthread_join(TM2, NULL);
    pthread_join(TED, NULL);
    pthread_join(TPA, NULL);
    pthread_join(TBD, NULL);
    pthread_join(TF2, NULL);
    pthread_join(TAA, NULL);
    pthread_join(TIA, NULL);
    pthread_join(TIS, NULL);
    pthread_join(TRC, NULL);
    pthread_join(TCG, NULL);
    pthread_join(TSO, NULL);
    pthread_join(TSI, NULL);
    pthread_join(TBigD, NULL);
    pthread_join(TSD, NULL);
    pthread_join(TDW, NULL);
    pthread_join(TRO, NULL);
    pthread_join(TCS, NULL);

    return 0;
<<<<<<< HEAD
}
=======
}
>>>>>>> 71208c0448bbdc608f01e71327a43e0a120cc7e7
