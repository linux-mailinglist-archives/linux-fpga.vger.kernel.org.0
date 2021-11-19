Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774024578AB
	for <lists+linux-fpga@lfdr.de>; Fri, 19 Nov 2021 23:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235126AbhKSW2U (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 19 Nov 2021 17:28:20 -0500
Received: from mail-dm6nam10on2060.outbound.protection.outlook.com ([40.107.93.60]:37152
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234745AbhKSW2U (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 19 Nov 2021 17:28:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FR2holyrp3W0c+YNYtdH9UyBwVSEw1HAbh/w8/eao2la9GvVng57zUtz6jeZvUsJzXytX/9j+ebBLVTs4M90kpJ28qsAhlS8livC1g+ShgeQYtr0/0dJ0VQmDdPdVw/2TLoiJHyExE2nURRh6Uc9CCMFHvaVRLalheZBykmrJ/heh0WbpwpxSjEE/2fpAa4eKmGPb3APEtXoQnbH1KnYp2rMo/aJh4pm95zbcpcuF4t1OYGDB8kyZ1OBYebud6Y38aErc0yNm1iz/n9a9BxAtJUo8lEJ086GO2b+252GuuBL8PPCHfA/0MY+CEtJTt8P7KJNomecdWaNMyeSdNv5Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1igVE7zaLdniu8vfszrZASVNDL49MDeN+YyJ7SpgO6k=;
 b=KC1J/+4bKzuvf6w/9FD3bigzaLMmN+0pLCawjG1jeKYjKFK1HDA01eJRXb2wVnNuMIZG9nkmxzPy/5vop7MsXrpDdkhbhrDyk9HD7nk1zDT+XVIp/XHwGLqXcMSxEZ0T3lKCH82p76XOXNqZB1PXU8HWtIthikGGijYamBTMkJGL6P/eALfeIdkB8rB/9Np/Oaw60QvTtbqbd/F1HxkGMZz1ZKc8JADCjpOEJv2RTQL9a8OMXGhJImc5TogY/4fHek06mIsAYRyythcCt16CXkOCHm4XqotceIj8TYrosfmGUE/ALfZdqcSce/pc75UC1GYtkXDRErsrP5LRCBH8+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1igVE7zaLdniu8vfszrZASVNDL49MDeN+YyJ7SpgO6k=;
 b=Y0T3nzB/Gy3R6w7pV9jSv/+GyXfuUAcsegZ5h6iEP+HOL3geUEkf/mJPQT+vKrsuI/pjqcett2qXOTAiwVYXUTQSiGUitt9mKhU4gKsTCSMmcIryJhcgj9YMLsMTRV6uD1HBHFlt7eXOz17m363RcgfqiG2pl/nY8b0c38RCDq4=
Received: from DS7PR03CA0242.namprd03.prod.outlook.com (2603:10b6:5:3b3::7) by
 CO6PR02MB7537.namprd02.prod.outlook.com (2603:10b6:303:b3::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.19; Fri, 19 Nov 2021 22:25:14 +0000
Received: from DM3NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::e2) by DS7PR03CA0242.outlook.office365.com
 (2603:10b6:5:3b3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24 via Frontend
 Transport; Fri, 19 Nov 2021 22:25:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT007.mail.protection.outlook.com (10.13.4.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.19 via Frontend Transport; Fri, 19 Nov 2021 22:25:14 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 19 Nov 2021 14:25:03 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 19 Nov 2021 14:25:02 -0800
Envelope-to: dwmw2@infradead.org,
 mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.93] (port=38938 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1moCJa-0001M7-SP; Fri, 19 Nov 2021 14:25:02 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 162B760014B; Fri, 19 Nov 2021 14:24:14 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, <dwmw2@infradead.org>,
        Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V2 XRT Alveo Infrastructure 3/9] of: handle fdt buffer alignment inside unflatten function
Date:   Fri, 19 Nov 2021 14:24:06 -0800
Message-ID: <20211119222412.1092763-4-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211119222412.1092763-1-lizhi.hou@xilinx.com>
References: <20211119222412.1092763-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1f88afb-4b63-467d-0782-08d9abab755e
X-MS-TrafficTypeDiagnostic: CO6PR02MB7537:
X-Microsoft-Antispam-PRVS: <CO6PR02MB7537EC8FA0961A51C4123798A19C9@CO6PR02MB7537.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XRd29BQ9ItvF+qT68WS9VmX2RDUDzGrHLooVzR3+2e2iSnOwPgMV4F9YqVG6eGY9HUz4n34zgwpC5JzJC8bw33UG4LmtRY0xx4i/oCa4jj9SyrnA7jkKSfT8neVghTe2KFTBfx8Y2RzAA2F6bzXCmNRL+CGXBiNabKhid2K21lLyIA/mWLafMnP41/j0cJZK4h4WhKszJYrhAtFF125mh9fgDqZZ4G7ymGfEEHWZyOeUksnz6cvOd0pktGAvT3vlk5sKVAW2H6QVEny0z69Xm4UFOMSyOJ+PygpJ6mp/KFTgWMLG8LpofYUcmBkEPuF8SqJpUlI/BcxZBY77pHNI/hRml2Wew6Lxit6gWNC9Z+vXTfxu+AhvH+VfRzY6CEXz7B+7U9BA/iEuaM1NgXyKVof5u6icrQqPwlto49oCi8R7sLRYFn/r2i78r0bjRNgWf3gMWSKDiza+s5A01O/uSlYytMGTXMS5bj6D81BaYsm8ph0Bq8Uy9L60p0dVOw01HSoRtMDef+uUa6+niOb/DrPRytK804H9/8Qw4b/nUYlP28fyLNWuO8dnfEDg/kuwIU+/jleJc1xZEXOyZ1A9bh7luFSoPH5bF//2AyjDJd20L7G3wjErJI8B3O8XMMWbD68MYFx/LvfHoXD8gP3XUkTBfXWluynJmySihSHLkVs6kSKETsOhk48Qn0zGx4Paf8oM9bB+Dtdz/Y1Iv/1ZfQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(6916009)(44832011)(54906003)(42186006)(8676002)(36756003)(426003)(336012)(2616005)(47076005)(1076003)(36906005)(4326008)(6266002)(107886003)(316002)(8936002)(82310400003)(26005)(6666004)(2906002)(186003)(508600001)(7636003)(356005)(36860700001)(83380400001)(5660300002)(70586007)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 22:25:14.5580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f88afb-4b63-467d-0782-08d9abab755e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT007.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7537
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add alignment check to of_fdt_unflatten_tree(). If it is not aligned,
allocate a aligned buffer and copy the fdt blob. So the caller does not
have to deal with the buffer alignment before calling this function.
XRT uses this function to unflatten fdt which is from Alveo firmware.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
---
 drivers/of/fdt.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 4546572af24b..d64445e43ceb 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -455,13 +455,28 @@ void *of_fdt_unflatten_tree(const unsigned long *blob,
 			    struct device_node *dad,
 			    struct device_node **mynodes)
 {
+	void *new_fdt = NULL, *fdt_align;
 	void *mem;
 
+	if (fdt_check_header(blob)) {
+		pr_err("Invalid fdt blob\n");
+		return NULL;
+	}
+	fdt_align = (void *)PTR_ALIGN(blob, FDT_ALIGN_SIZE);
+	if (fdt_align != blob) {
+		new_fdt = kmalloc(fdt_totalsize(blob) + FDT_ALIGN_SIZE, GFP_KERNEL);
+		if (!new_fdt)
+			return NULL;
+		fdt_align = PTR_ALIGN(new_fdt, FDT_ALIGN_SIZE);
+	}
+
 	mutex_lock(&of_fdt_unflatten_mutex);
-	mem = __unflatten_device_tree(blob, dad, mynodes, &kernel_tree_alloc,
+	mem = __unflatten_device_tree(fdt_align, dad, mynodes, &kernel_tree_alloc,
 				      true);
 	mutex_unlock(&of_fdt_unflatten_mutex);
 
+	kfree(new_fdt);
+
 	return mem;
 }
 EXPORT_SYMBOL_GPL(of_fdt_unflatten_tree);
-- 
2.27.0

