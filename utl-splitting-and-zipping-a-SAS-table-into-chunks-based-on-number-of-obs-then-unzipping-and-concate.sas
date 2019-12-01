This is useful if your email program only allows 10mb attachements                                                                       
                                                                                                                                         
 Splitting and zipping a SAS table into chunks based on numberof obs then unzipping and concatenating                                    
                                                                                                                                         
 Solution by                                                                                                                             
    Bartosz Jablonski                                                                                                                    
    yabwon@gmail.com                                                                                                                     
                                                                                                                                         
                                                                                                                                         
       a.  Split the SAS table into three parts based on the floor(number of rows/3) and zip each of the three sub-tables                
       b.  Unzip each of the three sub-tables abd concatenatate back tot he original table                                               
                                                                                                                                         
SAS-L                                                                                                                                    
https://listserv.uga.edu/cgi-bin/wa?A2=SAS-L;8a863c1e.1911e                                                                              
                                                                                                                                         
github                                                                                                                                   
                                                                                                                                         
                                                                                                                                         
*          _                   _                                                                                                         
  __ _    (_)_ __  _ __  _   _| |_                                                                                                       
 / _` |   | | '_ \| '_ \| | | | __|                                                                                                      
| (_| |_  | | | | | |_) | |_| | |_                                                                                                       
 \__,_(_) |_|_| |_| .__/ \__,_|\__|                                                                                                      
                  |_|                                                                                                                    
;                                                                                                                                        
                                                                                                                                         
/* table to be split */                                                                                                                  
                                                                                                                                         
%let file2split = zipcode;                                                                                                               
%let numberOfSplits = 3;                                                                                                                 
                                                                                                                                         
data &file2split;                                                                                                                        
set                                                                                                                                      
  sashelp.zipcode;                                                                                                                       
run;quit;                                                                                                                                
                                                                                                                                         
work.zipcode                                                                                                                             
                                                                                                                                         
/* create a folder for sub-tables and zipped sub-tables.                                                                                 
options dlcreatedir;                                                                                                                     
libname for_zip "%sysfunc(pathname(work))/for_zip";                                                                                      
                                                                                                                                         
*                      _               _                                                                                                 
  __ _      ___  _   _| |_ _ __  _   _| |_                                                                                               
 / _` |    / _ \| | | | __| '_ \| | | | __|                                                                                              
| (_| |_  | (_) | |_| | |_| |_) | |_| | |_                                                                                               
 \__,_(_)  \___/ \__,_|\__| .__/ \__,_|\__|                                                                                              
                          |_|                                                                                                            
;                                                                                                                                        
                                                                                                                                         
Note we built a folder in the work library                                                                                               
                                                                                                                                         
     d:/_TD4996_BEAST-PC_/for_zip                                                                                                        
                                                                                                                                         
        part1.sas7bdat    * subtables                                                                                                    
        part2.sas7bdat                                                                                                                   
        part3.sas7bdat                                                                                                                   
                                                                                                                                         
        part1.zip          * zipped subtables                                                                                            
        part2.zip                                                                                                                        
        part3.zip                                                                                                                        
                                                                                                                                         
        macro variable n                                                                                                                 
                                                                                                                                         
        %put &=n;                                                                                                                        
                                                                                                                                         
        N=3                                                                                                                              
                                                                                                                                         
*_        _                   _                                                                                                          
| |__    (_)_ __  _ __  _   _| |_                                                                                                        
| '_ \   | | '_ \| '_ \| | | | __|                                                                                                       
| |_) |  | | | | | |_) | |_| | |_                                                                                                        
|_.__(_) |_|_| |_| .__/ \__,_|\__|                                                                                                       
                 |_|                                                                                                                     
;                                                                                                                                        
    Output from a.                                                                                                                       
                                                                                                                                         
    d:/_TDXXXX_BEAST-PC_/for_zip                                                                                                         
                                                                                                                                         
        part1.zip          * zipped subtables                                                                                            
        part2.zip                                                                                                                        
        part3.zip                                                                                                                        
                                                                                                                                         
*_                    _               _                                                                                                  
| |__      ___  _   _| |_ _ __  _   _| |_                                                                                                
| '_ \    / _ \| | | | __| '_ \| | | | __|                                                                                               
| |_) |  | (_) | |_| | |_| |_) | |_| | |_                                                                                                
|_.__(_)  \___/ \__,_|\__| .__/ \__,_|\__|                                                                                               
                         |_|                                                                                                             
;                                                                                                                                        
                                                                                                                                         
   d:/_TDXXXX_BEAST-PC_/for_zip                                                                                                          
                                                                                                                                         
       zipcode.sas7bdat                                                                                                                  
                                                                                                                                         
*                                                                                                                                        
  __ _     _ __  _ __ ___   ___ ___  ___ ___                                                                                             
 / _` |   | '_ \| '__/ _ \ / __/ _ \/ __/ __|                                                                                            
| (_| |_  | |_) | | | (_) | (_|  __/\__ \__ \                                                                                            
 \__,_(_) | .__/|_|  \___/ \___\___||___/___/                                                                                            
          |_|                                                                                                                            
;                                                                                                                                        
                                                                                                                                         
%let file2split = zipcode;                                                                                                               
%let numberOfSplits = 3;                                                                                                                 
                                                                                                                                         
data &file2split;                                                                                                                        
set                                                                                                                                      
  sashelp.zipcode;                                                                                                                       
run;quit;                                                                                                                                
                                                                                                                                         
/* create a folder for sub-tables and zipped sub-tables */                                                                               
options dlcreatedir;                                                                                                                     
libname for_zip "%sysfunc(pathname(work))/for_zip";                                                                                      
                                                                                                                                         
                                                                                                                                         
data _null_;                                                                                                                             
  if 0 then set &file2split. nobs=nobs;                                                                                                  
  declare hash H(dataset:"&file2split.(obs=0)", multidata:"yes");                                                                        
  _RC_ = H.defineKey(all:"YES");                                                                                                         
  _RC_ = H.defineDone();                                                                                                                 
                                                                                                                                         
  do until(EOF);                                                                                                                         
    set &file2split. end=EOF curobs=curobs;                                                                                              
    _RC_ = H.add();                                                                                                                      
                                                                                                                                         
    if EOF or mod(curobs,ceil(nobs/&numberOfSplits.))=0 then                                                                             
      do;                                                                                                                                
        n+1;                                                                                                                             
        _RC_ = H.output(dataset:cats("for_zip.part",n));                                                                                 
        _RC_ = filename("F", cats(pathname("for_zip"),"/part",n,".zip"), "ZIP", cats("member='","part",n,".sas7bdat' recfm=n"));         
        _RC_ = filename("G", cats(pathname("for_zip"),"/part",n,".sas7bdat"), "DISK", "recfm=n");                                        
                                                                                                                                         
        if FEXIST('F') then _RC_ = fdelete('F');                                                                                         
        _RC_ = fcopy('G', 'F');                                                                                                          
        _RC_ = fdelete('G');                                                                                                             
                                                                                                                                         
        _RC_ = filename("F");                                                                                                            
        _RC_ = filename("G");                                                                                                            
        _RC_ = H.clear();                                                                                                                
      end;                                                                                                                               
  end;                                                                                                                                   
call symputX("n",n,"g");                                                                                                                 
stop;                                                                                                                                    
output;                                                                                                                                  
run;                                                                                                                                     
                                                                                                                                         
%put &=n;                                                                                                                                
                                                                                                                                         
*_                                                                                                                                       
| |__   _ __  _ __ ___   ___ ___  ___ ___                                                                                                
| '_ \ | '_ \| '__/ _ \ / __/ _ \/ __/ __|                                                                                               
| |_) || |_) | | | (_) | (_|  __/\__ \__ \                                                                                               
|_.__(_) .__/|_|  \___/ \___\___||___/___/                                                                                               
       |_|                                                                                                                               
;                                                                                                                                        
/*                                                                                                                                       
send created zip files by email;                                                                                                         
*/                                                                                                                                       
                                                                                                                                         
/* DESTINATION: */                                                                                                                       
/* location of zipped files on the destination */                                                                                        
libname for_zip "%sysfunc(pathname(work))/for_zip";                                                                                      
data _null_;                                                                                                                             
  do n = 1 to &n.;                                                                                                                       
    _RC_ = filename("F", cats(pathname("for_zip"),"/part",n,".zip"), "ZIP", cats("member='","part",n,".sas7bdat","' recfm=n lrecl=1"));  
    _RC_ = filename("G", cats(pathname("for_zip"),"/part",n,".sas7bdat"), "DISK", "recfm=n lrecl=1");                                    
                                                                                                                                         
    if FEXIST('G') then _RC_ = fdelete('G');                                                                                             
    _RC_ = fcopy('F', 'G');                                                                                                              
    /*_RC_ = fdelete('G');*/                                                                                                             
                                                                                                                                         
    _RC_ = filename("F");                                                                                                                
    _RC_ = filename("G");                                                                                                                
 end;                                                                                                                                    
stop;                                                                                                                                    
output;                                                                                                                                  
run;                                                                                                                                     
                                                                                                                                         
data for_zip.&file2split. / view = for_zip.&file2split.;                                                                                 
  set for_zip.part:;                                                                                                                     
run;                                                                                                                                     
                                                                                                                                         
                                                                                                                                         
proc print data=for_zip.part3(obs=10);                                                                                                   
run;quit;                                                                                                                                
                                                                                                                                         
                                                                                                                                         
                                                                                                                                         
                                                                                                                                         
                                                                                                                                         
