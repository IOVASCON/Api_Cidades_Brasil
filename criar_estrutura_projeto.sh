#!/bin/bash

# Caminho do diretório do projeto
PROJETO_PATH="L:/VSCode/JAVA/DIO/API_Cidades_Brasil"

# Criação da estrutura de diretórios
mkdir -p $PROJETO_PATH/src/main/java/com/dio/apicidadesbrasil/controller
mkdir -p $PROJETO_PATH/src/main/java/com/dio/apicidadesbrasil/model
mkdir -p $PROJETO_PATH/src/main/java/com/dio/apicidadesbrasil/repository
mkdir -p $PROJETO_PATH/src/main/java/com/dio/apicidadesbrasil/service
mkdir -p $PROJETO_PATH/src/main/resources
mkdir -p $PROJETO_PATH/src/test/java/com/dio/apicidadesbrasil
mkdir -p $PROJETO_PATH/src/main/resources/images

# Criação dos arquivos com conteúdo básico
echo "package com.dio.apicidadesbrasil;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class ApiCidadesBrasilApplication {

    public static void main(String[] args) {
        SpringApplication.run(ApiCidadesBrasilApplication.class, args);
    }
}" > $PROJETO_PATH/src/main/java/com/dio/apicidadesbrasil/ApiCidadesBrasilApplication.java

echo "package com.dio.apicidadesbrasil.controller;

import com.dio.apicidadesbrasil.model.Cidade;
import com.dio.apicidadesbrasil.service.CidadeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping(\"/cidades\")
public class CidadeController {

    @Autowired
    private CidadeService cidadeService;

    @GetMapping
    public List<Cidade> listarCidades() {
        return cidadeService.listarCidades();
    }

    @GetMapping(\"/distancia\")
    public double calcularDistancia(@RequestParam long id1, @RequestParam long id2) {
        return cidadeService.calcularDistancia(id1, id2);
    }
}" > $PROJETO_PATH/src/main/java/com/dio/apicidadesbrasil/controller/CidadeController.java

echo "package com.dio.apicidadesbrasil.model;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class Cidade {

    @Id
    private long id;
    private String nome;
    private double latitude;
    private double longitude;

    // Getters and setters
}" > $PROJETO_PATH/src/main/java/com/dio/apicidadesbrasil/model/Cidade.java

echo "package com.dio.apicidadesbrasil.repository;

import com.dio.apicidadesbrasil.model.Cidade;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CidadeRepository extends JpaRepository<Cidade, Long> {
}" > $PROJETO_PATH/src/main/java/com/dio/apicidadesbrasil/repository/CidadeRepository.java

echo "package com.dio.apicidadesbrasil.service;

import com.dio.apicidadesbrasil.model.Cidade;
import com.dio.apicidadesbrasil.repository.CidadeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CidadeService {

    @Autowired
    private CidadeRepository cidadeRepository;

    public List<Cidade> listarCidades() {
        return cidadeRepository.findAll();
    }

    public double calcularDistancia(long id1, long id2) {
        Cidade cidade1 = cidadeRepository.findById(id1).orElseThrow();
        Cidade cidade2 = cidadeRepository.findById(id2).orElseThrow();

        double lat1 = Math.toRadians(cidade1.getLatitude());
        double lon1 = Math.toRadians(cidade1.getLongitude());
        double lat2 = Math.toRadians(cidade2.getLatitude());
        double lon2 = Math.toRadians(cidade2.getLongitude());

        double earthRadius = 6371.01; // Earth's radius in kilometers
        return earthRadius * Math.acos(Math.sin(lat1) * Math.sin(lat2)
                + Math.cos(lat1) * Math.cos(lat2) * Math.cos(lon1 - lon2));
    }
}" > $PROJETO_PATH/src/main/java/com/dio/apicidadesbrasil/service/CidadeService.java

echo "spring.datasource.url=jdbc:postgresql://localhost:5432/cidades
spring.datasource.username=seu-usuario
spring.datasource.password=sua-senha
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true" > $PROJETO_PATH/src/main/resources/application.properties

echo "INSERT INTO cidade (id, nome, latitude, longitude) VALUES (1, 'São Paulo', -23.5505, -46.6333);
INSERT INTO cidade (id, nome, latitude, longitude) VALUES (2, 'Rio de Janeiro', -22.9068, -43.1729);" > $PROJETO_PATH/src/main/resources/data.sql

echo "<project xmlns=\"http://maven.apache.org/POM/4.0.0\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"
    xsi:schemaLocation=\"http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd\">
    <modelVersion>4.0.0</modelVersion>
    <groupId>com.dio</groupId>
    <artifactId>api-cidades-brasil</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <packaging>jar</packaging>

    <name>api-cidades-brasil</name>
    <description>API Rest de consulta de cidades do Brasil</description>

    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>2.5.4</version>
        <relativePath /> <!-- lookup parent from repository -->
    </parent>

    <properties>
        <java.version>11</java.version>
    </properties>

    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-jpa</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.postgresql</groupId>
            <artifactId>postgresql</artifactId>
            <version>42.2.23</version>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>
</project>" > $PROJETO_PATH/pom.xml

echo "package com.dio.apicidadesbrasil;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class ApiCidadesBrasilApplicationTests {

    @Test
    void contextLoads() {
    }
}" > $PROJETO_PATH/src/test/java/com/dio/apicidadesbrasil/ApiCidadesBrasilApplicationTests.java

echo "Estrutura de projeto criada com sucesso em $PROJETO_PATH"
