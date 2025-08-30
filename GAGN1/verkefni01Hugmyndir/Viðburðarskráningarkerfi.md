# 3. Viðburðaskráningarkerfi

## Tilgangur
Tilgangurinn er að halda utan um viðburði, þátttakendur og miðasölu.

### Viðburður (Event)
- **ViðburðarNúmer** (*Frumlykill*)
- Heiti viðburðar
- Dagsetning og tími
- Staðsetning
- Lýsing
- Miðaverð

### Þátttakandi (Participant)
- **ÞátttakandaNúmer** (*Frumlykill*)
- Nafn
- Netfang
- Símanúmer

### Miði/Skráning (Ticket/Registration)
- **MiðaNúmer** (*Frumlykill*)
- Skráningardagur
- Staða greiðslu
- Sætisnúmer (*ef við á*)
- ViðburðarNúmer (*Erlendur lykill*)
- ÞátttakandaNúmer (*Erlendur lykill*)
