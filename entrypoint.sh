#!/bin/bash
###############################################################################################
# ARGUMENTS
###############################################################################################
INFLUXDB_ENDPOINT=$1
INFLUXDB_PORT=$2

###############################################################################################
# COLLECTD PLUGINS AND SETTINGS
###############################################################################################
rm -rf /opt/collectd/etc/collectd.conf

echo "LoadPlugin logfile" >> /opt/collectd/etc/collectd.conf
echo "<Plugin logfile>" >> /opt/collectd/etc/collectd.conf
echo "    LogLevel \"info\"" >> /opt/collectd/etc/collectd.conf
echo "    File \"/tmp/collectd.log\"" >> /opt/collectd/etc/collectd.conf
echo "    Timestamp true" >> /opt/collectd/etc/collectd.conf
echo "    PrintSeverity true" >> /opt/collectd/etc/collectd.conf
echo "</Plugin>" >> /opt/collectd/etc/collectd.conf

echo "LoadPlugin cpu" >> /opt/collectd/etc/collectd.conf
echo "<Plugin cpu>" >> /opt/collectd/etc/collectd.conf
echo "    ReportByCpu true" >> /opt/collectd/etc/collectd.conf
echo "    ReportByState true" >> /opt/collectd/etc/collectd.conf
echo "    ValuesPercentage true" >> /opt/collectd/etc/collectd.conf
echo "    ReportNumCpu true" >> /opt/collectd/etc/collectd.conf
echo "    ReportGuestState false" >> /opt/collectd/etc/collectd.conf
echo "    SubtractGuestState true" >> /opt/collectd/etc/collectd.conf
echo "</Plugin>" >> /opt/collectd/etc/collectd.conf

echo "LoadPlugin df" >> /opt/collectd/etc/collectd.conf
echo "<Plugin df>" >> /opt/collectd/etc/collectd.conf
echo "    IgnoreSelected true" >> /opt/collectd/etc/collectd.conf
echo "    ReportInodes true" >> /opt/collectd/etc/collectd.conf
echo "</Plugin>" >> /opt/collectd/etc/collectd.conf

echo "LoadPlugin disk" >> /opt/collectd/etc/collectd.conf

echo "LoadPlugin interface" >> /opt/collectd/etc/collectd.conf

echo "LoadPlugin load" >> /opt/collectd/etc/collectd.conf

echo "LoadPlugin memory" >> /opt/collectd/etc/collectd.conf

echo "LoadPlugin network" >> /opt/collectd/etc/collectd.conf
echo "<Plugin network>" >> /opt/collectd/etc/collectd.conf
echo "    Server \"$INFLUXDB_ENDPOINT\" \"$INFLUXDB_PORT\"" >> /opt/collectd/etc/collectd.conf
echo "    <Server \"$INFLUXDB_ENDPOINT\" \"$INFLUXDB_PORT\">" >> /opt/collectd/etc/collectd.conf
echo "        ResolveInterval 14400" >> /opt/collectd/etc/collectd.conf
echo "    </Server>" >> /opt/collectd/etc/collectd.conf
echo "    TimeToLive 128" >> /opt/collectd/etc/collectd.conf
echo "    ReportStats true" >> /opt/collectd/etc/collectd.conf
echo "    MaxPacketSize 1452" >> /opt/collectd/etc/collectd.conf
echo "</Plugin>" >> /opt/collectd/etc/collectd.conf

###############################################################################################
# START COLLECTD
###############################################################################################
cat /opt/collectd/etc/collectd.conf
/opt/collectd/sbin/collectd
tail -f /tmp/collectd.log