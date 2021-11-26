#!/bin/bash

fecha=`date +"%d%m%Y"`
#from="cloudtools.devops.ssgg@es.logicalis.com"
#destinatarios="cloudtools.devops.ssgg@es.logicalis.com"
subject="GRUPO_PINERO-Reporte_Diario_Openshift_$fecha"

# EJECTURA SCRIPT OCUPACION PV

. /opt/checks/report/pv-preventivo.sh

# EJECUTA SCRIPT BACKUP ETCD

. /opt/checks/report/etcd-preventivo.sh

# EJECTUA SCRIPT BACKUP VELERO

. /opt/checks/report/velero-preventivo.sh

# EJECUTA SCRIPT ESTADO NODOS

. /opt/checks/report/nodos-preventivo.sh

# EJECUTA SCRIPT ESTDO PROYECTOS

. /opt/checks/report/proyects-report.sh

echo "to: admin@example.com
cc: devopsteam@example.com
subject: Reporte $fecha
Content-Type: text/html; charset=UTF-8
<html>
<head>
<style>
table#t01 {
  width: 65%;
}
th, td {
  padding: 5px;
}
</style>
</head>
<body>
    <p>Buenos días,</p>
    <br>
    <p>Remitimos informe diario de la plataforma Openshift a fecha $fecha </p>
    <p style = " font-size:16px "> HADEV - OnPremise </p>
    <table id='t01'>
    <tr>
        <th bgcolor='#787878' align='right'><b>Check</b></th>
        <th bgcolor='#93c47d' align='left'><b> Total Ok </b></th>
        <th bgcolor='#ffd966' align='left'><b> Warning </b></th>
        <th bgcolor='#fc685d' align='left'><b> Critical </b></th>
    </tr>
    <tr>
        <td bgcolor='#F1F1F1' align='right'>Estado PVs</td>
        <td> $PV_TOTAL_OK_DEV </td>
        <td> $PV_WARNING_DEV </td>
        <td> $PV_CRITICAL_DEV </td>
    </tr>
    <tr>
        <td bgcolor='#F1F1F1' align='right'>Estado Backup ETCD</td>
        <td> $ETCD_TOTAL_OK_DEV </td>
        <td> N/A </td>
        <td> $ETCD_CRITICAL_DEV </td>
    </tr>
    <tr>
        <td bgcolor='#F1F1F1' align='right'>Estado Backup Velero</td>
        <td> N/A  </td>
        <td> N/A </td>
        <td> N/A </td>
    </tr>
    <tr>
        <td bgcolor='#F1F1F1' align='right'>Estado Nodos</td>
        <td> $NODOS_DEV_READY </td>
        <td> N/A </td>
        <td> $NODOS_DEV_CRIT </td>
    </tr>
    <tr>
        <td bgcolor='#F1F1F1' align='right'>Estado Proyectos</td>
        <td> $proy_total_DEV  </td>
        <td> N/A </td>
        <td> $proy_cont_critical_DEV </td>
    </tr>
    </table>
    <p style = " font-size:16px "> HAPRO - OnPremise </p>
    <table id='t01'>
    <tr>
        <th bgcolor='#787878' align='right'><b>Check</b></th>
        <th bgcolor='#93c47d' align='left'><b> Total Ok </b></th>
        <th bgcolor='#ffd966' align='left'><b> Warning </b></th>
        <th bgcolor='#fc685d' align='left'><b> Critical </b></th>
    </tr>
    <tr>
        <td bgcolor='#F1F1F1' align='right'>Estado PVs</td>
        <td> $PV_TOTAL_OK_PROD </td>
        <td> $PV_WARNING_PROD </td>
        <td> $PV_CRITICAL_PROD </td>
    </tr>
    <tr>
        <td bgcolor='#F1F1F1' align='right'>Estado Backup ETCD</td>
        <td> $ETCD_TOTAL_OK_PROD </td>
        <td> N/A </td>
        <td> $ETCD_CRITICAL_PROD </td>
    </tr>
    <tr>
        <td bgcolor='#F1F1F1' align='right'>Estado Backup Velero</td>
        <td> N/A  </td>
        <td> N/A </td>
        <td> N/A </td>
    </tr>
    <tr>
        <td bgcolor='#F1F1F1' align='right'>Estado Nodos</td>
        <td> $NODOS_PROD_READY </td>
        <td> N/A </td>
        <td> $NODOS_PROD_CRIT </td>
    </tr>
    <tr>
        <td bgcolor='#F1F1F1' align='right'>Estado Proyectos</td>
        <td> $proy_total_PRO  </td>
        <td> N/A </td>
        <td> $proy_cont_critical_PRO </td>
    </tr>
    </table>
    <p style = " font-size:16px "> ARO - Azure </p>
    <table id='t01'>
    <tr>
        <th bgcolor='#787878' align='right'><b>Check</b></th>
        <th bgcolor='#93c47d' align='left'><b> Total Ok </b></th>
        <th bgcolor='#ffd966' align='left'><b> Warning </b></th>
        <th bgcolor='#fc685d' align='left'><b> Critical </b></th>
    </tr>
    <tr>
        <td bgcolor='#F1F1F1' align='right'>Estado PVs</td>
        <td> $PV_TOTAL_OK_ARO </td>
        <td> $PV_WARNING_ARO </td>
        <td> $PV_CRITICAL_ARO </td>
    </tr>
    <tr>
        <td bgcolor='#F1F1F1' align='right'>Estado Backup ETCD</td>
        <td> $ETCD_TOTAL_OK_ARO </td>
        <td> N/A </td>
        <td> $ETCD_CRITICAL_ARO </td>
    </tr>
    <tr>
        <td bgcolor='#F1F1F1' align='right'>Estado Backup Velero</td>
        <td> $velero_total_ok  </td>
        <td> N/A </td>
        <td> $no_backups_velero </td>
    </tr>
    <tr>
        <td bgcolor='#F1F1F1' align='right'>Estado Nodos</td>
        <td> $NODOS_ARO_READY </td>
        <td> N/A </td>
        <td> $NODOS_ARO_CRIT </td>
    </tr>
    <tr>
        <td bgcolor='#F1F1F1' align='right'>Estado Proyectos</td>
        <td> $proy_total_ARO  </td>
        <td> N/A </td>
        <td> $proy_cont_critical_ARO </td>
    </tr>
    </table>
    <br>
    <p>Un Saludo.</p>
    <br>
    <br>
<pre>
<font face="arial" size="2" color="#fc1403"><b>
DevOps - Team</b><font size=2>
</font>
</pre>
</body>
</html> " > /opt/checks/report/reporte.html

# ENVIO CORREO

/bin/cat /opt/checks/report/reporte.html | /usr/sbin/sendmail -t

#rm  -rf /opt/checks/report/reporte.html
