Return-Path: <linux-fpga+bounces-979-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB099EB96F
	for <lists+linux-fpga@lfdr.de>; Tue, 10 Dec 2024 19:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C37091637E4
	for <lists+linux-fpga@lfdr.de>; Tue, 10 Dec 2024 18:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71602046AB;
	Tue, 10 Dec 2024 18:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oQgPnx8j"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF181BC9E2;
	Tue, 10 Dec 2024 18:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733855881; cv=fail; b=UcUGRHe8HxLkxvTnndF7V3IDJFS/pPNl2uUgIXvo24rR36C/Du8M0D1stEdRZMXofl05K4p0jILpIHScB9qy25qkx8qEbS08Xi/AQxy5m7qb7pWLyg5IlO2AQxY76BY8mHDfIyOGGQumCtd5OjlEC4uQ4Ih5rWfuEP7fFavkyLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733855881; c=relaxed/simple;
	bh=6Yflc22+UMEVcJmTJQaSoVitwGFnbnLRelCa85EKric=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B1PwXtSKYm68rLQs567j2hGKbsFkZAjkdfHF8bqQeIm/Quw3DN5apM62VugILRom9z72/b9iy3Hd6epHg500t/CsAabYmM/4valALzARo9J47snEBHTOCp6q8ZFosTgFIz+oDvd6rUosB83lzG02K2wwXgnCYEEFV1R7SsXCB0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oQgPnx8j; arc=fail smtp.client-ip=40.107.243.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MI1/K/bhsMa7gakP0jKQlAO99XotfZecat899TiRgsTeftxdiP5QNSEqiEi2h8u8smYLpc7Nf1T2pSwctNwc9V+KVUuqC5aAOi//UJoi7hJhtzKuz3Hc4hEXxYSzQqfaKvFhN2vm1O4jwJMDqRWiPar5Wl0X9IaCDs/uDx+PJfdHdNPxETsAzuJ6FJxda5xAS0KfEf+oO8yqpgnMg6hhv2FZbxHmMlmz/Osji1tyEVBd2SF8L9qE+DRbAP2oZxtE7Kjk40Ptrw73QTd73P77T2wwtQZw8wLU7CGdea/oPse5OkmSc8tAfP4VEjU+8GzjPSfZTWhwctLyPujG7Ec74A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UkfM8v07g4zhLjtk8O46Px533kZKqiKQTfxSSh3jbqA=;
 b=E4xszOQoOmkn4bnbTqyZpM6Wy6H/aIcoKj1xZr/ChO+8T0z9R/gheo3+xd7EEPVCle0pMs0ANcTg4Y77IbohRa4K1+6/4zMacJPP2yeHVvTGZNODTaPaacoQZkc8rkaprzTXz8TKTLcGdXMnCjsJfirXX3BGb7b2PDBv7I8NHZHGryIU3+/AXs1GIb1gTyV00CYzEj6jfKtcp78bM+pRyhem7+wG/aVKmhIiAVbmLzZYliu4fokm55i+03l3Dp/vT4NmphU3NM8Ai7R0iGvBhhWJEwCEa/Z27CV0031CaXN6uHIiECCaFe6ctixLyMO3oAMgsr39dK8eVsn4Xwe9gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkfM8v07g4zhLjtk8O46Px533kZKqiKQTfxSSh3jbqA=;
 b=oQgPnx8j9B6kkvhre/3fk1EHyvakw22dPmJJQ9DsTz8nK+QxaI1otlzC2/qldXVZJU3qougFbd/81qmgknODmmg9u44bpvLz1xFW+p9FuQK2KMcSi3ciqcQKzpinCkFGHYDJi37HzUytGYG8UzuOg7E/rT+maCVIFhq5qS3fECg=
Received: from CH2PR17CA0017.namprd17.prod.outlook.com (2603:10b6:610:53::27)
 by SA0PR12MB4496.namprd12.prod.outlook.com (2603:10b6:806:9b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 18:37:55 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::21) by CH2PR17CA0017.outlook.office365.com
 (2603:10b6:610:53::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.14 via Frontend Transport; Tue,
 10 Dec 2024 18:37:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 10 Dec 2024 18:37:54 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 12:37:53 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 12:37:53 -0600
Received: from xsjyliu51.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 10 Dec 2024 12:37:53 -0600
From: Yidong Zhang <yidong.zhang@amd.com>
To: <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
	<mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>
CC: Yidong Zhang <yidong.zhang@amd.com>, <lizhi.hou@amd.com>, Nishad Saraf
	<nishads@amd.com>
Subject: [PATCH V2 2/4] drivers/fpga/amd: Add communication channel
Date: Tue, 10 Dec 2024 10:37:31 -0800
Message-ID: <20241210183734.30803-3-yidong.zhang@amd.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|SA0PR12MB4496:EE_
X-MS-Office365-Filtering-Correlation-Id: 798de9e6-d6fc-4ac1-bb99-08dd1949c2e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jUxGNSTkT/1RSajSAxb9MHH7PY+S+gXd9ei18HyOmSx/g9CW7Z3uAMIbZfOw?=
 =?us-ascii?Q?dr1bKpnDiO8P9jXGsI730S4NG3X9fUeO6mhCLOLNrv0wRLjxxUOP9aykLVzd?=
 =?us-ascii?Q?IKY1NWH9r6lcw9IbhadraLOaf2l2xLKpyT9Rs6MQVnUX8+qhQ9mzPVwW4uvK?=
 =?us-ascii?Q?1KpAhY/UhA9p/4x2dJpW/EbDZuUa5/512VvpDtddA2xUf4Gcu9z1F5LZUhYu?=
 =?us-ascii?Q?ghCrpYru/yXMh8dMyLq2mFObntXUFYINZ3xJAc3miNsPhU2qLPk7UIBwBY47?=
 =?us-ascii?Q?TmuV8Hlrtx8h77oLxxTUVeItY6Rf/f/uwgbYnfa503J/HH9t5JIUorVh2T0Y?=
 =?us-ascii?Q?wi6SxxXpejvl+ciBDoRuhimfYjm8DJgixsxtX/C8P4Ii+osFvjz5Df66uGbi?=
 =?us-ascii?Q?3v7dg9B1/8gUaabIsJ51nLa2EWyeY0s2Ng1XY+GcbEPBWz0+a+HBvg7AjrC7?=
 =?us-ascii?Q?C9g5dr6Qle5sRtABXjcMT1+v4ZS6XZpknhGJTsqxHAl9PT+Jw0oxRehFiVAF?=
 =?us-ascii?Q?Wa1c9djPwmX+7X8R5pjT1hHW3wl6d21AAd3z66ycR6vuwT6jNRuK6C14tLvm?=
 =?us-ascii?Q?ZE/bA8LcBThMlD8+800ED8vU+0vsb2Id+2lZKb/ctXCVTv6ATn8UHsIH/brm?=
 =?us-ascii?Q?QwBcnrxIi984Cm1s+74KmGRxy2SlhLLpCbDNCl1hB6KXDUglmKVTZ2lGYEHT?=
 =?us-ascii?Q?CHQnUH1KYED85AEzEOFcmwxcIzYdWMjQEKZgDkHZ0fS8KYivjKL6jW9kXtvo?=
 =?us-ascii?Q?Y+Wrru8nWvtzXkbGc8MZe803oepz6eCvQK9i5FZKeA/rbOL7nGGfTOui274d?=
 =?us-ascii?Q?j4yczdNH55I5rkGgiv/BJYITqIVc5DK2rcuDR8+BhVU3pJFxlfx9bstBSYF6?=
 =?us-ascii?Q?lv0cVRfYFcORWIiaqmQN+0IVRhHNAUW76oMTtRIV+ITIID5+9VreIbeQ4JF+?=
 =?us-ascii?Q?Ab6VWNyIOwsm/FuVhaW3o8taN/Mxwqm7ck+0+Fdfl8VnXoTZOZa6tKJUQmF5?=
 =?us-ascii?Q?EqMOcRXzJkTWwH5wT+1MrAiruxbUddrAvGtlNpgZcyd8mBp3asIOvknBVlN7?=
 =?us-ascii?Q?pqK2lbmyZzDHI3I7bVWUE4LFlYolG9lnxuwaO2nodSVLSaAYm/TVLG0D56ER?=
 =?us-ascii?Q?kTCVfk8PlNmckNdz2QYVbxgxabYFLziXfw/LF2ScH3YihSfkLjq9KcMDA6jC?=
 =?us-ascii?Q?noHYmPnOJbGEw9HG8seTS+q7hLK3rI+ubriKc5Sp90qsXtPb2e88Dbog6FF5?=
 =?us-ascii?Q?DLwPzHbY5wQAbvKlmdNJ6r7fwH02wMFqnkedtZZu893EBkwPB74bYxa/G4Gt?=
 =?us-ascii?Q?GHTA8hJXMGfCug59t1myn4c16TwKExGL4jF2HtKQR2e4IiqLMSf+BwG5kuO2?=
 =?us-ascii?Q?SSe7lOPR4Hda1sw354Gx7GtTsGqFhs0VuWx3G1O4Qm8p7JEhk7MtRv3z7mje?=
 =?us-ascii?Q?H0cNAHFwD2tkyutDtP6Z6cpTlwyG3Wdh?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 18:37:54.8461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 798de9e6-d6fc-4ac1-bb99-08dd1949c2e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4496

The communication channel (comm_chan) service is between versal-pci and the
user PF driver. When the user PF driver requests PL data download, the
comm_chan service will handle the request by versal_pci_load_xclbin.

Co-developed-by: Nishad Saraf <nishads@amd.com>
Signed-off-by: Nishad Saraf <nishads@amd.com>
Signed-off-by: Yidong Zhang <yidong.zhang@amd.com>
---
 drivers/fpga/amd/Makefile               |   3 +-
 drivers/fpga/amd/versal-pci-comm-chan.c | 271 ++++++++++++++++++++++++
 drivers/fpga/amd/versal-pci-comm-chan.h |  14 ++
 drivers/fpga/amd/versal-pci-main.c      |  14 +-
 drivers/fpga/amd/versal-pci.h           |   2 +
 5 files changed, 301 insertions(+), 3 deletions(-)
 create mode 100644 drivers/fpga/amd/versal-pci-comm-chan.c
 create mode 100644 drivers/fpga/amd/versal-pci-comm-chan.h

diff --git a/drivers/fpga/amd/Makefile b/drivers/fpga/amd/Makefile
index 5d1ef04b5e80..7a604785e5f9 100644
--- a/drivers/fpga/amd/Makefile
+++ b/drivers/fpga/amd/Makefile
@@ -2,4 +2,5 @@
 
 obj-$(CONFIG_AMD_VERSAL_PCI)			+= versal-pci.o
 
-versal-pci-$(CONFIG_AMD_VERSAL_PCI)		:= versal-pci-main.o
+versal-pci-$(CONFIG_AMD_VERSAL_PCI)		:= versal-pci-main.o \
+						   versal-pci-comm-chan.o
diff --git a/drivers/fpga/amd/versal-pci-comm-chan.c b/drivers/fpga/amd/versal-pci-comm-chan.c
new file mode 100644
index 000000000000..20ccb1ac7754
--- /dev/null
+++ b/drivers/fpga/amd/versal-pci-comm-chan.c
@@ -0,0 +1,271 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for Versal PCIe device
+ *
+ * Copyright (C) 2024 Advanced Micro Devices, Inc. All rights reserved.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/pci.h>
+
+#include "versal-pci.h"
+#include "versal-pci-comm-chan.h"
+
+#define COMM_CHAN_PROTOCOL_VERSION		1
+#define COMM_CHAN_PCI_BAR_OFF			0x2000000
+#define COMM_CHAN_TIMER				(HZ / 10)
+#define COMM_CHAN_DATA_LEN			16
+#define COMM_CHAN_DATA_TYPE_MASK		GENMASK(7, 0)
+#define COMM_CHAN_DATA_EOM_MASK			BIT(31)
+#define COMM_CHAN_MSG_END			BIT(31)
+
+#define COMM_CHAN_REG_WRDATA_OFF		0x0
+#define COMM_CHAN_REG_RDDATA_OFF		0x8
+#define COMM_CHAN_REG_STATUS_OFF		0x10
+#define COMM_CHAN_REG_ERROR_OFF			0x14
+#define COMM_CHAN_REG_RIT_OFF			0x1C
+#define COMM_CHAN_REG_IS_OFF			0x20
+#define COMM_CHAN_REG_IE_OFF			0x24
+#define COMM_CHAN_REG_CTRL_OFF			0x2C
+#define COMM_CHAN_REGS_SIZE			SZ_4K
+
+#define COMM_CHAN_IRQ_DISABLE_ALL		0
+#define COMM_CHAN_IRQ_RECEIVE_ENABLE		BIT(1)
+#define COMM_CHAN_IRQ_CLEAR_ALL			GENMASK(2, 0)
+#define COMM_CHAN_CLEAR_FIFO			GENMASK(1, 0)
+#define COMM_CHAN_RECEIVE_THRESHOLD		15
+
+enum comm_chan_req_ops {
+	COMM_CHAN_REQ_OPS_UNKNOWN		= 0,
+	COMM_CHAN_REQ_OPS_HOT_RESET		= 5,
+	COMM_CHAN_REQ_OPS_GET_PROTOCOL_VERSION	= 19,
+	COMM_CHAN_REQ_OPS_LOAD_XCLBIN_UUID	= 20,
+	COMM_CHAN_REQ_OPS_MAX,
+};
+
+enum comm_chan_msg_type {
+	COMM_CHAN_MSG_INVALID			= 0,
+	COMM_CHAN_MSG_START			= 2,
+	COMM_CHAN_MSG_BODY			= 3,
+};
+
+enum comm_chan_msg_service_type {
+	COMM_CHAN_MSG_SRV_RESPONSE		= BIT(0),
+	COMM_CHAN_MSG_SRV_REQUEST		= BIT(1),
+};
+
+struct comm_chan_hw_msg {
+	struct {
+		__u32		type;
+		__u32		payload_size;
+	} header;
+	struct {
+		__u64		id;
+		__u32		flags;
+		__u32		size;
+		__u32		payload[COMM_CHAN_DATA_LEN - 6];
+	} body;
+} __packed;
+
+struct comm_chan_srv_req {
+	__u64			flags;
+	__u32			opcode;
+	__u32			data[];
+};
+
+struct comm_chan_srv_ver_resp {
+	__u32			version;
+};
+
+struct comm_chan_srv_uuid_resp {
+	__u32			ret;
+};
+
+struct comm_chan_msg {
+	__u64			id;
+	__u32			flags;
+	__u32			len;
+	__u32			bytes_read;
+	__u32			data[10];
+};
+
+struct comm_chan_device {
+	struct versal_pci_device	*vdev;
+	struct timer_list		timer;
+	struct work_struct		work;
+};
+
+static inline struct comm_chan_device *to_ccdev_work(struct work_struct *w)
+{
+	return container_of(w, struct comm_chan_device, work);
+}
+
+static inline struct comm_chan_device *to_ccdev_timer(struct timer_list *t)
+{
+	return container_of(t, struct comm_chan_device, timer);
+}
+
+static inline u32 comm_chan_read(struct comm_chan_device *cdev, u32 offset)
+{
+	return readl(cdev->vdev->io_regs + COMM_CHAN_PCI_BAR_OFF + offset);
+}
+
+static inline void comm_chan_write(struct comm_chan_device *cdev, u32 offset, const u32 value)
+{
+	writel(value, cdev->vdev->io_regs + COMM_CHAN_PCI_BAR_OFF + offset);
+}
+
+static u32 comm_chan_set_uuid_resp(void *payload, int ret)
+{
+	struct comm_chan_srv_uuid_resp *resp = (struct comm_chan_srv_uuid_resp *)payload;
+	u32 resp_len = sizeof(*resp);
+
+	resp->ret = (u32)ret;
+
+	return resp_len;
+}
+
+static u32 comm_chan_set_protocol_resp(void *payload)
+{
+	struct comm_chan_srv_ver_resp *resp = (struct comm_chan_srv_ver_resp *)payload;
+	u32 resp_len = sizeof(*resp);
+
+	resp->version = COMM_CHAN_PROTOCOL_VERSION;
+
+	return sizeof(resp_len);
+}
+
+static void comm_chan_send_response(struct comm_chan_device *ccdev, u64 msg_id, void *payload)
+{
+	struct comm_chan_srv_req *req = (struct comm_chan_srv_req *)payload;
+	struct versal_pci_device *vdev = ccdev->vdev;
+	struct comm_chan_hw_msg response = {0};
+	u32 size;
+	int ret;
+	u8 i;
+
+	switch (req->opcode) {
+	case COMM_CHAN_REQ_OPS_GET_PROTOCOL_VERSION:
+		size = comm_chan_set_protocol_resp(response.body.payload);
+		break;
+	case COMM_CHAN_REQ_OPS_LOAD_XCLBIN_UUID:
+		ret = versal_pci_load_xclbin(vdev, (uuid_t *)req->data);
+		size = comm_chan_set_uuid_resp(response.body.payload, ret);
+		break;
+	default:
+		vdev_err(vdev, "Unsupported request opcode: %d", req->opcode);
+		*response.body.payload = -1;
+		size = sizeof(int);
+	}
+
+	vdev_dbg(vdev, "Response opcode: %d", req->opcode);
+
+	response.header.type = COMM_CHAN_MSG_START | COMM_CHAN_MSG_END;
+	response.header.payload_size = size;
+
+	response.body.flags = COMM_CHAN_MSG_SRV_RESPONSE;
+	response.body.size = size;
+	response.body.id = msg_id;
+
+	for (i = 0; i < COMM_CHAN_DATA_LEN; i++)
+		comm_chan_write(ccdev, COMM_CHAN_REG_WRDATA_OFF, ((u32 *)&response)[i]);
+}
+
+#define STATUS_IS_READY(status) ((status) & BIT(1))
+#define STATUS_IS_ERROR(status) ((status) & BIT(2))
+
+static void comm_chan_check_request(struct work_struct *w)
+{
+	struct comm_chan_device *ccdev = to_ccdev_work(w);
+	u32 status = 0, request[COMM_CHAN_DATA_LEN] = {0};
+	struct comm_chan_hw_msg *hw_msg;
+	u8 type, eom;
+	int i;
+
+	status = comm_chan_read(ccdev, COMM_CHAN_REG_IS_OFF);
+	if (!STATUS_IS_READY(status))
+		return;
+	if (STATUS_IS_ERROR(status)) {
+		vdev_err(ccdev->vdev, "An error has occurred with comms");
+		return;
+	}
+
+	/* ACK status */
+	comm_chan_write(ccdev, COMM_CHAN_REG_IS_OFF, status);
+
+	for (i = 0; i < COMM_CHAN_DATA_LEN; i++)
+		request[i] = comm_chan_read(ccdev, COMM_CHAN_REG_RDDATA_OFF);
+
+	hw_msg = (struct comm_chan_hw_msg *)request;
+	type = FIELD_GET(COMM_CHAN_DATA_TYPE_MASK, hw_msg->header.type);
+	eom = FIELD_GET(COMM_CHAN_DATA_EOM_MASK, hw_msg->header.type);
+
+	/* Only support fixed size 64B messages */
+	if (!eom || type != COMM_CHAN_MSG_START) {
+		vdev_err(ccdev->vdev, "Unsupported message format or length");
+		return;
+	}
+
+	if (hw_msg->body.flags != COMM_CHAN_MSG_SRV_REQUEST) {
+		vdev_err(ccdev->vdev, "Unsupported service request");
+		return;
+	}
+
+	if (hw_msg->body.size > sizeof(hw_msg->body.payload)) {
+		vdev_err(ccdev->vdev, "msg is too big: %d", hw_msg->body.size);
+		return;
+	}
+
+	/* Now decode and respond appropriately */
+	comm_chan_send_response(ccdev, hw_msg->body.id, hw_msg->body.payload);
+}
+
+static void comm_chan_sched_work(struct timer_list *t)
+{
+	struct comm_chan_device *ccdev = to_ccdev_timer(t);
+
+	/* Schedule a work in the general workqueue */
+	schedule_work(&ccdev->work);
+	/* Periodic timer */
+	mod_timer(&ccdev->timer, jiffies + COMM_CHAN_TIMER);
+}
+
+static void comm_chan_config(struct comm_chan_device *ccdev)
+{
+	/* Disable interrupts */
+	comm_chan_write(ccdev, COMM_CHAN_REG_IE_OFF, COMM_CHAN_IRQ_DISABLE_ALL);
+	/* Clear request and response FIFOs */
+	comm_chan_write(ccdev, COMM_CHAN_REG_CTRL_OFF, COMM_CHAN_CLEAR_FIFO);
+	/* Clear interrupts */
+	comm_chan_write(ccdev, COMM_CHAN_REG_IS_OFF, COMM_CHAN_IRQ_CLEAR_ALL);
+	/* Setup RIT reg */
+	comm_chan_write(ccdev, COMM_CHAN_REG_RIT_OFF, COMM_CHAN_RECEIVE_THRESHOLD);
+	/* Enable RIT interrupt */
+	comm_chan_write(ccdev, COMM_CHAN_REG_IE_OFF, COMM_CHAN_IRQ_RECEIVE_ENABLE);
+
+	/* Create and schedule timer to do recurring work */
+	INIT_WORK(&ccdev->work, &comm_chan_check_request);
+	timer_setup(&ccdev->timer, &comm_chan_sched_work, 0);
+	mod_timer(&ccdev->timer, jiffies + COMM_CHAN_TIMER);
+}
+
+void versal_pci_comm_chan_fini(struct comm_chan_device *ccdev)
+{
+	/* First stop scheduling new work then cancel work */
+	del_timer_sync(&ccdev->timer);
+	cancel_work_sync(&ccdev->work);
+}
+
+struct comm_chan_device *versal_pci_comm_chan_init(struct versal_pci_device *vdev)
+{
+	struct comm_chan_device *ccdev;
+
+	ccdev = devm_kzalloc(&vdev->pdev->dev, sizeof(*ccdev), GFP_KERNEL);
+	if (!ccdev)
+		return ERR_PTR(-ENOMEM);
+
+	ccdev->vdev = vdev;
+
+	comm_chan_config(ccdev);
+	return ccdev;
+}
diff --git a/drivers/fpga/amd/versal-pci-comm-chan.h b/drivers/fpga/amd/versal-pci-comm-chan.h
new file mode 100644
index 000000000000..7605abc5527f
--- /dev/null
+++ b/drivers/fpga/amd/versal-pci-comm-chan.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Driver for Versal PCIe device
+ *
+ * Copyright (C) 2024 Advanced Micro Devices, Inc. All rights reserved.
+ */
+
+#ifndef __VERSAL_PCI_COMM_CHAN_H
+#define __VERSAL_PCI_COMM_CHAN_H
+
+struct comm_chan_device *versal_pci_comm_chan_init(struct versal_pci_device *vdev);
+void versal_pci_comm_chan_fini(struct comm_chan_device *ccdev);
+
+#endif	/* __VERSAL_PCI_COMM_CHAN_H */
diff --git a/drivers/fpga/amd/versal-pci-main.c b/drivers/fpga/amd/versal-pci-main.c
index a10ccf86802b..a3b83197c6d5 100644
--- a/drivers/fpga/amd/versal-pci-main.c
+++ b/drivers/fpga/amd/versal-pci-main.c
@@ -8,6 +8,7 @@
 #include <linux/pci.h>
 
 #include "versal-pci.h"
+#include "versal-pci-comm-chan.h"
 
 #define DRV_NAME			"amd-versal-pci"
 
@@ -238,6 +239,7 @@ static void versal_pci_device_teardown(struct versal_pci_device *vdev)
 {
 	versal_pci_fpga_fini(vdev->fdev);
 	versal_pci_fw_upload_fini(vdev->fwdev);
+	versal_pci_comm_chan_fini(vdev->ccdev);
 }
 
 static int versal_pci_device_setup(struct versal_pci_device *vdev)
@@ -251,15 +253,23 @@ static int versal_pci_device_setup(struct versal_pci_device *vdev)
 		return ret;
 	}
 
+	vdev->ccdev = versal_pci_comm_chan_init(vdev);
+	if (IS_ERR(vdev->ccdev)) {
+		ret = PTR_ERR(vdev->ccdev);
+		vdev_err(vdev, "Failed to init comms channel, err %d", ret);
+		goto upload_fini;
+	}
+
 	vdev->fdev = versal_pci_fpga_init(vdev);
 	if (IS_ERR(vdev->fdev)) {
 		ret = PTR_ERR(vdev->fdev);
 		vdev_err(vdev, "Failed to init FPGA manager, err %d", ret);
-		goto upload_fini;
+		goto comm_chan_fini;
 	}
 
 	return 0;
-
+comm_chan_fini:
+	versal_pci_comm_chan_fini(vdev->ccdev);
 upload_fini:
 	versal_pci_fw_upload_fini(vdev->fwdev);
 
diff --git a/drivers/fpga/amd/versal-pci.h b/drivers/fpga/amd/versal-pci.h
index 1509bd0532ea..6c1ca3ce505d 100644
--- a/drivers/fpga/amd/versal-pci.h
+++ b/drivers/fpga/amd/versal-pci.h
@@ -26,6 +26,7 @@
 	dev_dbg(&(vdev)->pdev->dev, fmt, ##args)
 
 struct versal_pci_device;
+struct comm_chan_device;
 
 struct axlf_header {
 	__u64				length;
@@ -69,6 +70,7 @@ struct versal_pci_device {
 	struct pci_dev			*pdev;
 
 	struct fpga_device		*fdev;
+	struct comm_chan_device         *ccdev;
 	struct firmware_device		*fwdev;
 	struct device			*device;
 
-- 
2.34.1


