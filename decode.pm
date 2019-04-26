use File::Copy;

#&decode_folder('~/Documents/CARS/Database/HMDB51/HMDB51_SOVAN/');
#&decode_folder('~/Documents/CARS/Database/PETS/PETS_264_MV/');
#&decode_folder('~/Documents/CARS/Database/Moving_Object_Detection/New/cam1/');
#&decode_folder('~/Documents/CARS/Database/Weizman/Weizman_GOP30try/');
#&decode_folder('~/Documents/CARS/Database/Encoding_Try/Weizman/Weizman/');
#&decode_folder('~/Documents/CARS/Database/KTH_with_scale/');
#&decode_folder('~/Documents/CARS/Database/Weizman/Weizman_GOPmytry/');
#&decode_folder ('~/Documents/CARS/praveen/KTHexp/KTH_GOP_20');
#&decode_folder ('/home2/praveen/actionrec/KTH_variousGOPs/KTH_GOP_40');
#&decode_folder ('/home2/praveen/crowd_database');
&decode_folder ('/home2/praveen/crowd_cfsas_db');
sub decode_folder
{
	my $inPath = $_[0];
	my @files = <$inPath*.264>;
	if($#files==-1)
	{
		print "No 264 files.\n";
		@files = <$inPath*>;
		foreach $file (@files)
		{
			print $file."\n";
			&decode_folder($file.'/');
		}
	}
	else
	{
		foreach $file (@files)
		{
		#ldecod
			print $file."\n";
			copy($file,"/home/manu/Documents/CARS/Perl_Scripts/test.264");
			#system("/home/manu/Documents/CARS/softwares/JM151_naresh/bin/ldecod.exe");# QP and vidres
                               
                        system("/home/manu/Documents/CARS/softwares/JM151_naresh_for_sovan/bin/ldecod.exe");# MVx MVy and IDR
			$filename = substr($file,0,length($file)-4);
                        #print $filename."_mb_type.dat\n";
                        print $filename."\n";
                        
                        copy("/home/manu/Documents/CARS/Perl_Scripts/IDR_DUMP.dat",$filename."_IDR.dat");
                        #copy("/home/manu/Documents/CARS/Perl_Scripts/MVy_DUMP.dat",$filename."_MB_QP.dat");
                        #copy("/home/manu/Documents/CARS/Perl_Scripts/vid_res.dat",$filename."_vid_res.dat");
			
                        
                        copy("/home/manu/Documents/CARS/Perl_Scripts/MVx_DUMP.dat",$filename."_MVx.dat");
			copy("/home/manu/Documents/CARS/Perl_Scripts/MVy_DUMP.dat",$filename."_MVy.dat");

                        #copy("/home/manu/Documents/CARS/Perl_Scripts/MB_TYPE.dat",$filename."_mb_type.dat");
                        #copy("/home/manu/Documents/CARS/Perl_Scripts/MVx_DUMP.dat",$filename."_MB_size_crude.dat");
                        
			
		}
	}
}
