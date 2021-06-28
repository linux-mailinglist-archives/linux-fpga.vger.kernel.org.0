Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9103B59A1
	for <lists+linux-fpga@lfdr.de>; Mon, 28 Jun 2021 09:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbhF1HUr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 28 Jun 2021 03:20:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30340 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229998AbhF1HUq (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 28 Jun 2021 03:20:46 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15S74Dog043820;
        Mon, 28 Jun 2021 03:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=nn0ACPMnVX/PLgpAmD7MyV871J4EE4YnQb1PU4QRyXw=;
 b=fh6ENSFmj3dhqzUguGnllZDyDlFo7EzCsp1tTO5ngeWOv7XIR45ebNT2zqJpl5rJncRJ
 UgFcRq/anE2CK03hPdMJ8Ce++PApNtb2OoLLGmK0/mCcsZP8mFHm4dQ5xbwPIARtSEwH
 XK2QqP/VMNjeE8yop6MhtTzyHYh1UWEDlASG9WctUkeAn81Hw0XCCJfmxJmx2bM7BmUk
 5o17UEfJ5bRsaRW/Iz8r/xOveaXQrJC1JO7EdmTm1eP+mG8KgJUzwD8MZQO9EeypfpCZ
 0pR9F4piZjLu8UOQFiKxyPZ83dt5mE4q/hYpAs6Vb0ZiHjNnM6zGRYOYHkh8m724+1To ng== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39f8j0t2xg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 03:18:12 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15S74L3K044337;
        Mon, 28 Jun 2021 03:18:12 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39f8j0t2wr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 03:18:12 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15S7HkT4007920;
        Mon, 28 Jun 2021 07:18:10 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04fra.de.ibm.com with ESMTP id 39duv8gb34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 07:18:09 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15S7I6Xi33358298
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 07:18:06 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 03B15520A3;
        Mon, 28 Jun 2021 07:16:03 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.85.15])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7DE20522B8;
        Mon, 28 Jun 2021 07:15:56 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     will@kernel.org, hao.wu@intel.com, mark.rutland@arm.com
Cc:     trix@redhat.com, yilun.xu@intel.com, luwei.kang@intel.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        maddy@linux.vnet.ibm.com, atrajeev@linux.vnet.ibm.com,
        kjain@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, rnsastry@linux.ibm.com
Subject: [RFC] fpga: dfl: fme: Fix cpu hotplug code
Date:   Mon, 28 Jun 2021 12:45:46 +0530
Message-Id: <20210628071546.167088-1-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GjoDKIxFLf-hkCgBFSKbtvp0JQGhIj82
X-Proofpoint-ORIG-GUID: EzjgMD5N2Ah2TPVSxKt9XScKkDCRHmp3
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-28_03:2021-06-25,2021-06-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 spamscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1011 malwarescore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106280049
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Commit 724142f8c42a ("fpga: dfl: fme: add performance
reporting support") added performance reporting support
for FPGA management engine via perf.

It also added cpu hotplug feature but it didn't add
pmu migration call in cpu offline function.
This can create an issue incase the current designated
cpu being used to collect fme pmu data got offline,
as based on current code we are not migrating fme pmu to
new target cpu. Because of that perf will still try to
fetch data from that offline cpu and hence we will not
get counter data.

Patch fixed this issue by adding pmu_migrate_context call
in fme_perf_offline_cpu function.

Fixes: 724142f8c42a ("fpga: dfl: fme: add performance reporting support")
Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 drivers/fpga/dfl-fme-perf.c | 4 ++++
 1 file changed, 4 insertions(+)

---
- This fix patch is not tested (as I don't have required environment).
  But issue mentioned in the commit msg can be re-created, by starting any
  fme_perf event and while its still running, offline current designated
  cpu pointed by cpumask file. Since current code didn't migrating pmu,
  perf gonna try getting counts from that offlined cpu and hence we will
  not get event data.
---
diff --git a/drivers/fpga/dfl-fme-perf.c b/drivers/fpga/dfl-fme-perf.c
index 4299145ef347..b9a54583e505 100644
--- a/drivers/fpga/dfl-fme-perf.c
+++ b/drivers/fpga/dfl-fme-perf.c
@@ -953,6 +953,10 @@ static int fme_perf_offline_cpu(unsigned int cpu, struct hlist_node *node)
 		return 0;
 
 	priv->cpu = target;
+
+	/* Migrate fme_perf pmu events to the new target cpu */
+	perf_pmu_migrate_context(&priv->pmu, cpu, target);
+
 	return 0;
 }
 
-- 
2.31.1

