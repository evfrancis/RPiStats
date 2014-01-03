<Title>Rasperry Pi Stats</Title>
<!-- Weclome to the RPiStats project. This site shows stats from a raspberry pi running raspbmc. 

Site Basics:
Backend:
- Gnuplot (graphing)
- Perl/Bash (data gathering)
- Crontab (automating)

Frontend:
- PHP
- HTML5/Javascript
-->
<?php 

# For use in real time stats table
$titles = array("Up", "Users", "Load<BR>(1 Min)", "Load<BR>(5 Min)", "Load<BR>(15 Min)");

$clocks = array("arm", "gpu", "core", "sdram");

# Run uptime and get parsed data in $end
$string = exec('uptime'); 
$pattern = '/up (.*),  (\d+) users?,  load average: ([0-9].[0-9]+), ([0-9].[0-9]+), ([0-9].[0-9]+)/i';
preg_match($pattern, $string, $end);

for ($i=0; $i < 4 ; $i++) {
    # Not working yet
    $string = exec("vcgencmd measure_clock $clocks[$i]");
}

?>

<html>
<script language=javascript type='text/javascript'>
function showImage(id) {
        var ctx = document.getElementById('graph').getContext('2d')
        var img = new Image;
        img.onload = function() {
                ctx.drawImage(img, 0, 0);
        };
        img.src = "data/" + id + ".png";
}
</script>

<body onload="javascript:showImage('load_24')">
    <table>
        <tr>
            <td>
                <table border=1>
                    <tr>
                        <td colspan=2 align="center"><B>Live Stats</B></td>
                    </tr>
<?php
    for ($i = 0; $i < 5; $i++) {
        # Generate real time stats table
        echo "\t\t\t<tr>\n";
        echo "\t\t\t\t<td>$titles[$i]</td>\n\t\t\t\t<td>" . $end[$i + 1] . "</td>\n";
        echo "\t\t\t</tr>\n";
    }
?>
                </table>
            </td>
            <td>
                <canvas id='graph' width='1200px' height='600px'></canvas>
            </td>
        </tr>
    <table>

    <div style="text-align:center;">
        <button onclick="javascript:showImage('load_24')">Day</button>
        <button onclick="javascript:showImage('load_168')">Week</button>
        <button onclick="javascript:showImage('load_720')">Month</button>
        <button onclick="javascript:showImage('load_8760')">Year</button>
    </div>
</body>
</html>
