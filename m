Return-Path: <linux-fpga+bounces-982-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB109EB975
	for <lists+linux-fpga@lfdr.de>; Tue, 10 Dec 2024 19:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7CBC1883294
	for <lists+linux-fpga@lfdr.de>; Tue, 10 Dec 2024 18:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E03214233;
	Tue, 10 Dec 2024 18:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zLZZbg1t"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A99214223;
	Tue, 10 Dec 2024 18:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733855889; cv=fail; b=n8HNzqKhkJp4wXOtZjIwsn4SEMEmxfKEELBCFKCl+pmPSky+VBFh9ofFAFeRe6lCaYo/xNZuPl0g8QPVDYr+/kv8ZOU1KfXXrwPEMSPDUEqr66b3/GFouDqUpSGEJPmaOBCHtx5MKA7EMDQglLsIszkBg6U0Qh7tPItKPR6sjCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733855889; c=relaxed/simple;
	bh=NQIoY+oXM7XOjyafjY385stot4bZGPgTl0EVpVOevtM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ihTb6n5b38nDt4j7cARKYInc0YU7xb8l07vx91Wy9CdQOblnkQ+1TsaWeGUJyBudYJux8vtd5WQ0yLuJqY5Qz42FcQCtdKkPaNyoQJrsX/oNkTjLvk9Xb4/7ZFoDkDq1h8lq14afIhgX0ejBO1pgiwvxDBITlerMpFxqB+4eppE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zLZZbg1t; arc=fail smtp.client-ip=40.107.93.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x9eIGp0AqK+VDcMNV92tfZpKocXva4y82N6+aMnNzos/JdfJfjMegeAlBqcHV6tjOCugaheWspZ7CR5/jjDM4+AclIUsbdJUYOsYvZOCqVEMc2jWmZCSdFz9BIlQMTInVp1MZYU4r6e5+b4PScEyP/2SeBD8YfDz97AVscXtv9GsPddy8nvR7v91Fj1mh7yX+gtY2ueWr+M72wZqJv+KiEXId4GxhPDgDvqePdDWdJtSD8m5BroLUUJ/tHgvIaMeoqtlVm7D/Xx1rIIHMLkmEfhc8oTZG0Nd456C3uSRLLEMPiUYASQbND3z+iC9oQX6SUwuS/PBu33VoqM3OXcK3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8sVGtZZ9ZMm2oxW+LxmXFAa19cNChqImO4EO9fS0ElQ=;
 b=J0kW4mEI6d9iV0RBG34iXDEzHCl3sSOs6CuccEiiEBQT4/u5nWdCrmyr44L7OreJ9UMY2KuY+ym7XbOFrXshFMDC7EqmxTX+8fEzK0BHAcFmZWr2WzXT/XmeIDDQrl1y+97OeNXcCgmi+draPnHLElM8zGpToKgG0V/CpNNo6JCKXkSaM843ZYQIeN6si0y8Gj+aI+HeoS82soidf16I7sjQc0OcU4AY/iJLcYGhNY5+C4RIvlhCLUIUOMiTFf6FxEuOrpZQaK3iRd8kJIAqHh71iH5BdobyNQrxtO8XkIwTA4V6xzIFfHmfx3WpKTeJcKlroxSGPPtC+sMBPMTPAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sVGtZZ9ZMm2oxW+LxmXFAa19cNChqImO4EO9fS0ElQ=;
 b=zLZZbg1t3J2MNFgHA6uveRDj3uFDvKRoj7SJzElA/NEBZI5ABs3CMqgjsskQ+YABIK/UWgLeePB1YJluAsfu3jpAYMKlyMwbw9iB2o6NADfsndvdRWZjaqk5ilj5QufmoBUzmPbRikDTrv2vTikKoMfHz2qs0ksFds9/Ug5zWeo=
Received: from PH7P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::21)
 by SN7PR12MB7129.namprd12.prod.outlook.com (2603:10b6:806:2a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 18:37:56 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:510:32a:cafe::ac) by PH7P221CA0026.outlook.office365.com
 (2603:10b6:510:32a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.17 via Frontend Transport; Tue,
 10 Dec 2024 18:37:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 10 Dec 2024 18:37:55 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 12:37:54 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 12:37:54 -0600
Received: from xsjyliu51.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 10 Dec 2024 12:37:53 -0600
From: Yidong Zhang <yidong.zhang@amd.com>
To: <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
	<mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>
CC: Yidong Zhang <yidong.zhang@amd.com>, <lizhi.hou@amd.com>, Nishad Saraf
	<nishads@amd.com>, Prapul Krishnamurthy <prapulk@amd.com>
Subject: [PATCH V2 3/4] drivers/fpga/amd: Add remote queue
Date: Tue, 10 Dec 2024 10:37:32 -0800
Message-ID: <20241210183734.30803-4-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241210183734.30803-1-yidong.zhang@amd.com>
References: <20241210183734.30803-1-yidong.zhang@amd.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: yidong.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|SN7PR12MB7129:EE_
X-MS-Office365-Filtering-Correlation-Id: 7701de1a-0e82-4637-f9e1-08dd1949c37c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tNz/bMTKGwJqJni1P5ftLQo4RPNubS8AjOqmDt6FyJNsA1YS9HOFfc/IQH47?=
 =?us-ascii?Q?qaEvIzAVRaWIpNcx8Pjar68LTlMmu5lOnYqB9sVTD8qIC8mLioVDbiel6znL?=
 =?us-ascii?Q?7OI7H3azZziwrTxfcSCiyNDf844V5pfv24SKIc2e880AWNbGB8OliXsZ/Dpe?=
 =?us-ascii?Q?fiIRfmTqAHdK+rihkoMkJZ8sE3ChKg5R3As5PkZEDzXvOew6xkGhvAG+9LqM?=
 =?us-ascii?Q?3iTWo0Dif8PQJ51pODKFZ5tK9oY6gAMVJAPzSLvij+vhaDl4gqu1mSm9mq5Q?=
 =?us-ascii?Q?abG7wHjClBPTpe3QxfZBJPoYGo3rkiort1hVkkxpWQAYTrk6qxD39iXiimof?=
 =?us-ascii?Q?p4a7/4pcsf9T91G9ICeOGmkB46bRmspMWv0C5+rgEbjwvDCT5Jm7TyfM7jb+?=
 =?us-ascii?Q?dbc+Y4L0GGBAc2fmPQ7vdbkqj19ZKyrqP7JWsDgDW8z+eWU2e8VzfEeSrYTV?=
 =?us-ascii?Q?HDePGUMSm4/ltCvK381BhPP83iqOjMJySkIMTK3ZCAZFxQse6xxHyrZg7dQj?=
 =?us-ascii?Q?6piA27G9+gBHl6g6n/diAbpqcnv6ssso/J5KeSC1weDv3kt2jBJZP85VslCw?=
 =?us-ascii?Q?IYKXY9M1oa0Adwwt+vDKglZpHYTv/gzuEAUq7q41MWRQooLFxqCDdjBaeYob?=
 =?us-ascii?Q?dUD6h9Fp16fUMr/jxSM2LxTESaJ0Pvl65GvZJ4Gf1mIo1kVwQZkn1NPmSq8z?=
 =?us-ascii?Q?XV1skJz86fFblgphDmkoOLy2gBAr/ib54a4grljDTKO/a1KYLuFiVY2sgUf+?=
 =?us-ascii?Q?0pSheFRg9RKrEGIGfdwVZKzkmXBx2eLNkU89P0sO30IdnrXuU982yPRIsj/o?=
 =?us-ascii?Q?YDG0cohWOyA+SXd0pLwVOiOPSMyILVIyqdG3OsFulT6gxqGq0oEL61C8MC/A?=
 =?us-ascii?Q?a/zHe1dDEvydp50tbqM7WKYOBTSwlrJdXB1Vz9Jk/jczERjvF+EYXRsZ1sM5?=
 =?us-ascii?Q?hG1XclDmlvvJ7F019RYlWeS3DX/7SGIk6Ic58wl+7sa3tBWbW3afJ5jOn0OW?=
 =?us-ascii?Q?A6COFNk9e2dB/qILcbqJTehSWU9vmxPe7a508OJeszvPvC/FrPiRyXqD8p7E?=
 =?us-ascii?Q?5p0P+RPeJG267XYgyaCFSgjc2BkgbXc9AAZda7eu/BgNXO7MSElbCU7twI3r?=
 =?us-ascii?Q?8PexykyL7tpEqUSsV7ZovXwQTGfy7VOPvHmJwdW7TDtEvfiqpO5+HHMcQaxi?=
 =?us-ascii?Q?QUdW0qqEBVqJIfEgxDh8dQPgdaWdOq7LlPCnyohh2YBzWNNFSOUwefHTYqqd?=
 =?us-ascii?Q?jRSOwENIbNxe5duEw9c1PY8aG0Mfys2YxnEcwMiNQg3HuU633+r/ItDr6+bK?=
 =?us-ascii?Q?kYSGwxHj9jjF6FLBLYJg2ExdeoRjFS0s+uzoN1cBIMtHd+lnwdUJ3377SfJA?=
 =?us-ascii?Q?K9w8Jx3wF8PMhwly82W0r9z1h/z9TNt1RbtrZCLTsflL3K/VBZfDDFMsIXix?=
 =?us-ascii?Q?iRJTKVF1c4wQYlmz2MPlR9LVjg+kM6eY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 18:37:55.8751
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7701de1a-0e82-4637-f9e1-08dd1949c37c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7129

The remote queue is a hardware queue based ring buffer service between mgmt
PF and PCIe hardware firmware for programming FPGA Program Logic, loading
versal firmware and checking card healthy status.

Co-developed-by: Nishad Saraf <nishads@amd.com>
Signed-off-by: Nishad Saraf <nishads@amd.com>
Co-developed-by: Prapul Krishnamurthy <prapulk@amd.com>
Signed-off-by: Prapul Krishnamurthy <prapulk@amd.com>
Signed-off-by: Yidong Zhang <yidong.zhang@amd.com>
---
 drivers/fpga/amd/Makefile                |   3 +-
 drivers/fpga/amd/versal-pci-rm-queue.c   | 326 +++++++++++++++++++++++
 drivers/fpga/amd/versal-pci-rm-queue.h   |  21 ++
 drivers/fpga/amd/versal-pci-rm-service.h | 209 +++++++++++++++
 4 files changed, 558 insertions(+), 1 deletion(-)
 create mode 100644 drivers/fpga/amd/versal-pci-rm-queue.c
 create mode 100644 drivers/fpga/amd/versal-pci-rm-queue.h
 create mode 100644 drivers/fpga/amd/versal-pci-rm-service.h

diff --git a/drivers/fpga/amd/Makefile b/drivers/fpga/amd/Makefile
index 7a604785e5f9..b2ffdbf23400 100644
--- a/drivers/fpga/amd/Makefile
+++ b/drivers/fpga/amd/Makefile
@@ -3,4 +3,5 @@
 obj-$(CONFIG_AMD_VERSAL_PCI)			+= versal-pci.o
 
 versal-pci-$(CONFIG_AMD_VERSAL_PCI)		:= versal-pci-main.o \
-						   versal-pci-comm-chan.o
+						   versal-pci-comm-chan.o \
+						   versal-pci-rm-queue.o
diff --git a/drivers/fpga/amd/versal-pci-rm-queue.c b/drivers/fpga/amd/versal-pci-rm-queue.c
new file mode 100644
index 000000000000..92f2e1165052
--- /dev/null
+++ b/drivers/fpga/amd/versal-pci-rm-queue.c
@@ -0,0 +1,326 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for Versal PCIe device
+ *
+ * Copyright (C) 2024 Advanced Micro Devices, Inc. All rights reserved.
+ */
+
+#include <linux/pci.h>
+
+#include "versal-pci.h"
+#include "versal-pci-rm-queue.h"
+#include "versal-pci-rm-service.h"
+
+static inline struct rm_device *to_rdev_msg_monitor(struct work_struct *w)
+{
+	return container_of(w, struct rm_device, msg_monitor);
+}
+
+static inline struct rm_device *to_rdev_msg_timer(struct timer_list *t)
+{
+	return container_of(t, struct rm_device, msg_timer);
+}
+
+static inline u32 rm_io_read(struct rm_device *rdev, u32 offset)
+{
+	/* TODO */
+	return 0;
+}
+
+static inline int rm_io_write(struct rm_device *rdev, u32 offset, u32 value)
+{
+	/* TODO */
+	return 0;
+}
+
+static inline u32 rm_queue_read(struct rm_device *rdev, u32 offset)
+{
+	/* TODO */
+	return 0;
+}
+
+static inline void rm_queue_write(struct rm_device *rdev, u32 offset, u32 value)
+{
+	/* TODO */
+}
+
+static inline void rm_queue_bulk_read(struct rm_device *rdev, u32 offset,
+				      u32 *value, u32 size)
+{
+	/* TODO */
+}
+
+static inline void rm_queue_bulk_write(struct rm_device *rdev, u32 offset,
+				       u32 *value, u32 size)
+{
+	/* TODO */
+}
+
+static inline u32 rm_queue_get_cidx(struct rm_device *rdev, enum rm_queue_type type)
+{
+	u32 off;
+
+	if (type == RM_QUEUE_SQ)
+		off = offsetof(struct rm_queue_header, sq_cidx);
+	else
+		off = offsetof(struct rm_queue_header, cq_cidx);
+
+	return rm_queue_read(rdev, off);
+}
+
+static inline void rm_queue_set_cidx(struct rm_device *rdev, enum rm_queue_type type,
+				     u32 value)
+{
+	u32 off;
+
+	if (type == RM_QUEUE_SQ)
+		off = offsetof(struct rm_queue_header, sq_cidx);
+	else
+		off = offsetof(struct rm_queue_header, cq_cidx);
+
+	rm_queue_write(rdev, off, value);
+}
+
+static inline u32 rm_queue_get_pidx(struct rm_device *rdev, enum rm_queue_type type)
+{
+	if (type == RM_QUEUE_SQ)
+		return rm_io_read(rdev, RM_IO_SQ_PIDX_OFF);
+	else
+		return rm_io_read(rdev, RM_IO_CQ_PIDX_OFF);
+}
+
+static inline int rm_queue_set_pidx(struct rm_device *rdev,
+				    enum rm_queue_type type, u32 value)
+{
+	if (type == RM_QUEUE_SQ)
+		return rm_io_write(rdev, RM_IO_SQ_PIDX_OFF, value);
+	else
+		return rm_io_write(rdev, RM_IO_CQ_PIDX_OFF, value);
+}
+
+static inline u32 rm_queue_get_sq_slot_offset(struct rm_device *rdev)
+{
+	u32 index;
+
+	if ((rdev->sq.pidx - rdev->sq.cidx) >= rdev->queue_size)
+		return RM_INVALID_SLOT;
+
+	index = rdev->sq.pidx & (rdev->queue_size - 1);
+	return rdev->sq.offset + RM_CMD_SQ_SLOT_SIZE * index;
+}
+
+static inline u32 rm_queue_get_cq_slot_offset(struct rm_device *rdev)
+{
+	u32 index;
+
+	index = rdev->cq.cidx & (rdev->queue_size - 1);
+	return rdev->cq.offset + RM_CMD_CQ_SLOT_SIZE * index;
+}
+
+static int rm_queue_submit_cmd(struct rm_cmd *cmd)
+{
+	struct versal_pci_device *vdev = cmd->rdev->vdev;
+	struct rm_device *rdev = cmd->rdev;
+	u32 offset;
+	int ret;
+
+	mutex_lock(&rdev->queue);
+
+	offset = rm_queue_get_sq_slot_offset(rdev);
+	if (!offset) {
+		vdev_err(vdev, "No SQ slot available");
+		ret = -ENOSPC;
+		goto exit;
+	}
+
+	rm_queue_bulk_write(rdev, offset, (u32 *)&cmd->sq_msg,
+			    sizeof(cmd->sq_msg));
+
+	ret = rm_queue_set_pidx(rdev, RM_QUEUE_SQ, ++rdev->sq.pidx);
+	if (ret) {
+		vdev_err(vdev, "Failed to update PIDX, ret %d", ret);
+		goto exit;
+	}
+
+	list_add_tail(&cmd->list, &rdev->submitted_cmds);
+exit:
+	mutex_unlock(&rdev->queue);
+	return ret;
+}
+
+void rm_queue_withdraw_cmd(struct rm_cmd *cmd)
+{
+	mutex_lock(&cmd->rdev->queue);
+	list_del(&cmd->list);
+	mutex_unlock(&cmd->rdev->queue);
+}
+
+static int rm_queue_wait_cmd_timeout(struct rm_cmd *cmd, unsigned long timeout)
+{
+	struct versal_pci_device *vdev = cmd->rdev->vdev;
+	int ret;
+
+	if (wait_for_completion_timeout(&cmd->executed, timeout)) {
+		ret = cmd->cq_msg.data.rcode;
+		if (!ret)
+			return 0;
+
+		vdev_err(vdev, "CMD returned with a failure: %d", ret);
+		return ret;
+	}
+
+	/*
+	 * each cmds will be cleaned up by complete before it times out.
+	 * if we reach here, the cmd should be cleared and hot reset should
+	 * be issued.
+	 */
+	vdev_err(vdev, "cmd is timedout after, please reset the card");
+	rm_queue_withdraw_cmd(cmd);
+	return -ETIME;
+}
+
+int rm_queue_send_cmd(struct rm_cmd *cmd, unsigned long timeout)
+{
+	int ret;
+
+	ret = rm_queue_submit_cmd(cmd);
+	if (ret)
+		return ret;
+
+	return rm_queue_wait_cmd_timeout(cmd, timeout);
+}
+
+static int rm_process_msg(struct rm_device *rdev)
+{
+	struct versal_pci_device *vdev = rdev->vdev;
+	struct rm_cmd *cmd, *next;
+	struct rm_cmd_cq_hdr header;
+	u32 offset;
+
+	offset = rm_queue_get_cq_slot_offset(rdev);
+	if (!offset) {
+		vdev_err(vdev, "Invalid CQ offset");
+		return -EINVAL;
+	}
+
+	rm_queue_bulk_read(rdev, offset, (u32 *)&header, sizeof(header));
+
+	list_for_each_entry_safe(cmd, next, &rdev->submitted_cmds, list) {
+		u32 value = 0;
+
+		if (cmd->sq_msg.hdr.id != header.id)
+			continue;
+
+		rm_queue_bulk_read(rdev, offset + sizeof(cmd->cq_msg.hdr),
+				   (u32 *)&cmd->cq_msg.data,
+				   sizeof(cmd->cq_msg.data));
+
+		rm_queue_write(rdev, offset, value);
+
+		list_del(&cmd->list);
+		complete(&cmd->executed);
+		return 0;
+	}
+
+	vdev_err(vdev, "Unknown cmd ID %d found in CQ", header.id);
+	return -EFAULT;
+}
+
+static void rm_check_msg(struct work_struct *w)
+{
+	struct rm_device *rdev = to_rdev_msg_monitor(w);
+	int ret;
+
+	mutex_lock(&rdev->queue);
+
+	rdev->sq.cidx = rm_queue_get_cidx(rdev, RM_QUEUE_SQ);
+	rdev->cq.pidx = rm_queue_get_pidx(rdev, RM_QUEUE_CQ);
+
+	while (rdev->cq.cidx < rdev->cq.pidx) {
+		ret = rm_process_msg(rdev);
+		if (ret)
+			break;
+
+		rdev->cq.cidx++;
+
+		rm_queue_set_cidx(rdev, RM_QUEUE_CQ, rdev->cq.cidx);
+	}
+
+	mutex_unlock(&rdev->queue);
+}
+
+static void rm_sched_work(struct timer_list *t)
+{
+	struct rm_device *rdev = to_rdev_msg_timer(t);
+
+	/* Schedule a work in the general workqueue */
+	schedule_work(&rdev->msg_monitor);
+	/* Periodic timer */
+	mod_timer(&rdev->msg_timer, jiffies + RM_COMPLETION_TIMER);
+}
+
+void rm_queue_fini(struct rm_device *rdev)
+{
+	del_timer_sync(&rdev->msg_timer);
+	cancel_work_sync(&rdev->msg_monitor);
+	mutex_destroy(&rdev->queue);
+}
+
+int rm_queue_init(struct rm_device *rdev)
+{
+	struct versal_pci_device *vdev = rdev->vdev;
+	struct rm_queue_header header = {0};
+	int ret;
+
+	INIT_LIST_HEAD(&rdev->submitted_cmds);
+	mutex_init(&rdev->queue);
+
+	rm_queue_bulk_read(rdev, RM_HDR_OFF, (u32 *)&header, sizeof(header));
+
+	if (header.magic != RM_QUEUE_HDR_MAGIC_NUM) {
+		vdev_err(vdev, "Invalid RM queue header");
+		ret = -ENODEV;
+		goto error;
+	}
+
+	if (!header.version) {
+		vdev_err(vdev, "Invalid RM queue header");
+		ret = -ENODEV;
+		goto error;
+	}
+
+	sema_init(&rdev->sq.data_lock, 1);
+	sema_init(&rdev->cq.data_lock, 1);
+	rdev->queue_size = header.size;
+	rdev->sq.offset = header.sq_off;
+	rdev->cq.offset = header.cq_off;
+	rdev->sq.type = RM_QUEUE_SQ;
+	rdev->cq.type = RM_QUEUE_CQ;
+	rdev->sq.data_size = rdev->queue_buffer_size - RM_CMD_CQ_BUFFER_SIZE;
+	rdev->cq.data_size = RM_CMD_CQ_BUFFER_SIZE;
+	rdev->sq.data_offset = rdev->queue_buffer_start +
+			       RM_CMD_CQ_BUFFER_OFFSET + RM_CMD_CQ_BUFFER_SIZE;
+	rdev->cq.data_offset = rdev->queue_buffer_start +
+			       RM_CMD_CQ_BUFFER_OFFSET;
+	rdev->sq.cidx = header.sq_cidx;
+	rdev->cq.cidx = header.cq_cidx;
+
+	rdev->sq.pidx = rm_queue_get_pidx(rdev, RM_QUEUE_SQ);
+	rdev->cq.pidx = rm_queue_get_pidx(rdev, RM_QUEUE_CQ);
+
+	if (rdev->cq.cidx != rdev->cq.pidx) {
+		vdev_warn(vdev, "Clearing stale completions");
+		rdev->cq.cidx = rdev->cq.pidx;
+		rm_queue_set_cidx(rdev, RM_QUEUE_CQ, rdev->cq.cidx);
+	}
+
+	/* Create and schedule timer to do recurring work */
+	INIT_WORK(&rdev->msg_monitor, &rm_check_msg);
+	timer_setup(&rdev->msg_timer, &rm_sched_work, 0);
+	mod_timer(&rdev->msg_timer, jiffies + RM_COMPLETION_TIMER);
+
+	return 0;
+error:
+	mutex_destroy(&rdev->queue);
+	return ret;
+}
diff --git a/drivers/fpga/amd/versal-pci-rm-queue.h b/drivers/fpga/amd/versal-pci-rm-queue.h
new file mode 100644
index 000000000000..3bc7102c6a58
--- /dev/null
+++ b/drivers/fpga/amd/versal-pci-rm-queue.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Driver for Versal PCIe device
+ *
+ * Copyright (C) 2024 Advanced Micro Devices, Inc. All rights reserved.
+ */
+
+#ifndef __RM_QUEUE_H
+#define __RM_QUEUE_H
+
+struct rm_device;
+
+/* rm queue hardware setup */
+int rm_queue_init(struct rm_device *rdev);
+void rm_queue_fini(struct rm_device *rdev);
+
+/* rm queue common API */
+int rm_queue_send_cmd(struct rm_cmd *cmd, unsigned long timeout);
+void rm_queue_withdraw_cmd(struct rm_cmd *cmd);
+
+#endif	/* __RM_QUEUE_H */
diff --git a/drivers/fpga/amd/versal-pci-rm-service.h b/drivers/fpga/amd/versal-pci-rm-service.h
new file mode 100644
index 000000000000..85a78257770a
--- /dev/null
+++ b/drivers/fpga/amd/versal-pci-rm-service.h
@@ -0,0 +1,209 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Driver for Versal PCIe device
+ *
+ * Copyright (C) 2024 Advanced Micro Devices, Inc. All rights reserved.
+ */
+
+#ifndef __RM_SERVICE_H
+#define __RM_SERVICE_H
+
+#define RM_HDR_OFF			0x0
+#define RM_HDR_MAGIC_NUM		0x564D5230
+#define RM_QUEUE_HDR_MAGIC_NUM		0x5847513F
+#define RM_PCI_IO_BAR_OFF		0x2010000
+#define RM_PCI_IO_SIZE			SZ_4K
+#define RM_PCI_SHMEM_BAR_OFF		0x8000000
+#define RM_PCI_SHMEM_SIZE		SZ_128M
+#define RM_PCI_SHMEM_HDR_SIZE		0x28
+
+#define RM_QUEUE_HDR_MAGIC_NUM_OFF	0x0
+#define RM_IO_SQ_PIDX_OFF		0x0
+#define RM_IO_CQ_PIDX_OFF		0x100
+
+#define RM_CMD_ID_MIN			1
+#define RM_CMD_ID_MAX			(BIT(17) - 1)
+#define RM_CMD_SQ_HDR_OPS_MSK		GENMASK(15, 0)
+#define RM_CMD_SQ_HDR_SIZE_MSK		GENMASK(14, 0)
+#define RM_CMD_SQ_SLOT_SIZE		SZ_512
+#define RM_CMD_CQ_SLOT_SIZE		SZ_16
+#define RM_CMD_CQ_BUFFER_SIZE		(1024 * 1024)
+#define RM_CMD_CQ_BUFFER_OFFSET		0x0
+#define RM_CMD_LOG_PAGE_TYPE_MASK	GENMASK(15, 0)
+#define RM_CMD_VMR_CONTROL_MSK		GENMASK(10, 8)
+#define RM_CMD_VMR_CONTROL_PS_MASK	BIT(9)
+
+#define RM_CMD_WAIT_CONFIG_TIMEOUT	msecs_to_jiffies(10 * 1000)
+#define RM_CMD_WAIT_DOWNLOAD_TIMEOUT	msecs_to_jiffies(300 * 1000)
+
+#define RM_COMPLETION_TIMER		(HZ / 10)
+#define RM_HEALTH_CHECK_TIMER		(HZ)
+
+#define RM_INVALID_SLOT			0
+
+enum rm_queue_opcode {
+	RM_QUEUE_OP_LOAD_XCLBIN		= 0x0,
+	RM_QUEUE_OP_GET_LOG_PAGE	= 0x8,
+	RM_QUEUE_OP_LOAD_FW		= 0xA,
+	RM_QUEUE_OP_LOAD_APU_FW		= 0xD,
+	RM_QUEUE_OP_VMR_CONTROL		= 0xE,
+	RM_QUEUE_OP_IDENTIFY		= 0x202,
+};
+
+struct rm_cmd_sq_hdr {
+	__u16 opcode;
+	__u16 msg_size;
+	__u16 id;
+	__u16 reserved;
+} __packed;
+
+struct rm_cmd_cq_hdr {
+	__u16 id;
+	__u16 reserved;
+} __packed;
+
+struct rm_cmd_sq_bin {
+	__u64			address;
+	__u32			size;
+	__u32			reserved1;
+	__u32			reserved2;
+	__u32			reserved3;
+	__u64			reserved4;
+} __packed;
+
+struct rm_cmd_sq_log_page {
+	__u64			address;
+	__u32			size;
+	__u32			reserved1;
+	__u32			type;
+	__u32			reserved2;
+} __packed;
+
+struct rm_cmd_sq_ctrl {
+	__u32			status;
+} __packed;
+
+struct rm_cmd_sq_data {
+	union {
+		struct rm_cmd_sq_log_page	page;
+		struct rm_cmd_sq_bin		bin;
+		struct rm_cmd_sq_ctrl		ctrl;
+	};
+} __packed;
+
+struct rm_cmd_cq_identify {
+	__u16			major;
+	__u16			minor;
+	__u32			reserved;
+} __packed;
+
+struct rm_cmd_cq_log_page {
+	__u32			len;
+	__u32			reserved;
+} __packed;
+
+struct rm_cmd_cq_control {
+	__u16			status;
+	__u16			reserved1;
+	__u32			reserved2;
+} __packed;
+
+struct rm_cmd_cq_data {
+	union {
+		struct rm_cmd_cq_identify	identify;
+		struct rm_cmd_cq_log_page	page;
+		struct rm_cmd_cq_control	ctrl;
+		__u32				reserved[2];
+	};
+	__u32			rcode;
+} __packed;
+
+struct rm_cmd_sq_msg {
+	struct rm_cmd_sq_hdr	hdr;
+	struct rm_cmd_sq_data	data;
+} __packed;
+
+struct rm_cmd_cq_msg {
+	struct rm_cmd_cq_hdr	hdr;
+	struct rm_cmd_cq_data	data;
+} __packed;
+
+struct rm_cmd {
+	struct rm_device	*rdev;
+	struct list_head	list;
+	struct completion	executed;
+	struct rm_cmd_sq_msg	sq_msg;
+	struct rm_cmd_cq_msg	cq_msg;
+	enum rm_queue_opcode	opcode;
+	__u8			*buffer;
+	ssize_t			size;
+};
+
+enum rm_queue_type {
+	RM_QUEUE_SQ,
+	RM_QUEUE_CQ
+};
+
+enum rm_cmd_log_page_type {
+	RM_CMD_LOG_PAGE_AXI_TRIP_STATUS	= 0x0,
+	RM_CMD_LOG_PAGE_FW_ID		= 0xA,
+};
+
+struct rm_queue {
+	enum rm_queue_type	type;
+	__u32			pidx;
+	__u32			cidx;
+	__u32			offset;
+	__u32			data_offset;
+	__u32			data_size;
+	struct semaphore	data_lock;
+};
+
+struct rm_queue_header {
+	__u32			magic;
+	__u32			version;
+	__u32			size;
+	__u32			sq_off;
+	__u32			sq_slot_size;
+	__u32			cq_off;
+	__u32			sq_cidx;
+	__u32			cq_cidx;
+};
+
+struct rm_header {
+	__u32			magic;
+	__u32			queue_base;
+	__u32			queue_size;
+	__u32			status_off;
+	__u32			status_len;
+	__u32			log_index;
+	__u32			log_off;
+	__u32			log_size;
+	__u32			data_start;
+	__u32			data_end;
+};
+
+struct rm_device {
+	struct versal_pci_device	*vdev;
+
+	struct rm_header	rm_metadata;
+	__u32			queue_buffer_start;
+	__u32			queue_buffer_size;
+	__u32			queue_base;
+
+	/* Lock to queue access */
+	struct mutex		queue;
+	struct rm_queue		sq;
+	struct rm_queue		cq;
+	__u32			queue_size;
+
+	struct timer_list	msg_timer;
+	struct work_struct	msg_monitor;
+	struct timer_list	health_timer;
+	struct work_struct	health_monitor;
+	struct list_head	submitted_cmds;
+
+	__u32			firewall_tripped;
+};
+
+#endif	/* __RM_SERVICE_H */
-- 
2.34.1


