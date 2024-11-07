package com.dio.apicidadesbrasil.service;

import com.dio.apicidadesbrasil.model.Cidade;
import com.dio.apicidadesbrasil.repository.CidadeRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CidadeService {

    private final CidadeRepository cidadeRepository;

    public CidadeService(CidadeRepository cidadeRepository) {
        this.cidadeRepository = cidadeRepository;
    }

    public List<Cidade> listarCidades() {
        return cidadeRepository.findAll();
    }

    public double calcularDistancia(long id1, long id2) {
        Cidade cidade1 = cidadeRepository.findById(id1)
                .orElseThrow(() -> new IllegalArgumentException("Cidade com ID " + id1 + " não encontrada."));
        Cidade cidade2 = cidadeRepository.findById(id2)
                .orElseThrow(() -> new IllegalArgumentException("Cidade com ID " + id2 + " não encontrada."));

        double lat1 = Math.toRadians(cidade1.getLatitude());
        double lon1 = Math.toRadians(cidade1.getLongitude());
        double lat2 = Math.toRadians(cidade2.getLatitude());
        double lon2 = Math.toRadians(cidade2.getLongitude());

        double earthRadius = 6371.01; // Raio da Terra em quilômetros

        return earthRadius * Math.acos(Math.sin(lat1) * Math.sin(lat2)
                + Math.cos(lat1) * Math.cos(lat2) * Math.cos(lon1 - lon2));
    }
}
