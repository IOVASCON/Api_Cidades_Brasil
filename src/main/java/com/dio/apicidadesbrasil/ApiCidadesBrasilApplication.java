package com.dio.apicidadesbrasil;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * Classe principal da aplicação API Cidades Brasil.
 * Esta aplicação fornece uma API REST para consulta e cálculo de distância
 * entre cidades brasileiras.
 */
@SpringBootApplication
public class ApiCidadesBrasilApplication {

    /**
     * Método principal para iniciar a aplicação Spring Boot.
     *
     * @param args argumentos de linha de comando (não utilizados)
     */
    public static void main(String[] args) {
        SpringApplication.run(ApiCidadesBrasilApplication.class, args);
    }
}
