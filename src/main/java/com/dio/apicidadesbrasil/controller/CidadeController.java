package com.dio.apicidadesbrasil.controller;

import com.dio.apicidadesbrasil.model.Cidade;
import com.dio.apicidadesbrasil.service.CidadeService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/cidades")
public class CidadeController {

    private final CidadeService cidadeService;

    public CidadeController(CidadeService cidadeService) {
        this.cidadeService = cidadeService;
    }

    @GetMapping
    public List<Cidade> listarCidades() {
        return cidadeService.listarCidades();
    }

    @GetMapping("/distancia")
    public double calcularDistancia(@RequestParam long id1, @RequestParam long id2) {
        return cidadeService.calcularDistancia(id1, id2);
    }
}
