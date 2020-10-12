/***************************************************************************
*** FINAL RESULTS ***

MSPH Thesis (EPH 699)
FAST-C Project						 
Aneesh Chandramouli 
Last Updated: 07/15/2020
						  
Table of Contents:
*********************

1) Data Importing, Labelling, and Formatting
2) Regression Analysis:  
	a) Binary, Multinomial, & Ordinal Logistic Models
	b) Multiple Linear Regression
3) Final Tables 
4) Graphs 
						  						  
****************************************************************************/
 
/* DATA IMPORTING, LABELLING, AND FORMATTING  */

libname ac '/folders/myfolders/msph thesis';  
 
proc import datafile='/folders/myfolders/msph thesis/fastc_compliance_final.xlsx' dbms=xlsx out=ac.fastc replace; getnames=yes; run;

proc format; 
value hp_typef 1='Physician/Medical Doctor/Osteopathic Physician' 2='Nurse practitioner/Physician assistant' 3='Other healthcare professional' 4='Other' 5='Nurse Practitioner and Life Scan' 6='Life Scan';
value hp_servicef 1='HCF (paid contract)' 2='HCP (paid contract)' 3='HCF (volunteer basis)' 4='HCP (volunteer basis)' 5='Others' 6='Life Scan' 7='City Clinic' 8='Medical director in charge of annual screening initiative' 
9='HCF and HCP (both paid contracts)' 10='HCF (volunteer) and HCP (paid contract)'; 
value payf 1='The fire department' 2='The firefigher union' 3='The union and fire department combination' 4='Private health insurance' 5='Others' 6='City' 7='County' 8='Municipality' 9='Fire Department and City';
value concernf 1='Not at all concerned' 2='Slightly concerned' 3='Somewhat concerned' 4='Moderately concerned' 5='Extremely concerned';
value makeupf 1='All career' 2='All volunteer/unpaid' 3='Mixed career and volunteer/unpaid' 4='Paid on call';
value genderf 1='Male' 2='Female' 3='Other' 4='I prefer not to say';
value activestatusf 1='Active firefighter' 2='Retired firefighter' 3='Deferred retirement option plan (DROP) firefigher';
value ff_currentf 1='Career (paid) firefighter' 2='Career (unpaid) volunteer firefighter' 3='Other' 4='Retired';
value assignmentf 1='Chief (in charge of dept)' 2='Deputy Chief' 3='Assistant Chief' 4='Battalion, Division, or District Chief'
5='Lieutenant' 6='Captain' 7='Special Operations Captain' 8='EMS Captain' 9='Administrative' 10='Firefighter' 11='Driver Operator' 12='Firefighter Paramedic' 
13='Firefigher EMT' 14='Health & Safety Officer' 15='Fire Investigator' 16='Fire Trainer/Instructor' 17='Wildland/Wildland Urban Interface' 18='Other' 19='Retired';
value discussriskf 1='Never' 2='Every year' 3='Every 2-3 years' 4='Greater than 3 years';
value regiontypef 1='Rural' 2='Urban' 3='Suburban' 4='Mixed';
value dept_sizef 1='Small' 2='Medium' 3='Large';
value comply_ynf 0='No' 1='Yes';
value medical_v2f 0='Never' 1='Every year or longer'; 
value hptype_v2f 0='Life Scan' 1='Physician/Other Healthcare Professional'; 
value hptype_v3f 0='Life Scan' 1='Other Healthcare Professional' 2='Physician/Medical Doctor'; 
value healthed_binaryf 0='Never' 1='Rarely to Frequently';
value physical_binaryf 0='Never' 1='Between Every 1-4 Years';
value occu_rolef 1='Chief' 2='Lieutenant' 3='Captain' 4='Paramedic/Emergency Medical Technician' 5='Health & Safety Officer' 6='Other'; 
value havehp2f 0='No' 1='Yes'; 
value adhere_levelf 0='Low' 1='Medium' 2='High'; 
run;

data ac.compliance; set ac.fastc;
/* labels */
	label gender='Gender';
	label makeup='Workforce makeup';
	label union='Presence of union';
	label county='County';
	label activestatus='Active status';
	label ff_current='Current status';
	label assignment="Current functional assignment";
	label practice_1583='Practice of NFPA 1583 Health & Fitness Standard';
	label fittool='Availability of self-assessment fitness tool in department';
	label fitprog='Availability of physical fitness program in department';
	label gymavail='Availability of gym with exercise equipment in department';
	label fitduty='Time allocated on duty for physical fitness training';
	label printedhe='Distribution of printed health education materials';
	label fitfile='Maintenance of health-related fitness program file per participant';
	label cascr_freq='Frequency of cancer screening services available in the fire department';
	label hfc_count='Number of health & fitness coordinators/safety officers per department';
	label regiontype='Type of region(s) served by department';
	label activeff='Number of active firefighters within department';
	label dept_name='Department Name';
	label dept_size='Department Size';
	label station_count='Number of stations per department';
	label age="Age (years)";
	label years_served="Years Served";
	label hfc='Presence of health & fitness coordinator in department';	
	label havehp2='Presence of assigned health care provider in department';	
	label hp_type='Type of assigned health care provider in department';	
	label hp_other='Other type of health care provider in your department?';	
	label hp_service='Method of obtaining health care provider service';	
	label other_service='Other ways of obtaining health care provider service in your department?';	
	label pay='Method of payment for department health care provider';
	label other_pay='Other ways of paying health care provider in your department?';	
	label inform_physiodemand='Awareness of health care provider of physiological demands on firefighters';	
	label inform_psychdemand='Awarenes of health care provider of psychological demands on firefighters';		
	label inform_workenv='Awareness of health care provider of work environmental conditions of firefighters';		
	label inform_ppe='Awareness of health care provider of required personal protective equipment for firefighters';		
	label practice_1582='Practice of NFPA 1582 Health & Fitness Standard';	
	label practice_1584='Practice of NFPA 1584 Health & Fitness Standard';	
	label practice_dnk='I do not know if any of these nfpa standards are being practiced';	
	label practice_other='Are other NFPA standards besides 1582, 1583, & 1584 being practiced?';	
	label physical='Frequency of required/recommended physical tests';	
	label medical='Frequency of required/recommended medical tests';	
	label healthed='Frequency of workplace health promotion activities';	
	label he_skinca='Distribution of materials on skin cancer during health promotion activites';	
	label he_colca='Distribution of materials on colon cancer during health promotion activites';	
	label he_lungca='Distribution of materials on lung cancer during health promotion activites';	
	label he_thyroidca='Distribution of materials on thyroid cancer during health promotion activites';	
	label he_psa='Distribution of materials on prostate cancer during health promotion activites';	
	label he_breastca='Distribution of materials on breast cancer/mammorgrams during health promotion activites';	
	label he_cervca='Distribution of materials on cervical cancer/pap smears/annual gynec distributed during health promotion activites';	
	label he_alcdrug='Distribution of materials on alcohol and drug abuse during health promotion activites';	
	label he_smkcess='Distribution of materials on smoking cessation programs during health promotion activites';	
	label he_diet='Distribution of materials on diet & nutrition during health promotion activites';	
	label he_infect='Distribution of materials on infectious diseases during health promotion activites';	
	label he_sleep='Distribution of materials on sleep hygiene, stress, and fatigue during health promotion activites';
	label cascr_skin='Provision of full skin examination for employees at workplace'; 
	label cascr_psa='Provision of Prostate Specific Antigen test for employees at workplace'; 
	label cascr_breast='Provision of ultrasound/mammorgram screening for breast cancer for employees at workplace'; 
	label cascr_hpvkit='Provision of HPV test kits for vaginal PV test for employees at workplace'; 
	label cascr_occult='Provision of FOBT/FIT kits for colorectal cancer screening for employees at workplace';
	label cascr_alc='Provision of alcohol/substance abuse treatment for employees at workplace'; 
	label cascr_smkcess='Provision of smoking cessation treatment for employees at workplace';  
	label cascr_diet='Provision of healthy food samples/recipes for employees at workplace'; 
	label cascr_vhep='Provision of Hepatitis B/C vaccines for employees at workplace'; 
	label cascr_vherpes='Provision of Herpes virus vaccines for employees at workplace';
	label cascr_vhpv='Provision of HPV vaccines for employees at workplace';
	label cascr_apnea='Provision of sleep apnea treatment for employees at workplace';
	label occ_risk='Occurrence of annual educational program on evidence of occupational risk'; 
	label occ_lifestyle='Occurrence of annual educational program on lifestyle risk factors for cancer'; 
	label occ_lifestrat='Occurrence of annual educational program on strategies to reduce lifestyle risk factors for cancer';
	label occ_occstrat='Occurrence of annual educational program on strategies to reduce occupational risk factors for cancer';  
	label occ_eviscr='Occurrence of annual educational program on evidence-based medical screening for cancer in department'; 
	label occ_noed='Department does not organize annual education programs on risks of occupational cancer';
	label ref_no='Department does not offer medical referral to employees in need';  
	label ref_sleep='Offering of sleep disorder assessment to employees via medical referral or health care provider';
	label ref_oralca='Offering of oral cancer examination to employees via medical referral or health care provider'; 
	label ref_colca='Offering of colonoscopy to employees via medical referral or health care provider';  
	label ref_thyca='Offering of thyroid cancer screening to employees via medical referral or health care provider'; 
	label ref_bladca='Offering of bladder cancer screening with urine test to employees via medical referral or health care provider';  
	label ref_lungca='Offering of lung cancer screening to employees via medical referral or health care provider';
	label ref_metals='Offering of heavy metals screening to employees via medical referral or health care provider';
	label ref_testes='Offering of male testicular cancer examination to employees via medical referral or health care provider'; 
	label ref_psa='Offering of male prostate cancer examination to employees via medical referral or health care provider'; 
	label ref_pap='Offering of female cervical cancer screening to employees via medical referral or health care provider';
	label ref_mamo='Breast cancer screening offered to employees via medical referral or health care provider';
	label covercostscr='Coverage of out-of-pocket costs for employee cancer screening';
	label ensuretrt='Ensured medical care prescribed by health care provider for firefighters following injury/illness';
	label position='Provision of alternate duty positions for firefighters';
	label concern='Concern of employee medical information confidentiality';
	label cadx='Cancer diagnosis';
	label ca_type='Type of cancer';
	label ca2_type='Type of second cancer';
	label cadx_length="Years since first cancer diagnosis";
	label ca2dx_length="Years since second cancer diagnosis";
	label ca_remission='Cancer remission status';
	label ca2_remission='Second cancer remission status';
	label haveinsurance='Health insurance status';
	label havepdoc='Personal primary health care provider status';
	label pdoc_annual='Annual physical with personal primary health care provider';
	label discussrisk='Discussion with health care provider about cancer risks';	
	label compliance_binary='Adherence to NFPA 1583 Health & Fitness Standard';
	label healthed_binary='Occurrence of workplace health promotion activities';
	label physical_binary='Occurrence of required/recommended physical tests';
	label region='Location of fire department';
	label hptype_v3='Type of health care provider in department';
	label medical_v2='Frequency of required/recommended medical tests';
	label cascr_binary='Occurrence of 1+ type(s) of cancer screening for employees at workplace';
	label he_binary='Distribution of materials on 1+ topic(s) to employees at workplace';
	label occ_binary='Occurrence of annual education program for 1+ topic(s) related to occupational cancer risk';
	label ref_binary='Offering of 1+ types(s) of examination/screening for employees via medical referral/health care provider';
	label occu_role='Occupational Role';
	label compliance = 'Adherence Score';
	label adhere_level = 'Adherence Level';
/* formatting */
	format hp_type hp_typef. hp_service hp_servicef. pay payf. concern concernf. makeup makeupf. 
	gender genderf. activestatus activestatusf. ff_current ff_currentf. assignment assignmentf. 
	discussrisk discussriskf. regiontype regiontypef. dept_size dept_sizef. compliance_binary comply_ynf. 
	medical_v2 medical_v2f. hptype_v2 hptype_v2f. hptype_v3 hptype_v3f. healthed_binary healthed_binaryf. 
	physical_binary physical_binaryf. occu_role occu_rolef. havehp2 havehp2f. adhere_level adhere_levelf.; 
run; 

******************************************************************************************************************************************;

/* BINARY LOGISTIC REGRESSION - UVA & MVA */

/* Significant Variables from Univariate Analysis */

	title 'FastC - UVA Logistic Regression Results for Health & Fitness Coordinator Count';
	proc logistic data=ac.compliance; model compliance_binary(event='Yes') = hfc_count; run;
	title 'FastC - UVA Logistic Regression Results for Presence of Healthcare Provider in Fire Department';
	proc logistic data=ac.compliance; class havehp2(ref='No') / param=ref; model compliance_binary(event='Yes') = havehp2; run; 
	title 'FastC - UVA Logistic Regression Results for Medical Exam Frequency';
	proc logistic data=ac.compliance; class medical_v2(ref='Never') / param=ref; model compliance_binary(event='Yes') = medical_v2; run; 
	title 'FastC - UVA Logistic Regression Results for Healthcare Provider Type (2 categories)';
	proc logistic data=ac.compliance; class hptype_v2(ref='Life Scan') / param=ref; model compliance_binary(event='Yes') = hptype_v2; run; 
	title 'FastC - UVA Logistic Regression Results for Healthcare Provider Type (3 categories)';
	proc logistic data=ac.compliance; class hptype_v3(ref='Life Scan') / param=ref; model compliance_binary(event='Yes') = hptype_v3; run;
	title 'FastC - UVA Logistic Regression Results for Presence of Self-Assessment Fitness Tool';
	proc logistic data=ac.compliance; class fittool(ref='No') / param=ref; model compliance_binary(event='Yes') = fittool; run; 
	title 'FastC - UVA Logistic Regression Results for Department Size';
	proc logistic data=ac.compliance; class dept_size(ref='Small') / param=ref; model compliance_binary(event='Yes') = dept_size; run; 

/* Final Multivariate Model (Binary Logistic Regression) */

	title 'FastC - MVA Logistic Regression Results for Significant Variables (from UVA)';
	proc logistic data=ac.compliance; 
	class havehp2(ref='No') medical_v2(ref='Never') hptype_v3(ref='Life Scan') fittool(ref='No') dept_size(ref='Small') / param=ref; 
	model compliance_binary(event='Yes') = hfc_count havehp2 medical_v2 hptype_v3 fittool dept_size / firth maxiter=10000;
	run;

/* MULTINOMIAL LOGISTIC REGRESSION - MVA */

	proc logistic data=ac.compliance desc order=internal; 
	class havehp2(ref='No') medical_v2(ref='Never') hptype_v3(ref='Life Scan') fittool(ref='No') dept_size(ref='Small') / param=ref; 
	model adhere_level = hfc_count havehp2 medical_v2 hptype_v3 fittool dept_size / link=glogit; 
	run; 
	
/* ORDINAL LOGISTIC REGRESSION - UVA & MVA */
	
	title 'FastC - UVA Ordinal Logistic Regression Results for Health & Fitness Coordinator Count';
	proc logistic data=ac.compliance desc; model compliance = hfc_count; run;
	title 'FastC - UVA Ordinal Logistic Regression Results for Presence of Healthcare Provider in Fire Department';
	proc logistic data=ac.compliance desc; class havehp2(ref='No') / param=ref; model compliance = havehp2; run; 
	title 'FastC - UVA Ordinal Logistic Regression Results for Medical Exam Frequency';
	proc logistic data=ac.compliance desc; class medical_v2(ref='Never') / param=ref; model compliance = medical_v2; run; 
	title 'FastC - UVA Ordinal Logistic Regression Results for Healthcare Provider Type (3 categories)';
	proc logistic data=ac.compliance desc; class hptype_v3(ref='Life Scan') / param=ref; model compliance = hptype_v3; run;
	title 'FastC - UVA Ordinal Logistic Regression Results for Presence of Self-Assessment Fitness Tool';
	proc logistic data=ac.compliance desc; class fittool(ref='No') / param=ref; model compliance = fittool; run; 
	title 'FastC - UVA Ordinal Logistic Regression Results for Department Size';
	proc logistic data=ac.compliance desc; class dept_size(ref='Small') / param=ref; model compliance = dept_size; run; 

	title 'FastC - MVA Ordinal Logistic Regression Results for Significant Variables (from UVA)';
	proc logistic data=ac.compliance desc; 
	class havehp2(ref='No') medical_v2(ref='Never') hptype_v3(ref='Life Scan') fittool(ref='No') dept_size(ref='Small') / param=ref; 
	model compliance= hfc_count havehp2 medical_v2 hptype_v3 fittool dept_size / link=cumlogit; 
	run;	
	
/* LINEAR REGRESSION VIA PROC GLM */

	title 'FastC - Linear Regression Results for Significant Variables (from UVA)';
	proc glm data=ac.compliance order=data;
	class havehp2 medical_v2 hptype_v3 fittool dept_size;
	model compliance = hfc_count havehp2 medical_v2 hptype_v3 fittool dept_size / solution;
	run;
	
******************************************************************************************************************************************;

/* FINAL TABLES as of 06/15/2020 */

/* Tables 1a & 1b  */

title "Table 1a: Compliance of the NFPA 1583 Health & Fitness Standard";
proc tabulate missing data=ac.compliance;
class hfc physical fitprog healthed fitfile compliance_binary; 
tables all hfc physical fitprog healthed fitfile , all*(n colpctn) compliance_binary*(n colpctn) / nocellmerge; 
run; 

title 'Table 1b: Compliance of the NFPA 1583 Health & Fitness Standard - Yes/No Version';
proc tabulate missing data=ac.compliance; 
class hfc physical_binary fitprog healthed_binary fitfile compliance_binary; 
tables all hfc physical_binary fitprog healthed_binary fitfile ,
all*(n colpctn) (compliance_binary)*(n colpctn) / nocellmerge; 
run; 
	
/* Tables 2a & 2b */

title "Table 2a: Firefighter Sociodemographic and Job Characteristics";
	proc tabulate missing data=ac.compliance;
	class gender activestatus ff_current occu_role haveinsurance havepdoc pdoc_annual discussrisk compliance_binary;  
	tables all gender activestatus ff_current occu_role haveinsurance havepdoc pdoc_annual discussrisk 
	, all*(n colpctn) (compliance_binary)*(n colpctn) / nocellmerge; 
	run; 
	
title "Table 2b: Firefighter Sociodemographic and Job Characteristics"; 
	proc tabulate missing data=ac.compliance;
	class compliance_binary; 
	var age years_served; 
	tables age*(mean std min max median q1 q3) years_served*(mean std min max median q1 q3) , all='All' compliance_binary / nocellmerge; 
	run; 

/* Tables 3a & 3b */

title "Table 3a: Fire Department Characteristics";
	proc tabulate missing data=ac.compliance;
	class regiontype makeup union region county compliance_binary; 
	tables all regiontype makeup union region , all*(n colpctn) (compliance_binary)*(n colpctn) / nocellmerge; 
	run; 
title "Table 3b: Fire Department Characteristics"; 
	proc tabulate missing data=ac.compliance;
	class compliance_binary;
	var activeff hfc_count station_count; 
	tables activeff*(mean std min max median q1 q3) hfc_count*(mean std min max median q1 q3) station_count*(mean std min max median q1 q3), all='All' compliance_binary / nocellmerge; 
	run; 

/* Table 4 */

title "Table 4: Fire Department Cancer Prevention Practices";
proc tabulate missing data=ac.compliance;
class hfc havehp2 hp_type hp_service pay inform_physiodemand inform_psychdemand inform_workenv inform_ppe 
practice_1582 practice_1583 practice_1584 physical medical_v2 healthed covercostscr ensuretrt fittool fitprog gymavail 
fitduty printedhe fitfile position concern compliance_binary;
tables all hfc havehp2 hp_type hp_service pay inform_physiodemand inform_psychdemand inform_workenv 
inform_ppe practice_1582 practice_1583 practice_1584 physical medical_v2 healthed covercostscr ensuretrt fittool fitprog 
gymavail fitduty printedhe fitfile position concern , all*(n colpctn) compliance_binary*(n colpctn) / nocellmerge; 
run; 

******************************************************************************************************************************************;

/* GRAPHS */

/* Bar Graph for Ordinal Compliance Outcome (i.e. Total Compliance Score) */
ods graphics / reset width=6.4in height=4.8in imagemap;
proc sgplot data=ac.compliance;
	title height=12pt "Distribution of Total Adherence Score";
	vbar compliance / fillattrs=(color=CXf38b03) fillType=gradient 
		stat=percent dataskin=crisp;
	xaxis label='Total Adherence Score (0 - 5)';
	yaxis min=0 max=0.4 grid;
run;
ods graphics / reset; title;

/* Bar Graph for Binary Compliance Outcome */
ods graphics / reset width=6.4in height=4.8in imagemap;
proc sgplot data=ac.compliance;
	title height=12pt "Adherence to the NFPA 1583 Health & Fitness Standard";
	vbar compliance_binary / fillattrs=(color=CXf38b03) fillType=gradient 
		stat=percent dataskin=crisp;
	xaxis label='Adherence Status';
	yaxis min=0 max=1 grid;
run;
ods graphics / reset; title; 

/* Bar Graph for Type of Region(s) Served */
ods graphics / reset width=6.4in height=4.8in imagemap;
proc sgplot data=ac.compliance;
	title height=12pt "Type of Region(s) Served by Fire Department";
	vbar regiontype / fillattrs=(color=CXf38b03) stat=percent 
		dataskin=crisp;
	xaxis label="Type of Region(s) Served";
	yaxis max=0.5 grid;
run;

/* Bar Graph for Location of Fire Departments by Region */
ods graphics / reset; title; ods graphics / reset width=6.4in height=4.8in imagemap;
proc sgplot data=ac.compliance;
	title height=12pt "Location of Fire Departments by Region";
	vbar region / fillattrs=(color=CXf38b03) fillType=gradient stat=percent 
		dataskin=crisp;
	xaxis label="Location of Fire Departments by Region";
	yaxis max=0.5 grid;
run;
ods graphics / reset; title;

/* Bar Graph for Workforce Makeup */
ods graphics / reset; title; ods graphics / reset width=6.4in height=4.8in imagemap;
proc sgplot data=ac.compliance;
	title height=12pt "Workforce Makeup of Fire Departments";
	vbar makeup / fillattrs=(color=CXf38b03) fillType=gradient stat=percent 
		dataskin=crisp;
	xaxis label="Workforce Makeup of Fire Departments";
	yaxis max=1 grid;
run;
ods graphics / reset; title;

/* Bar Graph for Presence of Union */
ods graphics / reset width=6.4in height=4.8in imagemap;
proc sgplot data=ac.compliance;
	title height=12pt "Presence of a Union for Fire Deparments";
	vbar union / fillattrs=(color=CXf38b03) fillType=gradient stat=percent 
		dataskin=crisp;
	xaxis label="Presence of a Union";
	yaxis max=1 grid;
run;
ods graphics / reset; title;

/* Bar Graph for Gender */
ods graphics / reset width=6.4in height=4.8in imagemap;
proc sgplot data=ac.compliance;
	title height=12pt "Gender";
	vbar gender / fillattrs=(color=CXf38b03) fillType=gradient stat=percent 
		dataskin=crisp;
	xaxis label="Gender";
	yaxis max=1 grid;
run;
ods graphics / reset; title;

/* Boxplot of Adherence Score & Medical Exam Frequency */
ods graphics / reset width=6.4in height=4.8in imagemap;
proc sgplot data=AC.COMPLIANCE;
	title height=12pt "Adherence Score by Medical Exam Frequency";
	vbox compliance / category=medical_v2 fillattrs=(color=CXf38b03);
	yaxis grid;
run;
ods graphics / reset; title;

/* Boxplot of Adherence Score & Presence of Self-Assessment Fitness Tool */
ods graphics / reset width=6.4in height=4.8in imagemap;
proc sgplot data=AC.COMPLIANCE;
	title height=12pt "Adherence Score by Presence of Self-Assessment Fitness Tool";
	vbox compliance / category=fittool fillattrs=(color=CXf38b03);
	yaxis grid;
run;
ods graphics / reset; title;

******************************************************************************************************************************************;
