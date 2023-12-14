clc;
clear all;

FOLDER_PATH                 = pwd;
MAPSHED_OUTPUT_FOLDER       = strcat(FOLDER_PATH, '\MAPSHED_OUTPUT\SUB_001');
C_FILENAME					= 'cdt_kol001';
CEQUAL_C_INPUT_FOLDER		= strcat(FOLDER_PATH, '\CEQUAL_INPUT\C_FILES');
READ_MAPSHED_OUTPUT_FOLDER  = dir(strcat(MAPSHED_OUTPUT_FOLDER, '\*.csv'));
READ_MAPSHED_OUTPUT_FILE    = {READ_MAPSHED_OUTPUT_FOLDER(:).name}.';

cd(MAPSHED_OUTPUT_FOLDER) 
MAPSHED_OUTPUT_DATA         = readtable(READ_MAPSHED_OUTPUT_FILE{1});
cd(FOLDER_PATH)

fprintf('MAPSHED OUTPUT DOSYASI OKUNDU ...\n');

JDAY                        = transpose(1:(height(MAPSHED_OUTPUT_DATA)));
ROWS                        = height(MAPSHED_OUTPUT_DATA);

%KONSANTRASYON DOSYASI
C_DATA_FIRST_2_ROWS = cell(2,24);
C_DATA_FIRST_2_ROWS(1,1) = cellstr(strcat('$ [', C_FILENAME, '] [2015 - 2048]'));
C_DATA_FIRST_2_ROWS(2,1) = cellstr(strcat('$ [', C_FILENAME, ']'));

%---AMMONIUM----
C_NH4_N_DATA 		= MAPSHED_OUTPUT_DATA(:, {'Date', 'TN_mg_L_'});
month_data 			= month(C_NH4_N_DATA.Date);

%Aylik Amonyum/Toplam Azot oranlari
monthly_TN_TO_NH4_N_RATIO     = containers.Map('KeyType', 'int64', 'ValueType', 'double');
monthly_TN_TO_NH4_N_RATIO(1)  = 0.02;
monthly_TN_TO_NH4_N_RATIO(2)  = 0.00;
monthly_TN_TO_NH4_N_RATIO(3)  = 0.02;
monthly_TN_TO_NH4_N_RATIO(4)  = 0.00;
monthly_TN_TO_NH4_N_RATIO(5)  = 0.01;
monthly_TN_TO_NH4_N_RATIO(6)  = 0.01;
monthly_TN_TO_NH4_N_RATIO(7)  = 0.02;
monthly_TN_TO_NH4_N_RATIO(8)  = 0.00;
monthly_TN_TO_NH4_N_RATIO(9)  = 0.02;
monthly_TN_TO_NH4_N_RATIO(10) = 0.00;
monthly_TN_TO_NH4_N_RATIO(11) = 0.02;
monthly_TN_TO_NH4_N_RATIO(12) = 0.00;

C_NH4_N_DATA = zeros(length(month_data), 1);
for i = 1:length(month_data)
    C_NH4_N_DATA(i) = monthly_TN_TO_NH4_N_RATIO(month_data(i));
end
C_NH4_N_DATA		= round((MAPSHED_OUTPUT_DATA.TN_mg_L_).*C_NH4_N_DATA, 4);

%----NITRATE----
C_NO3_N_DATA 		= MAPSHED_OUTPUT_DATA(:, {'Date', 'TN_mg_L_'});
month_data 			= month(C_NO3_N_DATA.Date);

%Aylik Nitrat/Toplam Azot oranlari
monthly_TN_TO_NO3_N_RATIO     = containers.Map('KeyType', 'int64', 'ValueType', 'double');
monthly_TN_TO_NO3_N_RATIO(1)  = 0.04;
monthly_TN_TO_NO3_N_RATIO(2)  = 0.82;
monthly_TN_TO_NO3_N_RATIO(3)  = 0.72;
monthly_TN_TO_NO3_N_RATIO(4)  = 0.96;
monthly_TN_TO_NO3_N_RATIO(5)  = 0.48;
monthly_TN_TO_NO3_N_RATIO(6)  = 0.78;
monthly_TN_TO_NO3_N_RATIO(7)  = 0.87;
monthly_TN_TO_NO3_N_RATIO(8)  = 0.05;
monthly_TN_TO_NO3_N_RATIO(9)  = 0.18;
monthly_TN_TO_NO3_N_RATIO(10) = 0.59;
monthly_TN_TO_NO3_N_RATIO(11) = 0.35;
monthly_TN_TO_NO3_N_RATIO(12) = 0.33;

C_NO3_N_DATA 		= zeros(length(month_data), 1);
for i = 1:length(month_data)
    C_NO3_N_DATA(i) = monthly_TN_TO_NO3_N_RATIO(month_data(i));
end
C_NO3_N_DATA		= round((MAPSHED_OUTPUT_DATA.TN_mg_L_).*C_NO3_N_DATA, 4);

%----ORGANIC NITROGEN----
C_ORG_N_DATA 		= MAPSHED_OUTPUT_DATA(:, {'Date', 'TN_mg_L_'});
month_data 			= month(C_ORG_N_DATA.Date);

%Aylik Org Azot/Toplam Azot oranlari
monthly_TN_TO_ORG_N_RATIO     = containers.Map('KeyType', 'int64', 'ValueType', 'double');
monthly_TN_TO_ORG_N_RATIO(1)  = 0.95;
monthly_TN_TO_ORG_N_RATIO(2)  = 0.18;
monthly_TN_TO_ORG_N_RATIO(3)  = 0.27;
monthly_TN_TO_ORG_N_RATIO(4)  = 0.04;
monthly_TN_TO_ORG_N_RATIO(5)  = 0.50;
monthly_TN_TO_ORG_N_RATIO(6)  = 0.21;
monthly_TN_TO_ORG_N_RATIO(7)  = 0.11;
monthly_TN_TO_ORG_N_RATIO(8)  = 0.95;
monthly_TN_TO_ORG_N_RATIO(9)  = 0.81;
monthly_TN_TO_ORG_N_RATIO(10) = 0.41;
monthly_TN_TO_ORG_N_RATIO(11) = 0.63;
monthly_TN_TO_ORG_N_RATIO(12) = 0.67;

C_ORG_N_DATA 		= zeros(length(month_data), 1);
for i = 1:length(month_data)
    C_ORG_N_DATA(i) = monthly_TN_TO_ORG_N_RATIO(month_data(i));
end
C_ORG_N_DATA		= round((MAPSHED_OUTPUT_DATA.TN_mg_L_).*C_ORG_N_DATA, 4);

%----PHOSPHATE----
C_PO4_P_DATA		= MAPSHED_OUTPUT_DATA(:, {'Date', 'TP_mg_L_'});
month_data 			= month(C_PO4_P_DATA.Date);

%Aylik Fosfat/Toplam fosfor oranlari
monthly_TP_TO_PO4_P_RATIO     = containers.Map('KeyType', 'int64', 'ValueType', 'double');
monthly_TP_TO_PO4_P_RATIO(1)  = 0.00;
monthly_TP_TO_PO4_P_RATIO(2)  = 0.00;
monthly_TP_TO_PO4_P_RATIO(3)  = 0.00;
monthly_TP_TO_PO4_P_RATIO(4)  = 0.37;
monthly_TP_TO_PO4_P_RATIO(5)  = 0.00;
monthly_TP_TO_PO4_P_RATIO(6)  = 0.55;
monthly_TP_TO_PO4_P_RATIO(7)  = 0.06;
monthly_TP_TO_PO4_P_RATIO(8)  = 0.18;
monthly_TP_TO_PO4_P_RATIO(9)  = 1.00;
monthly_TP_TO_PO4_P_RATIO(10) = 0.50;
monthly_TP_TO_PO4_P_RATIO(11) = 0.00;
monthly_TP_TO_PO4_P_RATIO(12) = 0.00;

C_PO4_P_DATA 		= zeros(length(month_data), 1);
for i = 1:length(month_data)
    C_PO4_P_DATA(i) = monthly_TP_TO_PO4_P_RATIO(month_data(i));
end
C_PO4_P_DATA 		= round((MAPSHED_OUTPUT_DATA.TP_mg_L_).*C_PO4_P_DATA, 4);

%----ORG PHOSPHOROUS----
C_ORG_P_DATA		= MAPSHED_OUTPUT_DATA(:, {'Date', 'TP_mg_L_'});
month_data 			= month(C_ORG_P_DATA.Date);

%Aylik Org P/Toplam fosfor oranlari
monthly_TP_TO_ORG_P_RATIO     = containers.Map('KeyType', 'int64', 'ValueType', 'double');
monthly_TP_TO_ORG_P_RATIO(1)  = 1.00;
monthly_TP_TO_ORG_P_RATIO(2)  = 1.00;
monthly_TP_TO_ORG_P_RATIO(3)  = 1.00;
monthly_TP_TO_ORG_P_RATIO(4)  = 0.63;
monthly_TP_TO_ORG_P_RATIO(5)  = 1.00;
monthly_TP_TO_ORG_P_RATIO(6)  = 0.45;
monthly_TP_TO_ORG_P_RATIO(7)  = 0.94;
monthly_TP_TO_ORG_P_RATIO(8)  = 0.82;
monthly_TP_TO_ORG_P_RATIO(9)  = 0.00;
monthly_TP_TO_ORG_P_RATIO(10) = 0.50;
monthly_TP_TO_ORG_P_RATIO(11) = 1.00;
monthly_TP_TO_ORG_P_RATIO(12) = 1.00;

C_ORG_P_DATA 		= zeros(length(month_data), 1);
for i = 1:length(month_data)
    C_ORG_P_DATA(i) = monthly_TP_TO_ORG_P_RATIO(month_data(i));
end
C_ORG_P_DATA		= round((MAPSHED_OUTPUT_DATA.TP_mg_L_).*C_ORG_P_DATA, 4);

C_TDS_DATA			= zeros(ROWS, 1)+500;

cd(CEQUAL_C_INPUT_FOLDER)

NEW_C_DATA 				= readcell([C_FILENAME '.csv']);
NEW_C_DATA(1:2,:) 		= C_DATA_FIRST_2_ROWS;
NEW_C_DATA(4:end, 3) 	= num2cell(C_PO4_P_DATA);
NEW_C_DATA(4:end, 4) 	= num2cell(C_NH4_N_DATA);
NEW_C_DATA(4:end, 5) 	= num2cell(C_NO3_N_DATA);
NEW_C_DATA(4:end, 11) 	= num2cell(C_ORG_P_DATA);
NEW_C_DATA(4:end, 12) 	= num2cell(C_ORG_N_DATA);

fprintf([C_FILENAME ' DOSYASI YAZILIYOR ...\n']);
writecell(NEW_C_DATA, [C_FILENAME '.csv']);
fprintf([C_FILENAME ' DOSYASI YAZILDI ...\n']);
cd(FOLDER_PATH)

%DEBI DOSYASI
Q_FILENAME					= 'qdt_kol001';
CEQUAL_Q_INPUT_FOLDER		= strcat(FOLDER_PATH, '\CEQUAL_INPUT\Q_FILES');
Q_DATA_FIRST_3_ROWS 		= cell(3,2);
Q_DATA_FIRST_3_ROWS(1,1)	= cellstr(strcat('$ [', Q_FILENAME, '] [2015 - 2048]'));
Q_DATA_FIRST_3_ROWS(2,1)	= cellstr(strcat('$ [', Q_FILENAME, ']'));
Q_DATA_FIRST_3_ROWS(3,1)	= cellstr('JDAY');
Q_DATA_FIRST_3_ROWS(3,2)	= cellstr('Q (M3/S)');
Q_DATA						= [JDAY round(((MAPSHED_OUTPUT_DATA.DailyFlow_m_3_)./86400), 4)];
NEW_Q_DATA					= [Q_DATA_FIRST_3_ROWS; num2cell(Q_DATA)];
cd(CEQUAL_Q_INPUT_FOLDER)

fprintf([Q_FILENAME ' DOSYASI YAZILIYOR ...\n']);
writecell(NEW_Q_DATA, [Q_FILENAME '.csv']);
fprintf([Q_FILENAME ' DOSYASI YAZILDI ...\n']);
cd(FOLDER_PATH)

%---------------------------------------------------------------------------------------

MAPSHED_OUTPUT_FOLDER       = strcat(FOLDER_PATH, '\MAPSHED_OUTPUT\SUB_002');
C_FILENAME					= 'cin_kol001_seg002_sub002';
CEQUAL_C_INPUT_FOLDER		= strcat(FOLDER_PATH, '\CEQUAL_INPUT\C_FILES');
READ_MAPSHED_OUTPUT_FOLDER  = dir(strcat(MAPSHED_OUTPUT_FOLDER, '\*.csv'));
READ_MAPSHED_OUTPUT_FILE    = {READ_MAPSHED_OUTPUT_FOLDER(:).name}.';

cd(MAPSHED_OUTPUT_FOLDER) 
MAPSHED_OUTPUT_DATA         = readtable(READ_MAPSHED_OUTPUT_FILE{1});
cd(FOLDER_PATH)

fprintf('MAPSHED OUTPUT DOSYASI OKUNDU ...\n');

JDAY                        = transpose(1:(height(MAPSHED_OUTPUT_DATA)));
ROWS                        = height(MAPSHED_OUTPUT_DATA);

%KONSANTRASYON DOSYASI
C_DATA_FIRST_2_ROWS = cell(2,24);
C_DATA_FIRST_2_ROWS(1,1) = cellstr(strcat('$ [', C_FILENAME, '] [2015 - 2048]'));
C_DATA_FIRST_2_ROWS(2,1) = cellstr(strcat('$ [', C_FILENAME, ']'));

%---AMMONIUM----
C_NH4_N_DATA 		= MAPSHED_OUTPUT_DATA(:, {'Date', 'TN_mg_L_'});
month_data 			= month(C_NH4_N_DATA.Date);

%Aylik Amonyum/Toplam Azot oranlari
monthly_TN_TO_NH4_N_RATIO     = containers.Map('KeyType', 'int64', 'ValueType', 'double');
monthly_TN_TO_NH4_N_RATIO(1)  = 0.02;
monthly_TN_TO_NH4_N_RATIO(2)  = 0.00;
monthly_TN_TO_NH4_N_RATIO(3)  = 0.02;
monthly_TN_TO_NH4_N_RATIO(4)  = 0.00;
monthly_TN_TO_NH4_N_RATIO(5)  = 0.01;
monthly_TN_TO_NH4_N_RATIO(6)  = 0.01;
monthly_TN_TO_NH4_N_RATIO(7)  = 0.02;
monthly_TN_TO_NH4_N_RATIO(8)  = 0.00;
monthly_TN_TO_NH4_N_RATIO(9)  = 0.02;
monthly_TN_TO_NH4_N_RATIO(10) = 0.00;
monthly_TN_TO_NH4_N_RATIO(11) = 0.02;
monthly_TN_TO_NH4_N_RATIO(12) = 0.00;

C_NH4_N_DATA = zeros(length(month_data), 1);
for i = 1:length(month_data)
    C_NH4_N_DATA(i) = monthly_TN_TO_NH4_N_RATIO(month_data(i));
end
C_NH4_N_DATA		= round((MAPSHED_OUTPUT_DATA.TN_mg_L_).*C_NH4_N_DATA, 4);

%----NITRATE----
C_NO3_N_DATA 		= MAPSHED_OUTPUT_DATA(:, {'Date', 'TN_mg_L_'});
month_data 			= month(C_NO3_N_DATA.Date);

%Aylik Nitrat/Toplam Azot oranlari
monthly_TN_TO_NO3_N_RATIO     = containers.Map('KeyType', 'int64', 'ValueType', 'double');
monthly_TN_TO_NO3_N_RATIO(1)  = 0.04;
monthly_TN_TO_NO3_N_RATIO(2)  = 0.82;
monthly_TN_TO_NO3_N_RATIO(3)  = 0.72;
monthly_TN_TO_NO3_N_RATIO(4)  = 0.96;
monthly_TN_TO_NO3_N_RATIO(5)  = 0.48;
monthly_TN_TO_NO3_N_RATIO(6)  = 0.78;
monthly_TN_TO_NO3_N_RATIO(7)  = 0.87;
monthly_TN_TO_NO3_N_RATIO(8)  = 0.05;
monthly_TN_TO_NO3_N_RATIO(9)  = 0.18;
monthly_TN_TO_NO3_N_RATIO(10) = 0.59;
monthly_TN_TO_NO3_N_RATIO(11) = 0.35;
monthly_TN_TO_NO3_N_RATIO(12) = 0.33;

C_NO3_N_DATA 		= zeros(length(month_data), 1);
for i = 1:length(month_data)
    C_NO3_N_DATA(i) = monthly_TN_TO_NO3_N_RATIO(month_data(i));
end
C_NO3_N_DATA		= round((MAPSHED_OUTPUT_DATA.TN_mg_L_).*C_NO3_N_DATA, 4);

%----ORGANIC NITROGEN----
C_ORG_N_DATA 		= MAPSHED_OUTPUT_DATA(:, {'Date', 'TN_mg_L_'});
month_data 			= month(C_ORG_N_DATA.Date);

%Aylik Org Azot/Toplam Azot oranlari
monthly_TN_TO_ORG_N_RATIO     = containers.Map('KeyType', 'int64', 'ValueType', 'double');
monthly_TN_TO_ORG_N_RATIO(1)  = 0.95;
monthly_TN_TO_ORG_N_RATIO(2)  = 0.18;
monthly_TN_TO_ORG_N_RATIO(3)  = 0.27;
monthly_TN_TO_ORG_N_RATIO(4)  = 0.04;
monthly_TN_TO_ORG_N_RATIO(5)  = 0.50;
monthly_TN_TO_ORG_N_RATIO(6)  = 0.21;
monthly_TN_TO_ORG_N_RATIO(7)  = 0.11;
monthly_TN_TO_ORG_N_RATIO(8)  = 0.95;
monthly_TN_TO_ORG_N_RATIO(9)  = 0.81;
monthly_TN_TO_ORG_N_RATIO(10) = 0.41;
monthly_TN_TO_ORG_N_RATIO(11) = 0.63;
monthly_TN_TO_ORG_N_RATIO(12) = 0.67;

C_ORG_N_DATA 		= zeros(length(month_data), 1);
for i = 1:length(month_data)
    C_ORG_N_DATA(i) = monthly_TN_TO_ORG_N_RATIO(month_data(i));
end
C_ORG_N_DATA		= round((MAPSHED_OUTPUT_DATA.TN_mg_L_).*C_ORG_N_DATA, 4);

%----PHOSPHATE----
C_PO4_P_DATA		= MAPSHED_OUTPUT_DATA(:, {'Date', 'TP_mg_L_'});
month_data 			= month(C_PO4_P_DATA.Date);

%Aylik Fosfat/Toplam fosfor oranlari
monthly_TP_TO_PO4_P_RATIO     = containers.Map('KeyType', 'int64', 'ValueType', 'double');
monthly_TP_TO_PO4_P_RATIO(1)  = 0.00;
monthly_TP_TO_PO4_P_RATIO(2)  = 0.00;
monthly_TP_TO_PO4_P_RATIO(3)  = 0.00;
monthly_TP_TO_PO4_P_RATIO(4)  = 0.37;
monthly_TP_TO_PO4_P_RATIO(5)  = 0.00;
monthly_TP_TO_PO4_P_RATIO(6)  = 0.55;
monthly_TP_TO_PO4_P_RATIO(7)  = 0.06;
monthly_TP_TO_PO4_P_RATIO(8)  = 0.18;
monthly_TP_TO_PO4_P_RATIO(9)  = 1.00;
monthly_TP_TO_PO4_P_RATIO(10) = 0.50;
monthly_TP_TO_PO4_P_RATIO(11) = 0.00;
monthly_TP_TO_PO4_P_RATIO(12) = 0.00;

C_PO4_P_DATA 		= zeros(length(month_data), 1);
for i = 1:length(month_data)
    C_PO4_P_DATA(i) = monthly_TP_TO_PO4_P_RATIO(month_data(i));
end
C_PO4_P_DATA 		= round((MAPSHED_OUTPUT_DATA.TP_mg_L_).*C_PO4_P_DATA, 4);

%----ORG PHOSPHOROUS----
C_ORG_P_DATA		= MAPSHED_OUTPUT_DATA(:, {'Date', 'TP_mg_L_'});
month_data 			= month(C_ORG_P_DATA.Date);

%Aylik Org P/Toplam fosfor oranlari
monthly_TP_TO_ORG_P_RATIO     = containers.Map('KeyType', 'int64', 'ValueType', 'double');
monthly_TP_TO_ORG_P_RATIO(1)  = 1.00;
monthly_TP_TO_ORG_P_RATIO(2)  = 1.00;
monthly_TP_TO_ORG_P_RATIO(3)  = 1.00;
monthly_TP_TO_ORG_P_RATIO(4)  = 0.63;
monthly_TP_TO_ORG_P_RATIO(5)  = 1.00;
monthly_TP_TO_ORG_P_RATIO(6)  = 0.45;
monthly_TP_TO_ORG_P_RATIO(7)  = 0.94;
monthly_TP_TO_ORG_P_RATIO(8)  = 0.82;
monthly_TP_TO_ORG_P_RATIO(9)  = 0.00;
monthly_TP_TO_ORG_P_RATIO(10) = 0.50;
monthly_TP_TO_ORG_P_RATIO(11) = 1.00;
monthly_TP_TO_ORG_P_RATIO(12) = 1.00;

C_ORG_P_DATA 		= zeros(length(month_data), 1);
for i = 1:length(month_data)
    C_ORG_P_DATA(i) = monthly_TP_TO_ORG_P_RATIO(month_data(i));
end
C_ORG_P_DATA		= round((MAPSHED_OUTPUT_DATA.TP_mg_L_).*C_ORG_P_DATA, 4);

C_TDS_DATA			= zeros(ROWS, 1)+500;

cd(CEQUAL_C_INPUT_FOLDER)

NEW_C_DATA 				= readcell([C_FILENAME '.csv']);
NEW_C_DATA(1:2,:) 		= C_DATA_FIRST_2_ROWS;
NEW_C_DATA(4:end, 3) 	= num2cell(C_PO4_P_DATA);
NEW_C_DATA(4:end, 4) 	= num2cell(C_NH4_N_DATA);
NEW_C_DATA(4:end, 5) 	= num2cell(C_NO3_N_DATA);
NEW_C_DATA(4:end, 11) 	= num2cell(C_ORG_P_DATA);
NEW_C_DATA(4:end, 12) 	= num2cell(C_ORG_N_DATA);

fprintf([C_FILENAME ' DOSYASI YAZILIYOR ...\n']);
writecell(NEW_C_DATA, [C_FILENAME '.csv']);
fprintf([C_FILENAME ' DOSYASI YAZILDI ...\n']);
cd(FOLDER_PATH)

%DEBI DOSYASI
Q_FILENAME					= 'qin_kol001_seg002_sub002';
CEQUAL_Q_INPUT_FOLDER		= strcat(FOLDER_PATH, '\CEQUAL_INPUT\Q_FILES');
Q_DATA_FIRST_3_ROWS 		= cell(3,2);
Q_DATA_FIRST_3_ROWS(1,1)	= cellstr(strcat('$ [', Q_FILENAME, '] [2015 - 2048]'));
Q_DATA_FIRST_3_ROWS(2,1)	= cellstr(strcat('$ [', Q_FILENAME, ']'));
Q_DATA_FIRST_3_ROWS(3,1)	= cellstr('JDAY');
Q_DATA_FIRST_3_ROWS(3,2)	= cellstr('Q (M3/S)');
Q_DATA						= [JDAY round(((MAPSHED_OUTPUT_DATA.DailyFlow_m_3_)./86400), 4)];
NEW_Q_DATA					= [Q_DATA_FIRST_3_ROWS; num2cell(Q_DATA)];
cd(CEQUAL_Q_INPUT_FOLDER)

fprintf([Q_FILENAME ' DOSYASI YAZILIYOR ...\n']);
writecell(NEW_Q_DATA, [Q_FILENAME '.csv']);
fprintf([Q_FILENAME ' DOSYASI YAZILDI ...\n']);
cd(FOLDER_PATH)
