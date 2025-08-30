# 4. Gagnagrunnur fyrir Líkamsræktarstöð

## Tilgangur
Tilgangurinn er að skrá meðlimi, aðgang, hóptíma og búnað.

### Meðlimur (Member)
- **MeðlimsNúmer** (*Frumlykill*)
- Nafn
- Kennitala
- Netfang
- Gerð áskriftar (t.d. 'Mánaðaráskrift', 'Árskort')

### Hóptími (GroupClass)
- **TímaNúmer** (*Frumlykill*)
- Heiti (t.d. 'Spinning', 'Jóga', 'Pallatími')
- Kennari
- Dagur og tími
- Salur

### Bókun (Booking)
- **BókunarNúmer** (*Frumlykill*)
- Bókunardagur
- MeðlimsNúmer (*Erlendur lykill*)
- TímaNúmer (*Erlendur lykill*)

### Aðgangur (AccessLog)
- **AðgangsID** (*Frumlykill*)
- Tímastimpill (hvenær meðlimur kom inn/fór út)
- MeðlimsNúmer (*Erlendur lykill*)
