# 1. Bókasafnskerfi

## Tilgangur
Tilgangurinn er að halda utan um bækur, höfunda, útlán og meðlimi.

### Bók (Book)
- **ISBN** (*Frumlykill*)
- Titill
- Útgáfuár
- Bókaflokkur (t.d. Sakamálasaga, Fræðirit)

### Höfundur (Author)
- **HöfundarNafn** (*Frumlykill*)
- Fæðingarár
- Þjóðerni

### Eintak (BookCopy)
- **EintaksNúmer** (*Frumlykill, einstakt fyrir hvern fizískan hlut*)
- Staða (t.d. 'Í boði', 'Í útláni', 'Í viðgerð')
- ISBN (*Erlendur lykill sem vísar í Bók*)

### Meðlimur (Member)
- **MeðlimsNúmer** (*Frumlykill*)
- Nafn
- Heimilisfang
- Netfang

### Útlán (Loan)
- **ÚtlánsNúmer** (*Frumlykill*)
- Útlánsdagur
- Skiladagur
- RaunverulegurSkiladagur
- EintaksNúmer (*Erlendur lykill*)
- MeðlimsNúmer (*Erlendur lykill*)
