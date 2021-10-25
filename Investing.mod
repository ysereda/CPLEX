// --------------------------------------------------------------------------
// A company has $50 million available for investment over the next 4 months.
// There are four possible investment options available.
// The objective of the company is to maximize the total cash available at the end of the fourth month.
//	Type				Maturity	Return			Availability
// Government Bonds		2 months	2% over the		Every month
//									2-month period
//	Treasury Bills		3 months	4% over the		Every month
//									3-month period
//	Certif. of Deposit	2 months	4% over the		Every month
//									2-month period
//	Security Deposit	2 months	3% over the		Only in Month 2
//									3-month period
// In order to minimize risk, the company requires at least 30% of the total investments to be in security deposit.
// Formulate a linear program that will help the company determine how to invest over the next four months.
// --------------------------------------------------------------------------
// C - Cash Ready to be Invested
// G - Government Bonds
// T - Treasure Bills
// CD - Certificate of Deposit
// S - Security Deposit
// G1 - how much to invest into Government Bonds for month 1 (at time 0)
// --------------------------------------------------------------------------

dvar float+ C1;	// cash by the end of month 1
dvar float+ C2;	// cash by the end of month 2
dvar float+ C3;	// cash by the end of month 3
dvar float+ C4;		// objective: cash available after 4 months
dvar float+ C0;		// initial cash available for investment
dvar float+ G0;		// investment in Government Bonds at t=0
dvar float+ T0;		// investment in Treasure Bills at t=0
dvar float+ CD0;	// investment in Certificate of Deposit at t=0
dvar float+ G1;		// investment in Government Bonds at t=1
dvar float+ S1;		// investment in Security Deposit at t=1
dvar float+ CD1;	// investment in Certificate of Deposit at t=1
dvar float+ T1;		// investment in Treasure Bills at t=1
dvar float+ G2;		// investment in Government Bonds at t=2
dvar float+ CD2;	// investment in Certificate of Deposit at t=2


maximize
  C4;
   
subject to {
  ctCash0: 
    C0 <= 50;
    CD0 >= 0; CD1 >= 0; CD2 >= 0; T0 >= 0; T1 >= 0;
    CD0 >= 0.3*(G0 + T0 + CD0);	// at least 30% is in CD at time 0
    CD0 + CD1 >= 0.3*(G0 + T0 + CD0 + G1 + T1 + CD1 + S1);	// at least 30% is in CD at time 1
    CD1 + CD2 >= 0.3*(T0 + G1 + T1 + CD1 + S1 + G2 + CD2);	// at least 30% is in CD at time 2
    CD2 >= 0.3*(G2 + T1 + CD2);	// at least 30% is in CD at time 3
  ctCash0i:
  	C0 - G0 - T0 - CD0 >= 0;	// max. cash restriction at time 0
  ctCash1:
  	C1 == C0 - G0 - T0 - CD0;	// cash by the end of month 1
  ctCash1i:
  	C1 - G1 - S1 - CD1 - T1 >= 0;	// max. cash restriction after 1 month
  ctCash2:
  	C2 == C1 - G1 - S1 - CD1 - T1 + G0*1.02 + CD0*1.04;	// cash by the end of month 2
  ctChas2i:
  	C2 - G2 - CD2 >= 0;	// max. cash restriction after 2 months
  ctCash3:	
  	C3 == C2 - G2 - CD2 + G1*1.02 + T0*1.04 + CD1*1.04 + S1*1.03;	// cash by the end of month 3
  ctCash3i:
  	C3 >= 0;	// max. cash restriction after 3 months
  ctCash4:
  	C4 == C3 + G2*1.02 + T1*1.04 + CD2*1.04;	// cash by the end of month 4	
}
