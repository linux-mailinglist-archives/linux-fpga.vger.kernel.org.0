Return-Path: <linux-fpga+bounces-921-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 775419B4572
	for <lists+linux-fpga@lfdr.de>; Tue, 29 Oct 2024 10:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F3D2283463
	for <lists+linux-fpga@lfdr.de>; Tue, 29 Oct 2024 09:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325761E32D5;
	Tue, 29 Oct 2024 09:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b1DQxCDm"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2EE1E1021;
	Tue, 29 Oct 2024 09:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730193478; cv=fail; b=eTg9iQKFiog0MRouMkGz5KmeCggYks8cWKnlv2Nm5B/20KbLBBeG770xc77/y7biY46iZWpiAUHZ/c/g1xn4iuxCBL7lfvHtJhA0UE0UBU9qwaZweqdy6nLOIJ/VPLVBRTGjJmeZNxD6S+kieZj+qGEgZ1M8T9DR7mw5uUU5Qmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730193478; c=relaxed/simple;
	bh=NPhmvtIUi5TiiR+jTFDTn+KF9FEVqGYs3RxST3knlrQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qUT8+HNMC7qU/0vBqnwiOzpKXIvpPVQP0RLVPJou7H/JaNlWTngaCF8zFFLq8k3A3QQnT4hUCJbxVloZblEd5zgf+Uh85JNBqKEF65xJSjm7BnuDMFww3RcYDN4uzEw09XzEyEc/WF4N/hQjEqI9Cg5YIPlGhAbr9cl6XUIQrdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b1DQxCDm; arc=fail smtp.client-ip=40.107.92.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BoXd13OCIBROb+G1b4ibq1yXGnSHsgv9N1ffS3SZ2560cL09Re5hoeFIUmZQPpX5sA5FBIvpq07tUzauAlt4BTli5r6j5GKjn9Ry/6L8svkNyN9j4btV9pbSZas0jx0nQx2N0vXP6UoHIOU7GxB5FWjVNYJtdUALCySwA76TE3zRvk+QUH7yAJT5HMPZ0ZbV8+rTF9F+4t6unLcQlk71yRQ3fs8Fbwt1UOqdS03ZhETdFOaxMSpzGTPbe6QvXFKsygyTSBV+sqWtQKg3/TyXPU8aTWzoHrkcRw+ExxTF+/McEF9PZnxZnABpfkmLK3faa9Z62fGaCge4r94Dz1K9qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ej+6LAiWgZL7cMf5TXgzQLP7gLBuTW0442nDFnKNiQ4=;
 b=fYq/MMnifxd1PyAgQ3JDm2zGLqfogKw77akpaC091eJ4n5b7P5KFJnnZ3Xk4tXVlqvFsvqQTzos//+KXwVz3QULt+fHIzwLRn0nxk45MDNA9zPtqVYGHpic7ke2Zudhr8rwWYZ8ruC2cyRqWtqVAXzM0v4Lpj/B/l4m048h9CL1pKKEd6mc5FrU4H5tq1i61+Tg3MMQzJqWIYcGS0Hc+4UUGcXCdqvKp+wzmfK7SwWzCo6iISv1uhliCirxAx0sqgmf/+pLK1+O7WaKP6X4ZovNJag2vEzXyJgdt8TxG1sPcxpxg3lnIXIoRGKyAI9rdqk36tnutPGyp3HFBRrJxWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ej+6LAiWgZL7cMf5TXgzQLP7gLBuTW0442nDFnKNiQ4=;
 b=b1DQxCDm+mQRE9PsvdvUrbDyR0p9TcQFk5/xZMdH4wOzwnhuKeOOQAlaGbKSILhrat0E18NQI+4GNfCkS1Qj44TD3+R3YMTAt1EY6O0s+WM1oFOFYjG3cCBKTdYbj6+wiqHcnHnyhnvF7k3ib1UBj09Pj17YTk/pYjE6nP4rd2A=
Received: from SA9PR03CA0010.namprd03.prod.outlook.com (2603:10b6:806:20::15)
 by MW3PR12MB4442.namprd12.prod.outlook.com (2603:10b6:303:55::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Tue, 29 Oct
 2024 09:17:49 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:806:20:cafe::36) by SA9PR03CA0010.outlook.office365.com
 (2603:10b6:806:20::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Tue, 29 Oct 2024 09:17:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 09:17:48 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 04:17:40 -0500
From: Nava kishore Manne <nava.kishore.manne@amd.com>
To: <git@amd.com>, <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
	<trix@redhat.com>, <robh@kernel.org>, <saravanak@google.com>,
	<nava.kishore.manne@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-fpga@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [RFC v2 1/1] fpga-region: Add generic IOCTL interface for runtime FPGA programming
Date: Tue, 29 Oct 2024 14:47:34 +0530
Message-ID: <20241029091734.3288005-2-nava.kishore.manne@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029091734.3288005-1-nava.kishore.manne@amd.com>
References: <20241029091734.3288005-1-nava.kishore.manne@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|MW3PR12MB4442:EE_
X-MS-Office365-Filtering-Correlation-Id: 47d6d5c4-7952-4db7-bcb7-08dcf7fa8ec3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WybMvs18Q16+wFktlGGBfJrZnnWwBM33EeLUes1WcWWYIy7CiI+Gy9z6DgmW?=
 =?us-ascii?Q?BalUlXlQtM7zu0fNfCp6nVeDZ/iNK1R42UezPFLnGcWlQg+1HGOwPxA5Esuj?=
 =?us-ascii?Q?F7aRuRkYS2/DQowEJ92BMeBBH/viyfdCqJFvTlQS1fq+q7XvFmnjmFZXVDUV?=
 =?us-ascii?Q?CWK62R/U/lb7afpy7ouaWVfEP7a5LosccmwQBv5L0j0HADvArmplkhsvnzcu?=
 =?us-ascii?Q?Qxx02QJ5+zhUd1Xw/37mm/RuaZ6hM8D1PA/pP0pYHriIehyKE3HQDGNxtqCJ?=
 =?us-ascii?Q?URxvv0lDjQcGEo6YKV9vpx+JGhUKZL9bNOGA4xt7J6vhI+pzaOlhrn1a5oEs?=
 =?us-ascii?Q?qb2mw34UKcE90VFRg2Wm6m37BKvVHoU4HrJCWBQtv7UmjQ2Cohy6DodvoSb7?=
 =?us-ascii?Q?UMIy8nFWQCjVTBLlJ3bxFq0Jy7f3iQynvj3zEGnys72pzalgzLr3k84NT+xs?=
 =?us-ascii?Q?QRWLMFcqdmtXthitWEKQ/f6wBHkYbRWtlV1M9fhKocKgICrRjXKgrRpM20I/?=
 =?us-ascii?Q?cNcPvAjurQzKfSm3u9JjqzBTalEslp0P6iSBRGsKBCxtxy5wB4aPoDEyhU4p?=
 =?us-ascii?Q?55FeNp8vJaQtTw6uj97Z2yqZjD3HCmfem9qZVgpcKhLnMI2s8MqTbD9roI9T?=
 =?us-ascii?Q?z+0bz5JwZaKDz/jKNY4fyRHgXXQuQFlZPWvIyqlBn+34AUT3IOb+QLBzbzCR?=
 =?us-ascii?Q?xcGtw/6WCPX/5LoRXbvawJT7mYm65nN7ZZ8Uvxjyc4731//6DuBOONzV0U08?=
 =?us-ascii?Q?z6fWQZ3/tCnULynejtFW6LWVhzkILyJReU44TDcfOzAsh3xjDP0J2PONZ7zh?=
 =?us-ascii?Q?l6rbSOweIeRlhCIpJBcnS7kuYcVfxXtOHgBa+igd+zdVH3DnfsNtOccZXr5M?=
 =?us-ascii?Q?AGrjBU7FtTrI5jwtHr6aJNzTf4RC76BZUBqTyCOGKdrdy8svWmKdgMk++zNA?=
 =?us-ascii?Q?pYa8RpiJMM1OpGxSEkuUIrA36Js4iHt29NzC1bCvTvhSDmuRlACDb3XYNI1J?=
 =?us-ascii?Q?KU/4kTDozPYe1QBqnnz/gMgr6SH0YOUJbD/Dy8ClM0Kz485bexNzhtLkuP1b?=
 =?us-ascii?Q?Uyl6MSQqz7AISSxC5YEdmbcgKXBZlkELe4v4LV/mhqnA9wEwq8PaO8A461z2?=
 =?us-ascii?Q?pbV4nea95wApK3M0RfkQgE9bYPKZcrsJt229czfMQq0hBwSgDFnIGbO821aR?=
 =?us-ascii?Q?aPiGp/ePWqn5EbgVFdPtpEQvapJy0gXxkNh4+skpxi2QwF3E/zxe4Twa7T6h?=
 =?us-ascii?Q?n/6aILE2HYR2XrY1mitOjMjKqBNZ8qdiNv5FzE3dlWxsyw7s0971w+ziPGRX?=
 =?us-ascii?Q?7FGvoQdQZHKBT+IeKWEcbZ27E4NbAAZ3TvbKY8Chc5V1DLVi7YG+78E7P5/z?=
 =?us-ascii?Q?YoILnjwba77HHebIEWOPYSTGwLKsqsqrrIsE1wiHGp1Yt5jrFqf8CZUg0B5v?=
 =?us-ascii?Q?4d3RUKELbP8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 09:17:48.8063
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d6d5c4-7952-4db7-bcb7-08dcf7fa8ec3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4442

Introduces an IOCTL interface within the fpga-region subsystem,
providing a generic and standardized mechanism for configuring (or)
reprogramming FPGAs during runtime. The newly added interface supports
both OF (Open Firmware) and non-OF devices, leveraging vendor-specific
callbacks (e.g., configuration + enumeration, removal, and status) to
accommodate a wide range of device specific configurations.

The IOCTL interface ensures compatibility with both OF and non-OF
devices, allowing for seamless FPGA reprogramming across diverse
platforms.

Vendor-specific callbacks are integrated into the interface, enabling
custom FPGA configuration + enumeration, removal, and status reporting
mechanisms, ensuring flexibility for vendor implementations.

This solution enhances FPGA runtime management, supporting various device
types and vendors, while ensuring compatibility with the current FPGA
configuration flow.

Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
---
Changes for v2:
 - As discussed with Yilun, the implementation has been modified to utilize a
 callback approach, enabling seamless handling of both OF and non-OF devices.

 - As suggested by Yilun in the POC code, we have moved away from using  void *args
 as a parameter for ICOTL inputs to obtain the required user inputs. Instead, we are
 utilizing the fpga_region_config_info structure to gather user inputs. Currently,
 this structure is implemented to support only OF devices, but we intend to extend
 it by incorporating new members to accommodate non-OF devices in the future.

 drivers/fpga/fpga-region.c       | 110 +++++++++++++++++++++++++++++++
 drivers/fpga/of-fpga-region.c    |  91 ++++++++++++++++++++++++-
 include/linux/fpga/fpga-region.h |  32 +++++++++
 include/uapi/linux/fpga-region.h |  51 ++++++++++++++
 4 files changed, 283 insertions(+), 1 deletion(-)
 create mode 100644 include/uapi/linux/fpga-region.h

diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index 753cd142503e..c6bea3c99a69 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -8,6 +8,7 @@
 #include <linux/fpga/fpga-bridge.h>
 #include <linux/fpga/fpga-mgr.h>
 #include <linux/fpga/fpga-region.h>
+#include <linux/fpga-region.h>
 #include <linux/idr.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
@@ -180,6 +181,67 @@ static struct attribute *fpga_region_attrs[] = {
 };
 ATTRIBUTE_GROUPS(fpga_region);
 
+static int fpga_region_device_open(struct inode *inode, struct file *file)
+{
+	struct miscdevice *miscdev = file->private_data;
+	struct fpga_region *region = container_of(miscdev, struct fpga_region, miscdev);
+
+	file->private_data = region;
+
+	return 0;
+}
+
+static int fpga_region_device_release(struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+static long fpga_region_device_ioctl(struct file *file, unsigned int cmd,
+				     unsigned long arg)
+{
+	int err;
+	void __user *argp = (void __user *)arg;
+	struct fpga_region_config_info config_info;
+	struct fpga_region *region =  (struct fpga_region *)(file->private_data);
+
+	switch (cmd) {
+	case FPGA_REGION_IOCTL_LOAD:
+		if (copy_from_user(&config_info, argp, sizeof(struct fpga_region_config_info)))
+			return -EFAULT;
+
+		err = region->region_ops->region_config_enumeration(region, &config_info);
+
+		break;
+	case FPGA_REGION_IOCTL_REMOVE:
+		if (copy_from_user(&config_info, argp, sizeof(struct fpga_region_config_info)))
+			return -EFAULT;
+
+		err = region->region_ops->region_remove(region, &config_info);
+
+		break;
+	case FPGA_REGION_IOCTL_STATUS:
+		unsigned int status;
+
+		status = region->region_ops->region_status(region);
+
+		if (copy_to_user((void __user *)arg, &status, sizeof(status)))
+			err = -EFAULT;
+		break;
+	default:
+		err = -ENOTTY;
+	}
+
+	return err;
+}
+
+static const struct file_operations fpga_region_fops = {
+	.owner		= THIS_MODULE,
+	.open		= fpga_region_device_open,
+	.release	= fpga_region_device_release,
+	.unlocked_ioctl	= fpga_region_device_ioctl,
+	.compat_ioctl	= fpga_region_device_ioctl,
+};
+
 /**
  * __fpga_region_register_full - create and register an FPGA Region device
  * @parent: device parent
@@ -229,8 +291,21 @@ __fpga_region_register_full(struct device *parent, const struct fpga_region_info
 	if (ret)
 		goto err_remove;
 
+	if (info->region_ops) {
+		region->region_ops = info->region_ops;
+		region->miscdev.minor = MISC_DYNAMIC_MINOR;
+		region->miscdev.name = kobject_name(&region->dev.kobj);
+		region->miscdev.fops = &fpga_region_fops;
+		ret = misc_register(&region->miscdev);
+		if (ret) {
+			pr_err("fpga-region: failed to register misc device.\n");
+			goto err_remove;
+		}
+	}
+
 	ret = device_register(&region->dev);
 	if (ret) {
+		misc_deregister(&region->miscdev);
 		put_device(&region->dev);
 		return ERR_PTR(ret);
 	}
@@ -272,6 +347,40 @@ __fpga_region_register(struct device *parent, struct fpga_manager *mgr,
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
@@ -280,6 +389,7 @@ EXPORT_SYMBOL_GPL(__fpga_region_register);
  */
 void fpga_region_unregister(struct fpga_region *region)
 {
+	misc_deregister(&region->miscdev);
 	device_unregister(&region->dev);
 }
 EXPORT_SYMBOL_GPL(fpga_region_unregister);
diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index 8526a5a86f0c..63fe56e0466f 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -8,6 +8,8 @@
 #include <linux/fpga/fpga-bridge.h>
 #include <linux/fpga/fpga-mgr.h>
 #include <linux/fpga/fpga-region.h>
+#include <linux/firmware.h>
+#include <linux/fpga-region.h>
 #include <linux/idr.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
@@ -18,6 +20,20 @@
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
@@ -394,20 +410,93 @@ static struct notifier_block fpga_region_of_nb = {
 	.notifier_call = of_fpga_region_notify,
 };
 
+static int of_fpga_region_status(struct fpga_region *region)
+{
+	struct of_fpga_region_priv *ovcs = region->priv;
+
+	if (ovcs->ovcs_id)
+		return FPGA_REGION_HAS_PL;
+
+	return FPGA_REGION_EMPTY;
+}
+
+static int of_fpga_region_config_enumeration(struct fpga_region *region,
+					     struct fpga_region_config_info *config_info)
+{
+	struct of_fpga_region_priv *ovcs = region->priv;
+	int err;
+
+	/* if it's set do not allow changes */
+	if (ovcs->ovcs_id)
+		return -EPERM;
+
+	err = request_firmware(&ovcs->fw, config_info->firmware_name, NULL);
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
+	return 0;
+
+out_err:
+	ovcs->ovcs_id = 0;
+	ovcs->fw = NULL;
+
+	return err;
+}
+
+static int of_fpga_region_config_remove(struct fpga_region *region,
+					struct fpga_region_config_info *config_info)
+{
+	struct of_fpga_region_priv *ovcs = region->priv;
+
+	if (!ovcs->ovcs_id)
+		return -EPERM;
+
+	of_overlay_remove(&ovcs->ovcs_id);
+	release_firmware(ovcs->fw);
+
+	ovcs->ovcs_id = 0;
+	ovcs->fw = NULL;
+
+	return 0;
+}
+
+static const struct fpga_region_ops region_ops = {
+	.region_status = of_fpga_region_status,
+	.region_config_enumeration = of_fpga_region_config_enumeration,
+	.region_remove = of_fpga_region_config_remove,
+};
+
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
diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
index 5fbc05fe70a6..3a3ba6dbb5e1 100644
--- a/include/linux/fpga/fpga-region.h
+++ b/include/linux/fpga/fpga-region.h
@@ -6,15 +6,35 @@
 #include <linux/device.h>
 #include <linux/fpga/fpga-mgr.h>
 #include <linux/fpga/fpga-bridge.h>
+#include <linux/fpga-region.h>
+#include <linux/miscdevice.h>
 
 struct fpga_region;
 
+/**
+ * struct fpga_region_ops - ops for low level FPGA region ops for device
+ * enumeration/removal
+ * @region_status: returns the FPGA region status
+ * @region_config_enumeration: Configure and enumerate the FPGA region.
+ * @region_remove: Remove all devices within the FPGA region
+ * (which are added as part of the enumeration).
+ */
+struct fpga_region_ops {
+	int (*region_status)(struct fpga_region *region);
+	int (*region_config_enumeration)(struct fpga_region *region,
+					 struct fpga_region_config_info *config_info);
+	int (*region_remove)(struct fpga_region *region,
+			     struct fpga_region_config_info *config_info);
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
@@ -26,6 +46,7 @@ struct fpga_region_info {
 	struct fpga_compat_id *compat_id;
 	void *priv;
 	int (*get_bridges)(struct fpga_region *region);
+	const struct fpga_region_ops *region_ops;
 };
 
 /**
@@ -39,6 +60,8 @@ struct fpga_region_info {
  * @ops_owner: module containing the get_bridges function
  * @priv: private data
  * @get_bridges: optional function to get bridges to a list
+ * @fpga_region_ops: ops for low level FPGA region ops for device
+ * enumeration/removal
  */
 struct fpga_region {
 	struct device dev;
@@ -50,6 +73,8 @@ struct fpga_region {
 	struct module *ops_owner;
 	void *priv;
 	int (*get_bridges)(struct fpga_region *region);
+	const struct fpga_region_ops *region_ops;
+	struct miscdevice miscdev;
 };
 
 #define to_fpga_region(d) container_of(d, struct fpga_region, dev)
@@ -71,6 +96,13 @@ __fpga_region_register_full(struct device *parent, const struct fpga_region_info
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
diff --git a/include/uapi/linux/fpga-region.h b/include/uapi/linux/fpga-region.h
new file mode 100644
index 000000000000..88ade83daf61
--- /dev/null
+++ b/include/uapi/linux/fpga-region.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Header File for FPGA Region User API
+ *
+ * Copyright (C) 2024 Advanced Micro Devices, Inc.
+ *
+ * Author: Manne, Nava kishore <nava.kishore.manne@amd.com>
+ */
+
+#ifndef _UAPI_LINUX_FPGA_REGION_H
+#define _UAPI_LINUX_FPGA_REGION_H
+
+#include <linux/ioctl.h>
+#include <linux/limits.h>
+#include <linux/types.h>
+
+/* IOCTLs for fpga region file descriptor */
+#define FPGA_REGION_MAGIC_NUMBER	'f'
+#define FPGA_REGION_BASE		0
+
+/**
+ * FPGA_REGION_IOCTL_LOAD - _IOW(FPGA_REGION_MAGIC, 0,
+ *                               struct fpga_region_config_info)
+ *
+ * FPGA_REGION_IOCTL_REMOVE - _IOW(FPGA_REGION_MAGIC, 1,
+ *                                 struct fpga_region_config_info)
+ *
+ * Driver does Configuration/Reconfiguration based on Region ID and
+ * Buffer (Image) provided by caller.
+ * Return: 0 on success, -errno on failure.
+ */
+struct fpga_region_config_info {	/* Input */
+	char firmware_name[NAME_MAX];   /* Firmware file name */
+};
+
+/*
+ * FPGA Region Control IOCTLs.
+ */
+#define FPGA_REGION_MAGIC	'f'
+#define FPGA_IOW(num, dtype)	_IOW(FPGA_REGION_MAGIC, num, dtype)
+#define FPGA_IOR(num, dtype)	_IOR(FPGA_REGION_MAGIC, num, dtype)
+
+#define FPGA_REGION_IOCTL_LOAD		FPGA_IOW(0, __u32)
+#define FPGA_REGION_IOCTL_REMOVE        FPGA_IOW(1, __u32)
+#define FPGA_REGION_IOCTL_STATUS        FPGA_IOR(2, __u32)
+
+/* Region status possibilities returned by FPGA_REGION_IOCTL_STATUS ioctl */
+#define FPGA_REGION_HAS_PL	0	/* if the region has PL logic */
+#define FPGA_REGION_EMPTY	1	/* If the region is empty */
+
+#endif /* _UAPI_LINUX_FPGA_REGION_H */
-- 
2.34.1


