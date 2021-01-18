Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3B592F9803
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Jan 2021 03:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730001AbhARC6P (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 17 Jan 2021 21:58:15 -0500
Received: from mail-co1nam11on2070.outbound.protection.outlook.com ([40.107.220.70]:48238
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731397AbhARC6G (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 17 Jan 2021 21:58:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7lqh3f40B5XlgsItWiz3OMaaeLO6QcyzChB8V23uoj9V5r7g1mXxrw4xodQ8cEM866sB77qVRRuXirgBHksFygfC5wRJi3xgBub0XzEkuyQI1YQVTGjvSe3IK98D9C0pmUCACoUZuLr7Bhdq6ZJLLYvpVZjut36tKlQxZJEbJ9fDidYa7dXYlVWFQbdhP8WnVyMClTAsOge07dwcGfgZjm5XHxNvqLUu3uulyWhfS6hMVBrMs94gDTLsETE5D8LyCKE4C0L3keTLAv/1jsIf5/d8z7zdAu74EnbrwYYLIuEVfx5ui5Nba6yiQEymai6vFX4QM5j9I9bhS6KzxD8CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Hg6uxNY3+Il/igarO0HtEFd6IFRD6RDWMVM/m+yzL8=;
 b=oU6xI1j/4ejoCDh5dwnv36qcfwZ3R57TIHQ3ctmKeRtylaGJHstPp7bYJS9zRClOSJFE0Tu38Bt2mRDbgoNBQw3dHmUJbJe3Uiutn1q98/44SwAeKRcUO+nZsWoalqD5ZSHvibEyT/hcJ4ogskDzK6uPZKM+JfPCX1T0Oigtykn1kx5z4ySWwHkHvbHOG0bh8J8Mgj7fk2j0Cs0ByFlEzNDAlCuVRWqYNOh/TmQaw8tgGQnF3JY/gUtZIvXoHxLLubB4YPrt30X1jU4Q3kYAWPIKRmk7cC2plG79KWkNv7of8JNovPb2Q54r1dXZ/CprMpABql7/6P/ufWl/DQB03A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Hg6uxNY3+Il/igarO0HtEFd6IFRD6RDWMVM/m+yzL8=;
 b=g6b6x7EZAL/TudNVr+CmU78DVabQkXaMWpVpKvCstkDGeWgHZseXBMWfxmTwz7WJlOiR4+19ELOEG6zD98ney9gR7IggHlP6c1pW/Zwib0HhmGTl9naoHbG6qof94GARp5lpy5BGxUgo3G8tYLDVo5lFmxolwcQ3h2ojfcaM2Hc=
Received: from CY4PR19CA0042.namprd19.prod.outlook.com (2603:10b6:903:103::28)
 by SJ0PR02MB7440.namprd02.prod.outlook.com (2603:10b6:a03:29c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Mon, 18 Jan
 2021 02:57:12 +0000
Received: from CY1NAM02FT017.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:103:cafe::5d) by CY4PR19CA0042.outlook.office365.com
 (2603:10b6:903:103::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend
 Transport; Mon, 18 Jan 2021 02:57:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT017.mail.protection.outlook.com (10.152.75.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3763.12 via Frontend Transport; Mon, 18 Jan 2021 02:57:12 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Sun, 17 Jan 2021 18:57:00 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Sun, 17 Jan 2021 18:57:00 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 mdf@kernel.org,
 trix@redhat.com,
 robh+dt@kernel.org,
 linux-fpga@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 chinnikishore369@gmail.com
Received: from [10.140.6.60] (port=41770 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1l1Kix-0004GM-Dh; Sun, 17 Jan 2021 18:56:59 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <trix@redhat.com>, <robh+dt@kernel.org>,
        <michal.simek@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <git@xilinx.com>, <chinnikishore369@gmail.com>,
        Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH 2/2] fpga: zynqmp: Adds secure BitStream loading support for Xilinx
Date:   Mon, 18 Jan 2021 08:20:58 +0530
Message-ID: <20210118025058.10051-2-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210118025058.10051-1-nava.manne@xilinx.com>
References: <20210118025058.10051-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7824eb2-e925-478b-5d11-08d8bb5cc134
X-MS-TrafficTypeDiagnostic: SJ0PR02MB7440:
X-Microsoft-Antispam-PRVS: <SJ0PR02MB7440441D9416834DD9CFBFBFC2A40@SJ0PR02MB7440.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:89;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tM0/djXI3IIApwWV1BX/rBoknae+mEBj2yj1LwUj+omIGrDQHoRon5s8s6u59XYFGRbsBCoevJcEqQ8qKJN7VLiOMK1t1pt4CbFeAs+FmNq+tCF9C8fJdaBYOIa3tx8oqTwdyfg4iJR9knsm0YDjb7ttGFPtJCQv2hJY/KEj6gbGeMja8ZkKdRMYuiDsr8aierUGB9xtbyVFSj8VRbc+UoMpMhqAx1nUwoPy5+ZbSzQSm9GJBXmPwDLD5Q3BteIKw+8YFjejMyITfbQkuqRdA8nrw7MgYQLa3LAfXVwlpkn7mUGMj/inPsg9bzlwZ3UirhIsqX8zS8uSkZA8YAAiA6B4LJafR+0SoRaG4Atwkav0g0NECVFO/lZ3VQHWkKMCbZhklB7ashB+ADPe6YBJwVzFeZx+CUFIxixO/+iiKYKRcnjygpzX7D+BmUUK9v7L1eaU/9TZlsJ6VRo4gPsG1KQ6w+4zSUZRw/5CJHQyCg3c4wnW0uRJ4v4MScb6mGN8cN+JD4dPB70b2XZvKrlGGQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(346002)(39850400004)(46966006)(82740400003)(54906003)(8936002)(7636003)(356005)(110136005)(336012)(36756003)(107886003)(1076003)(5660300002)(70586007)(2616005)(316002)(70206006)(4326008)(7696005)(8676002)(2906002)(82310400003)(478600001)(36906005)(426003)(9786002)(26005)(47076005)(186003)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2021 02:57:12.5105
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7824eb2-e925-478b-5d11-08d8bb5cc134
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT017.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7440
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This commit adds secure BitStream Loading support for the Xilinx
ZynqMp chip.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
 drivers/fpga/zynqmp-fpga.c           | 8 ++++++++
 include/linux/firmware/xlnx-zynqmp.h | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
index 125743c9797f..0ce34553944b 100644
--- a/drivers/fpga/zynqmp-fpga.c
+++ b/drivers/fpga/zynqmp-fpga.c
@@ -56,6 +56,14 @@ static int zynqmp_fpga_ops_write(struct fpga_manager *mgr,
 
 	wmb(); /* ensure all writes are done before initiate FW call */
 
+	if (priv->flags & FPGA_MGR_ENCRYPTED_BITSTREAM)
+		eemi_flags |= XILINX_ZYNQMP_PM_FPGA_ENCRYPTION_DEVKEY;
+
+	if (priv->flags & FPGA_MGR_DDR_MEM_AUTH_BITSTREAM)
+		eemi_flags |= XILINX_ZYNQMP_PM_FPGA_AUTHENTICATION_DDR;
+	else if (priv->flags & FPGA_MGR_SECURE_MEM_AUTH_BITSTREAM)
+		eemi_flags |= XILINX_ZYNQMP_PM_FPGA_AUTHENTICATION_OCM;
+
 	if (priv->flags & FPGA_MGR_PARTIAL_RECONFIG)
 		eemi_flags |= XILINX_ZYNQMP_PM_FPGA_PARTIAL;
 
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 87114ee645b1..8a4038bf85e2 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -62,6 +62,9 @@
  */
 #define XILINX_ZYNQMP_PM_FPGA_FULL	0x0U
 #define XILINX_ZYNQMP_PM_FPGA_PARTIAL	BIT(0)
+#define XILINX_ZYNQMP_PM_FPGA_AUTHENTICATION_DDR	BIT(1)
+#define XILINX_ZYNQMP_PM_FPGA_AUTHENTICATION_OCM	BIT(2)
+#define XILINX_ZYNQMP_PM_FPGA_ENCRYPTION_DEVKEY		BIT(4)
 
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
-- 
2.18.0

