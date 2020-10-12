/***************************************************************************
*** DATA CLEANING & OUTCOME VARIABLE CREATION ***
						    
MSPH Thesis (EPH 699)
FAST-C Project
Aneesh Chandramouli 
Last Updated: 06/29/2020
****************************************************************************/
 
proc import datafile='/folders/myfolders/msph thesis/fastc_year3data_ac.xlsx' dbms=xlsx out=fast replace; getnames=yes; run;
libname ac '/folders/myfolders/msph thesis'; 

**************
DATA CLEANING
**************;

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
value comply_ynf 0='Non-Adherence' 1='Met Standard';
value medical_v2f 0='Never' 1='Every year or longer'; 
value hptype_v2f 0='Life Scan' 1='Physician/Other Healthcare Professional'; 
value hptype_v3f 0='Life Scan' 1='Other Healthcare Professional' 2='Physician/Medical Doctor'; 
value healthed_binaryf 0='Never' 1='Rarely to Frequently';
value physical_binaryf 0='Never' 1='Between Every 1-4 Years';
/* formatting of new 'occupational role' variable */
value occu_rolef 1='Chief' 2='Lieutenant' 3='Captain' 4='Paramedic/Emergency Medical Technician' 5='Health & Safety Officer' 6='Other'; 
/* formatting of new 'havehp' binary variable */
value havehp2f 0='No' 1='Yes'; 
run;

data ac.fast; 
set fast (
drop = 
	DD DE DF DG DH Yes No dnk DL never yearly _2_3_years _3years DQ DR DS DT DU DV DW DX DY DZ Q6_informed
rename = (
	study_ID_2 = Study_ID  q1_hfc = hfc  q2_havehp = havehp  q3_cathp = hp_type  q3_others = hp_other
	q4_service = hp_service  q4_others = other_service  q5_pay = pay  q5_others = other_pay  q6_a = inform_physiodemand
	q6_b = inform_psychdemand  q6_c = inform_workenv  q6_d = inform_ppe  q7_nfpaa = practice_1582  q7_nfpab = practice_1583
	q7_nfpac = practice_1584  q7_nfpad = practice_dnk  q7_others = practice_other  q8_physicals = physical
	q9_medical = medical  q10_hlthedu = healthed  q11_skin = he_skinca  q11_colon = he_colca  q11_lung = he_lungca
	q11_thyroid = he_thyroidca  q11_psa = he_psa  q11_breast = he_breastca  q11_pap = he_cervca  q11_alcohol = he_alcdrug
	q11_smoke = he_smkcess  q11_diet = he_diet  q11_infection = he_infect  q11_sleep = he_sleep  q12_freq = cascr_freq
	q13_skin = cascr_skin  q13_psa = cascr_psa  q13_breast = cascr_breast  q13_hpv = cascr_hpvkit  q13_fobt = cascr_occult
	q13_alcohol = cascr_alc  q13_smoke = cascr_smkcess  q13_diet = cascr_diet  q13_vachep = cascr_vhep  q13_vacherpes = cascr_vherpes
	q13_vachpv = cascr_vhpv  q13_cpap = cascr_apnea  q14_a = occ_risk  q14_b = occ_lifestyle  q14_c = occ_lifestrat
	q14_d = occ_occstrat  q14_e = occ_eviscr  q14_none = occ_noed  q15_refa = ref_no  q15_sleep = ref_sleep
	q15_oral = ref_oralca  q15_colon = ref_colca  q15_thyroid = ref_thyca  q15_bladder = ref_bladca  q15_lung = ref_lungca
	q15_metals = ref_metals  q15_testes = ref_testes  q15_psa = ref_psa  q15_pap = ref_pap  q15_mamo = ref_mamo
	q16_cost = covercostscr  q17_trt = ensuretrt  q18_fit = fittool  q19_fitprog = fitprog  q20_gym = gymavail
	q21_duty = fitduty  q22_edu = printedhe  q23_file = fitfile  q24_position = position  q25_concern = concern
	q26_ff = activeff  q27_nohfc = hfc_count  q28_geo = regiontype  q28_rural = rural  q28_urban = urban  q28_suburban = suburban
	q28_other = otherarea  q29_makeup = makeup  q30_union = union  q31_name = dept_name  q32_station = station_count
	q33_county = county  q_34age = age  q35_gender = gender  q36_active = activestatus  q37_current = ff_current  
	q37_other = ff_other  q38_assign = assignment  q38_other = assignment_other  q39_yrsff = years_served  q40_insure = haveinsurance
	q41_pdoc = havepdoc  q42_annual = pdoc_annual  q43_risk = discussrisk  q44_cadx = cadx  q44_a__years_first_diagnosis_ = cadx_length
	q44_a2__years_2nd_ca_diagnosis_ = ca2dx_length  q44_b = ca_type  q44_b2type_of_cancer = ca2_type  q44_c = ca_remission
	q44_c2_remission = ca2_remission
));
format 
	hp_type hp_typef. hp_service hp_servicef. pay payf. concern concernf. makeup makeupf. gender genderf. 
	activestatus activestatusf. ff_current ff_currentf. assignment assignmentf. discussrisk discussriskf. 
	regiontype regiontypef. dept_size dept_sizef. compliance_binary comply_ynf. medical_v2 medical_v2f. 
	hptype_v2 hptype_v2f. hptype_v3 hptype_v3f. healthed_binary healthed_binaryf. physical_binary physical_binaryf.
	occu_role occu_rolef. havehp2 havehp2f.;
/*recreation of "assignment_other" variable  */
	length assignment_alt $200.;
	if assignment_other in ('4') then assignment_alt='Battalion, Division, or District Chief';
	if assignment_other in ('12','firefighter paramedic') then assignment_alt='Firefighter Paramedic';
	if assignment_other in ('13','firefighter EMT') then assignment_alt='Firefighter EMT';
	if assignment_other in ('14','Health and safety officer') then assignment_alt='Health & Safety Officer';
	if assignment_other in ('16','Fire trainer/instructor') then assignment_alt='Fire Trainer/Instructor';
	if assignment_other in ('12,16') then assignment_alt='Firefighter Paramedic, Fire Trainer/Instructor'; 
	if assignment_other in ('10,12,16') then assignment_alt='Firefighter, Firefighter Paramedic, Fire Trainer/Instructor'; 
	if assignment_other in ('14,16','14, 16') then assignment_alt='Health & Safety Officer, Fire Trainer/Instructor';
	if assignment_other in ('10,11,12,16,peer support') then assignment_alt='Firefighter, Driver Operator, Firefighter Paramedic, Fire Trainer/Instructor, Peer Support'; 
	if assignment_other in ('9,10,13,15') then assignment_alt='Administrative, Firefighter, Firefighter EMT, Fire Investigator';
	if assignment_other in ('4,5,7,10, 11, 13,14 17') then assignment_alt='Battalion/Division/District Chief, Lieutenant, Special Operations Captain, Firefighter, Driver Operator, Firefighter EMT, Health & Safety Officer, Wildland';
	if assignment_other in ('Driver operator') then assignment_alt='Driver Operator';
	if assignment_other in ('Diver operator, ff paramedic') then assignment_alt='Driver Operator, Firefighter Paramedic';
	if assignment_other in ('Retired') then assignment_alt='Retired';
	if assignment_other in ('Special assignment 40 hours') then assignment_alt='Special Assignment 40 Hours';
	if assignment_other in ('Union rep') then assignment_alt='Union Representative';
drop assignment_other; 
rename assignment_alt = assignment_other;
/* transformation of "activeff" from character to numeric variable */
	if activeff='300+' then activeff='300'; if activeff='<600' then activeff='600'; 
	active_ff=input(activeff, 10.); 
	drop activeff; 
	rename active_ff = activeff; 
/* creation of department workforce size variable */
	if .<activeff<=100 then dept_size=1; if 100<activeff<=500 then dept_size=2; if activeff>500 then dept_size=3;
/* NOTE: here we are removing studyID 98 and 231 because they have many missing variable info */
	if study_ID=98 or study_ID=231 then delete;
/* NOTE: here we are removing this subject because they serve in a department outside of Florida */
if dept_name='Cottleville fire department' then delete; 
/* creation of new 'havehp' binary variable	*/
if havehp='No' then havehp2=0; if havehp='Yes' then havehp2=1; 
run;

data ac.fast_outcomes;
length printedhe $20.; format printedhe $20.;
length fittool $20.; format fittool $20.;
length fitprog $20.; format fitprog $20.;
length fitfile $20.; format fitfile $20.;
length covercostscr $20.; format covercostscr $20.;
length ensuretrt $20.; format ensuretrt $20.;
length position $20.; format position $20.;
length hfc $20.; format hfc $20.;
length havehp $20.; format havehp $20.;
length haveinsurance $20.; format haveinsurance $20.;
length havepdoc $20.; format havepdoc $20.;
length pdoc_annual $20.; format pdoc_annual $20.;
length cadx $20.; format cadx $20.;
length ca_remission $20.; format ca_remission $20.;
length ca2_remission $20.; format ca2_remission $20.;
length physical $20.; format physical $20.;
set ac.fast;
/* lowercase/uppercase issues for yes's and no's resolved */
	if hfc='yes' then hfc='Yes'; if hfc='no' then hfc='No'; if hfc='dnk' then hfc='';
	if havehp='yes' then havehp='Yes'; if havehp='no' then havehp='No'; if havehp='dnk' then havehp='';
	if practice_1583='yes' then practice_1583='Yes'; if practice_1583='no' then practice_1583='No';
	if fittool='yes' then fittool='Yes'; if fittool='no' then fittool='No'; if fittool='dnk' then fittool='';
	if fitprog='yes' then fitprog='Yes'; if fitprog='no' then fitprog='No'; if fitprog='dnk' then fitprog='';
	if gymavail='yes' then gymavail='Yes'; if gymavail='no' then gymavail='No';
	if fitduty='yes' then fitduty='Yes'; if fitduty='no' then fitduty='No'; 
	if printedhe='yes' then printedhe='Yes'; if printedhe='no' then printedhe='No'; if printedhe='dnk' then printedhe='';
	if fitfile='yes' then fitfile='Yes'; if fitfile='no' then fitfile='No'; if fitfile='dnk' then fitfile='';
	if rural='yes' then rural='Yes'; if rural='no' then rural='No';
	if urban='yes' then urban='Yes'; if urban='no' then urban='No';
	if suburban='yes' then suburban='Yes'; if suburban='no' then suburban='No';
	if union='yes' then union='Yes'; if union='no' then union='No';
	if covercostscr='yes' then covercostscr='Yes'; if covercostscr='no' then covercostscr='No'; if covercostscr='dnk' then covercostscr='';
	if ensuretrt='yes' then ensuretrt='Yes'; if ensuretrt='no' then ensuretrt='No'; if ensuretrt='dnk' then ensuretrt='';
	if position='yes' then position='Yes'; if position='no' then position='No'; if position='dnk' then position='';
	if inform_physiodemand ='yes' then inform_physiodemand ='Yes'; if inform_physiodemand ='no' then inform_physiodemand ='No'; if inform_physiodemand ='dnk' then inform_physiodemand='';
	if inform_psychdemand ='yes' then inform_psychdemand='Yes'; if inform_psychdemand='no' then inform_psychdemand='No'; if inform_psychdemand='dnk' then inform_psychdemand='';
	if inform_workenv='yes' then inform_workenv='Yes'; if inform_workenv='no' then inform_workenv='No'; if inform_workenv='dnk' then inform_workenv='';
	if inform_ppe='yes' then inform_ppe='Yes'; if inform_ppe='no' then inform_ppe='No'; if inform_ppe='dnk' then inform_ppe='';
	if practice_1582='yes' then practice_1582='Yes'; if practice_1582='no' then practice_1582='No'; if practice_1582='dnk' then practice_1582='';
	if practice_1583='yes' then practice_1583='Yes'; if practice_1583='no' then practice_1583='No'; if practice_1583='dnk' then practice_1583='';
	if practice_1584='yes' then practice_1584='Yes'; if practice_1584='no' then practice_1584='No'; if practice_1584='dnk' then practice_1584='';
	if practice_dnk='yes' then practice_dnk='Yes'; if practice_dnk='no' then practice_dnk='No'; if practice_dnk='dnk' then practice_dnk='';
	if occ_noed='yes' then occ_noed='Yes'; if occ_noed='no' then occ_noed='No'; if occ_noed='dnk' then occ_noed='';
	if cascr_hpvkit='yes' then cascr_hpvkit='Yes'; if cascr_hpvkit='no' then cascr_hpvkit='No'; if cascr_hpvkit='dnk' then cascr_hpvkit='';
	if cascr_apnea='yes' then cascr_apnea='Yes'; if cascr_apnea='no' then cascr_apnea='No'; if cascr_apnea='dnk' then cascr_apnea='';
	if ref_no='yes' then ref_no='Yes'; if ref_no='no' then ref_no='No'; if ref_no='dnk' then ref_no='';
	if ref_sleep ='yes' then ref_sleep='Yes'; if ref_sleep='no' then ref_sleep='No'; if ref_sleep='dnk' then ref_sleep='';
	if ref_oralca='yes' then ref_oralca='Yes'; if ref_oralca='no' then ref_oralca='No'; if ref_oralca='dnk' then ref_oralca='';
	if ref_colca='yes' then ref_colca='Yes'; if ref_colca='no' then ref_colca='No'; if ref_colca='dnk' then ref_colca='';
	if ref_thyca='yes' then ref_thyca='Yes'; if ref_thyca='no' then ref_thyca='No'; if ref_thyca='dnk' then ref_thyca='';
	if ref_bladca='yes' then ref_bladca='Yes'; if ref_bladca='no' then ref_bladca='No'; if ref_bladca='dnk' then ref_bladca='';
	if ref_lungca='yes' then ref_lungca='Yes'; if ref_lungca='no' then ref_lungca='No'; if ref_lungca='dnk' then ref_lungca='';
	if ref_metals='yes' then ref_metals='Yes'; if ref_metals='no' then ref_metals='No'; if ref_metals='dnk' then ref_metals='';
	if ref_testes='yes' then ref_testes='Yes'; if ref_testes='no' then ref_testes='No'; if ref_testes='dnk' then ref_testes='';
	if ref_psa='yes' then ref_psa='Yes'; if ref_psa='no' then ref_psa='No'; if ref_psa='dnk' then ref_psa='';
	if ref_pap='yes' then ref_pap='Yes'; if ref_pap='no' then ref_pap='No'; if ref_pap='dnk' then ref_pap='';
	if ref_mamo='yes' then ref_mamo='Yes'; if ref_mamo='no' then ref_mamo='No'; if ref_mamo='dnk' then ref_mamo='';
	if haveinsurance='yes' then haveinsurance='Yes'; if haveinsurance='no' then haveinsurance='No'; if haveinsurance='dnk' then haveinsurance='';
	if havepdoc='yes' then havepdoc='Yes'; if havepdoc='no' then havepdoc='No'; if havepdoc='dnk' then havepdoc='';
	if pdoc_annual='yes' then pdoc_annual='Yes'; if pdoc_annual='no' then pdoc_annual='No'; if pdoc_annual='dnk' then pdoc_annual='';
	if cadx='yes' then cadx='Yes'; if cadx in ('NO','No','no') then cadx='No'; if cadx='dnk' then cadx='';
	if ca_remission='yes' then ca_remission='Yes'; if ca_remission='no' then ca_remission='No'; if ca_remission='dnk' then ca_remission='';
	if ca2_remission='yes' then ca2_remission='Yes'; if ca2_remission='no' then ca2_remission='No'; if ca2_remission='dnk' then ca2_remission='';
/* labels */
	label gender='Gender';
	label makeup='Workforce Makeup';
	label union='Presence of Union';
	label county='County';
	label activestatus='Active Status';
	label ff_current='Current Status';
	label assignment="Current Functional Assignment";
	label practice_1583='Are NFPA 1583 Health/Fitness Standards being practiced?';
	label fittool='Self-assessment tool available to measure your fitness level?';
	label fitprog='Physical Fitness Program Available in Department';
	label gymavail='Gym with exercise equipment available?';
	label fitduty='Time allocated on duty for physical fitness training?';
	label printedhe='Printed health education materials provided?';
	label fitfile='Maintenance of Health-Related Fitness Program File per Participant';
	label cascr_freq='How often are cancer screening services available in the fire department?';
	label hfc_count='Number of Health & Fitness Coordinators/Safety Officers per Department';
	label regiontype='Type of Region(s) Served by Department';
	label activeff='Number of Active Firefigthers per Department';
	label dept_name='Department Name';
	label dept_size='Department Size';
	label station_count='Number of Stations per Department';
	label age="Age (Years)";
	label years_served="Years Served";
	label hfc='Health & Fitness Coordinator in Department';	
	label havehp='Health Care Provider (HCP) in your Department?';	
	label hp_type='Type of HCP in your Department?';	
	label hp_other='Other Type of HCP in your Department?';	
	label hp_service='Method of Obtaining HCP Service in your Department?';	
	label other_service='Other Ways of Obtaining HCP Service in your Department?';	
	label pay='Who pays HCP in your Department?';
	label other_pay='Other ways of paying HCP in your Department?';	
	label inform_physiodemand='Is your HCP informed of physiological demands on firefighters?';	
	label inform_psychdemand='Is your HCP informed of psychological demands on firefighters?';		
	label inform_workenv='Is your HCP informed of work environmental conditions of firefighters?';		
	label inform_ppe='Is your HCP informed of PPE that firefighters must wear?';		
	label practice_1582='Are NFPA 1582 Health/Fitness Standards being practiced?';	
	label practice_1584='Are NFPA 1584 Health/Fitness Standards being practiced?';	
	label practice_dnk='I do not know if any of these NFPA Standards are being practiced?';	
	label practice_other='Are other NFPA Standards besides 1582, 1583, & 1584 being practiced?';	
	label physical='Frequency of Required/Recommended Physical Tests';	
	label medical='How often are medical tests required/recommended?';	
	label healthed='Frequency of Workplace Health Promotion Activities';	
	label he_skinca='Are materials on skin cancer distributed during health promotion activites?';	
	label he_colca='Are materials on colon cancer distributed during health promotion activites?';	
	label he_lungca='Are materials on lung cancer distributed during health promotion activites?';	
	label he_thyroidca='Are materials on thyroid cancer distributed during health promotion activites?';	
	label he_psa='Are materials on prostate cancer distributed during health promotion activites?';	
	label he_breastca='Are materials on breast cancer/mammorgrams distributed during health promotion activites?';	
	label he_cervca='Are materials on cervical cancer/Pap smears/annual gynec distributed during health promotion activites?';	
	label he_alcdrug='Are materials on alcohol and drug abuse distributed during health promotion activites?';	
	label he_smkcess='Are materials on smoking cessation programs distributed during health promotion activites?';	
	label he_diet='Are materials on diet & nutrition distributed during health promotion activites?';	
	label he_infect='Are materials on infectious diseases distributed during health promotion activites?';	
	label he_sleep='Are materials on sleep hygiene, stress, and fatigue distributed during health promotion activites?';
	label cascr_skin='Full skin examination provided to employees at workplace?'; 
	label cascr_psa='Prostate Specific Antigen test provided to employees at workplace?'; 
	label cascr_breast='Ultrasound/mammorgram screening for breast CA provided to employees at workplace?'; 
	label cascr_hpvkit='HPV test kits for vaginal HPV test provided to employees at workplace?'; 
	label cascr_occult='FOBT or FIT kits for colorectal CA screening provided to employees at workplace?';
	label cascr_alc='Alcohol/substance abuse treatment provided to employees at workplace?'; 
	label cascr_smkcess='Smoking cessation treatment provided to employees at workplace?';  
	label cascr_diet='Healthy food samples/recipes provided to employees at workplace?'; 
	label cascr_vhep='Vaccination for Hepatitis B/C prevention provided to employees at workplace?'; 
	label cascr_vherpes='Vaccination for Herpes virus provided to employees at workplace?';
	label cascr_vhpv='Vaccination for HPV prevention provided to employees at workplace?';
	label cascr_apnea='Sleep apnea treatment provided to employees at workplace?';
	label occ_risk='Annual educational program on evidence of occupational risk?'; 
	label occ_lifestyle='Annual educational program on lifestyle risk factors for cancer (CA)'; 
	label occ_lifestrat='Annual educational program on strategies to reduce lifestyle risk factors for CA?';
	label occ_occstrat='Annual educational program on strategies to reduce occupational risk factors for CA?';  
	label occ_eviscr='Annual educational program on evidence-based medical screening for CA?'; 
	label occ_noed='My department DOES NOT organize annual education programs on risks of occupational CA?';
	label ref_no='My department DOES NOT offer medical referral to employees in need';  
	label ref_sleep='Sleep disorder assessment offered to employees via medical referral or HCP?';
	label ref_oralca='Oral CA examination offered to employees via medical referral or HCP?'; 
	label ref_colca='Colonoscopy for colon CA screening offered to employees via medical referral or HCP?';  
	label ref_thyca='Thyroid CA offered to employees via medical referral or HCP?'; 
	label ref_bladca='Bladder CA screening with urine test offered to employees via medical referral or HCP?';  
	label ref_lungca='Lung CA screening with lose dose CT scan offered to employees via medical referral or HCP?';
	label ref_metals='Heavy metals screening offered to employees via medical referral or HCP?';
	label ref_testes='Male testicular CA examination offered to employees via medical referral or HCP?'; 
	label ref_psa='Male prostate CA examination (using PSA test) offered to employees via medical referral or HCP?'; 
	label ref_pap='Female cervical CA screening (using Pap smear) offered to employees via medical referral or HCP?';
	label ref_mamo='Breast CA screening (using mammogram/ultrasound) offered to employees via medical referral or HCP?';
	label covercostscr='Out-of-pocket costs covered for employees for cancer screening?';
	label ensuretrt='Is medical care prescribed by HCP ensured for firefighers following injury/illness?';
	label position='Alternate duty positions provided for firefighters when HCP recommends temporary work restrictions?';
	label concern='How concerned are you that employee medical information is kept confidential?';
	label cadx='Cancer Diagnosis';
	label ca_type='Type of Cancer';
	label ca2_type='Type of Second Cancer';
	label cadx_length="Years Since First Cancer Diagnosis";
	label ca2dx_length="Years Since Second Cancer Diagnosis";
	label ca_remission='Cancer Remission Status';
	label ca2_remission='Second Cancer Remission Status';
	label haveinsurance='Health Insurance Status';
	label havepdoc='Personal Primary HPC Status';
	label pdoc_annual='Annual Physical with Personal Primary HPC?';
	label discussrisk='Discussion with HCP about Cancer Risks';	
/* numerical variables for Q11 */
	if he_alcdrug='No' then he_alcdrug_num=0; if he_alcdrug='Yes' then he_alcdrug_num=1;
	if he_breastca='No' then he_breastca_num=0; if he_breastca='Yes' then he_breastca_num=1; 	
	if he_cervca='No' then he_cervca_num=0; if he_cervca='Yes' then he_cervca_num=1;	
	if he_colca='No' then he_colca_num=0; if he_colca='Yes' then he_colca_num=1;
	if he_diet='No' then he_diet_num=0; if he_diet='Yes' then he_diet_num=1;	
	if he_infect='No' then he_infect_num=0; if he_infect='Yes' then he_infect_num=1;	
	if he_lungca='No' then he_lungca_num=0; if he_lungca='Yes' then he_lungca_num=1;	
	if he_psa='No' then he_psa_num=0; if he_psa='Yes' then he_psa_num=1;
	if he_skinca='No' then he_skinca_num=0; if he_skinca='Yes' then he_skinca_num=1;	
	if he_sleep='No' then he_sleep_num=0; if he_sleep='Yes' then he_sleep_num=1;	
	if he_smkcess='No' then he_smkcess_num=0; if he_smkcess='Yes' then he_smkcess_num=1;	
	if he_thyroidca='No' then he_thyroidca_num=0; if he_thyroidca='Yes' then he_thyroidca_num=1;
/* sum variable for Q11 */
	he_sum = sum(he_alcdrug_num, he_breastca_num, he_cervca_num, he_colca_num, he_diet_num, he_infect_num, he_psa_num, he_skinca_num, he_sleep_num, he_smkcess_num, he_thyroidca_num);
/* numerical varaibles for Q13 */
	if cascr_skin='No' then cascr_skin_num=0; if cascr_skin='Yes' then cascr_skin_num=1;
	if cascr_psa='No' then cascr_psa_num=0; if cascr_psa='Yes' then cascr_psa_num=1; 
	if cascr_breast='No' then cascr_breast_num=0; if cascr_breast='Yes' then cascr_breast_num=1; 
	if cascr_hpvkit='No' then cascr_hpvkit_num=0; if cascr_hpvkit='Yes' then cascr_hpvkit_num=1;
	if cascr_occult='No' then cascr_occult_num=0; if cascr_occult='Yes' then cascr_occult_num=1; 
	if cascr_alc='No' then cascr_alc_num=0; if cascr_alc='Yes' then cascr_alc_num=1; 
	if cascr_smkcess='No' then cascr_smkcess_num=0; if cascr_smkcess='Yes' then cascr_smkcess_num=1;
	if cascr_diet='No' then cascr_diet_num=0; if cascr_diet='Yes' then cascr_diet_num=1; 
	if cascr_vhep='No' then cascr_vhep_num=0; if cascr_vhep='Yes' then cascr_vhep_num=1; 
	if cascr_vherpes='No' then cascr_vherpes_num=0; if cascr_vherpes='Yes' then cascr_vherpes_num=1; 
	if cascr_vhpv='No' then cascr_vhpv_num=0; if cascr_vhpv='Yes' then cascr_vhpv_num=1; 
	if cascr_apnea='No' then cascr_apnea_num=0; if cascr_apnea='Yes' then cascr_apnea_num=1; 
/* sum variable for Q13 */
	cascr_sum=sum(cascr_skin_num, cascr_psa_num, cascr_breast_num, cascr_hpvkit_num, cascr_occult_num, cascr_alc_num, cascr_smkcess_num, cascr_diet_num, cascr_vhep_num, cascr_vherpes_num, cascr_vhpv_num, cascr_apnea_num);
/* numerical variables for Q14 */
	if occ_risk='No' then occ_risk_num=0; if occ_risk='Yes' then occ_risk_num=1;  
	if occ_lifestyle='No' then occ_lifestyle_num=0; if occ_lifestyle='Yes' then occ_lifestyle_num=1;  
	if occ_lifestrat='No' then occ_lifestrat_num=0; if occ_lifestrat='Yes' then occ_lifestrat_num=1;  
	if occ_occstrat='No' then occ_occstrat_num=0; if occ_occstrat='Yes' then occ_occstrat_num=1;  
	if occ_eviscr='No' then occ_eviscr_num=0; if occ_eviscr='Yes' then occ_eviscr_num=1;  
	if occ_noed='No' then occ_noed_num=0; if occ_noed='Yes' then occ_noed_num=1;  
/* sum variable for Q14 */
	occ_sum=sum(occ_risk_num, occ_lifestyle_num, occ_lifestrat_num, occ_occstrat_num, occ_eviscr_num, occ_noed_num); 
/* numerical variables for Q15 */
	if ref_no='No' then ref_no_num=0; if ref_no='Yes' then ref_no_num=1;
	if ref_sleep='No' then ref_sleep_num=0; if ref_sleep='Yes' then ref_sleep_num=1;
	if ref_oralca='No' then ref_oralca_num=0; if ref_oralca='Yes' then ref_oralca_num=1;
	if ref_colca='No' then ref_colca_num=0; if ref_colca='Yes' then ref_colca_num=1;
	if ref_thyca='No' then ref_thyca_num=0; if ref_thyca='Yes' then ref_thyca_num=1;
	if ref_bladca='No' then ref_bladca_num=0; if ref_bladca='Yes' then ref_bladca_num=1;
	if ref_lungca='No' then ref_lungca_num=0; if ref_lungca='Yes' then ref_lungca_num=1;
	if ref_metals='No' then ref_metals_num=0; if ref_metals='Yes' then ref_metals_num=1;
	if ref_testes='No' then ref_testes_num=0; if ref_testes='Yes' then ref_testes_num=1;
	if ref_psa='No' then ref_psa_num=0; if ref_psa='Yes' then ref_psa_num=1;
	if ref_pap='No' then ref_pap_num=0; if ref_pap='Yes' then ref_pap_num=1;
	if ref_mamo='No' then ref_mamo_num=0; if ref_mamo='Yes' then ref_mamo_num=1;
/* sum variable for Q15 */
	ref_sum=sum(ref_no_num, ref_sleep_num, ref_oralca_num, ref_colca_num, ref_thyca_num, ref_bladca_num, ref_lungca_num, ref_metals_num, ref_testes_num, ref_psa_num, ref_pap_num, ref_mamo_num);
/* numerical variables for Q28 */
	if rural='No' then rural_num=0; if rural='Yes' then rural_num=1;
	if urban='No' then urban_num=0; if urban='Yes' then urban_num=1;
	if suburban='No' then suburban_num=0; if suburban='Yes' then suburban_num=1;
	if otherarea='No' then otherarea_num=0; if otherarea='Yes' then otherarea_num=1;
/* sum variable for Q28 */
	region_sum=sum(rural_num, urban_num, suburban_num, otherarea_num); 	
/* labels for sum variables */
	label he_sum='Total Score: Health Promotion Activities'; 
	label cascr_sum='Total Score: Cancer Screening Services'; 
	label occ_sum='Total Score: Occupational Cancer Risk Education via Annual Programs'; 
	label ref_sum='Total Score: Services Provided via Medical Referral or HCP'; 
	label region_sum='Total Score: Types of Regions Served';		
/* cleaned up "hp_other" variable (DONE) */
	if hp_other in ('Nurse practitioner', 'nurse practitioner') then hp_type=2;
	if hp_other in ("Life scan", "Lifescan", "life scan", "lifescan") then hp_type=6;
	if hp_other in ('Nurse practitioner and lifescan', 'also nurse and lifescan') then hp_type=5; * 5='Nurse Practitioner and Life Scan';
/* cleaned up "other_service" variable (DONE to the best of my ability) */
	if other_service='2' then hp_service=2; * 2=Through an individual health care provider, on a paid contract basis; 
	if other_service='3' then hp_service=3; * 3=Through a health facility, on a volunteer basis; 
	if other_service in ('LIFESCAN IS OFFERED ON VOLUNTEER BASIS', 'life scan') then hp_service=6; * 6=Life Scan;	 
	if other_service='City clinic' then hp_service=7; * 7=City Clinic; 
	if other_service='Medical director in charge of annual screening initiative' then hp_service=8; * 8=Medical director... ; 
	if hp_service=1 and other_service='2' and study_ID=228 then hp_service=9; * 9='Health Care Facility and HCP (both paid contract)';
	if hp_service=2 and other_service='3' and study_ID=250 then hp_service=10; * 10='Health Care Facility (volunteer) and Health Care Provider (paid contract)';		
/* cleaned up "other_pay" variable (DONE to the best of my ability)  */
	if other_pay in ('City', 'City HR', 'City of lakeland', 'city') then other_pay='City'; 
	if other_pay in ('Municipality', 'municipality') then other_pay='Municipality';	
/* cleaned up "assignment_other" variable */
	if assignment_other='Battalion, Division, or District Chief' then assignment=4;
	if assignment_other='Driver Operator' then assignment=11;
	if assignment_other='Fire Trainer/Instructor' then assignment=16;
	if assignment_other='Firefighter EMT' then assignment=13;
	if assignment_other='Firefighter Paramedic' then assignment=12; 
	if assignment_other='Health & Safety Officer' then assignment=14;
	if assignment=18 and assignment_other='Retired' and study_ID in (188,192) then assignment=19; * 19=Retired;
/* cleaned up "type of cancer" variable */
	if ca_type in ('Skin basal cell', 'Skin ca basal cell carcinoma', 'Skin cancer', 'Skin cancer basal and squamouscell', 'Skin cancer basal cell', 'skin') then ca_type='Skin';
	if ca_type in ('Acute lymphocytic leukemia', 'Chronic myeloid Leukemia') then ca_type='Leukemia';
	if ca_type='breast cancer rt side stage 2 tripple negative' then ca_type='Breast';
	if ca_type in ('Thyroid', 'thyroid') then ca_type='Thyroid'; 
/* cleaned up "dept_name" variable */
	if dept_name in ('Brevard County Fire rescue','Brevard county Fr') then dept_name='Brevard County Fire Rescue';
	if dept_name in ('Clay County fire department', 'Clay county fire rescue') then dept_name='Clay County Fire Rescue';
	if dept_name in ('Fort Meyers fire department','Forth meyers fire dept') then dept_name='Fort Myers Fire Department';	
	if dept_name in ('Gainesville fire rescue', 'Gainsville fire rescue') then dept_name='Gainesville Fire Rescue';
	if dept_name in ('Lakeland fire department','Lakke land fire dept') then dept_name='Lakeland Fire Department';
	if dept_name in ('Miami Dade fire rescue','Miami dade fire rescue') then dept_name='Miami-Dade Fire Rescue';
	if dept_name in ('Oakland Park fire rescue','Oakland park fire rescue') then dept_name='Oakland Park Fire Rescue';
	if dept_name in ('Walton CFR','Walton county fire rescue') then dept_name='Walton County Fire Rescue';
	if dept_name in ('Winter Haven fire department','Winter haven fire department') then dept_name='Winter Haven Fire Department';
	if dept_name in ('Pinellas suncoast fire rescue','Pinellas suncoast fire rescue district') then dept_name='Pinellas Suncoast Fire Rescue';
	if dept_name in ('Riviera Beach Fire rescue','Riviera beach fire rescue') then dept_name='Riviera Beach Fire Rescue';
	if dept_name in ('Boca Raton Fire Rescue','boca raton fire rescue') then dept_name='Boca Raton Fire Rescue';
	if dept_name='BSO fire rescue' then dept_name='Broward Sheriffs Office Fire Rescue'; 
	if dept_name in ('City of cocoa','Cocoa fire department') then dept_name='Cocoa Fire Department';
/* cleaned up "county" variable */
	if county in ('Miami-Dade','Miami-dade') then county='Miami-Dade';
	if county in ('Walton','walton') then county='Walton';
	if county in ('Pinellas','Pinellas county','pinellas') then county='Pinellas';
	if county in ('St Johns county') then county='St. Johns';
	if county in ('Brervard','Brevard') then county='Brevard';
	if county in ('Santa rosa','Santa rose') then county='Santa Rosa';
	if county in ('St Lucie','St. Lucie') then county='St. Lucie';
/* cleaned up "county" and "dept_name" missing data */
	if dept_name='Pembroke Pines fire department' then county='Broward';
/* cleaned up "havepdoc" and "pdoc_annual" variables */
	if pdoc_annual='Yes' then havepdoc='Yes'; 
	if havepdoc='No' then pdoc_annual='No';
/* cleaned up "ff_current" and "ff_other" variables */
	if ff_other='retired' then ff_current=4;
	if ff_other='unpaid volunteer' and study_ID=244 then ff_other='';
/* cleaned up "pay" and "other_pay" (NOT DONE) */
	if pay=5 and other_pay='City' and study_ID in (10,20,28,74,111,126,179,234,292) then pay=6;
	if pay=5 and other_pay='County' and study_ID=17 then pay=7;
	if pay=5 and other_pay='Private reedy creek gov' and study_ID=334 then pay=7; 
	if pay=5 and other_pay='Municipality' and study_ID in (77,303) then pay=8;
	if pay=1 and other_pay='City' and study_ID in (24,55) then pay=9;	
/* cleaned up "regiontype" variable	*/
	if rural='Yes' and suburban='Yes' and study_ID=337 then regiontype=4;
	if regiontype=2 and otherarea='small city' and study_ID=20 then urban='Yes';
	if study_ID=148 then regiontype=4; 
/* cleaned up "healthed" responses */
	healthed_prop = propcase(healthed); 
	drop healthed; 
	rename healthed_prop = healthed; 
/* cleaned up "physical" responses */
	if physical='2yearly' then physical='Every 2 Years';
	if physical='3-4years' then physical='Every 3-4 Years';
	if physical='never' then physical='Never';
	if physical='yearly' then physical='Every Year'; 
/* collapsing 'medical' variable */
	if medical='never' then medical_v2=0; 
	if medical in ('yearly','2yearly','3-4years','>4years') then medical_v2=1; 
/* collapsing 'hp_type' variable --> hptype_v2 */
	if hp_type=6 then hptype_v2=0; 
	if hp_type in (1 2 3 4 5) then hptype_v2=1;
/* collapsing 'hp_type' variable --> hptype_v3 */
	if hp_type=6 then hptype_v3=0;
	if hp_type in (2 3 4 5) then hptype_v3=1; 
	if hp_type=1 then hptype_v3=2; 			
/* created binary variables for he_sum, cascr_sum, occ_sum, and ref_sum */	
	if he_sum=0 then he_binary=0; else if he_sum=. then he_binary=.; else he_binary=1;	
	if cascr_sum=0 then cascr_binary=0; else if cascr_sum=. then cascr_binary=.; else cascr_binary=1;
	if occ_sum=0 then occ_binary=0; else if occ_sum=. then occ_binary=.; else occ_binary=1;
	if ref_sum=0 then ref_binary=0; else if ref_sum=. then ref_binary=.; else ref_binary=1; 
/* creation of binary versions of healthed and physical variables for Table 1 (Outcome Table) */
	if healthed='Never' then healthed_binary=0; if healthed='' then healthed_binary=.; 
	if healthed in ('Rarely', 'Occasionally', 'Frequently') then healthed_binary=1;
	if physical='Never' then physical_binary=0; else if physical='' then physical_binary=.; else physical_binary=1;
/* creation of 'region' variable based on county */	
length region $20.;
	if county in ('Brevard', 'Manatee', 'Polk', 'Hardee', 'Hernando', 'Hillsborough', 'Orange', 'Pasco', 'Seminole', 'Sumter', 'Osceola', 'Lake', 'Pinellas', 'Volusia') then region='Central/West Florida';
	if county in ('Alachua', 'Bay', 'Clay', 'Duval', 'Marion', 'Monroe', 'Okaloosa', 'Putnam', 'Santa Rosa', 'St. Johns', 'Suwanee', 'Walton') then region='North Florida';
	if county in ('Broward', 'Collier', 'Lee', 'Martin', 'Miami-Dade', 'Palm Beach', 'sarasota', 'St. Lucie') then region='South Florida';
/* cleanup of hptype_v3 variable */
	if hptype_v3=1 then havehp='Yes'; 
/* cleanup of dept_size variable */
	if dept_name='Cape Coral fire dept.' then dept_size=2; 
/* cleaning up 'assignment' variable by creating new 'occupational role' variable */
	if assignment in (1 2 3 4) then occu_role=1; * 1 = Chief ; 
	else if assignment in (5) then occu_role=2; * 2 = Lieutenant ; 
	else if assignment in (6 7 8) then occu_role=3; * 3 = Captain ; 
	else if assignment in (12 13) then occu_role=4; * 4 = Emergency Medical Technician/Paramedic ; 
	else if assignment in (14) then occu_role=5; * 5 = Health & Safety Officer ; 
	else occu_role=6; * 6 = Other ; 	
run; 

******************
OUTCOME VARIABLES 
******************;	

proc format; value comply_ynf 0='Non-Adherence' 1='Met Standard'; run;

data ac.fast_compliance; 
set ac.fast_outcomes;
/* creation of adherence score variable: scored 1-5 */
	if hfc='No' then hfc_num=0; if hfc='Yes' then hfc_num=1;
	if physical='Never' then physical_num=0; if physical in ('Every 3-4 Years', 'Every 2 Years', 'Every Year') then physical_num=1;
	if fitprog='No' then fitprog_num=0; if fitprog='Yes' then fitprog_num=1; 
	if healthed='Never' then healthed_num=0; if healthed in ('Rarely', 'Occasionally', 'Frequently') then healthed_num=1;  
	if fitfile='No' then fitfile_num=0; if fitfile='Yes' then fitfile_num=1; 
	compliance = sum(hfc_num, physical_num, fitprog_num, healthed_num, fitfile_num); 
/* creation of adherence binary variable (0 vs 1) */
	if compliance<3 then compliance_binary=0; 
	if compliance>=3 then compliance_binary=1;
/* creation of adherence level variable (low, medium, high) */
	if compliance in (0,1) then adhere_level=0; * 0 = Low;
	if compliance in (2,3) then adhere_level=1; * 1 = Medium;
	if compliance in (4,5) then adhere_level=2; * 2 = High; 
run; 

proc export data=ac.fast_compliance outfile='/folders/myfolders/MSPH Thesis/fastc_compliance_final.xlsx' dbms=xlsx replace; run; 

*********************************************************************************************************************************;


