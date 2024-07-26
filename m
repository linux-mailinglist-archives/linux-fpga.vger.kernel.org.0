Return-Path: <linux-fpga+bounces-580-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A221493CE3E
	for <lists+linux-fpga@lfdr.de>; Fri, 26 Jul 2024 08:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59646281E9B
	for <lists+linux-fpga@lfdr.de>; Fri, 26 Jul 2024 06:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B931F176255;
	Fri, 26 Jul 2024 06:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Z1QDBNDH"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8FF17623C;
	Fri, 26 Jul 2024 06:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721975916; cv=fail; b=kTg1HMTREYzt5kJbZSbgRrUeDGILwdKnFY4+UxBfNgqkWr9WgrAHvW8mkgJ/PM7yRIl721w+n88M+kCvhek1eQLO6m2PU32oJxZAjp571JM7IPSGsDYbCTCva0fhfeLV8Mnf+yVkEmPnWBRlL9K/tDduHqNlz+k+TkhuHfEPC6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721975916; c=relaxed/simple;
	bh=Sgpr/hyVKcBR7P41CtY1t9wzez5VMOe7KNnOkMT02ts=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c4Gv2Obxn3cyT2nqPmjsorOiqfaoFfo9faC7XTtpLrrcSTyrYCjWVozUhTp+MdH3h00KrpqpZzY9SIVVbJVCL7gZdKJyopMITwfmFdr0HHdgzF9XeQEFQzJH8g/4vvt2okm3qzfotNk7bCKLgsTmtUlsLQeMs0ANq7Yb9PCK1dA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Z1QDBNDH; arc=fail smtp.client-ip=40.107.92.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EPVDZvx1aP/qlMgjg09wUc2d4CbgnUC1HRoMEqu37HFR5wfPpZfaRg+/mXSa23KgdGi1RdEwtedMiN743ae/rPzzIWsZyv0Pxz9xwS+Z686hGUJSX2bfwlIvpADl6gT7735KBFBS9k9whTihuvur+ULJYXcj8TIMbDimV+K/FN+qsRnfhmiqSAoqgvOCo3cEgZT+We/9gamhOUBTrO5x4vGv1RvmTAaXIqD9I5FcpEQNFnMCN2IqEhw2zgu8HUDhMAw68suxV1c+xxa5YEUpFBst49uIR+wug1W1mvFGaEPtxJB1s1Ske1TZQMEbC11TdtyTx/5GStk+BjCMvo6Pxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZXsKLEWoTvr8hcOu5eSDRuQVKyhi1C2guTTw2+ZphDk=;
 b=emwqt1buIiotCRcpZhilVBiDgw2IsZBbohrVSiHtcPWhCVXaMZ8JWnt9ul0VoXc4Qg59UgodgbfsAX4vLj0e3hiRV+klqcw6++4UNTOBWAGjzFtfRL4oeMIACak44zplSCkfscHMteUN/RbaNNV8ehPk59i3QlCHBJNX5SULhpComNcP5Wx4/yirDhygIUXZZTN1TKy07QLbe5HjMEqHyYDcYlkccUoEWVfGG79QeazfPGUd1osZDdOGp/7nHyJ94Qn/wCmF9QZCLAQNOd0GYd2HBk6pRbd7MvwYXwhGyMt7KzoqTOxTzGbxIctDLIIAK/WjSAj2Tbipno9/+X8DcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXsKLEWoTvr8hcOu5eSDRuQVKyhi1C2guTTw2+ZphDk=;
 b=Z1QDBNDHMXSzsMtBYvGVtnD4+jFPBByhXiqwCovZ/euzgc7HDVa90TFlgYRpYrMDZUZ2mFOKXAmHI7U3mIVzdL3nQPaP13SXBDJ0hMvbImfXjel/aJI1HEwk54KC+j/hEpbhb+MxWzexFeiPfjO2n+DZsskk91bEkh2OyZArqP4=
Received: from BN1PR13CA0007.namprd13.prod.outlook.com (2603:10b6:408:e2::12)
 by SJ0PR12MB8091.namprd12.prod.outlook.com (2603:10b6:a03:4d5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Fri, 26 Jul
 2024 06:38:30 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:408:e2:cafe::3d) by BN1PR13CA0007.outlook.office365.com
 (2603:10b6:408:e2::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28 via Frontend
 Transport; Fri, 26 Jul 2024 06:38:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Fri, 26 Jul 2024 06:38:29 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 26 Jul
 2024 01:38:25 -0500
From: Nava kishore Manne <nava.kishore.manne@amd.com>
To: <git@amd.com>, <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
	<trix@redhat.com>, <robh@kernel.org>, <saravanak@google.com>,
	<linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: [RFC 1/1] of-fpga-region: Add sysfs interface support for FPGA configuration
Date: Fri, 26 Jul 2024 12:08:19 +0530
Message-ID: <20240726063819.2274324-2-nava.kishore.manne@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240726063819.2274324-1-nava.kishore.manne@amd.com>
References: <20240726063819.2274324-1-nava.kishore.manne@amd.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|SJ0PR12MB8091:EE_
X-MS-Office365-Filtering-Correlation-Id: 06a36750-6609-41a1-2db8-08dcad3d8fc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wQN9EVmDSBxZvIJAdCBCO17DfZPRrUKdSyMXsQULKcAXtmh0JmhhKbqS7k3I?=
 =?us-ascii?Q?V8qUaUdiUDbKK/duTPDWP9x4KgWyS6jJAHV7nlTmt4R4FLx6AVt4U0LwVolx?=
 =?us-ascii?Q?Tx+AepnmtjQuVTl/C8NQz0chyzXx16TulWNkUzWjVH1bnGsNnMdXz4z62+8j?=
 =?us-ascii?Q?KlCrkj3XHVRcZ1KeDLQ4P13juX4V69kmp96LSBreKK8tJEO01TTUbcfyO7z9?=
 =?us-ascii?Q?9CfkpVoQyi2N4FX+IDeE9oJy3NfTjF2vhX75dx3YIIyECGjWATqWO7AxwAmf?=
 =?us-ascii?Q?ZTt5j2FagMCvwM+3FsxhHvKWqVVdOq3bfP0HnNXJ1xA0BeAdTumBh/+djv1j?=
 =?us-ascii?Q?KvnJW50Bwx3wWpLrzlxV/HOcp/lATQWePuf0kdJiF8HiGyCrGUd3vmCVvT3X?=
 =?us-ascii?Q?oSzsZNr3QZHjFrc2z2McRTQDRAz1csXbR194s9D+NMZspXeLOynYafrIfVAf?=
 =?us-ascii?Q?pC1/P8fUPtim9oVmHZEin9m+lnlL/aSLAPDTnY6acr7y6uLvIwwdyYiaV3Vu?=
 =?us-ascii?Q?1Hcece62XB11xpG+tWrQES0VwE881ocZIxBguclvC9X7etpxuMeO7a0pG6c7?=
 =?us-ascii?Q?xiN+jcHN9mdMsmZpv8nTHQWZPRdqAS3h24dj33cyR+RlbkR9AYraEzviU8/U?=
 =?us-ascii?Q?JWTbogHD1LkA3QWh0z2o0kUHiJ52D8O2+NcRRa6DERKJ5cshmq1O3IieUB9x?=
 =?us-ascii?Q?pq426vfN0gTxlfRsktDa6AfNsl6Q7TW28qr9Y5TdAcLap52NR6MjqVc8JRW6?=
 =?us-ascii?Q?CF7cKttEjuf0oaT1WOcO1H9H9oSkqQHvGFt/J+8RdmDXY6v2oSZqOXeMzg8/?=
 =?us-ascii?Q?7yjcjrH+jkYiveQcVLn5o5hY5OIjqkgpdxSALMevVdWB7qhCPpX5OOrvqhP2?=
 =?us-ascii?Q?SB1zjS0C/Or/P0za09UFXwxGmHg6nVs9NvMju6OGT8BdmhSTbm0bQuwqwgz3?=
 =?us-ascii?Q?GENnsFVy9aMNt6gpWwAiOR6hHXoTFEX+HAxg0GcCvgO+O3uy0NXLPpCiW/Qr?=
 =?us-ascii?Q?M4N5RTKHu91KwYtstL8E/ryvsmi3aEIco+KUG2PkZbemK1/4snsSA9zgmZHq?=
 =?us-ascii?Q?uH0NuCtnNjDKSuQqq1fTc1YMIR5dN0Dn5BwIUwubnuSGCOefSbG0l47/n8Py?=
 =?us-ascii?Q?caaT3IgEg179EHgoURZ4oBq4F1b6CxNoVjvyeUpua+cXoKkr6GUCaowKdhYk?=
 =?us-ascii?Q?UCCuLGtQ17liUwkxnZqnvWk/4nJMOylSl5uk4W3ASPAG4AA+0/Y5fXH+u4li?=
 =?us-ascii?Q?BLn2zS3dK3Gn5Dm809VVeXLNU64kZqOvbmZPM1DXlwjQ8lJNf6G5umOHc0/G?=
 =?us-ascii?Q?N/SqNGZ/PzmQq6VPkx8Nw7JEt5KkS7e5cCBtkgJMbF5JRYqxkl7zKRqxbLXi?=
 =?us-ascii?Q?P/V4xalR75oS19BVXi/T7uBdz7PmJigQ4TQ3N8IMwNUk7cOLaA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 06:38:29.4138
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a36750-6609-41a1-2db8-08dcad3d8fc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8091

Adds sysfs interface as part of the of-fpga-region. This newly added
sysfs interface uses Device Tree Overlay (DTO) files to configure/reprogram
an FPGA while an operating system is running.This solution will not change
the existing sequence When a DT overlay that targets an FPGA Region is
applied.
	- Disable appropriate FPGA bridges.
	- Program the FPGA using the FPGA manager.
	- Enable the FPGA bridges.
	- The Device Tree overlay is accepted into the live tree.
	- Child devices are populated.

When the overlay is removed, the child nodes will be removed, and the FPGA
Region will disable the bridges.

Usage:
To configure/reprogram an FPGA region:
echo "fpga.dtbo" > /sys/class/fpga_region/<region>/device/load

To remove an FPGA region:
echo "fpga.dtbo" > /sys/class/fpga_region/<region>/device/remove

To get an FPGA region status:
cat /sys/class/fpga_region/<region>/device/status

Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
---
 .../ABI/testing/sysfs-class-of-fpga-region    | 30 ++++++
 MAINTAINERS                                   |  1 +
 drivers/fpga/fpga-region.c                    |  4 +-
 drivers/fpga/of-fpga-region.c                 | 92 +++++++++++++++++++
 include/linux/fpga/fpga-region.h              | 15 +++
 5 files changed, 141 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-of-fpga-region

diff --git a/Documentation/ABI/testing/sysfs-class-of-fpga-region b/Documentation/ABI/testing/sysfs-class-of-fpga-region
new file mode 100644
index 000000000000..aeb4e3be4ff3
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-of-fpga-region
@@ -0,0 +1,30 @@
+What:		/sys/class/fpga_region/<region>/device/load
+Date:		July 2024
+KernelVersion:	6.10
+Contact:	Nava kishore Manne <nava.kishore.manne@amd.com>
+Description:	(WO) Configure/Reprogram an FPGA region.
+		It uses Device Tree Overlay (DTO) files to configurer (or)
+		reprogram an FPGA. While an operating system is running.
+		The bitstream and the relevant DTO file has to be located
+		on the appropriate firmware path, typically, /lib/firmware.
+		For example, when user pass the option "echo fpga.dtbo"	the
+		file /lib/firmware/fpga.dtbo must be present.
+
+What:		/sys/class/fpga_region/<region>/device/remove
+Date:		July 2024
+KernelVersion:	6.10
+Contact:	Nava kishore Manne <nava.kishore.manne@amd.com>
+Description:	(WO) Revert the changes added by the load interface
+		It revert and free an overlay changeset added by the load
+		interface.
+
+What:		/sys/class/fpga_region/<region>/device/status
+Date:		July 2024
+KernelVersion:	6.10
+Contact:	Nava kishore Manne <nava.kishore.manne@amd.com>
+Description:	(RO) Status of the FPGA region
+		This file is used to check the status of the FPGA region.
+		This is a list of strings for the supported status.
+
+		* applied	= FPGA is programmed and operating
+		* unapplied	= Error while programing the FPGA
diff --git a/MAINTAINERS b/MAINTAINERS
index c0a3d9e93689..384f1d6f3af9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8795,6 +8795,7 @@ L:	linux-fpga@vger.kernel.org
 S:	Maintained
 Q:	http://patchwork.kernel.org/project/linux-fpga/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga.git
+F:	Documentation/ABI/testing/sysfs-class-of-fpga-region
 F:	Documentation/devicetree/bindings/fpga/
 F:	Documentation/driver-api/fpga/
 F:	Documentation/fpga/
diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index 753cd142503e..0733db1347ea 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/of.h>
 
 static DEFINE_IDA(fpga_region_ida);
 static const struct class fpga_region_class;
@@ -192,6 +193,7 @@ struct fpga_region *
 __fpga_region_register_full(struct device *parent, const struct fpga_region_info *info,
 			    struct module *owner)
 {
+	struct device_node *np = parent->of_node;
 	struct fpga_region *region;
 	int id, ret = 0;
 
@@ -225,7 +227,7 @@ __fpga_region_register_full(struct device *parent, const struct fpga_region_info
 	region->dev.of_node = parent->of_node;
 	region->dev.id = id;
 
-	ret = dev_set_name(&region->dev, "region%d", id);
+	ret = dev_set_name(&region->dev, "%s", of_node_full_name(np));
 	if (ret)
 		goto err_remove;
 
diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index 8526a5a86f0c..edcc4c23a4b4 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -5,6 +5,7 @@
  *  Copyright (C) 2013-2016 Altera Corporation
  *  Copyright (C) 2017 Intel Corporation
  */
+#include <linux/firmware.h>
 #include <linux/fpga/fpga-bridge.h>
 #include <linux/fpga/fpga-mgr.h>
 #include <linux/fpga/fpga-region.h>
@@ -347,6 +348,7 @@ static int of_fpga_region_notify(struct notifier_block *nb,
 				 unsigned long action, void *arg)
 {
 	struct of_overlay_notify_data *nd = arg;
+	struct fpga_overlay_image_info *ovcs;
 	struct fpga_region *region;
 	int ret;
 
@@ -371,6 +373,10 @@ static int of_fpga_region_notify(struct notifier_block *nb,
 	if (!region)
 		return NOTIFY_OK;
 
+	ovcs = &region->ovcs;
+	if (!ovcs->fw)
+		return NOTIFY_STOP;
+
 	ret = 0;
 	switch (action) {
 	case OF_OVERLAY_PRE_APPLY:
@@ -394,6 +400,91 @@ static struct notifier_block fpga_region_of_nb = {
 	.notifier_call = of_fpga_region_notify,
 };
 
+static ssize_t load_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
+{
+	struct fpga_region *region = to_fpga_region(dev);
+	struct fpga_overlay_image_info *ovcs = &region->ovcs;
+	char *s;
+	int err;
+
+	/* if it's set do not allow changes */
+	if (ovcs->ovcs_id)
+		return -EPERM;
+
+	/* copy to path buffer (and make sure it's always zero terminated */
+	count = snprintf(ovcs->path, sizeof(ovcs->path) - 1, "%s", buf);
+	ovcs->path[sizeof(ovcs->path) - 1] = '\0';
+
+	/* strip trailing newlines */
+	s = ovcs->path + strlen(ovcs->path);
+	while (s > ovcs->path && *--s == '\n')
+		*s = '\0';
+
+	err = request_firmware(&ovcs->fw, ovcs->path, NULL);
+	if (err != 0)
+		goto out_err;
+
+	err = of_overlay_fdt_apply((void *)ovcs->fw->data, ovcs->fw->size,
+				   &ovcs->ovcs_id, NULL);
+	if (err < 0) {
+		pr_err("%s: Failed to create overlay (err=%d)\n",
+		       __func__, err);
+		release_firmware(ovcs->fw);
+		goto out_err;
+	}
+
+	return count;
+out_err:
+	ovcs->path[0] = '\0';
+	ovcs->ovcs_id = 0;
+	ovcs->fw = NULL;
+
+	return err;
+}
+
+static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct fpga_region *region = to_fpga_region(dev);
+	struct fpga_overlay_image_info *ovcs = &region->ovcs;
+
+	if (!ovcs->ovcs_id)
+		return -EPERM;
+
+	of_overlay_remove(&ovcs->ovcs_id);
+	release_firmware(ovcs->fw);
+
+	ovcs->path[0] = '\0';
+	ovcs->ovcs_id = 0;
+	ovcs->fw = NULL;
+
+	return count;
+}
+
+static ssize_t status_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
+{
+	struct fpga_region *region = to_fpga_region(dev);
+	struct fpga_overlay_image_info *ovcs = &region->ovcs;
+
+	return sprintf(buf, "%s\n", ovcs->ovcs_id > 0 ?
+		       "applied" : "unapplied");
+}
+
+static DEVICE_ATTR_WO(load);
+static DEVICE_ATTR_WO(remove);
+static DEVICE_ATTR_RO(status);
+
+static struct attribute *of_fpga_region_attrs[] = {
+	&dev_attr_load.attr,
+	&dev_attr_remove.attr,
+	&dev_attr_status.attr,
+	NULL,
+};
+
+ATTRIBUTE_GROUPS(of_fpga_region);
+
 static int of_fpga_region_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -440,6 +531,7 @@ static struct platform_driver of_fpga_region_driver = {
 	.driver = {
 		.name	= "of-fpga-region",
 		.of_match_table = of_match_ptr(fpga_region_of_match),
+		.dev_groups = of_fpga_region_groups,
 	},
 };
 
diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
index 5fbc05fe70a6..36143301b49b 100644
--- a/include/linux/fpga/fpga-region.h
+++ b/include/linux/fpga/fpga-region.h
@@ -9,6 +9,19 @@
 
 struct fpga_region;
 
+/**
+ * struct fpga_overlay_image_info - information specific to an FPGA Overlay
+ * image.
+ * @fw: firmware of coeff table.
+ * @path: path of FPGA overlay image firmware file.
+ * @ovcs_id: overlay changeset id.
+ */
+struct fpga_overlay_image_info {
+	const struct firmware *fw;
+	char path[PATH_MAX];
+	int ovcs_id;
+};
+
 /**
  * struct fpga_region_info - collection of parameters an FPGA Region
  * @mgr: fpga region manager
@@ -37,6 +50,7 @@ struct fpga_region_info {
  * @info: FPGA image info
  * @compat_id: FPGA region id for compatibility check.
  * @ops_owner: module containing the get_bridges function
+ * @ovcs: FPGA overlay image info
  * @priv: private data
  * @get_bridges: optional function to get bridges to a list
  */
@@ -48,6 +62,7 @@ struct fpga_region {
 	struct fpga_image_info *info;
 	struct fpga_compat_id *compat_id;
 	struct module *ops_owner;
+	struct fpga_overlay_image_info ovcs;
 	void *priv;
 	int (*get_bridges)(struct fpga_region *region);
 };
-- 
2.34.1


