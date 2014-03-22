//Vim replace for gradients: :%s/\([0-9]\)\-[0-9]*/\1/

var lookup = {};
lookup.attenuation = {
	100: {	dB: 1.381,	adsl1: 8000,	adsl2: 24000,	adsl1max: 8000,	adsl2max: 24000},
	500: {	dB: 6.905,	adsl1: 8000,	adsl2: 24000,	adsl1max: 8000,	adsl2max: 24000},
	900: {	dB: 12.429,	adsl1: 8000,	adsl2: 23000,	adsl1max: 8000,	adsl2max: 24000},
	1300: {	dB: 17.953,	adsl1: 8000,	adsl2: 21000,	adsl1max: 8000,	adsl2max: 24000},
	1700: {	dB: 23.477,	adsl1: 8000,	adsl2: 19000,	adsl1max: 8000,	adsl2max: 24000},
	2100: {	dB: 29.001,	adsl1: 8000,	adsl2: 16000,	adsl1max: 8000,	adsl2max: 24000},
	2500: {	dB: 34.525,	adsl1: 7600,	adsl2: 12000,	adsl1max: 8000,	adsl2max: 24000},
	2900: {	dB: 40.049,	adsl1: 7000,	adsl2: 9000,	adsl1max: 8000,	adsl2max: 24000},
	3300: {	dB: 45.573,	adsl1: 5900,	adsl2: 7000,	adsl1max: 8000,	adsl2max: 24000},
	3700: {	dB: 51.097,	adsl1: 4600,	adsl2: 4700,	adsl1max: 8000,	adsl2max: 24000},
	4100: {	dB: 56.621,	adsl1: 3300,	adsl2: 3600,	adsl1max: 8000,	adsl2max: 24000},
	4500: {	dB: 62.145,	adsl1: 2100,	adsl2: 2100,	adsl1max: 8000,	adsl2max: 24000},
	4900: {	dB: 67.669,	adsl1: 1200,	adsl2: 1600,	adsl1max: 8000,	adsl2max: 24000}
};
lookup.gradientAdsl1 = {
	900: { gradient: 0,	yIntercept: 8000,	trueA: undefined,	trueB: undefined },
	1300: { gradient: 0,	yIntercept: 8000,	trueA: undefined,	trueB: undefined },
	1700: { gradient: 0,	yIntercept: 8000,	trueA: undefined,	trueB: undefined },
	2100: { gradient: -72.4112961622,	yIntercept: 10100,	trueA: 0,	trueB: 1 },
	2500: { gradient: -108.6169442433,	yIntercept: 11350,	trueA: 0,	trueB: 1 },
	2900: { gradient: -199.1310644461,	yIntercept: 14975,	trueA: 0,	trueB: 1 },
	3300: { gradient: -235.3367125272,	yIntercept: 16625,	trueA: 0,	trueB: 1 },
	3700: { gradient: -235.3367125272,	yIntercept: 16625,	trueA: 0,	trueB: 1 },
	4100: { gradient: -217.2338884866,	yIntercept: 15600,	trueA: 0,	trueB: 1 },
	4500: { gradient: -162.925416365,	yIntercept: 12225,	trueA: 0,	trueB: 1 }
};
lookup.gradientAdsl2 = {
	900: { gradient: -362.056480811,	yIntercept: 27500,	trueA: 0,	trueB: 1 },
	1300: { gradient: -362.056480811,	yIntercept: 27500,	trueA: 0,	trueB: 1 },
	1700: { gradient: -543.0847212165,	yIntercept: 31750,	trueA: 0,	trueB: 1 },
	2100: { gradient: -724.112961622,	yIntercept: 37000,	trueA: 0,	trueB: 1 },
	2500: { gradient: -543.0847212165,	yIntercept: 30750,	trueA: 0,	trueB: 1 },
	2900: { gradient: -362.056480811,	yIntercept: 23500,	trueA: 0,	trueB: 1 },
	3300: { gradient: -416.3649529327,	yIntercept: 25975,	trueA: 0,	trueB: 1 },
	3700: { gradient: -199.1310644461,	yIntercept: 14875,	trueA: 0,	trueB: 1 },
	4100: { gradient: -271.5423606083,	yIntercept: 18975,	trueA: 0,	trueB: 1 },
	4500: { gradient: -90.5141202028,	yIntercept: 7725,	trueA: 0,	trueB: 1 }
};

module.exports = lookup;
