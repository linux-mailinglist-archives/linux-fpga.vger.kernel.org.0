Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1104564C6
	for <lists+linux-fpga@lfdr.de>; Thu, 18 Nov 2021 22:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbhKRVHg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 18 Nov 2021 16:07:36 -0500
Received: from mail-bn7nam10on2050.outbound.protection.outlook.com ([40.107.92.50]:20926
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233954AbhKRVHf (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 18 Nov 2021 16:07:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4ScFZpWm+FEu5/aGc6jmLvWbBIR+MxQZFx40sJIKWIKhaOOXxKXVVhgHV6Jxvv5brvxM7Wty3DzY+lvK2ePQTy/TnW95pvnf+Ff8XES4pob8QCvctZB1rEvriYIfo2n/Wngzvti67q0xW9IVRVbClwNSHeVR4J//Zh8KUlBTALni2Am4wt3lg82iXTRk95SajuB3t8515dWZLVQPnZKJMDohjqbzNy6o7kKuRI0lNug5kLG/YTt3eYW+/TTAqeHc2WwhauCO0Cdx9TuK0rOTLTseN35UBMNF9JAt3IADxFJCLBX9e/L9nxqjeHprIgXOvfKcFoqKhZ2Y9/zYhaVRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1igVE7zaLdniu8vfszrZASVNDL49MDeN+YyJ7SpgO6k=;
 b=UkZg+qyEx7EW0aNJIfSEHpDdrm8Oi3ZkotWDwX3VsGR3g1nBUvd1mUhSLx/D+0GEeHRkL01bxA7gFzIOYy84Q5KHRqtawxEiZqDg8z2BuaOV0TwX47Glzs6qLV/w4gJrposSO9rfH3wha62QLfmR/ES64Ytw/Wc+mOpKR1VpkKeW8ns/od3XjHUi8YeuHgy8u6KPkfjDzY5nedwkO7g9RPtEZ2qg0EzkZGieOrfx08Ctdg7GWUzrfswJ+atzQIO7Tp1dm228Q7Zj/19VvTuGFLl3FZ/YISwWRMOsHK6ksWJ5cjx9Fymqd73qeH3kqjRH68q+PiTcH8ocjMWm2xPb8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1igVE7zaLdniu8vfszrZASVNDL49MDeN+YyJ7SpgO6k=;
 b=oYos8GYKsDSXpBZZjbXDJHqGk+/nHuPzONKdvlSmlOsAKV5IluvBrcAZhBFNXT/s15Zi5WwMEsVrAJ2EAHuWnInZ/eE7d0BuchZHtPAEUHmBA91CV5ZimuKuxI7D+S5ZwywSYnI6YkT+06mZBeY4J8HlpvGf2RfWIFWBaDmJMRI=
Received: from BN0PR04CA0021.namprd04.prod.outlook.com (2603:10b6:408:ee::26)
 by CH2PR02MB6679.namprd02.prod.outlook.com (2603:10b6:610:7a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.20; Thu, 18 Nov
 2021 21:04:32 +0000
Received: from BN1NAM02FT039.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::27) by BN0PR04CA0021.outlook.office365.com
 (2603:10b6:408:ee::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27 via Frontend
 Transport; Thu, 18 Nov 2021 21:04:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT039.mail.protection.outlook.com (10.13.2.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.19 via Frontend Transport; Thu, 18 Nov 2021 21:04:30 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 18 Nov 2021 13:04:12 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 18 Nov 2021 13:04:12 -0800
Envelope-to: dwmw2@infradead.org,
 mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.93] (port=37754 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1mnoZo-0001YV-FB; Thu, 18 Nov 2021 13:04:12 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id CE081600143; Thu, 18 Nov 2021 13:03:36 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, <dwmw2@infradead.org>,
        Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V1 XRT Alveo Infrastructure 3/9] of: handle fdt buffer alignment inside unflatten function
Date:   Thu, 18 Nov 2021 13:03:17 -0800
Message-ID: <20211118210323.1070283-4-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211118210323.1070283-1-lizhi.hou@xilinx.com>
References: <20211118210323.1070283-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e48aca60-c825-4824-bd79-08d9aad70393
X-MS-TrafficTypeDiagnostic: CH2PR02MB6679:
X-Microsoft-Antispam-PRVS: <CH2PR02MB667900BEB441220025A305CFA19B9@CH2PR02MB6679.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O/ThyLr+AzL586F9ZtGtSBHu4bxlFDMJp+K4T6EBOZYnOje/BNg28jivBVlaDKrfZo+/cg77czQtUQCzYLr+YSg8oWnQB9HJ76p4X94ySTQ2GsfFjbVS3GPRKeXuF0uEZLs+CUk35SvE0kgCPdtwf5SJAiZq/FzNXkW8Amf0NDg6QSfT1XJ4Bni4Ku5jYV5k9MerI1uMvzgiACV4YZP7FVM9BotwTfFPhPjyVCBSuLcqBa7UKKm6xCOtYURGcDiUpfBIyIBDo8Kb5xruU/0bvkfngN4lnzzFNC3zPeagZA8AgJqfvDyJh6minPDSAUH+8Q8yQDens6E2pmqPJzZAkhCwv7oa6R7VXmUhwe66SQCkOBno5I+vHVABkgLjCILXcz5dAswEQ2Uqh/Rf3cry1HvhPjjEKQK+d74tRCyqSR+E4M4+JaVHz3iF6BJSrXXNLDNfUv7cl+u4JcnYmSX9JMjmBeTO65vlq1pP99qL3u/356kqBVGjbidPl9Xbtph9dMilqhfQFpk3YzfNq5wDhX5Or+Db+gKztSKGwBEu6Cx/FRxtVTzTgYWo4cyTBdH8eSYGIXA3UPrS1TTNcgaqry3ajVTD1pAZxWSBtSLF34R+yApvvNUHHF337VaNtXRCuZ0tUICBKRQbCwk++plyfIgBdgsMjKk/TX1L0y2eIvWoH025eqc+43s42deiUKtY7JAqfJzs2U+ixReZxd+1cg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(36860700001)(8676002)(107886003)(6666004)(5660300002)(83380400001)(2906002)(508600001)(47076005)(26005)(356005)(70206006)(70586007)(36756003)(186003)(54906003)(426003)(82310400003)(336012)(7636003)(42186006)(4326008)(6916009)(1076003)(6266002)(36906005)(8936002)(44832011)(2616005)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 21:04:30.2930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e48aca60-c825-4824-bd79-08d9aad70393
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT039.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6679
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

