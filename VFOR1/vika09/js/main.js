// ===================================================================
// Sýnidæmi fyrir Viku 9: Inngangur að JavaScript
// ===================================================================

// 1. Að nota þróunartólin (Developer Console)
// console.log() er okkar helsta tól til að sjá hvað er að gerast í kóðanum.
// Það prentar skilaboð í Console flipann í þróunartólum vafrans. [cite: 2118, 2633]
console.log('Halló, heimur! Skriftan er tengd og virkar.');

// 2. Athugasemdir (Comments)
// Þetta er einnar línu athugasemd. Hún er hunsuð af vafranum. [cite: 2136, 2651]

/*
  Þetta er fjöllínu athugasemd.
  Hún er gagnleg fyrir lengri útskýringar. [cite: 2137, 2652]
*/

// 3. Breytur: let og const (Variables)
// Við notum breytur til að geyma gögn. [cite: 2147, 2662]

// 'const' er fyrir gildi sem breytast EKKI. Þetta er best practice að nota sjálfgefið. [cite: 2163, 2678]
const FORNAFN = "Jón";
const FAEAINGARAR = 1995;

// 'let' er fyrir gildi sem GÆTU breyst seinna. [cite: 2152, 2667]
let aldur = 2025 - FAEAINGARAR;
let erNemandi = true;

// Við getum prentað breytur í console til að sjá gildið þeirra.
console.log('Nafn:', FORNAFN);
console.log('Aldur:', aldur);

// 4. Helstu Gagnatýpur (Data Types)
// JavaScript er "dynamically typed", sem þýðir að við þurfum ekki að skilgreina týpuna. [cite: 2174, 2689]

// Strengur (String): Texti innan gæsalappa. [cite: 2177, 2692]
const borg = "Reykjavík";
console.log('Gagnatýpa fyrir "borg":', typeof borg);

// Tala (Number): Bæði heiltölur og kommutölur. [cite: 2182, 2697]
const einkunn = 8.5;
console.log('Gagnatýpa fyrir "einkunn":', typeof einkunn);

// Búlean (Boolean): true eða false. Gott fyrir ákvarðanir. [cite: 2185, 2700]
const hefurLokidVerkefni = false;
console.log('Gagnatýpa fyrir "hefurLokidVerkefni":', typeof hefurLokidVerkefni);

// Undefined: Breyta hefur verið skilgreind en hefur ekkert gildi ennþá. [cite: 2191, 2706]
let bilnumer;
console.log('Gagnatýpa fyrir "bilnumer":', typeof bilnumer);
console.log('Gildi fyrir "bilnumer":', bilnumer);

// Null: Yfirlýst fjarvera gildis. Við segjum "hér er ekkert gildi, viljandi". [cite: 2188, 2703]
let uppahaldsLitur = null;
console.log('Gagnatýpa fyrir "uppahaldsLitur":', typeof uppahaldsLitur); // Athugið: 'typeof null' er "object", þekkt sérviska í JS.
console.log('Gildi fyrir "uppahaldsLitur":', uppahaldsLitur);

// SAMANTEKT
console.log('--- Samantekt ---');
console.log(FORNAFN + ' er ' + aldur + ' ára gamall og býr í ' + borg + '.');