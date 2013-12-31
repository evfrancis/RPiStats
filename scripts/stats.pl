my $mem = `free -m|sed -n 2p| awk '{print 100-\$4/\$2*100}'`;
my $cpu = `uptime`;
my $date = `date`;
my $temp = `/opt/vc/bin/vcgencmd measure_temp`;
my @disk = `df -h`;
my @disk_percents;

chomp($mem);
chomp($cpu);
chomp($date);
chomp($temp);

$date =~ s/CST//;
$date =~ s/ +/-/g;
$date =~ s/^....//;

foreach my $mount (@disk) {
    if ($mount =~ m/Backup/ or $mount =~ m/SmartWare/) {
        # Skip
    } elsif ($mount =~ m/([0-9]+)%/) {
        push(@disk_percents, $1);
    }
}

if ($temp =~ m/([0-9]+\.[0-9]+)'C/) {
    $temp = $1;
}

if ($cpu =~ m/([0-9]+\.[0-9]+)$/) {
    $cpu = $1;
}

print "$date $cpu $mem $temp @disk_percents\n";
