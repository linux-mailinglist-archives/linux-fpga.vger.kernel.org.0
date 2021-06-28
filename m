Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 411FB3B5C61
	for <lists+linux-fpga@lfdr.de>; Mon, 28 Jun 2021 12:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbhF1KUU (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 28 Jun 2021 06:20:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61792 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232628AbhF1KUT (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 28 Jun 2021 06:20:19 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15SA6FdZ021485;
        Mon, 28 Jun 2021 06:17:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=sXZdoLvBk+fNTtJpTtUX4MKouU0H3cFHvZFshe/wFbE=;
 b=PNFDmJnhJNIN2yJRpC2Qu8qSGShRLpJ+b8GSq2n4VYloUdnD1DS92FIX4p5G6cUaIffl
 TTCrvWzND8SfjqlEUwfIGDJEOAGK3ep+bBWi5FPhgabiglfRj8XnF9GDHgzMc0Eg8b4i
 QQOEMldUqFb+eGdS0B15M/1wz4RlQJa1vTPR+kLbRVSOw9BvykCwx5XY/L+fRw2n2TcB
 8PeLMW/Zy1rYM5z0f+rDTnluJj2KxZDzlJ0vvUDQLZsC/H+rIHTkz42JMXvfs6Rpj2be
 fxsfIg0VlvgLJ6oEEcQOgO/ZQC2LJOzwk5z7Wl4krYzFbH6l5Mi3Rq1Gen3Dz4tpK20e yQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39fb6d2acr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 06:17:46 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15SA6ckU023350;
        Mon, 28 Jun 2021 06:17:46 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39fb6d2ac6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 06:17:46 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15SAHBBd019245;
        Mon, 28 Jun 2021 10:17:44 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 39duv8gchb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 10:17:44 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15SAGAsA23200056
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 10:16:10 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00BBAAE3BC;
        Mon, 28 Jun 2021 10:17:40 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47AC1AE454;
        Mon, 28 Jun 2021 10:17:36 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.42.117])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 28 Jun 2021 10:17:36 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     will@kernel.org, hao.wu@intel.com, mark.rutland@arm.com
Cc:     trix@redhat.com, yilun.xu@intel.com, mdf@kernel.org,
        linux-fpga@vger.kernel.org, maddy@linux.vnet.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        rnsastry@linux.ibm.com, linux-perf-users@vger.kernel.org
Subject: [PATCH] fpga: dfl: fme: Fix cpu hotplug issue in performance reporting
Date:   Mon, 28 Jun 2021 15:47:21 +0530
Message-Id: <20210628101721.188991-1-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ALhaI1aBKmPv9rGZWQe4h5o1VwraTyfn
X-Proofpoint-ORIG-GUID: Ll6Af3jtnxqNQDGQEYB0jvWtFaxc-WaF
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-28_07:2021-06-25,2021-06-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106280070
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The performance reporting driver added cpu hotplug
feature but it didn't add pmu migration call in cpu
offline function.
This can create an issue incase the current designated
cpu being used to collect fme pmu data got offline,
as based on current code we are not migrating fme pmu to
new target cpu. Because of that perf will still try to
fetch data from that offline cpu and hence we will not
get counter data.

Patch fixed this issue by adding pmu_migrate_context call
in fme_perf_offline_cpu function.

Fixes: 724142f8c42a ("fpga: dfl: fme: add performance reporting support")
Tested-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 drivers/fpga/dfl-fme-perf.c | 4 ++++
 1 file changed, 4 insertions(+)

---
Changelog:
- Remove RFC tag
- Did nits changes on subject and commit message as suggested by Xu Yilun
- Added Tested-by tag
- Link to rfc patch: https://lkml.org/lkml/2021/6/28/112
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

