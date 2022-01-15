
set more off

/* ASSEMBLE NASSGAP 2010 through 2013 AID Data */

cd "/Users/Charlie/Google Drive/Lincoln Project/State-Based Financial Aid/Code/Sheisha defaultcorraid"
/* Process the NASSGAP information */
import delimited "Primary program20170905.csv", clear
drop v5
duplicates drop statename surveyyear, force
save primaryprogram.dta, replace

import delimited "Third try - public 4 year20170905.csv", clear

import delimited "/Users/Charlie/Downloads/MyMostRecentQuery20190531.csv", clear

merge m:1 statename surveyyear using primaryprogram.dta
drop if statename==""
*br if programname==primaryneedbasedprogram

rename surveyyear year
gen public_4yr_amt=0
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if programname==primaryneedbasedprogram

/* Some states suck */
/* Arizona */
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if (programname=="(AFAT) Arizona Financial Aid Trust") & statename=="Arizona"
/* Connecticut */
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if regexm(programname,"Governorâs Scholarship Program")==1 & regexm(programname,"Need")>0 & statename=="Connecticut"
/* Delaware */
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if regexm(programname,"University of Delaware")>0 & ///
	regexm(definitionofneed,"Need")>0 & statename=="Delaware"
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if programname=="Delaware State University Aid to Needy Students" & statename=="Delaware"
/* California */
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if (programname=="Cal Grant A"|programname=="Cal Grant B"|programname=="Cal Grant C") & statename=="California" & year>2004
/* Florida */
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if regexm(programname,"Florida Student Assistance Grant")==1 & statename=="Florida" & year>2004
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if programname=="First Generation Matching Grant" & statename=="Florida"
/* Hawaii */
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if regexm(programname,"Hawaii B Plus")>0 & statename=="Hawaii"
/* Idaho */
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if programname=="ID Leveraging Educational Assistance Partnership" & year==2006 & statename=="Idaho"
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if programname=="Minority and 'At Risk' Scholarship" & statename=="Idaho"
/* Ilinois */
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if regexm(programname,"(HELP)")>0 & statename=="Illinois"
/* Indiana */
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if regexm(programname,"Indiana Higher Education Award")>0 & statename=="Indiana"
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if regexm(programname,"Twenty-First Century Scholars")>0 & statename=="Indiana"
/* Iowa */
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if programname=="All Iowa Opportunity Scholarship" & statename=="Iowa"
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if programname=="Iowa Grant" & statename=="Iowa"
/* Kansas */	
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if programname=="Kansas Ethnic Minority Scholarship" & statename=="Kansas"
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if programname=="Kansas State Scholarship" & statename=="Kansas"
/* Kentucky */
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if programname=="Go Higher Grant " & statename=="Kentucky"
/* Maryland */
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if programname=="Senatorial Scholarship" & statename=="Maryland"
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if programname=="Delegate Scholarship" & statename=="Maryland"
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if regexm(programname,"Howard P. Rawlings")==1 & statename=="Maryland"
/* Massachusetts */
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if regexm(programname, "Access Grant")>0 & statename=="Massachusetts"
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if programname=="Completion Incentive Grant Fund" & statename=="Massachusetts"
/* Michigan - FUBARED */
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if programname=="Tuition Incentive Program" & statename=="Michigan"
/* Mississippi */
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if regexm(programname,"Resident Tuition")>0 & statename=="Mississippi"
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if regexm(programname,"Legislative Plan")>0 & statename=="Mississippi"
/* Missouri */
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if regexm(programname,"Access Missouri")==1 & statename=="Missouri"
/* Montana */
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if programname=="Governor's Postsecondary Scholarship - Need"  ///
	& statename=="Montana"
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if programname=="Montana Higher Education Grant" & statename=="Montana"
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if programname=="State SEOG Match" & statename=="Montana"
/* Nebraska */
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if programname=="Access College Early" ///
	& statename=="Nebraska"
/* Nevada */
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if programname=="Nevada Student Access Grants/Scholarships" ///
	& statename=="Nevada"
/* New Jersey */
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if regexm(programname,"Educational Opportunity Fund")==1 & statename=="New Jersey"
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if regexm(programname,"Governors Urban Scholars")==1 & statename=="New Jersey"	
/* New Mexico */
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if programname=="3% Scholarships" & statename=="New Mexico"
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if programname=="NM Scholars" & statename=="New Mexico"
/* New York */
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if programname=="NYS Aid for Part-Time Study" & statename=="New York"
/* North Carolina */
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if (programname=="Appropriated Grants"| ///
	programname=="North Carolina Education Lottery Scholarship"| ///
	programname=="UNC Need Based Grant"| ///
	programname=="UNC Campus Scholarships")  ///
	& statename=="North Carolina"

/* North Dakota */
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if programname=="North Dakota State Student Incentive Grant Program"  ///
	& statename=="North Dakota"
/* Oklahoma */
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if programname=="Oklahoma's Promise - OHLAP"  ///
	& statename=="Oklahoma"
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if programname=="William P. Willis Scholarship"  ///
	& statename=="Oklahoma"
/* Pennsylvania */
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if regexm(programname,"(PATH)")>0 ///
	& statename=="Pennsylvania"
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if regexm(programname,"State Grant")>0  ///
	& statename=="Pennsylvania"

/* Tennessee */
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if programname=="ASPIRE supplement to the HOPE Scholarship"  ///
	& statename=="Tennessee"
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if programname=="HOPE Access Grant"  ///
	& statename=="Tennessee"
/* Texas */
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if programname=="Designated Tuition- Grants"  ///
	& statename=="Texas"
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if programname=="Student Deposit Scholarships"  ///
	& statename=="Texas"
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if programname=="Texas Public Education Grant"  ///
	& statename=="Texas"
/* Utah */
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if regexm(programname,"(HESSP)")>0 & statename=="Utah"
/* Vermont */
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if regexm(programname,"Emily Lester")>0 & statename=="Vermont" 
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if programname=="Vermont Endowment Scholarship"  ///
	& statename=="Vermont"
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if programname=="VT Part-Time Grant"  ///
	& statename=="Vermont"
/* Virginia */
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if regexm(programname,"VSFAP")==1 & statename=="Virginia"
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if regexm(programname,"College Transfer Grant")>0 & statename=="Virginia"
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if regexm(programname,"GEARUP")==1 & statename=="Virginia"
/* Washington */
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if regexm(programname,"College Bound")==1 & statename=="Washington"
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if regexm(programname,"Passport to College")==1 & statename=="Washington"
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if regexm(programname,"Washington State Opportunity")==1 & statename=="Washington"
/* West Virginia */
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if programname=="West Virginia Higher Education Grant Program"  ///
	& statename=="West Virginia"
/* Wisconsin */
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if regexm(programname,"Wisconsin Higher Education Grant")==1 ///
	& year<2015 & statename=="Wisconsin"
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if regexm(programname,"Wisconsin Grant")==1 ///
	& year==2015 & statename=="Wisconsin"
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if regexm(programname,"Wisconsin Covenant")==1 ///
	 & statename=="Wisconsin"
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if regexm(programname,"Foundation Grant")==1 ///
	 & statename=="Wisconsin"
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if regexm(programname,"Talent Incentive Program")==1 ///
	& statename=="Wisconsin"
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if regexm(programname,"Indian Student Assistance")==1 ///
	& statename=="Wisconsin"
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if regexm(programname,"Hearing & Visually")==1 ///
	& statename=="Wisconsin"	 
/* Wyoming */
replace public_4yr_amt=dollarsawardedto4yearinstatepubl if programname=="Hathaway Scholarship"  ///
	& statename=="Wyoming"	

gen nonneed=dollarsawardedto4yearinstatepubl if public_4yr_amt==0

gen public_4yr_recipients=recipientsin4yearinstatepublicin if public_4yr_amt>0 & public_4yr_amt<.
collapse (sum) public_4yr_recipients nonneed public_4yr_amt (first) primaryneedbasedprogram, by(statename year)

/* Check with Charlie's data and get state abbreviations */
rename public_4yr_amt public_4yr_amt_sheisha
rename statename state
merge m:1 state using public_4yr_state_grant_aid_mod.dta
gen diff=public_4yr_amt-public_4yr_amt_sheisha if year==2014

gen year2008=public_4yr_amt_sheisha if year==2008
gen year2010=public_4yr_amt_sheisha if year==2010
bysort state: egen y2008=max(year2008)
bysort state: egen y2010=max(year2010)
gen perdiff=(y2010-y2008)/y2008

replace stabbr="SC" if state=="SC CHE"
replace stabbr="SD" if state=="South Dakota"
replace stabbr="PA" if state=="Pennsylvania"
replace stabbr="NH" if state=="New Hampshire"
replace stabbr="MS" if state=="Mississippi"
replace stabbr="ME" if state=="Maine"
replace stabbr="GA" if state=="Georgia"
replace stabbr="AR" if state=="Arkansas"
keep nonneed public_4yr_amt_sheisha stabbr year public_4yr_recipients

rename public_4yr_amt_sheisha public_4yr_amt
*keep if year>2009
*keep if year<2016
duplicates tag stabbr year, gen(dups)

drop if stabbr==""

save nassgap4year2003_2015.dta, replace

use "/Users/Charlie/Google Drive/Lincoln Project/IPEDS Disaggregated/Data/finaid_2000_2017.dta", clear


gen low=npis412

/* get things like the school name etc. */
capture drop _merge
merge m:1 unitid using "/Users/Charlie/Google Drive/Lincoln Project/State-Based Financial Aid/Code/Sheisha defaultcorraid/hd2008.dta", keep(1 3)

/* drop US service schools */
drop if obereg==0
/* drop outlying areas */
drop if obereg==9
/* drop if area not known */
drop if obereg==-3
/* get tuition */
capture drop _merge
destring ein, replace force
merge 1:1 unitid year using "/Users/Charlie/Google Drive/Lincoln Project/IPEDS Disaggregated/Data/ipeds_sticker_1987to2016_20180802.dta", ///
keepusing(tuition2 fee2) keep(1 3) nogen

merge 1:1 unitid year using "/Users/Charlie/Google Drive/Lincoln Project/IPEDS Disaggregated/Data/IPEDS_Ownership_Outcomes_1981_2016_2018_08_15.dta", ///
keepusing(all_under fte_count nettuition01 state_local_app) keep(1 3) nogen

*Data is only available for public schools
keep if control==1 & iclevel==1

/* HGroup classifications */
merge m:1 unitid using "/Users/Charlie/Google Drive/Lincoln Project/State-Based Financial Aid/Code/Sheisha defaultcorraid/HB_classifications_2014_8_26.dta", keep(1 3) nogen
*drop if hgroup==.

/* Make the variables you need */
merge 1:1 unitid year using "/Users/Charlie/Dropbox/Bankers in the Ivory Tower Book/2 Our New Financial Oligarchy/Data/Boards 2000 to 2017/nonmissing_sat_act_admissions_all_universities_20181223.dta", keep(1 3) nogen

**CALCULATE WEIGHTED MEAN INSTATE RATE BY RESEARCH CATEGORY**
gen instatetuition=tuition2+fee2
gen winstate_under= instatetuition * all_under
bysort stabbr hgroup year: egen statehg_under=total(all_under) 
bysort stabbr hgroup year: egen winstate_under_hgtotal=total(winstate_under)
gen winstate_wtmn=winstate_under_hgtotal / statehg_under
gen winstate_unweighted=instatetuition
replace instatetuition=winstate_wtmn

bysort stabbr year: egen state_under=total(all_under)
bysort stabbr year: egen winstate_under_total=total(winstate_under)
gen st_instate_wt_mn=winstate_under_total / state_under

**CALCULATE WEIGHTED MEAN LOW INCOME NET PRICE BY RESEARCH CATEGORY**
gen low_pell=low * upgrntn
bysort stabbr hgroup year: egen state_pell=total(upgrntn)
bysort stabbr hgroup year: egen low_pell_total=total(low_pell)
gen low_wtmn=low_pell_total / state_pell
gen low_unweighted=low

merge m:1 year using "/Users/Charlie/Google Drive/Lincoln Project/IPEDS Disaggregated/Data/cpi_scalar_2015.dta"
merge m:1 stabbr year using "/Users/Charlie/Google Drive/Lincoln Project/State-Based Financial Aid/Code/Sheisha defaultcorraid/nassgap4year2003_2015.dta", nogen

bysort stabbr year: egen state_total_pell=total(upgrntn)

gen spend_ugd_4yr_low=public_4yr_amt/state_total_pell
gen spend_ugdtuit_low=100*(spend_ugd_4yr_low/st_instate_wt_mn)

**Do inflation adjustment

replace public_4yr_amt=0 if public_4yr_amt==.
drop if stabbr=="DC"

drop opeid

merge m:1 unitid year using "/Users/Charlie/Dropbox/Private Equity ForProfit Colleges/Data/College Scorecard/CollegeScorecard_Raw_Data/scorecardfull.dta" ///
, nogen keepusing(lo_inc_debt_mdn md_inc_debt_mdn lo_inc_rpy_3yr_n md_inc_rpy_3yr_n opeid highdeg control)

replace year=year+3
merge m:1 unitid year using "/Users/Charlie/Dropbox/Private Equity ForProfit Colleges/Data/College Scorecard/CollegeScorecard_Raw_Data/scorecardfull.dta" ///
, nogen keepusing(lo_inc_rpy_3yr_rt_supp md_inc_rpy_3yr_rt_supp opeid highdeg control) update

replace year=year-3
replace opeid="0"+opeid if strlen(opeid)==6
replace opeid="0"+opeid if strlen(opeid)==7
gen nettuition01_fte= nettuition01  / fte_count
gen state_local_app_fte = state_local_app / fte_count

foreach var in nettuition01_fte state_local_app_fte nonneed public_4yr_amt lo_inc_debt_mdn md_inc_debt_mdn igrnt_t fgrnt_t sgrnt_t instatetuition st_instate_wt_mn winstate_wtmn low {
replace `var'= `var' / cpi_scalar_2015
}

drop if year<2000
keep if control==1
replace hgroup=9 if hgroup==.
gen pell_exp=upgrntt

gen totallincome=gis4n2
gen totallincomerecgrt=gis4g2
gen total030=gis4n12
gen total030recgrt=gis4g12
gen total4875=gis4n32
gen total3048=gis4n22
gen total048=total030+total3048
gen per_lowinc=100*(upgrntn/scugrad)
gen igrnt_low_inc= igrnt_t / fgrnt_n
gen sgrnt_low_inc= sgrnt_t / fgrnt_n
gen uagrnt_low_inc= uagrntt / upgrntn
gen fgrnt_low_inc= fgrnt_t / fgrnt_n
egen sandigrntt=rowtotal(igrnt_t sgrnt_t)
gen sandigrnt_low_inc=sandigrntt / fgrnt_n

merge m:1 stabbr using "/Users/Charlie/Google Drive/Lincoln Project/IPEDS Disaggregated/Data/stateabbreviations.dta", keep(1 3) nogen
merge m:1 stabbr using "/Users/Charlie/Google Drive/Lincoln Project/State-Based Financial Aid/Code/Sheisha defaultcorraid/public_4yr_state_grant_aid_mod.dta", keepusing(public_4yr_recipients) nogen
drop if year>2015

save "/Users/Charlie/Google Drive/Lincoln Project/State-Based Financial Aid/Code/Replication/affording_master_2000_2015_20190606", replace
