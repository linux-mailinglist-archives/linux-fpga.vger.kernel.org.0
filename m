Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A63C4D13B7
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Mar 2022 10:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345448AbiCHJrA (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 8 Mar 2022 04:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345432AbiCHJrA (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 8 Mar 2022 04:47:00 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2072.outbound.protection.outlook.com [40.107.95.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C21E41987;
        Tue,  8 Mar 2022 01:46:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kid49SAo0lV+1lLhuHXVzssiKUtgHrYbFtjZ2yt/UDam2aoNKHbC+3v3pFc3r4/qPa+RLe35hnATIvl6Qs6/5b+Zo6Ie1+m5+Ma7DLmkPs2LyK2zQzj9L5GdEAQE/1/uQ/0Jnb2E9/jhm/3KH8xgCZJPVmX1CBNT1yvjvWf8YtK4Zlf/zd6SdUP/iyn1jwi0ygEQf5badAVjQQKDu3bPhqhNnBou7jKrop9W0xTXKwBq3QxL/7YQslUmdqFMrcIm5rTpubSfZ9rGzWcC0/XUO0qzTLX6bf7eKNXD0qcrN3HD8TG2g9HprGZfMruopIQ4MUQLVr6TSre+rqv0/oUSOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfXb7aQ6u7FRV4UOy5xcGZK/GlNI/Ngoyqq+Iq6D7Os=;
 b=TzAkT3RLmjNPflFQpJ/JJf6Ov+gAEp8EkIj0kcvFkyMX/bolgHvkwDtLoQrfUgjjjOB35Ah0tKmzBsl+3TKD7Veum29oqJUVtctmdbm780Ojv5Uc/kWFi1VIESJIktN4wAXOTmXMDcUhjT7WjABtnl5uo476IZ5XrtbqxNzlH7laeTmZ7UMUcYBnxsvxRRdbg94TsLNFb4CTCYBFfof1d6mYCQwNrnuyft3iGYSfmSiQne2WEZvzPqfpI4fH8sKGU3fa2yF0pK0sHuIsMerp/jw7POy6Dd1poStxQddAeJZxFcUxY1ff5iAGruDiyV1oeV5UT0vCi4C3Q708k2IkfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfXb7aQ6u7FRV4UOy5xcGZK/GlNI/Ngoyqq+Iq6D7Os=;
 b=E4v1V4xUpCiUyoPNM7h81D4vumR0aI/Krdm4+qFT4JX8hIfd1jW33Wqz3G97H3WvH7yexXNFvtqLmNH0ZBfGpndE7jzAzeB1/gdaXLxsGYXBVGffs05t9ngobcqXfKqk4g6WbkLLlOWVzM2wu5op1QQ3myfMnSUnmhHUFdrTnaw=
Received: from DM6PR07CA0128.namprd07.prod.outlook.com (2603:10b6:5:330::20)
 by SJ0PR02MB7664.namprd02.prod.outlook.com (2603:10b6:a03:323::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 09:45:58 +0000
Received: from DM3NAM02FT012.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::b5) by DM6PR07CA0128.outlook.office365.com
 (2603:10b6:5:330::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Tue, 8 Mar 2022 09:45:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT012.mail.protection.outlook.com (10.13.5.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Tue, 8 Mar 2022 09:45:58 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 8 Mar 2022 01:45:55 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 8 Mar 2022 01:45:55 -0800
Envelope-to: mdf@kernel.org,
 hao.wu@intel.com,
 yilun.xu@intel.com,
 trix@redhat.com,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [10.140.6.60] (port=33304 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1nRWPi-000G0A-Nc; Tue, 08 Mar 2022 01:45:55 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <michal.simek@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH 3/6] fpga: fpga-mgr: fix for coding style issues
Date:   Tue, 8 Mar 2022 15:15:16 +0530
Message-ID: <20220308094519.1816649-4-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220308094519.1816649-1-nava.manne@xilinx.com>
References: <20220308094519.1816649-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51cee8cb-ed73-43aa-c34e-08da00e87294
X-MS-TrafficTypeDiagnostic: SJ0PR02MB7664:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR02MB76649D6EACD5D89987E848C8C2099@SJ0PR02MB7664.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HepvI+kEaCmsP2x3F1cE9kGPmvXo0OpumTAaHrCC66mqky78QUTE8kmBnYbKFRYCuiFqtVZ1hgyqxUTEqrFgQhVrHMR+e4imIO2CyJ5kgdPfYJpubtHN0S2VqmVsF5+SKm3yIH5Gif+t0EL07qpon4n+A1Dqr3w/P9I0WGk0un+MIpgjwqJpBHwtUv9hccKDzFmcfFYTYTF4fM4jZbO5bdWWHNAgF8nTU8p5VLhkob1ZEJbMxFBzE0/+xcDbcWXTl4PAdEktVYxBUZjNe2xdSKrdAoJUFs4hmp+rmPVque1kfKze/8p0/igzSxVJ1GEv3PAfWf48yQkJXew1aDPW1hBz2vNdMogsQPMetI7L9oN9nsxpf3Se6eQvgFhA7+hx3dcVr72qF4fhJX535JuACUN4KnOWssqn6sfXfMYg5Rfk9z1wY7O/gqAmLLXOo2qeYjdJ21K0+23XZfL20r7Te6UOn48VZXf1kvT/7PWGD8WTsjUroMlsm6zlcpRyLZSS5ExPJYYkmVwiKG6pILOUOVVKu3daF8HZUJ2RDBWd8HbF3XmG3iSOi2ds+GCleE72+cwsGQr7VVUoIsrHZGvpeL7h392lbSJv/IHjox8xSV6+5fHzHaJWicQtz/RwhIDGUdi3MuCuaFb3oGRJ2of2ZNFlmMS03tTkuM6NMS1L69ahd4K43hqacMaX3G8Ygw9ChZvBVOHcyt21k/UG8RDRhLo3CyRjvBOXBYGrXuU5Tbo=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(82310400004)(36860700001)(4326008)(4744005)(70206006)(508600001)(70586007)(47076005)(6666004)(83380400001)(2906002)(426003)(336012)(7696005)(36756003)(5660300002)(8936002)(9786002)(110136005)(40460700003)(26005)(356005)(1076003)(7636003)(107886003)(2616005)(316002)(186003)(8676002)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 09:45:58.0173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51cee8cb-ed73-43aa-c34e-08da00e87294
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT012.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7664
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

fixes the below checks reported by checkpatch.pl
Lines should not end with a '('
Alignment should match open parenthesis

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
 drivers/fpga/fpga-mgr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index d49a9ce34568..a699cc8e2fa6 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -151,8 +151,8 @@ static int fpga_mgr_write_init_buf(struct fpga_manager *mgr,
 	if (!mgr->mops->initial_header_size)
 		ret = fpga_mgr_write_init(mgr, info, NULL, 0);
 	else
-		ret = fpga_mgr_write_init(
-		    mgr, info, buf, min(mgr->mops->initial_header_size, count));
+		ret = fpga_mgr_write_init(mgr, info, buf,
+					  min(mgr->mops->initial_header_size, count));
 
 	if (ret) {
 		dev_err(&mgr->dev, "Error preparing FPGA for writing\n");
-- 
2.25.1

