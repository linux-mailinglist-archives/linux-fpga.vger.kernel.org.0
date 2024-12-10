Return-Path: <linux-fpga+bounces-981-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D18319EB973
	for <lists+linux-fpga@lfdr.de>; Tue, 10 Dec 2024 19:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B62163816
	for <lists+linux-fpga@lfdr.de>; Tue, 10 Dec 2024 18:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3B2214227;
	Tue, 10 Dec 2024 18:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a5Gd/XZT"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8102F214214;
	Tue, 10 Dec 2024 18:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733855887; cv=fail; b=t93RIeURBapBeDvmDqSGflsUjVghAki6yhVvm4SGyhiFKQCPmk+lzsEdAkzQE1qcYGRbbSfwFetUXpGEuYbpa3ZBPmzgMfKzGZFi07ylD97cC2BRwIURpsFuEW1E3UPPE42TJF3W3StpK0iCRpMSVTpw9EgDxD1dD7xqPCyMoFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733855887; c=relaxed/simple;
	bh=GpQDLaKH50MB2GBB3cqdgGDlaFb3zQl2c+JiALyAiMk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KCEvrXFS1A/yRe8W1xuJjHh5OopApKk9yIYHDpopvCLIPZJwNqfmnMrVYrkXH7nzMPkPupMd9iSe9PXQKEbne+p6w+Htg+zc17NxjlTElu4yHNWeqMWM6oMwrvqYvE0oz1tMpvRtgfljlJ4Qs0TT2muEmBTazOUfhl0JzHAi1eU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a5Gd/XZT; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FXtETrF8USuL5eNk/+J8JIkMouoTlSTaek7buB24tHo7l3J6GFiZRe1wHe/9S5nA5zZ9BfLL7CzsMemaiZlnm7Gk7x6AJEG4gydmQDSAz+vETPrXKRJHJSSuvLRoJdMUS2KXUn8NS6YmDSbSmYTtWI6rLIKmHA4sympSZLe2jKSVOk8YxocE37yXrsVR7yTA81gKNLVbjV0kpcOwZJscbhlP8sMyNt96Ul2TRU25CJ8liNoYcXBkACwumIwlu5EeuLdTCooT9cOhN3xCnD0TlPNIE4C6oRroZ7PPT4Wi80VeCi/ABwqNalEWNSISJdeEbevRXD0YRiZdCvVX8HTN5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qYHfyBW3ia1q5G4plYvmmIk4ry4jwrUFeKOExRWp7Q=;
 b=PeRBOXSpy71nedndjiewuY69ahiAOGruZUPhF42IuZ7Lv2K68e/T3tQ0ZA96HOGgZ8M+wh4Xjswzb7lmV/lKDViLai3Mc2bE2nGS49hjx8BeuSV6eeyW5E6/cwHGGUWsKmEadrw/QRqXwySwqcWxM9ZwmEP7xEZEslS78Na0Udrc8gIvdnnw5ZFeJTQCjO/8wQtsjy6bZkI8QOiYC2PnUXaR9r07Mq1TSTGwSiVW3UxSz0P1D+mvKPlAtmDiNYcegOA5g7NQJUc9P1fFItrg3i3HV311uoOiWURg6Wazom6J+rm1JDkqdb3Ell5+E5/ytuZe92LRxHDXHkctuvbp1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qYHfyBW3ia1q5G4plYvmmIk4ry4jwrUFeKOExRWp7Q=;
 b=a5Gd/XZTiq8vnZyvEqa/+5Adgi0ZQ+Fo3qNsBtNG/kscHT2kA9SJMRGQyjqP3M+ulkkvaTON3jdYHaciV5H2H61CTZ782Sqx8onKaGfzqFQaXabKWwe/p/xwpR8a+kbOa1a3IMPINbMmsjtD2o7ZIGlRGnYqawj3wbqQFvJxk4U=
Received: from PH7P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::6)
 by CH3PR12MB8306.namprd12.prod.outlook.com (2603:10b6:610:12c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Tue, 10 Dec
 2024 18:37:58 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:510:32a:cafe::4f) by PH7P221CA0020.outlook.office365.com
 (2603:10b6:510:32a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.14 via Frontend Transport; Tue,
 10 Dec 2024 18:37:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 10 Dec 2024 18:37:57 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 12:37:55 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 12:37:55 -0600
Received: from xsjyliu51.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 10 Dec 2024 12:37:54 -0600
From: Yidong Zhang <yidong.zhang@amd.com>
To: <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
	<mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>
CC: Yidong Zhang <yidong.zhang@amd.com>, <lizhi.hou@amd.com>, Nishad Saraf
	<nishads@amd.com>, Prapul Krishnamurthy <prapulk@amd.com>
Subject: [PATCH V2 4/4] drivers/fpga/amd: Add load xclbin and load firmware
Date: Tue, 10 Dec 2024 10:37:33 -0800
Message-ID: <20241210183734.30803-5-yidong.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|CH3PR12MB8306:EE_
X-MS-Office365-Filtering-Correlation-Id: c14ca5e7-707b-4339-c743-08dd1949c48c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HxwKpdRrumlDz45/vWQRUuXHK5Ujacd3hcluhN4HrT8qtriubjyqefiHOP0a?=
 =?us-ascii?Q?Gvf0nb7cKEv8yWBqQ9hm9kzROqJBAwKb+yUruLY9eYUP8kToWsZpicSiGBUu?=
 =?us-ascii?Q?iSkR8r2bkMsYoYsQCxI9kN8NvFcd1xS+5Kau2/8ZsuC4WuvBh15RTgBBjgg5?=
 =?us-ascii?Q?Jlx4uki5ONYHqoTw6DNrCCSe6+V49l+LZ2PEDdZUwL5i+K7FQJX3muKzLQL/?=
 =?us-ascii?Q?rOP0F8RBbWii+geqCQnwlsbL7xjIKv5PkMH8JOt47+/6iAM6GAeKXXQnLIBX?=
 =?us-ascii?Q?lPGhuqqLWMwOAnTH3lzH8DePEsyxaxXBaSGDLnAr/SGQQaYhcysmuCNIjJcz?=
 =?us-ascii?Q?O+ljq605W7Eny8SGnXsHNmRiXs1MQHSjU8sjpAlNBFHsK9a5hp6TS0Gd11JA?=
 =?us-ascii?Q?LF8Ix2/zSXlUnGRkDeQ33Y5P8F3wbhDl6ExwhzwAfZJXeMkjHhBeRiMEXZFI?=
 =?us-ascii?Q?F6raDZMI0HmTIeG/LccZeGzze5WkoSEyl6H3LBIvC1ntsf4ljVTG90grcO8o?=
 =?us-ascii?Q?i44U2VerdxRHBeZyrLkE1S8qI4W2OHlkr6Q7axNXTZHGL5CaXtvE/mCrxNNo?=
 =?us-ascii?Q?FHO1SUXPyThcQprRfJXwpL4tJj4mhD55X2pAN+Kn2fHaQxdXMT1txQrUJoyv?=
 =?us-ascii?Q?YtaNhJmx/HEmq7p+IZ4tF+Q0DSCfT91pgT8vKslZ9P6Sojnj0hSn5v63OMDI?=
 =?us-ascii?Q?SNY7WM4mvcCEnu9C5R4orkY10JPZfyOm1sxLMbvWi9pWbSALmXTbmAhaZMZ6?=
 =?us-ascii?Q?6OTlgjqMFWOzGgZ4qc5ERPNaxKjkKMPNvUn7KGvdna4Y/lkcBhDjbLhtDLIW?=
 =?us-ascii?Q?3HWjVjqoLtqOvx23Wzte1S8jxnV3GApGVo0U9+M5hOQsE1QMNiOxbJq8m5sp?=
 =?us-ascii?Q?6Zazu167vwZokkRjnFNyCv5a8O3AFf+oqkrCByxSqD+BVL1Nu0SHaHb7+vK6?=
 =?us-ascii?Q?acKIhFw/Mq5hBK1jjTiojIYF9S9fRYB3XcvG4cTtmyvO8dGl4O5AhbO3vmbI?=
 =?us-ascii?Q?pXroIUcWFtdOWkBC0R7p0L+bQn+QKkiqhpR1W2hhikGDuNHmTSXa/AS4KaJ0?=
 =?us-ascii?Q?d88pIwn0y4yVYwsr4oMNkQrixUivUeKWFmele31WQGHHx6h0zpzFWtmrnrsG?=
 =?us-ascii?Q?3FMrUvHnql9y/qZMlRNqY0wnapoRsx7//SzLv+v49Ip0gGnOo1CAo6KLQ77r?=
 =?us-ascii?Q?BDzJ8Qs/eickFL/dAToyC7kj5VaNhMpS0p+cmElDaarL81XZL9KPS2isCaQH?=
 =?us-ascii?Q?HuYGqDum66D9s7+9rqj+xRVTMHw0CJMkjvfAv5HHx2Oq9fyG1jEx00LS4tlN?=
 =?us-ascii?Q?CZdWztU27zF7qjE0Txx5yq9kbyHlk4klGXDvTryZhSEH1FIw2AzoGG0SlEC8?=
 =?us-ascii?Q?s9DvWajBUv2Gya1pla17UNl6/ZmYsTrW/M7gmvdo8x8CsWLHO3Ge+BGXuEwB?=
 =?us-ascii?Q?Y2EFGlPO8vZYfFQgULBfy7ZZJeh+YA9J?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 18:37:57.6408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c14ca5e7-707b-4339-c743-08dd1949c48c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8306

   - programming FW
     - The base FW is downloaded onto the flash of the card.
     - The APU FW is downloaded once after a POR (power on reset).
     - Reloading the MgmtPF driver will not change any existing hardware.

   - programming FPGA hardware binaries - PL Data
    - using fpga framework ops to support re-programing FPGA
    - the re-programming request will be initiated from the existing UserPF
      driver only, and the MgmtPF driver load the matched PL Data after
      receiving request from the communication channel. The matching PL
      Data is indexed by the PL Data UUID and Base FW UUID.
      - The Base FW UUID identifies unique based hardware. Often called the
      interface UUID.
      - The PL Data UUID identifies unique PL design that is generated
      based on the base hardware. Often called xclbin UUID.

    - Example:
      4fdebe35[...trimmed...]_96df7d[...trimmed...].xclbin
      |                     | |                   |
      +--  xclbin UUID    --+ +--interface UUID --+

Co-developed-by: Nishad Saraf <nishads@amd.com>
Signed-off-by: Nishad Saraf <nishads@amd.com>
Co-developed-by: Prapul Krishnamurthy <prapulk@amd.com>
Signed-off-by: Prapul Krishnamurthy <prapulk@amd.com>
Signed-off-by: Yidong Zhang <yidong.zhang@amd.com>
---
 drivers/fpga/amd/Makefile                |   3 +-
 drivers/fpga/amd/versal-pci-main.c       | 137 ++++++-
 drivers/fpga/amd/versal-pci-rm-queue.c   |  14 +-
 drivers/fpga/amd/versal-pci-rm-service.c | 497 +++++++++++++++++++++++
 drivers/fpga/amd/versal-pci-rm-service.h |  20 +
 drivers/fpga/amd/versal-pci.h            |   2 +
 6 files changed, 649 insertions(+), 24 deletions(-)
 create mode 100644 drivers/fpga/amd/versal-pci-rm-service.c

diff --git a/drivers/fpga/amd/Makefile b/drivers/fpga/amd/Makefile
index b2ffdbf23400..ffe4ead0d55e 100644
--- a/drivers/fpga/amd/Makefile
+++ b/drivers/fpga/amd/Makefile
@@ -4,4 +4,5 @@ obj-$(CONFIG_AMD_VERSAL_PCI)			+= versal-pci.o
 
 versal-pci-$(CONFIG_AMD_VERSAL_PCI)		:= versal-pci-main.o \
 						   versal-pci-comm-chan.o \
-						   versal-pci-rm-queue.o
+						   versal-pci-rm-queue.o \
+						   versal-pci-rm-service.o
diff --git a/drivers/fpga/amd/versal-pci-main.c b/drivers/fpga/amd/versal-pci-main.c
index a3b83197c6d5..b56449932c05 100644
--- a/drivers/fpga/amd/versal-pci-main.c
+++ b/drivers/fpga/amd/versal-pci-main.c
@@ -9,6 +9,8 @@
 
 #include "versal-pci.h"
 #include "versal-pci-comm-chan.h"
+#include "versal-pci-rm-service.h"
+#include "versal-pci-rm-queue.h"
 
 #define DRV_NAME			"amd-versal-pci"
 
@@ -18,22 +20,55 @@
 static int versal_pci_fpga_write_init(struct fpga_manager *mgr, struct fpga_image_info *info,
 				      const char *buf, size_t count)
 {
-	/* TODO */
-	return 0;
+	struct fpga_device *fdev = mgr->priv;
+	struct fw_tnx *tnx = &fdev->fw;
+	int ret;
+
+	ret = rm_queue_create_cmd(fdev->vdev->rdev, tnx->opcode, &tnx->cmd);
+	if (ret) {
+		fdev->state = FPGA_MGR_STATE_WRITE_INIT_ERR;
+		return ret;
+	}
+
+	fdev->state = FPGA_MGR_STATE_WRITE_INIT;
+	return ret;
 }
 
 static int versal_pci_fpga_write(struct fpga_manager *mgr, const char *buf,
 				 size_t count)
 {
-	/* TODO */
-	return 0;
+	struct fpga_device *fdev = mgr->priv;
+	int ret;
+
+	ret = rm_queue_data_init(fdev->fw.cmd, buf, count);
+	if (ret) {
+		fdev->state = FPGA_MGR_STATE_WRITE_ERR;
+		rm_queue_destory_cmd(fdev->fw.cmd);
+		return ret;
+	}
+
+	fdev->state = FPGA_MGR_STATE_WRITE;
+	return ret;
 }
 
 static int versal_pci_fpga_write_complete(struct fpga_manager *mgr,
 					  struct fpga_image_info *info)
 {
-	/* TODO */
-	return 0;
+	struct fpga_device *fdev = mgr->priv;
+	int ret;
+
+	ret = rm_queue_send_cmd(fdev->fw.cmd, RM_CMD_WAIT_DOWNLOAD_TIMEOUT);
+	if (ret) {
+		fdev->state = FPGA_MGR_STATE_WRITE_COMPLETE_ERR;
+		vdev_err(fdev->vdev, "Send cmd failed:%d, cid:%d", ret, fdev->fw.id);
+	} else {
+		fdev->state = FPGA_MGR_STATE_WRITE_COMPLETE;
+	}
+
+	rm_queue_data_fini(fdev->fw.cmd);
+	rm_queue_destory_cmd(fdev->fw.cmd);
+	memset(&fdev->fw, 0, sizeof(fdev->fw));
+	return ret;
 }
 
 static enum fpga_mgr_states versal_pci_fpga_state(struct fpga_manager *mgr)
@@ -97,10 +132,20 @@ static struct fpga_device *versal_pci_fpga_init(struct versal_pci_device *vdev)
 		return ERR_PTR(ret);
 	}
 
-	/* Place holder for rm_queue_get_fw_id(vdev->rdev) */
+	ret = rm_queue_get_fw_id(vdev->rdev);
+	if (ret) {
+		vdev_warn(vdev, "Failed to get fw_id");
+		ret = -EINVAL;
+		goto unregister_fpga_mgr;
+	}
 	versal_pci_uuid_parse(vdev, &vdev->intf_uuid);
 
 	return fdev;
+
+unregister_fpga_mgr:
+	fpga_mgr_unregister(fdev->mgr);
+
+	return ERR_PTR(ret);
 }
 
 static int versal_pci_program_axlf(struct versal_pci_device *vdev, char *data, size_t size)
@@ -161,31 +206,84 @@ int versal_pci_load_xclbin(struct versal_pci_device *vdev, uuid_t *xuuid)
 static enum fw_upload_err versal_pci_fw_prepare(struct fw_upload *fw_upload, const u8 *data,
 						u32 size)
 {
-	/* TODO */
+	struct firmware_device *fwdev = fw_upload->dd_handle;
+	struct axlf *xsabin = (struct axlf *)data;
+	int ret;
+
+	ret = memcmp(xsabin->magic, VERSAL_XCLBIN_MAGIC_ID, sizeof(VERSAL_XCLBIN_MAGIC_ID));
+	if (ret) {
+		vdev_err(fwdev->vdev, "Invalid device firmware");
+		return FW_UPLOAD_ERR_INVALID_SIZE;
+	}
+
+	/* Firmware size should never be over 1G and less than size of struct axlf */
+	if (!size || size != xsabin->header.length || size < sizeof(*xsabin) ||
+	    size > 1024 * 1024 * 1024) {
+		vdev_err(fwdev->vdev, "Invalid device firmware size");
+		return FW_UPLOAD_ERR_INVALID_SIZE;
+	}
+
+	ret = rm_queue_create_cmd(fwdev->vdev->rdev, RM_QUEUE_OP_LOAD_FW,
+				  &fwdev->cmd);
+	if (ret)
+		return FW_UPLOAD_ERR_RW_ERROR;
+
+	uuid_copy(&fwdev->uuid, &xsabin->header.uuid);
 	return FW_UPLOAD_ERR_NONE;
 }
 
 static enum fw_upload_err versal_pci_fw_write(struct fw_upload *fw_upload, const u8 *data,
 					      u32 offset, u32 size, u32 *written)
 {
-	/* TODO */
+	struct firmware_device *fwdev = fw_upload->dd_handle;
+	int ret;
+
+	ret = rm_queue_data_init(fwdev->cmd, data, size);
+	if (ret)
+		return FW_UPLOAD_ERR_RW_ERROR;
+
+	*written = size;
 	return FW_UPLOAD_ERR_NONE;
 }
 
 static enum fw_upload_err versal_pci_fw_poll_complete(struct fw_upload *fw_upload)
 {
-	/* TODO */
+	struct firmware_device *fwdev = fw_upload->dd_handle;
+	int ret;
+
+	vdev_info(fwdev->vdev, "Programming device firmware: %pUb", &fwdev->uuid);
+
+	ret = rm_queue_send_cmd(fwdev->cmd, RM_CMD_WAIT_DOWNLOAD_TIMEOUT);
+	if (ret) {
+		vdev_err(fwdev->vdev, "Send cmd failedi:%d, cid %d", ret, fwdev->id);
+		return FW_UPLOAD_ERR_HW_ERROR;
+	}
+
+	vdev_info(fwdev->vdev, "Successfully programmed device firmware: %pUb",
+		  &fwdev->uuid);
 	return FW_UPLOAD_ERR_NONE;
 }
 
 static void versal_pci_fw_cancel(struct fw_upload *fw_upload)
 {
-	/* TODO */
+	struct firmware_device *fwdev = fw_upload->dd_handle;
+
+	vdev_warn(fwdev->vdev, "canceled");
+	rm_queue_withdraw_cmd(fwdev->cmd);
 }
 
 static void versal_pci_fw_cleanup(struct fw_upload *fw_upload)
 {
-	/* TODO */
+	struct firmware_device *fwdev = fw_upload->dd_handle;
+
+	if (!fwdev->cmd)
+		return;
+
+	rm_queue_data_fini(fwdev->cmd);
+	rm_queue_destory_cmd(fwdev->cmd);
+
+	fwdev->cmd = NULL;
+	fwdev->id = 0;
 }
 
 static const struct fw_upload_ops versal_pci_fw_ops = {
@@ -240,23 +338,31 @@ static void versal_pci_device_teardown(struct versal_pci_device *vdev)
 	versal_pci_fpga_fini(vdev->fdev);
 	versal_pci_fw_upload_fini(vdev->fwdev);
 	versal_pci_comm_chan_fini(vdev->ccdev);
+	versal_pci_rm_fini(vdev->rdev);
 }
 
 static int versal_pci_device_setup(struct versal_pci_device *vdev)
 {
 	int ret;
 
+	vdev->rdev = versal_pci_rm_init(vdev);
+	if (IS_ERR(vdev->rdev)) {
+		ret = PTR_ERR(vdev->rdev);
+		vdev_err(vdev, "Failed to init remote queue, err %d", ret);
+		return ret;
+	}
+
 	vdev->fwdev = versal_pci_fw_upload_init(vdev);
 	if (IS_ERR(vdev->fwdev)) {
 		ret = PTR_ERR(vdev->fwdev);
 		vdev_err(vdev, "Failed to init FW uploader, err %d", ret);
-		return ret;
+		goto rm_fini;
 	}
 
 	vdev->ccdev = versal_pci_comm_chan_init(vdev);
 	if (IS_ERR(vdev->ccdev)) {
 		ret = PTR_ERR(vdev->ccdev);
-		vdev_err(vdev, "Failed to init comms channel, err %d", ret);
+		vdev_err(vdev, "Failed to init comm channel, err %d", ret);
 		goto upload_fini;
 	}
 
@@ -272,7 +378,8 @@ static int versal_pci_device_setup(struct versal_pci_device *vdev)
 	versal_pci_comm_chan_fini(vdev->ccdev);
 upload_fini:
 	versal_pci_fw_upload_fini(vdev->fwdev);
-
+rm_fini:
+	versal_pci_rm_fini(vdev->rdev);
 	return ret;
 }
 
diff --git a/drivers/fpga/amd/versal-pci-rm-queue.c b/drivers/fpga/amd/versal-pci-rm-queue.c
index 92f2e1165052..e62aa6791a95 100644
--- a/drivers/fpga/amd/versal-pci-rm-queue.c
+++ b/drivers/fpga/amd/versal-pci-rm-queue.c
@@ -23,37 +23,35 @@ static inline struct rm_device *to_rdev_msg_timer(struct timer_list *t)
 
 static inline u32 rm_io_read(struct rm_device *rdev, u32 offset)
 {
-	/* TODO */
-	return 0;
+	return rm_reg_read(rdev, RM_PCI_IO_BAR_OFF + offset);
 }
 
 static inline int rm_io_write(struct rm_device *rdev, u32 offset, u32 value)
 {
-	/* TODO */
+	rm_reg_write(rdev, RM_PCI_IO_BAR_OFF + offset, value);
 	return 0;
 }
 
 static inline u32 rm_queue_read(struct rm_device *rdev, u32 offset)
 {
-	/* TODO */
-	return 0;
+	return rm_reg_read(rdev, RM_PCI_SHMEM_BAR_OFF + rdev->queue_base + offset);
 }
 
 static inline void rm_queue_write(struct rm_device *rdev, u32 offset, u32 value)
 {
-	/* TODO */
+	rm_reg_write(rdev, RM_PCI_SHMEM_BAR_OFF + rdev->queue_base + offset, value);
 }
 
 static inline void rm_queue_bulk_read(struct rm_device *rdev, u32 offset,
 				      u32 *value, u32 size)
 {
-	/* TODO */
+	rm_bulk_reg_read(rdev, RM_PCI_SHMEM_BAR_OFF + rdev->queue_base + offset, value, size);
 }
 
 static inline void rm_queue_bulk_write(struct rm_device *rdev, u32 offset,
 				       u32 *value, u32 size)
 {
-	/* TODO */
+	rm_bulk_reg_write(rdev, RM_PCI_SHMEM_BAR_OFF + rdev->queue_base + offset, value, size);
 }
 
 static inline u32 rm_queue_get_cidx(struct rm_device *rdev, enum rm_queue_type type)
diff --git a/drivers/fpga/amd/versal-pci-rm-service.c b/drivers/fpga/amd/versal-pci-rm-service.c
new file mode 100644
index 000000000000..0a1d96a432b2
--- /dev/null
+++ b/drivers/fpga/amd/versal-pci-rm-service.c
@@ -0,0 +1,497 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for Versal PCIe device
+ *
+ * Copyright (C) 2024 Advanced Micro Devices, Inc. All rights reserved.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/pci.h>
+#include <linux/vmalloc.h>
+
+#include "versal-pci.h"
+#include "versal-pci-rm-service.h"
+#include "versal-pci-rm-queue.h"
+
+static DEFINE_IDA(rm_cmd_ids);
+
+static void rm_uninstall_health_monitor(struct rm_device *rdev);
+
+static inline struct rm_device *to_rdev_health_monitor(struct work_struct *w)
+{
+	return container_of(w, struct rm_device, health_monitor);
+}
+
+static inline struct rm_device *to_rdev_health_timer(struct timer_list *t)
+{
+	return container_of(t, struct rm_device, health_timer);
+}
+
+u32 rm_reg_read(struct rm_device *rdev, u32 offset)
+{
+	return readl(rdev->vdev->io_regs + offset);
+}
+
+void rm_reg_write(struct rm_device *rdev, u32 offset, const u32 value)
+{
+	writel(value, rdev->vdev->io_regs + offset);
+}
+
+void rm_bulk_reg_read(struct rm_device *rdev, u32 offset, u32 *value, size_t size)
+{
+	void __iomem *src = rdev->vdev->io_regs + offset;
+	void *dst = (void *)value;
+
+	memcpy_fromio(dst, src, size);
+	/* Barrier of reading data from device */
+	rmb();
+}
+
+void rm_bulk_reg_write(struct rm_device *rdev, u32 offset, const void *value, size_t size)
+{
+	void __iomem *dst = rdev->vdev->io_regs + offset;
+
+	memcpy_toio(dst, value, size);
+	/* Barrier of writing data to device */
+	wmb();
+}
+
+static inline u32 rm_shmem_read(struct rm_device *rdev, u32 offset)
+{
+	return rm_reg_read(rdev, RM_PCI_SHMEM_BAR_OFF + offset);
+}
+
+static inline void rm_shmem_bulk_read(struct rm_device *rdev, u32 offset,
+				      u32 *value, u32 size)
+{
+	rm_bulk_reg_read(rdev, RM_PCI_SHMEM_BAR_OFF + offset, value, size);
+}
+
+static inline void rm_shmem_bulk_write(struct rm_device *rdev, u32 offset,
+				       const void *value, u32 size)
+{
+	rm_bulk_reg_write(rdev, RM_PCI_SHMEM_BAR_OFF + offset, value, size);
+}
+
+void rm_queue_destory_cmd(struct rm_cmd *cmd)
+{
+	ida_free(&rm_cmd_ids, cmd->sq_msg.hdr.id);
+	kfree(cmd);
+}
+
+static int rm_queue_copy_response(struct rm_cmd *cmd, void *buffer, ssize_t len)
+{
+	struct rm_cmd_cq_log_page *result = &cmd->cq_msg.data.page;
+	u64 off = cmd->sq_msg.data.page.address;
+
+	if (!result->len || len < result->len) {
+		vdev_err(cmd->rdev->vdev, "Invalid response or buffer size");
+		return -EINVAL;
+	}
+
+	rm_shmem_bulk_read(cmd->rdev, off, (u32 *)buffer, result->len);
+	return 0;
+}
+
+static void rm_queue_payload_fini(struct rm_cmd *cmd)
+{
+	up(&cmd->rdev->cq.data_lock);
+}
+
+static int rm_queue_payload_init(struct rm_cmd *cmd,
+				 enum rm_cmd_log_page_type type)
+{
+	struct rm_device *rdev = cmd->rdev;
+	int ret;
+
+	ret = down_interruptible(&rdev->cq.data_lock);
+	if (ret)
+		return ret;
+
+	cmd->sq_msg.data.page.address = rdev->cq.data_offset;
+	cmd->sq_msg.data.page.size = rdev->cq.data_size;
+	cmd->sq_msg.data.page.reserved1 = 0;
+	cmd->sq_msg.data.page.type = FIELD_PREP(RM_CMD_LOG_PAGE_TYPE_MASK,
+						type);
+	return 0;
+}
+
+void rm_queue_data_fini(struct rm_cmd *cmd)
+{
+	up(&cmd->rdev->sq.data_lock);
+}
+
+int rm_queue_data_init(struct rm_cmd *cmd, const char *buffer, ssize_t size)
+{
+	struct rm_device *rdev = cmd->rdev;
+	int ret;
+
+	if (!size || size > rdev->sq.data_size) {
+		vdev_err(rdev->vdev, "Unsupported file size");
+		return -ENOMEM;
+	}
+
+	ret = down_interruptible(&rdev->sq.data_lock);
+	if (ret)
+		return ret;
+
+	rm_shmem_bulk_write(cmd->rdev, rdev->sq.data_offset, buffer, size);
+
+	cmd->sq_msg.data.bin.address = rdev->sq.data_offset;
+	cmd->sq_msg.data.bin.size = size;
+	return 0;
+}
+
+int rm_queue_create_cmd(struct rm_device *rdev, enum rm_queue_opcode opcode,
+			struct rm_cmd **cmd_ptr)
+{
+	struct rm_cmd *cmd = NULL;
+	int ret, id;
+	u16 size;
+
+	if (rdev->firewall_tripped)
+		return -ENODEV;
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd)
+		return -ENOMEM;
+	cmd->rdev = rdev;
+
+	switch (opcode) {
+	case RM_QUEUE_OP_LOAD_XCLBIN:
+		fallthrough;
+	case RM_QUEUE_OP_LOAD_FW:
+		fallthrough;
+	case RM_QUEUE_OP_LOAD_APU_FW:
+		size = sizeof(struct rm_cmd_sq_bin);
+		break;
+	case RM_QUEUE_OP_GET_LOG_PAGE:
+		size = sizeof(struct rm_cmd_sq_log_page);
+		break;
+	case RM_QUEUE_OP_IDENTIFY:
+		size = 0;
+		break;
+	case RM_QUEUE_OP_VMR_CONTROL:
+		size = sizeof(struct rm_cmd_sq_ctrl);
+		break;
+	default:
+		vdev_err(rdev->vdev, "Invalid cmd opcode %d", opcode);
+		ret = -EINVAL;
+		goto error;
+	}
+
+	cmd->opcode = opcode;
+	cmd->sq_msg.hdr.opcode = FIELD_PREP(RM_CMD_SQ_HDR_OPS_MSK, opcode);
+	cmd->sq_msg.hdr.msg_size = FIELD_PREP(RM_CMD_SQ_HDR_SIZE_MSK, size);
+
+	id = ida_alloc_range(&rm_cmd_ids, RM_CMD_ID_MIN, RM_CMD_ID_MAX, GFP_KERNEL);
+	if (id < 0) {
+		vdev_err(rdev->vdev, "Failed to alloc cmd ID: %d", id);
+		ret = id;
+		goto error;
+	}
+	cmd->sq_msg.hdr.id = id;
+
+	init_completion(&cmd->executed);
+
+	*cmd_ptr = cmd;
+	return 0;
+error:
+	kfree(cmd);
+	return ret;
+}
+
+static int rm_queue_verify(struct rm_device *rdev)
+{
+	struct versal_pci_device *vdev = rdev->vdev;
+	struct rm_cmd_cq_identify *result;
+	struct rm_cmd *cmd;
+	u32 major, minor;
+	int ret;
+
+	ret = rm_queue_create_cmd(rdev, RM_QUEUE_OP_IDENTIFY, &cmd);
+	if (ret)
+		return ret;
+
+	ret = rm_queue_send_cmd(cmd, RM_CMD_WAIT_CONFIG_TIMEOUT);
+	if (ret)
+		goto error;
+
+	result = &cmd->cq_msg.data.identify;
+	major = result->major;
+	minor = result->minor;
+	vdev_dbg(vdev, "VMR version %d.%d", major, minor);
+	if (!major) {
+		vdev_err(vdev, "VMR version is unsupported");
+		ret = -EOPNOTSUPP;
+	}
+
+error:
+	rm_queue_destory_cmd(cmd);
+	return ret;
+}
+
+static int rm_check_apu_status(struct rm_device *rdev, bool *status)
+{
+	struct rm_cmd_cq_control *result;
+	struct rm_cmd *cmd;
+	int ret;
+
+	ret = rm_queue_create_cmd(rdev, RM_QUEUE_OP_VMR_CONTROL, &cmd);
+	if (ret)
+		return ret;
+
+	ret = rm_queue_send_cmd(cmd, RM_CMD_WAIT_CONFIG_TIMEOUT);
+	if (ret)
+		goto error;
+
+	result = &cmd->cq_msg.data.ctrl;
+	*status = FIELD_GET(RM_CMD_VMR_CONTROL_PS_MASK, result->status);
+
+	rm_queue_destory_cmd(cmd);
+	return 0;
+
+error:
+	rm_queue_destory_cmd(cmd);
+	return ret;
+}
+
+static int rm_download_apu_fw(struct rm_device *rdev, char *data, ssize_t size)
+{
+	struct rm_cmd *cmd;
+	int ret;
+
+	ret = rm_queue_create_cmd(rdev, RM_QUEUE_OP_LOAD_APU_FW, &cmd);
+	if (ret)
+		return ret;
+
+	ret = rm_queue_data_init(cmd, data, size);
+	if (ret)
+		goto done;
+
+	ret = rm_queue_send_cmd(cmd, RM_CMD_WAIT_DOWNLOAD_TIMEOUT);
+
+done:
+	rm_queue_destory_cmd(cmd);
+	return ret;
+}
+
+int rm_queue_boot_apu(struct rm_device *rdev)
+{
+	char *bin = "xilinx/xrt-versal-apu.xsabin";
+	const struct firmware *fw = NULL;
+	bool status;
+	int ret;
+
+	ret = rm_check_apu_status(rdev, &status);
+	if (ret) {
+		vdev_err(rdev->vdev, "Failed to get APU status");
+		return ret;
+	}
+
+	if (status) {
+		vdev_dbg(rdev->vdev, "APU online. Skipping APU FW download");
+		return 0;
+	}
+
+	ret = request_firmware(&fw, bin, &rdev->vdev->pdev->dev);
+	if (ret) {
+		vdev_warn(rdev->vdev, "Request APU FW %s failed %d", bin, ret);
+		return ret;
+	}
+
+	vdev_dbg(rdev->vdev, "Starting... APU FW download");
+	ret = rm_download_apu_fw(rdev, (char *)fw->data, fw->size);
+	vdev_dbg(rdev->vdev, "Finished... APU FW download %d", ret);
+
+	if (ret)
+		vdev_err(rdev->vdev, "Failed to download APU FW, ret:%d", ret);
+
+	release_firmware(fw);
+
+	return ret;
+}
+
+static void rm_check_health(struct work_struct *w)
+{
+	struct rm_device *rdev = to_rdev_health_monitor(w);
+	u32 max_len = PAGE_SIZE;
+	struct rm_cmd *cmd;
+	int ret;
+
+	ret = rm_queue_create_cmd(rdev, RM_QUEUE_OP_GET_LOG_PAGE, &cmd);
+	if (ret)
+		return;
+
+	ret = rm_queue_payload_init(cmd, RM_CMD_LOG_PAGE_AXI_TRIP_STATUS);
+	if (ret)
+		goto destroy_cmd;
+
+	ret = rm_queue_send_cmd(cmd, RM_CMD_WAIT_CONFIG_TIMEOUT);
+	if (ret == -ETIME || ret == -EINVAL)
+		goto payload_fini;
+
+	if (ret) {
+		u32 log_len = cmd->cq_msg.data.page.len;
+
+		if (log_len > max_len) {
+			vdev_warn(rdev->vdev, "msg size %d is greater than requested %d",
+				  log_len, max_len);
+			log_len = max_len;
+		}
+
+		if (log_len) {
+			char *buffer = vzalloc(log_len);
+
+			if (!buffer)
+				goto payload_fini;
+
+			ret = rm_queue_copy_response(cmd, buffer, log_len);
+			if (ret) {
+				vfree(buffer);
+				goto payload_fini;
+			}
+
+			vdev_err(rdev->vdev, "%s", buffer);
+			vfree(buffer);
+
+		} else {
+			vdev_err(rdev->vdev, "firewall check ret%d", ret);
+		}
+
+		rdev->firewall_tripped = 1;
+	}
+
+payload_fini:
+	rm_queue_payload_fini(cmd);
+destroy_cmd:
+	rm_queue_destory_cmd(cmd);
+
+	vdev_dbg(rdev->vdev, "check result: %d", ret);
+}
+
+static void rm_sched_health_check(struct timer_list *t)
+{
+	struct rm_device *rdev = to_rdev_health_timer(t);
+
+	if (rdev->firewall_tripped) {
+		vdev_err(rdev->vdev, "Firewall tripped, health check paused. Please reset card");
+		return;
+	}
+	/* Schedule a work in the general workqueue */
+	schedule_work(&rdev->health_monitor);
+	/* Periodic timer */
+	mod_timer(&rdev->health_timer, jiffies + RM_HEALTH_CHECK_TIMER);
+}
+
+static void rm_uninstall_health_monitor(struct rm_device *rdev)
+{
+	del_timer_sync(&rdev->health_timer);
+	cancel_work_sync(&rdev->health_monitor);
+}
+
+static void rm_install_health_monitor(struct rm_device *rdev)
+{
+	INIT_WORK(&rdev->health_monitor, &rm_check_health);
+	timer_setup(&rdev->health_timer, &rm_sched_health_check, 0);
+	mod_timer(&rdev->health_timer, jiffies + RM_HEALTH_CHECK_TIMER);
+}
+
+void versal_pci_rm_fini(struct rm_device *rdev)
+{
+	rm_uninstall_health_monitor(rdev);
+	rm_queue_fini(rdev);
+}
+
+struct rm_device *versal_pci_rm_init(struct versal_pci_device *vdev)
+{
+	struct rm_header *header;
+	struct rm_device *rdev;
+	u32 status;
+	int ret;
+
+	rdev = devm_kzalloc(&vdev->pdev->dev, sizeof(*rdev), GFP_KERNEL);
+	if (!rdev)
+		return ERR_PTR(-ENOMEM);
+
+	rdev->vdev = vdev;
+	header = &rdev->rm_metadata;
+
+	rm_shmem_bulk_read(rdev, RM_HDR_OFF, (u32 *)header, sizeof(*header));
+	if (header->magic != RM_HDR_MAGIC_NUM) {
+		vdev_err(vdev, "Invalid RM header 0x%x", header->magic);
+		ret = -ENODEV;
+		goto err;
+	}
+
+	status = rm_shmem_read(rdev, header->status_off);
+	if (!status) {
+		vdev_err(vdev, "RM status %d is not ready", status);
+		ret = -ENODEV;
+		goto err;
+	}
+
+	rdev->queue_buffer_size = header->data_end - header->data_start + 1;
+	rdev->queue_buffer_start = header->data_start;
+	rdev->queue_base = header->queue_base;
+
+	ret = rm_queue_init(rdev);
+	if (ret) {
+		vdev_err(vdev, "Failed to init cmd queue, ret %d", ret);
+		ret = -ENODEV;
+		goto err;
+	}
+
+	ret = rm_queue_verify(rdev);
+	if (ret) {
+		vdev_err(vdev, "Failed to verify cmd queue, ret %d", ret);
+		ret = -ENODEV;
+		goto queue_fini;
+	}
+
+	ret = rm_queue_boot_apu(rdev);
+	if (ret) {
+		vdev_err(vdev, "Failed to bringup APU, ret %d", ret);
+		ret = -ENODEV;
+		goto queue_fini;
+	}
+
+	rm_install_health_monitor(rdev);
+
+	return rdev;
+queue_fini:
+	rm_queue_fini(rdev);
+err:
+	return ERR_PTR(ret);
+}
+
+int rm_queue_get_fw_id(struct rm_device *rdev)
+{
+	struct rm_cmd *cmd;
+	int ret;
+
+	ret = rm_queue_create_cmd(rdev, RM_QUEUE_OP_GET_LOG_PAGE, &cmd);
+	if (ret)
+		return ret;
+
+	ret = rm_queue_payload_init(cmd, RM_CMD_LOG_PAGE_FW_ID);
+	if (ret)
+		goto destroy_cmd;
+
+	ret = rm_queue_send_cmd(cmd, RM_CMD_WAIT_CONFIG_TIMEOUT);
+	if (ret)
+		goto payload_fini;
+
+	ret = rm_queue_copy_response(cmd, rdev->vdev->fw_id, sizeof(rdev->vdev->fw_id));
+	if (ret)
+		goto payload_fini;
+
+	vdev_info(rdev->vdev, "fw_id %s", rdev->vdev->fw_id);
+
+payload_fini:
+	rm_queue_payload_fini(cmd);
+destroy_cmd:
+	rm_queue_destory_cmd(cmd);
+
+	return ret;
+}
diff --git a/drivers/fpga/amd/versal-pci-rm-service.h b/drivers/fpga/amd/versal-pci-rm-service.h
index 85a78257770a..90796567f0d3 100644
--- a/drivers/fpga/amd/versal-pci-rm-service.h
+++ b/drivers/fpga/amd/versal-pci-rm-service.h
@@ -206,4 +206,24 @@ struct rm_device {
 	__u32			firewall_tripped;
 };
 
+/* rm service init api */
+struct rm_device *versal_pci_rm_init(struct versal_pci_device *vdev);
+void versal_pci_rm_fini(struct rm_device *rdev);
+
+/* rm services APIs */
+int rm_queue_create_cmd(struct rm_device *rdev, enum rm_queue_opcode opcode,
+			struct rm_cmd **cmd_ptr);
+void rm_queue_destory_cmd(struct rm_cmd *cmd);
+
+int rm_queue_data_init(struct rm_cmd *cmd, const char *buffer, ssize_t size);
+void rm_queue_data_fini(struct rm_cmd *cmd);
+int rm_queue_get_fw_id(struct rm_device *rdev);
+int rm_queue_boot_apu(struct rm_device *rdev);
+
+/* rm bar register operation APIs */
+u32 rm_reg_read(struct rm_device *rdev, u32 offset);
+void rm_reg_write(struct rm_device *rdev, u32 offset, const u32 value);
+void rm_bulk_reg_read(struct rm_device *rdev, u32 offset, u32 *value, size_t size);
+void rm_bulk_reg_write(struct rm_device *rdev, u32 offset, const void *value, size_t size);
+
 #endif	/* __RM_SERVICE_H */
diff --git a/drivers/fpga/amd/versal-pci.h b/drivers/fpga/amd/versal-pci.h
index 6c1ca3ce505d..5d3f793a5b68 100644
--- a/drivers/fpga/amd/versal-pci.h
+++ b/drivers/fpga/amd/versal-pci.h
@@ -27,6 +27,7 @@
 
 struct versal_pci_device;
 struct comm_chan_device;
+struct rm_cmd;
 
 struct axlf_header {
 	__u64				length;
@@ -69,6 +70,7 @@ struct firmware_device {
 struct versal_pci_device {
 	struct pci_dev			*pdev;
 
+	struct rm_device		*rdev;
 	struct fpga_device		*fdev;
 	struct comm_chan_device         *ccdev;
 	struct firmware_device		*fwdev;
-- 
2.34.1


