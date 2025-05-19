Return-Path: <linux-fpga+bounces-1213-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF91FABB3B1
	for <lists+linux-fpga@lfdr.de>; Mon, 19 May 2025 05:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60D401722A5
	for <lists+linux-fpga@lfdr.de>; Mon, 19 May 2025 03:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F431E5B60;
	Mon, 19 May 2025 03:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D57OqcDb"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0527A2D;
	Mon, 19 May 2025 03:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747626195; cv=fail; b=McdwSiqCTMGP1y/X7g226ycNEM/Ptl1HpXCcnog9rYLWyEeNbB74iH0wRliCwsUa9IViYR7+cIEw2d7IogK+s6X88Fnx+cRD/xY+xl3yQsV82GBQH7FGcvAWDqGidMP2ajeQz5WfMYb7WdcHo/IAxzGY6JLsLg1n9yjo/+6AR0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747626195; c=relaxed/simple;
	bh=wJB+lIvCffMhfmqw3W+PJ/ZsJUmS38Iuq9Z+Dk8XZWQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qJe6d0YBJu6iCcM5xQ8VwfcyEDCRht+LBOcubkdRMYZIQAg+QcMxbsEpdELwkyP2FsJpRGauOeh4CuS8kYn7Hno1e4N4VPkTvE1aFwIiSZ0FnFNydyK00UAywxkgGz8xMlJpWZRHpqXKlA/aTipV1qM5Xd6Ho8WQm2aCq8pUdVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D57OqcDb; arc=fail smtp.client-ip=40.107.94.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lSdgTB+nkAxbLoVOdjSGRstzbeaEL3/c3/GGauSCK9oxj5nt4/HFwBY6pfcoeAoWnyW+vk5YvdOc6F8X+olNHn0hX8FvjZ4ESHjHwVYYw6A6Nrk7VOc1janaFDIqmgXxQxMgSox/55o9goSAisnw6feXXqkHmy9gZALo7toZV9/GVv6o9BjHviRJ4BYBp8z/l6Piuzg128npQ9NeMNXaa4zHj8PlYYMgOQtMsLxspLhefCC+8GCAKTW6wGrEaQ9v66LCttIYER2/h18o9Qw3075ncB8aVzBjE+5CQtro4cieABD21c3XTfZjWud5PHv/OLJTF0JCb7HCVkATN321Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xG/7w9mE904sigwSppwzQaojDMmBEl5px+hbOrGXl34=;
 b=nMW4py6PkfGxXQN0a0TfmJqprmJu+wvdDHOrPB1QUudpIZf6ZXDMy+VyEUQ3FJeHimqYQ0ircbKbP5Lgt+g09JPowUjBnZMWyDFksDEIfxlZGdx8m+6q6951p8FgBiMF40NK4xxdVpiDKyFiWakhrvn/UG+mJvwTyVk5/qlroP21avHSifRmEzSsIVGs40xS0idFs8WNBDS21SuVhv9322cdfK/T2jDHYLaBphZ4R5qre6xIhpWy4+kF1pe6QJ0kK/h6QUUuXwA1FxlpuGGSuJZpreLgXp49K4g1/L80fLmBBBeIj5fcPZVjD8MH5NagGHvdKXngPslbwyhNYTS0Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xG/7w9mE904sigwSppwzQaojDMmBEl5px+hbOrGXl34=;
 b=D57OqcDbAEiWl76+eL3Fjsqa59g80XJFhcQOiw+rQsXLkdVWiNhGQ5GvVEhuJRgHTjqtLhVuzIIIAgIShQTAC6pSmJpMaN00JAEWHw1HIFkYxsmq1iSAuOIx4oYrHAcqEO3WEqcdqqHMsoraEh0iU0dTlF2HspYPOLWndzrGC8U=
Received: from BLAPR03CA0037.namprd03.prod.outlook.com (2603:10b6:208:32d::12)
 by SJ5PPFCB5E1B8F5.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Mon, 19 May
 2025 03:43:07 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:32d:cafe::ee) by BLAPR03CA0037.outlook.office365.com
 (2603:10b6:208:32d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.30 via Frontend Transport; Mon,
 19 May 2025 03:43:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8746.27 via Frontend Transport; Mon, 19 May 2025 03:43:06 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 18 May
 2025 22:41:30 -0500
From: Nava kishore Manne <nava.kishore.manne@amd.com>
To: <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
	<trix@redhat.com>, <robh@kernel.org>, <saravanak@google.com>,
	<linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <git@amd.com>
Subject: [RFC v3 1/1] fpga-region: Introduce ConfigFS interface for runtime FPGA configuration
Date: Mon, 19 May 2025 09:09:37 +0530
Message-ID: <20250519033950.2669858-2-nava.kishore.manne@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250519033950.2669858-1-nava.kishore.manne@amd.com>
References: <20250519033950.2669858-1-nava.kishore.manne@amd.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|SJ5PPFCB5E1B8F5:EE_
X-MS-Office365-Filtering-Correlation-Id: c53dbd4c-7705-4a06-b1b2-08dd96874466
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Cq/JNnFcJ7dZ/Pe7X6j3Phg/7zhdrxOBXRCjJgGtJjNgfnedcVxEst+RFN6S?=
 =?us-ascii?Q?BdnwvVgfbwgDAqm5XaN5gxrJbf/i+ss519qTa9AT4nJqCvOcP26/g8Y8Qp89?=
 =?us-ascii?Q?B/m/h7oAa4/taoRBVZjqRl4rB3/zdj2drPpxrnd9YQNX40fCZpfdo7BzweEH?=
 =?us-ascii?Q?jvuKIA7bhAz6gR+tMcAejI3UQK2cFzXswiN/JC+Inat7X7IQzY1ue/14rQpE?=
 =?us-ascii?Q?8mM2bL1pmiAzjQlOGbv1qA1frMwckJh8Bw1Nbdq29mwkmXI0KA+wj6KfE2Tr?=
 =?us-ascii?Q?E0nSMlfi3nxw58tJP4B4wQTqS52sDWB0C+wKQH69rZAVLZNaa3i+0S1MCZKt?=
 =?us-ascii?Q?0dIGobmqivm9dSQN+aMJA91Ws/oSMTOSGHLIVQhvygxuHgO2xXp45oPJuxqt?=
 =?us-ascii?Q?4TZEf3AosfxzUdMdZQz+zoNttvyOMwdmnp5ar6uifOBzoysr1PpVVGNqHheF?=
 =?us-ascii?Q?EwuVqCYl7FNKc8gyooqOMGvhGP3qOLBcigpApiQx1H+gOn/U5JDGBJf5X2gA?=
 =?us-ascii?Q?EXWUvvMZEgqr3S0yWrekE302eGLFRBIjmzbwgszysbjWwU+n9Lr+rBG6Uwvk?=
 =?us-ascii?Q?3CgAsw4x23oOlfx6MnSvcNeJ8L7aV1B2dgSp8wlnLkQC42lc97oIuhSO11xR?=
 =?us-ascii?Q?ZvdKyxk92Q4MAl27wRq8hpmhtEvtG1BolQBI/EOhSktoXPGLcuNUgfi+IbvD?=
 =?us-ascii?Q?o26QfmJQqMiJR3gMqTBK/F2pEm0AsP55sEEffm/AhcXUJlsY0o5vI7YYD+IZ?=
 =?us-ascii?Q?pjNaKTljB3BIno1ktE2ld/ij4RyIOjsjCa9o5OIbGnnjs3WULqPjPfyjpIgt?=
 =?us-ascii?Q?8fd0FhRdA6mxIYLmsVzY/PMh8CxtE8laehyWBc13MNgGtRKF15R6L8RX5kfx?=
 =?us-ascii?Q?WV+Oh+qhdTl1aIO7mhPjAd7hSln3xTC9rOOit2XJc6Chx0dPysvp/9HBLy4x?=
 =?us-ascii?Q?OWkKxiRSqaQYMMZfoXB7YJzMiXkw/IE4ETLiIBMe2lr4JtmgrSx0piITYwRd?=
 =?us-ascii?Q?hPoPPtPyHv7vLCgvB+WGuZQUKxJUgzXGCpgzupOMCgPSfK5zroIVL9UhPc0+?=
 =?us-ascii?Q?YurmYpPAFy/pYjpxHyw0QUa3yKmV24iHtvUPsBI2dgViXZ7mx2UynWTBPleZ?=
 =?us-ascii?Q?Ed+ofHf7QhdoLn4dOOYxKzAyuq9pW4TjjAiM112+qeAyjKJQGTjW6UqbxyQe?=
 =?us-ascii?Q?ff2b3K3OcEFC2/Iftf3865/u2uuXL3yh6ULLflf4FO7kXohEHPH6LutNkCs9?=
 =?us-ascii?Q?UX/YwGKKk8DNuT6CVoBKHV9YIRGi63UCVYW6Ga3LT8zNC56zOukVKQ++hMFy?=
 =?us-ascii?Q?4X8HU4QOs6MskIGiIJ4O2C1kqzWOfg/dHOmLEyay7MoLNgLJXNVJcYfllw8M?=
 =?us-ascii?Q?/vyvtHYvshMu3Zs0RtQUFXUh8LAkuZgND/2XZ2CIZw+p60dbwck4ygYGRMP/?=
 =?us-ascii?Q?gQsQS0XwngHPOAfT9XIapjnJqpE37eMr4d1zr93ivQS/uR33IHDLUATTMD8N?=
 =?us-ascii?Q?ab9Q1JGwyk2L50Y2a2s3l9luidFh42k337uXEVmBUr8FKMtWOnE7SL9sDA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 03:43:06.8384
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c53dbd4c-7705-4a06-b1b2-08dd96874466
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFCB5E1B8F5

Introduces an ConfigFS interface within the fpga-region subsystem,
providing a generic and standardized mechanism for configuring (or)
reprogramming FPGAs during runtime. The newly added interface supports
both OF (Open Firmware) and non-OF devices, leveraging vendor-specific
callbacks (e.g., pre_config, post_config, removal, and status) to
accommodate a wide range of device specific configurations.

The ConfigFS interface ensures compatibility with both OF and non-OF
devices, allowing for seamless FPGA reprogramming across diverse
platforms.

Vendor-specific callbacks are integrated into the interface, enabling
custom FPGA pre_config, post_config, removal, and status reporting
mechanisms, ensuring flexibility for vendor implementations.

This solution enhances FPGA runtime management, supporting various device
types and vendors, while ensuring compatibility with the current FPGA
configuration flow.

Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
---
Changes for v3:
 - As discussed with Yilun, the implementation continues to use a callback-based
 approach to seamlessly support both OF (Open Firmware) and non-OF devices via
 vendor-specific hooks. Additionally, the earlier IOCTL-based interface has been
 replaced with a more suitable ConfigFS-based mechanism to enable runtime FPGA
 configuration.

Changes for v2:
 - As discussed with Yilun, the implementation has been modified to utilize a
 callback approach, enabling seamless handling of both OF and non-OF devices.

 - As suggested by Yilun in the POC code, we have moved away from using  void *args
 as a parameter for ICOTL inputs to obtain the required user inputs. Instead, we are
 utilizing the fpga_region_config_info structure to gather user inputs. Currently,
 this structure is implemented to support only OF devices, but we intend to extend
 it by incorporating new members to accommodate non-OF devices in the future.

 drivers/fpga/fpga-region.c       | 196 +++++++++++++
 drivers/fpga/of-fpga-region.c    | 474 +++++++++++++++++--------------
 include/linux/fpga/fpga-region.h |  34 +++
 3 files changed, 493 insertions(+), 211 deletions(-)

diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index 753cd142503e..d583fc22955b 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -5,6 +5,7 @@
  *  Copyright (C) 2013-2016 Altera Corporation
  *  Copyright (C) 2017 Intel Corporation
  */
+#include <linux/configfs.h>
 #include <linux/fpga/fpga-bridge.h>
 #include <linux/fpga/fpga-mgr.h>
 #include <linux/fpga/fpga-region.h>
@@ -180,6 +181,158 @@ static struct attribute *fpga_region_attrs[] = {
 };
 ATTRIBUTE_GROUPS(fpga_region);
 
+static struct fpga_region *item_to_fpga_region(struct config_item *item)
+{
+	return container_of(to_configfs_subsystem(to_config_group(item)),
+			    struct fpga_region, subsys);
+}
+
+/**
+ * fpga_region_image_store - Set firmware image name for FPGA region
+ * This function sets the firmware image name for an FPGA region through configfs.
+ * @item: Configfs item representing the FPGA region
+ * @buf: Input buffer containing the firmware image name
+ * @count: Size of the input buffer
+ *
+ * Return: Number of bytes written on success, or negative errno on failure.
+ */
+static ssize_t fpga_region_image_store(struct config_item *item, const char *buf, size_t count)
+{
+	struct fpga_region *region = item_to_fpga_region(item);
+	struct device *dev = &region->dev;
+	struct fpga_image_info *info;
+	char firmware_name[NAME_MAX];
+	char *s;
+
+	if (region->info) {
+		dev_err(dev, "Region already has already configured.\n");
+		return -EINVAL;
+	}
+
+	info = fpga_image_info_alloc(dev);
+	if (!info)
+		return -ENOMEM;
+
+	/* copy to path buffer (and make sure it's always zero terminated */
+	count = snprintf(firmware_name, sizeof(firmware_name) - 1, "%s", buf);
+	firmware_name[sizeof(firmware_name) - 1] = '\0';
+
+	/* strip trailing newlines */
+	s = firmware_name + strlen(firmware_name);
+	while (s > firmware_name && *--s == '\n')
+		*s = '\0';
+
+	region->firmware_name = devm_kstrdup(dev, firmware_name, GFP_KERNEL);
+	if (!region->firmware_name)
+		return -ENOMEM;
+
+	region->info = info;
+
+	return count;
+}
+
+/**
+ * fpga_region_config_store - Trigger FPGA configuration via configfs
+ * @item: Configfs item representing the FPGA region
+ * @buf: Input buffer containing the configuration command (expects "1" to program, "0" to remove)
+ * @count: Size of the input buffer
+ *
+ * If the input is "1", this function performs:
+ *   1. region_pre_config() (if defined)
+ *   2. Bitstream programming via fpga_region_program_fpga() (unless external config flag is set)
+ *   3. region_post_config() (if defined)
+ *
+ * If the input is "0", it triggers region_remove() (if defined).
+ *
+ * Return: Number of bytes processed on success, or negative errno on failure.
+ */
+static ssize_t fpga_region_config_store(struct config_item *item,
+					const char *buf, size_t count)
+{
+	struct fpga_region *region = item_to_fpga_region(item);
+	int config_value, ret = 0;
+
+	/* Parse input: must be "0" or "1" */
+	if (kstrtoint(buf, 10, &config_value) || (config_value != 0 && config_value != 1))
+		return -EINVAL;
+
+	/* Ensure fpga_image_info is available */
+	if (!region->info)
+		return -EINVAL;
+
+	if (config_value == 1) {
+		/* Pre-config */
+		if (region->region_ops->region_pre_config) {
+			ret = region->region_ops->region_pre_config(region);
+			if (ret)
+				return ret;
+		}
+
+		/* Program bitstream if not external */
+		if (!(region->info->flags & FPGA_MGR_EXTERNAL_CONFIG)) {
+			ret = fpga_region_program_fpga(region);
+			if (ret)
+				return ret;
+		}
+
+		/* Post-config */
+		if (region->region_ops->region_post_config) {
+			ret = region->region_ops->region_post_config(region);
+			if (ret)
+				return ret;
+		}
+
+	} else {
+		/* Remove configuration */
+		if (region->region_ops->region_remove) {
+			ret = region->region_ops->region_remove(region);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return count;
+}
+
+/* Define Attributes */
+CONFIGFS_ATTR_WO(fpga_region_, image);
+CONFIGFS_ATTR_WO(fpga_region_, config);
+
+/* Attribute List */
+static struct configfs_attribute *fpga_region_config_attrs[] = {
+	&fpga_region_attr_image,
+	&fpga_region_attr_config,
+	NULL,
+};
+
+/* ConfigFS Item Type */
+static const struct config_item_type fpga_region_item_type = {
+	.ct_attrs = fpga_region_config_attrs,
+	.ct_owner = THIS_MODULE,
+};
+
+static int fpga_region_configfs_register(struct fpga_region *region)
+{
+	struct configfs_subsystem *subsys = &region->subsys;
+
+	snprintf(subsys->su_group.cg_item.ci_namebuf,
+		 sizeof(subsys->su_group.cg_item.ci_namebuf),
+		 "%s", dev_name(&region->dev));
+
+	subsys->su_group.cg_item.ci_type = &fpga_region_item_type;
+
+	config_group_init(&subsys->su_group);
+
+	return configfs_register_subsystem(subsys);
+}
+
+static void fpga_region_configfs_unregister(struct fpga_region *region)
+{
+	struct configfs_subsystem *subsys = &region->subsys;
+
+	configfs_unregister_subsystem(subsys);
+}
+
 /**
  * __fpga_region_register_full - create and register an FPGA Region device
  * @parent: device parent
@@ -229,8 +382,16 @@ __fpga_region_register_full(struct device *parent, const struct fpga_region_info
 	if (ret)
 		goto err_remove;
 
+	if (info->region_ops) {
+		region->region_ops = info->region_ops;
+		ret = fpga_region_configfs_register(region);
+		if (ret)
+			goto err_remove;
+	}
+
 	ret = device_register(&region->dev);
 	if (ret) {
+		fpga_region_configfs_unregister(region);
 		put_device(&region->dev);
 		return ERR_PTR(ret);
 	}
@@ -272,6 +433,40 @@ __fpga_region_register(struct device *parent, struct fpga_manager *mgr,
 }
 EXPORT_SYMBOL_GPL(__fpga_region_register);
 
+/**
+ * __fpga_region_register_with_ops - create and register an FPGA Region device
+ * with user interface call-backs.
+ * @parent: device parent
+ * @mgr: manager that programs this region
+ * @region_ops: ops for low level FPGA region for device enumeration/removal
+ * @priv: of-fpga-region private data
+ * @get_bridges: optional function to get bridges to a list
+ * @owner: module containing the get_bridges function
+ *
+ * This simple version of the register function should be sufficient for most users.
+ * The fpga_region_register_full() function is available for users that need to
+ * pass additional, optional parameters.
+ *
+ * Return: struct fpga_region or ERR_PTR()
+ */
+struct fpga_region *
+__fpga_region_register_with_ops(struct device *parent, struct fpga_manager *mgr,
+				const struct fpga_region_ops *region_ops,
+				void *priv,
+				int (*get_bridges)(struct fpga_region *),
+				struct module *owner)
+{
+	struct fpga_region_info info = { 0 };
+
+	info.mgr = mgr;
+	info.priv = priv;
+	info.get_bridges = get_bridges;
+	info.region_ops = region_ops;
+
+	return __fpga_region_register_full(parent, &info, owner);
+}
+EXPORT_SYMBOL_GPL(__fpga_region_register_with_ops);
+
 /**
  * fpga_region_unregister - unregister an FPGA region
  * @region: FPGA region
@@ -280,6 +475,7 @@ EXPORT_SYMBOL_GPL(__fpga_region_register);
  */
 void fpga_region_unregister(struct fpga_region *region)
 {
+	fpga_region_configfs_unregister(region);
 	device_unregister(&region->dev);
 }
 EXPORT_SYMBOL_GPL(fpga_region_unregister);
diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index 43db4bb77138..7088835a224a 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -8,16 +8,34 @@
 #include <linux/fpga/fpga-bridge.h>
 #include <linux/fpga/fpga-mgr.h>
 #include <linux/fpga/fpga-region.h>
+#include <linux/firmware.h>
+#include <linux/fpga-region.h>
 #include <linux/idr.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_fdt.h>
+#include <linux/libfdt.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
+/**
+ * struct of_fpga_region_priv - Private data structure
+ * image.
+ * @dev:	Device data structure
+ * @fw:		firmware of coeff table.
+ * @path:	path of FPGA overlay image firmware file.
+ * @ovcs_id:	overlay changeset id.
+ */
+struct of_fpga_region_priv {
+	struct device *dev;
+	const struct firmware *fw;
+	int ovcs_id;
+};
+
 static const struct of_device_id fpga_region_of_match[] = {
 	{ .compatible = "fpga-region", },
 	{},
@@ -141,273 +159,322 @@ static int of_fpga_region_get_bridges(struct fpga_region *region)
 }
 
 /**
- * child_regions_with_firmware - Used to check the child region info.
- * @overlay: device node of the overlay
+ * of_fpga_region_post_remove - post-remove overlay
  *
- * If the overlay adds child FPGA regions, they are not allowed to have
- * firmware-name property.
+ * @region: FPGA region that was targeted by the overlay that was removed
  *
- * Return: 0 for OK or -EINVAL if child FPGA region adds firmware-name.
+ * Called after an overlay has been removed if the overlay's target was a
+ * FPGA region.
  */
-static int child_regions_with_firmware(struct device_node *overlay)
+static void of_fpga_region_post_remove(struct fpga_region *region)
 {
-	struct device_node *child_region;
-	const char *child_firmware_name;
-	int ret = 0;
-
-	of_node_get(overlay);
-
-	child_region = of_find_matching_node(overlay, fpga_region_of_match);
-	while (child_region) {
-		if (!of_property_read_string(child_region, "firmware-name",
-					     &child_firmware_name)) {
-			ret = -EINVAL;
-			break;
-		}
-		child_region = of_find_matching_node(child_region,
-						     fpga_region_of_match);
-	}
+	fpga_bridges_disable(&region->bridge_list);
+	fpga_bridges_put(&region->bridge_list);
+	fpga_image_info_free(region->info);
+	region->info = NULL;
+}
 
-	of_node_put(child_region);
+static int of_fpga_region_status(struct fpga_region *region)
+{
+	struct of_fpga_region_priv *ovcs = region->priv;
 
-	if (ret)
-		pr_err("firmware-name not allowed in child FPGA region: %pOF",
-		       child_region);
+	if (ovcs->ovcs_id)
+		return FPGA_REGION_HAS_PL;
 
-	return ret;
+	return FPGA_REGION_EMPTY;
 }
 
-/**
- * of_fpga_region_parse_ov - parse and check overlay applied to region
+/*
+ * FPGA DTBO Parser
  *
- * @region: FPGA region
- * @overlay: overlay applied to the FPGA region
+ * This file contains the implementation of a function to parse Device Tree
+ * Blob Overlay (DTBO) files used for dynamic reconfiguration of  FPGAs in
+ * Linux. The `parse_dtbo()` function is responsible for:
  *
- * Given an overlay applied to an FPGA region, parse the FPGA image specific
- * info in the overlay and do some checking.
+ * - Validating the DTBO header
+ * - Extracting fixups and resolving symbolic paths to actual device nodes
+ * - Identifying the FPGA region targeted by the overlay
+ * - Allocating and populating the `fpga_image_info` structure with
+ *   relevant configuration such as flags, firmware name, and timeout values
+ * - Retrieving and associating any fpga-bridges specified in the overlay
  *
- * Return:
- *   NULL if overlay doesn't direct us to program the FPGA.
- *   fpga_image_info struct if there is an image to program.
- *   error code for invalid overlay.
+ * This function leverages the Flattened Device Tree (FDT) and OF (Open Firmware)
+ * APIs to interpret the overlay and prepare the FPGA Manager for a runtime
+ * configuration update. It is intended for use in dynamic reconfiguration
+ * scenarios where full/partial bitstreams are applied using overlay files.
+ *
+ * Returns 0 on success or a negative error code on failure.
  */
-static struct fpga_image_info *
-of_fpga_region_parse_ov(struct fpga_region *region,
-			struct device_node *overlay)
+static int parse_dtbo(const struct firmware *fw)
 {
-	struct device *dev = &region->dev;
+	int fixups_off, prop_off, overlay_off, prop_len, fw_name_len, ret;
+	const char *prop_name, *symbol_path, *fw_name, *name, *value;
+	struct device_node *symbols_node = NULL;
+	struct device_node *fpga_node = NULL;
+	struct device_node *br_node = NULL;
+	const struct fdt_property *prop;
 	struct fpga_image_info *info;
-	const char *firmware_name;
-	int ret;
+	struct fpga_region *region;
+	const fdt32_t *val;
 
-	if (region->info) {
-		dev_err(dev, "Region already has overlay applied.\n");
-		return ERR_PTR(-EINVAL);
+	/* Validate DTBO header */
+	if (!fw || fdt_check_header(fw->data) < 0) {
+		pr_err("%s: Invalid DTBO file\n", __func__);
+		return -EINVAL;
 	}
 
-	/*
-	 * Reject overlay if child FPGA Regions added in the overlay have
-	 * firmware-name property (would mean that an FPGA region that has
-	 * not been added to the live tree yet is doing FPGA programming).
-	 */
-	ret = child_regions_with_firmware(overlay);
-	if (ret)
-		return ERR_PTR(ret);
+	/* Locate __fixups__ node */
+	fixups_off = fdt_path_offset((void *)fw->data, "/__fixups__");
+	if (fixups_off < 0) {
+		pr_err("%s: __fixups__ node not found\n", __func__);
+		return -EINVAL;
+	}
 
-	info = fpga_image_info_alloc(dev);
-	if (!info)
-		return ERR_PTR(-ENOMEM);
+	/* Retrieve the first property under __fixups__ */
+	prop_off = fdt_first_property_offset((void *)fw->data, fixups_off);
+	if (prop_off < 0) {
+		pr_info("%s: No properties in __fixups__\n", __func__);
+		return -ENOENT;
+	}
+
+	prop = fdt_get_property_by_offset((void *)fw->data, prop_off, &prop_len);
+	if (!prop) {
+		pr_err("%s: Failed to get first __fixups__ property\n", __func__);
+		return -ENOENT;
+	}
+
+	prop_name = fdt_string((void *)fw->data, fdt32_to_cpu(prop->nameoff));
+
+	/* Locate __symbols__ node */
+	symbols_node = of_find_node_by_path("/__symbols__");
+	if (!symbols_node) {
+		pr_err("%s: Missing __symbols__ node\n", __func__);
+		return -ENODEV;
+	}
+
+	/* Resolve symbolic path to FPGA node */
+	symbol_path = of_get_property(symbols_node, prop_name, NULL);
+	if (!symbol_path) {
+		pr_err("%s: Symbol '%s' not found in __symbols__\n", __func__, prop_name);
+		goto err_put_symbols;
+	}
+
+	/* Retrieve FPGA region associated with the node */
+	fpga_node = of_find_node_by_path(symbol_path);
+	if (!fpga_node) {
+		pr_err("%s: FPGA node not found at path: %s\n", __func__, symbol_path);
+		goto err_put_symbols;
+	}
+
+	/* Retrieve FPGA region associated with the node */
+	region = of_fpga_region_find(fpga_node);
+	if (!region) {
+		pr_err("%s: FPGA region not found for: %s\n", __func__, symbol_path);
+		goto err_put_fpga;
+	}
+
+	/* Allocate FPGA image info structure */
+	info = fpga_image_info_alloc(&region->dev);
+	if (!info) {
+		ret = -ENOMEM;
+		goto err_put_fpga;
+	}
 
-	info->overlay = overlay;
+	/* Locate /fragment@0/__overlay__ node in the overlay */
+	overlay_off = fdt_path_offset((void *)fw->data, "/fragment@0/__overlay__");
+	if (overlay_off < 0) {
+		pr_err("%s: Missing /fragment@0/__overlay__\n", __func__);
+		ret = -ENOENT;
+		goto err_free_info;
+	}
 
-	/* Read FPGA region properties from the overlay */
-	if (of_property_read_bool(overlay, "partial-fpga-config"))
+	/* Parse optional configuration flags */
+	if (fdt_getprop(fw->data, overlay_off, "partial-fpga-config", NULL))
 		info->flags |= FPGA_MGR_PARTIAL_RECONFIG;
 
-	if (of_property_read_bool(overlay, "external-fpga-config"))
+	if (fdt_getprop(fw->data, overlay_off, "external-fpga-config", NULL))
 		info->flags |= FPGA_MGR_EXTERNAL_CONFIG;
 
-	if (of_property_read_bool(overlay, "encrypted-fpga-config"))
+	if (fdt_getprop(fw->data, overlay_off, "encrypted-fpga-config", NULL))
 		info->flags |= FPGA_MGR_ENCRYPTED_BITSTREAM;
 
-	if (!of_property_read_string(overlay, "firmware-name",
-				     &firmware_name)) {
-		info->firmware_name = devm_kstrdup(dev, firmware_name,
-						   GFP_KERNEL);
-		if (!info->firmware_name)
-			return ERR_PTR(-ENOMEM);
+	/* Retrieve firmware-name property */
+	fw_name = fdt_getprop(fw->data, overlay_off, "firmware-name", &fw_name_len);
+	if (fw_name) {
+		info->firmware_name = devm_kstrdup(&region->dev, fw_name, GFP_KERNEL);
+		if (!info->firmware_name) {
+			ret = -ENOMEM;
+			goto err_free_info;
+		}
 	}
 
-	of_property_read_u32(overlay, "region-unfreeze-timeout-us",
-			     &info->enable_timeout_us);
+	/* Parse optional timeout properties */
+	val = fdt_getprop(fw->data, overlay_off, "region-unfreeze-timeout-us", &fw_name_len);
+	if (val && fw_name_len == sizeof(fdt32_t))
+		info->enable_timeout_us = fdt32_to_cpu(*val);
 
-	of_property_read_u32(overlay, "region-freeze-timeout-us",
-			     &info->disable_timeout_us);
+	val = fdt_getprop(fw->data, overlay_off, "region-freeze-timeout-us", &fw_name_len);
+	if (val && fw_name_len == sizeof(fdt32_t))
+		info->disable_timeout_us = fdt32_to_cpu(*val);
 
-	of_property_read_u32(overlay, "config-complete-timeout-us",
-			     &info->config_complete_timeout_us);
+	val = fdt_getprop(fw->data, overlay_off, "config-complete-timeout-us", &fw_name_len);
+	if (val && fw_name_len == sizeof(fdt32_t))
+		info->config_complete_timeout_us = fdt32_to_cpu(*val);
 
-	/* If overlay is not programming the FPGA, don't need FPGA image info */
-	if (!info->firmware_name) {
-		ret = 0;
-		goto ret_no_info;
-	}
+	/* Attach parsed image info to the FPGA region */
+	region->info = info;
 
-	/*
-	 * If overlay informs us FPGA was externally programmed, specifying
-	 * firmware here would be ambiguous.
-	 */
-	if (info->flags & FPGA_MGR_EXTERNAL_CONFIG) {
-		dev_err(dev, "error: specified firmware and external-fpga-config");
-		ret = -EINVAL;
-		goto ret_no_info;
-	}
+	/* Handle optional fpga-bridges references */
+	fdt_for_each_property_offset(prop_off, (void *)fw->data, fixups_off) {
+		prop = fdt_get_property_by_offset((void *)fw->data, prop_off, NULL);
+		if (!prop)
+			continue;
 
-	return info;
-ret_no_info:
-	fpga_image_info_free(info);
-	return ERR_PTR(ret);
-}
+		name = fdt_string((void *)fw->data, fdt32_to_cpu(prop->nameoff));
+		value = prop->data;
 
-/**
- * of_fpga_region_notify_pre_apply - pre-apply overlay notification
- *
- * @region: FPGA region that the overlay was applied to
- * @nd: overlay notification data
- *
- * Called when an overlay targeted to an FPGA Region is about to be applied.
- * Parses the overlay for properties that influence how the FPGA will be
- * programmed and does some checking. If the checks pass, programs the FPGA.
- * If the checks fail, overlay is rejected and does not get added to the
- * live tree.
- *
- * Return: 0 for success or negative error code for failure.
- */
-static int of_fpga_region_notify_pre_apply(struct fpga_region *region,
-					   struct of_overlay_notify_data *nd)
-{
-	struct device *dev = &region->dev;
-	struct fpga_image_info *info;
-	int ret;
+		if (!name || !value)
+			continue;
 
-	info = of_fpga_region_parse_ov(region, nd->overlay);
-	if (IS_ERR(info))
-		return PTR_ERR(info);
+		if (strstr(value, "fpga-bridges")) {
+			symbol_path = of_get_property(symbols_node, name, NULL);
+			if (!symbol_path) {
+				pr_err("%s: Missing symbol for bridge: %s\n", __func__, name);
+				ret = -ENODEV;
+				goto err_put_symbols;
+			}
 
-	/* If overlay doesn't program the FPGA, accept it anyway. */
-	if (!info)
-		return 0;
+			br_node = of_find_node_by_path(symbol_path);
+			if (!br_node) {
+				pr_err("%s: Bridge node not found at: %s\n", __func__, symbol_path);
+				ret = -ENODEV;
+				goto err_put_symbols;
+			}
 
-	if (region->info) {
-		dev_err(dev, "Region already has overlay applied.\n");
-		return -EINVAL;
-	}
+			ret = of_fpga_bridge_get_to_list(br_node, info, &region->bridge_list);
+			of_node_put(br_node);
 
-	region->info = info;
-	ret = fpga_region_program_fpga(region);
-	if (ret) {
-		/* error; reject overlay */
-		fpga_image_info_free(info);
-		region->info = NULL;
+			if (ret == -EBUSY) {
+				fpga_bridges_put(&region->bridge_list);
+				goto err_put_symbols;
+			}
+		}
 	}
 
+	of_node_put(fpga_node);
+	of_node_put(symbols_node);
+
+	return 0;
+
+err_free_info:
+	fpga_image_info_free(info);
+err_put_fpga:
+	of_node_put(fpga_node);
+err_put_symbols:
+	of_node_put(symbols_node);
+
 	return ret;
 }
 
-/**
- * of_fpga_region_notify_post_remove - post-remove overlay notification
- *
- * @region: FPGA region that was targeted by the overlay that was removed
- * @nd: overlay notification data
- *
- * Called after an overlay has been removed if the overlay's target was a
- * FPGA region.
- */
-static void of_fpga_region_notify_post_remove(struct fpga_region *region,
-					      struct of_overlay_notify_data *nd)
+static int of_fpga_region_pre_config(struct fpga_region *region)
 {
-	fpga_bridges_disable(&region->bridge_list);
-	fpga_bridges_put(&region->bridge_list);
-	fpga_image_info_free(region->info);
-	region->info = NULL;
+	struct of_fpga_region_priv *ovcs = region->priv;
+	int err;
+
+	/* if it's set do not allow changes */
+	if (ovcs->ovcs_id)
+		return -EPERM;
+
+	err = request_firmware(&ovcs->fw, region->firmware_name, NULL);
+	if (err)
+		return err;
+
+	err = parse_dtbo(ovcs->fw);
+	if (err)
+		return err;
+
+	release_firmware(ovcs->fw);
+
+	return 0;
 }
 
-/**
- * of_fpga_region_notify - reconfig notifier for dynamic DT changes
- * @nb:		notifier block
- * @action:	notifier action
- * @arg:	reconfig data
- *
- * This notifier handles programming an FPGA when a "firmware-name" property is
- * added to an fpga-region.
- *
- * Return: NOTIFY_OK or error if FPGA programming fails.
- */
-static int of_fpga_region_notify(struct notifier_block *nb,
-				 unsigned long action, void *arg)
+static int of_fpga_region_post_config(struct fpga_region *region)
 {
-	struct of_overlay_notify_data *nd = arg;
-	struct fpga_region *region;
-	int ret;
-
-	switch (action) {
-	case OF_OVERLAY_PRE_APPLY:
-		pr_debug("%s OF_OVERLAY_PRE_APPLY\n", __func__);
-		break;
-	case OF_OVERLAY_POST_APPLY:
-		pr_debug("%s OF_OVERLAY_POST_APPLY\n", __func__);
-		return NOTIFY_OK;       /* not for us */
-	case OF_OVERLAY_PRE_REMOVE:
-		pr_debug("%s OF_OVERLAY_PRE_REMOVE\n", __func__);
-		return NOTIFY_OK;       /* not for us */
-	case OF_OVERLAY_POST_REMOVE:
-		pr_debug("%s OF_OVERLAY_POST_REMOVE\n", __func__);
-		break;
-	default:			/* should not happen */
-		return NOTIFY_OK;
+	struct of_fpga_region_priv *ovcs = region->priv;
+	int err;
+
+	/* if it's set do not allow changes */
+	if (ovcs->ovcs_id)
+		return -EPERM;
+
+	err = request_firmware(&ovcs->fw, region->firmware_name, NULL);
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
 	}
 
-	region = of_fpga_region_find(nd->target);
-	if (!region)
-		return NOTIFY_OK;
+	return 0;
 
-	ret = 0;
-	switch (action) {
-	case OF_OVERLAY_PRE_APPLY:
-		ret = of_fpga_region_notify_pre_apply(region, nd);
-		break;
+out_err:
+	ovcs->ovcs_id = 0;
+	ovcs->fw = NULL;
 
-	case OF_OVERLAY_POST_REMOVE:
-		of_fpga_region_notify_post_remove(region, nd);
-		break;
-	}
+	return err;
+}
 
-	put_device(&region->dev);
+static int of_fpga_region_config_remove(struct fpga_region *region)
+{
+	struct of_fpga_region_priv *ovcs = region->priv;
+
+	if (!ovcs->ovcs_id)
+		return -EPERM;
 
-	if (ret)
-		return notifier_from_errno(ret);
+	of_overlay_remove(&ovcs->ovcs_id);
+	of_fpga_region_post_remove(region);
+	release_firmware(ovcs->fw);
 
-	return NOTIFY_OK;
+	ovcs->ovcs_id = 0;
+	ovcs->fw = NULL;
+
+	return 0;
 }
 
-static struct notifier_block fpga_region_of_nb = {
-	.notifier_call = of_fpga_region_notify,
+static const struct fpga_region_ops region_ops = {
+	.region_status = of_fpga_region_status,
+	.region_pre_config = of_fpga_region_pre_config,
+	.region_post_config = of_fpga_region_post_config,
+	.region_remove = of_fpga_region_config_remove,
 };
 
 static int of_fpga_region_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
+	struct of_fpga_region_priv *priv;
 	struct fpga_region *region;
 	struct fpga_manager *mgr;
 	int ret;
 
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+
 	/* Find the FPGA mgr specified by region or parent region. */
 	mgr = of_fpga_region_get_mgr(np);
 	if (IS_ERR(mgr))
 		return -EPROBE_DEFER;
 
-	region = fpga_region_register(dev, mgr, of_fpga_region_get_bridges);
+	region = fpga_region_register_with_ops(dev, mgr, &region_ops, priv,
+					       of_fpga_region_get_bridges);
 	if (IS_ERR(region)) {
 		ret = PTR_ERR(region);
 		goto eprobe_mgr_put;
@@ -451,27 +518,12 @@ static struct platform_driver of_fpga_region_driver = {
  */
 static int __init of_fpga_region_init(void)
 {
-	int ret;
-
-	ret = of_overlay_notifier_register(&fpga_region_of_nb);
-	if (ret)
-		return ret;
-
-	ret = platform_driver_register(&of_fpga_region_driver);
-	if (ret)
-		goto err_plat;
-
-	return 0;
-
-err_plat:
-	of_overlay_notifier_unregister(&fpga_region_of_nb);
-	return ret;
+	return platform_driver_register(&of_fpga_region_driver);
 }
 
 static void __exit of_fpga_region_exit(void)
 {
 	platform_driver_unregister(&of_fpga_region_driver);
-	of_overlay_notifier_unregister(&fpga_region_of_nb);
 }
 
 subsys_initcall(of_fpga_region_init);
diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
index 5fbc05fe70a6..d4e4beb62533 100644
--- a/include/linux/fpga/fpga-region.h
+++ b/include/linux/fpga/fpga-region.h
@@ -3,18 +3,37 @@
 #ifndef _FPGA_REGION_H
 #define _FPGA_REGION_H
 
+#include <linux/configfs.h>
 #include <linux/device.h>
 #include <linux/fpga/fpga-mgr.h>
 #include <linux/fpga/fpga-bridge.h>
+#include <linux/fpga-region.h>
 
 struct fpga_region;
 
+/**
+ * struct fpga_region_ops - ops for low level FPGA region ops for device
+ * enumeration/removal
+ * @region_status: Check current status of the FPGA region.
+ * @region_pre_config: Called before starting FPGA configuration.
+ * @region_post_config: Called after FPGA configuration is done.
+ * @region_remove: Called to remove devices added during configuration.
+ */
+struct fpga_region_ops {
+	int (*region_status)(struct fpga_region *region);
+	int (*region_pre_config)(struct fpga_region *region);
+	int (*region_post_config)(struct fpga_region *region);
+	int (*region_remove)(struct fpga_region *region);
+};
+
 /**
  * struct fpga_region_info - collection of parameters an FPGA Region
  * @mgr: fpga region manager
  * @compat_id: FPGA region id for compatibility check.
  * @priv: fpga region private data
  * @get_bridges: optional function to get bridges to a list
+ * @fpga_region_ops: ops for low level FPGA region ops for device
+ * enumeration/removal
  *
  * fpga_region_info contains parameters for the register_full function.
  * These are separated into an info structure because they some are optional
@@ -26,6 +45,7 @@ struct fpga_region_info {
 	struct fpga_compat_id *compat_id;
 	void *priv;
 	int (*get_bridges)(struct fpga_region *region);
+	const struct fpga_region_ops *region_ops;
 };
 
 /**
@@ -39,6 +59,10 @@ struct fpga_region_info {
  * @ops_owner: module containing the get_bridges function
  * @priv: private data
  * @get_bridges: optional function to get bridges to a list
+ * @fpga_region_ops: ops for low level FPGA region ops for device
+ * enumeration/removal.
+ * @subsys: Configfs subsystem for exposing region configuration.
+ * @firmware_name: Firmware name set via configfs for image loading.
  */
 struct fpga_region {
 	struct device dev;
@@ -50,6 +74,9 @@ struct fpga_region {
 	struct module *ops_owner;
 	void *priv;
 	int (*get_bridges)(struct fpga_region *region);
+	const struct fpga_region_ops *region_ops;
+	struct configfs_subsystem subsys;
+	char *firmware_name;
 };
 
 #define to_fpga_region(d) container_of(d, struct fpga_region, dev)
@@ -71,6 +98,13 @@ __fpga_region_register_full(struct device *parent, const struct fpga_region_info
 struct fpga_region *
 __fpga_region_register(struct device *parent, struct fpga_manager *mgr,
 		       int (*get_bridges)(struct fpga_region *), struct module *owner);
+#define fpga_region_register_with_ops(parent, mgr, region_ops, priv, get_bridges) \
+	__fpga_region_register_with_ops(parent, mgr, region_ops, priv, get_bridges, THIS_MODULE)
+struct fpga_region *
+__fpga_region_register_with_ops(struct device *parent, struct fpga_manager *mgr,
+				const struct fpga_region_ops *region_ops, void *priv,
+				int (*get_bridges)(struct fpga_region *),
+				struct module *owner);
 void fpga_region_unregister(struct fpga_region *region);
 
 #endif /* _FPGA_REGION_H */
-- 
2.43.0


