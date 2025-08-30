# 2. Vöruhúsakerfi fyrir Vefverslun

## Tilgangur
Tilgangurinn er að skrá vörur, birgðastöðu, pantanir og viðskiptavini.

### Vara (Product)
- **VöruNúmer** (*Frumlykill*)
- Heiti vöru
- Lýsing
- Verð
- Birgðastaða (fjöldi á lager)

### Viðskiptavinur (Customer)
- **ViðskiptavinarNúmer** (*Frumlykill*)
- Nafn
- Netfang
- Heimilisfang

### Pöntun (Order)
- **PöntunarNúmer** (*Frumlykill*)
- Pöntunardagur
- Heildarupphæð
- Staða pöntunar (t.d. 'Í bið', 'Send', 'Afhent')
- ViðskiptavinarNúmer (*Erlendur lykill*)

### Birgi (Supplier)
- **BirgjaNúmer** (*Frumlykill*)
- Nafn fyrirtækis
- Tengiliður (nafn, sími, netfang)

### Pöntunarlína (OrderLine)
*(Tengir Pöntun og Vöru)*
- **PöntunarNúmer** (*Hluti af frumlykli, erlendur lykill*)
- **VöruNúmer** (*Hluti af frumlykli, erlendur lykill*)
- Fjöldi
- Verð á einingu
