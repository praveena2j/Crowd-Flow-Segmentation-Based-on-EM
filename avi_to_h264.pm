use File::Copy;

#&decode_folder('/Documents/CARS/Database/Weizman/Weizman');
#&decode_folder('~/Documents/CARS/Database/Encoding_Try/Weizman/Weizman');
#&decode_folder('/home/manu/Documents/CARS/Database/Encoding_Try/KTH');
#&decode_folder ('/home2/praveen/actionrec/KTH_variousGOPs/KTH_GOP_40');
&decode_folder ('/home2/praveen/crowd_database');
sub decode_folder
{
	my $inPath = $_[0];
	my @files = <$inPath*.avi>;
	if($#files==-1)
	{
		print "No avi files.\n";
		@files = <$inPath*>;
                 
		foreach $file (@files)
		{
			print $file."\n";
                        $foldername = substr($file,30,length($file)-30);# KTH-52, Weizman-60
			&decode_folder($file.'/');
		}
	}
	else
	{
		foreach $file (@files)
		{
		        #print $file."\n";
                                
                        print $foldername."\n";
			copy($file,"/home/manu/Documents/CARS/Perl_Scripts/test.avi");

                        my $file_del = "test.yuv";
                        unlink $file_del;

                        
                        system("/home/manu/Documents/CARS/softwares/ffmpeg-1.0/ffmpeg -i test.avi test.yuv");
                       
                        $filename = substr($file,30 + length($foldername)+1,length($file) - length($foldername) - 1 -30 - 4 );

                        #$filename = substr($file,52 + length($foldername)+1,length($file) - length($foldername) - 1 -52 - 4 );# KTH-52, Weizman-60
                        print $filename."\n";
                        
                        system("x264 --profile baseline --keyint 30 --ref 1 --input-res 640x352  -o test.264 test.yuv");# KTH-160x120, Weizman-180x144,  crowd - 640x352
			#system("x264 --profile baseline --keyint 20 --ref 1 --input-res 180x144  -o test.264 test.yuv");# KTH-160x120, Weizman-180x144
                        #system("x264 --profile baseline --keyint 30 --ref 1 --input-res 720x576  -o test.264 test.yuv");
                        #system("x264 --profile baseline --keyint 30 --ref 1 --input-res 352x288  -o test.264 test.yuv");
                        #system("x264 --profile baseline --keyint 30 --ref 1 --input-res 432x288  -o test.264 test.yuv");
                        
			print $inPath.$filename.".264\n";
                        move("/home/manu/Documents/CARS/Perl_Scripts/test.264",$inPath.$filename.".264");  
                        
			
		}
	}
}
