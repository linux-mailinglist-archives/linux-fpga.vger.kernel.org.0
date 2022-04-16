Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5E65036C5
	for <lists+linux-fpga@lfdr.de>; Sat, 16 Apr 2022 15:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbiDPNkH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 16 Apr 2022 09:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbiDPNkG (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 16 Apr 2022 09:40:06 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F1BD3737;
        Sat, 16 Apr 2022 06:37:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UmbQzA6j1flGWbXciRZqUsNRzLhC01HcaWKU5s6yNZZZhajmvHZ/MAhyfzaNUB5FMzpl6S4xYxBbaJOYLqvs8z++dsCzo60nUel2EntK38U8sYcEymaY5FKefa226jrpFQDkI4cryHj5ndR3NdcyiEAvYfFf7cVaQuqyg+ZQsTZblt1Lxu+KMahRXGWXC71oLWJ5DFQ5j8AY/iBw2sncrvzRLQKWCdsOHpDWcz7OHRWYTEi1dZrOLlc73d2RGVbHoILWzdTbH7YO6pG3XedTwxUgOWQ4qX+xSguL20+F4ZDgnke5nP8NdIrQOyR34wrp/Fvd6vc3f8b4tjacxaq3wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wREnmfHXmJi/4pzRfxLgzRdTnMxt4bSq6450Laxcd+o=;
 b=W+jUv7QELzKxi/TnvAhGfYFno6VEz0lVHKeS15a6nSc88PWEMcFFC2aZM66N6tchAGI3bvKrp6k+rU2JeVBcYBszK55Nm4DF9DyqSto/0FuNx9c3+tX3ecgzXsOLpU3PDqEMScS6uOhAsoYKlUVXE5isdsVjeVBeNWIPxDfyqhhRthWiRjhPyBbPLV0iUaA015IU+HAX69Z39QF4TjPLpthjO/ljVsi3VKdqMmt9wb8HJfDGtMSHc753vSb4VMJD8LdrR8C5PCwmzNalO+VCtw4RbeChzmhv9jbSpXwGiuvd/WAP/7EAcx8bxb0eLXqe7ob3ECEEguu+CyzZL/Pi/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wREnmfHXmJi/4pzRfxLgzRdTnMxt4bSq6450Laxcd+o=;
 b=HGUq2vw0EWkbz2lar+UF8leIvVwtX8KByI8ZaBbfkq6jqXrPk2Wv6Z/AselOLw7CVr75y8QiZtQ5rYJaW559PUbehnl9gA0i1sUUnQQWA5Z5UIgywGz6FsKvbHJ1yjf5bsiYIprRh3Pu8FXl0FwjnxQHivYqJ79r0vuojMhCsf8=
Received: from BN0PR04CA0167.namprd04.prod.outlook.com (2603:10b6:408:eb::22)
 by SA0PR02MB7338.namprd02.prod.outlook.com (2603:10b6:806:ec::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Sat, 16 Apr
 2022 13:37:31 +0000
Received: from BN1NAM02FT048.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::e8) by BN0PR04CA0167.outlook.office365.com
 (2603:10b6:408:eb::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20 via Frontend
 Transport; Sat, 16 Apr 2022 13:37:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT048.mail.protection.outlook.com (10.13.2.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Sat, 16 Apr 2022 13:37:30 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sat, 16 Apr 2022 06:37:28 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sat, 16 Apr 2022 06:37:28 -0700
Envelope-to: git@xilinx.com,
 mdf@kernel.org,
 hao.wu@intel.com,
 yilun.xu@intel.com,
 trix@redhat.com,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [10.140.6.60] (port=32988 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1nficC-00088I-C0; Sat, 16 Apr 2022 06:37:28 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <michal.simek@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@xilinx.com>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v4 1/5] fpga: zynq: Fix incorrect variable type
Date:   Sat, 16 Apr 2022 19:07:15 +0530
Message-ID: <20220416133719.3382895-2-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220416133719.3382895-1-nava.manne@xilinx.com>
References: <20220416133719.3382895-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45cfdab7-0b99-4d09-94bc-08da1fae4150
X-MS-TrafficTypeDiagnostic: SA0PR02MB7338:EE_
X-Microsoft-Antispam-PRVS: <SA0PR02MB733885D45910625004AAC318C2F19@SA0PR02MB7338.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0YXzMV3JNJ/pIrLzOVPc+5+V0PhjPJV0xE5lbXltkvYfIGH/iZC2oCtXuf/sDT6GfZDp8uzsjHhsV+fxNinD5u6H+pxIoyqdUHAhXHsNxtNjOsJB05FhQx0O48JqcytlvrjXXQQ1yC8+9fhK25ZWEjPw90oZheyGHYnQsi+7d3gKJwNCWoFgrMUwCZ4AT3scQvjcMLLKRevqWZ0KWex8refMmr2LZYmfi4mx9sXSnlbun+wysG0cNrMtoqB8hek6vOhgtjuG3f8TeoGQs80OKzwMu1XJqgGIRSH7Br3oHn5wkPRKcM3Gjp7MG/cyo1U2X668rdnfTMhUzq4GPjWyVzfic1tYjMtq3qrC5ZitWE4BzvFaa7LUG48zscIlllt3TlMAXGuTmkhrXggq4Hio1cxyEpHdppdEwstHF9chctHAdHKe2ODvYAzo3pHRfzsLXntDp8m5oYIULxHNO49zdfBJ1Nk8edLDwSWSEGoNDszXDG6ppk9LZQ/Qa/ujd+KdVtg/ILN46MFKGuuOoM2yez5hCYCHBQOBwO1zdAU07K6J99TNjKd9DTsyfaNPzz1BCkG8vdnvX3XN5hNpRWBnvFMl13SHreX8qi//tyooqRJy/JFnazelOGA1H5uE2wr5+8GPcQp6b4iqEIIgtmZYtq7lKiaq2D9ZJgfCZCnK8jTQvftvaF3FP67R38FmB0whMryUVYigsshCg/MsEKPaETozUHcynPIo0fR+mh2kmRk=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(356005)(36756003)(6636002)(8936002)(36860700001)(110136005)(70206006)(47076005)(83380400001)(316002)(7636003)(82310400005)(336012)(426003)(2906002)(8676002)(4326008)(107886003)(6666004)(70586007)(1076003)(186003)(7696005)(5660300002)(508600001)(9786002)(26005)(40460700003)(2616005)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2022 13:37:30.5510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45cfdab7-0b99-4d09-94bc-08da1fae4150
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT048.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7338
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

zynq_fpga_has_sync () API is expecting "u8 *" but the
formal parameter that was passed is of type "const char *".
fixes this issue by changing the buf type to "const char *"

This patch will also update zynq_fpga_has_sync () API description
to align with API functionality.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v2:
                -None.
Changes for v3:
               - Changed arg buf type to "const char *" as suggested by Tom.
               - update zynq_fpga_has_sync () API description to align with API
                 functionality.
Changes for v4:
               - None.

 drivers/fpga/zynq-fpga.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index 426aa34c6a0d..ada07eea64bc 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -235,11 +235,11 @@ static irqreturn_t zynq_fpga_isr(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-/* Sanity check the proposed bitstream. It must start with the sync word in
- * the correct byte order, and be dword aligned. The input is a Xilinx .bin
- * file with every 32 bit quantity swapped.
+/* Sanity check the proposed bitstream. The sync word must be found in the
+ * correct byte order and it should be dword aligned. The input is a
+ * Xilinx.bin file with every 32 bit quantity swapped.
  */
-static bool zynq_fpga_has_sync(const u8 *buf, size_t count)
+static bool zynq_fpga_has_sync(const char *buf, size_t count)
 {
 	for (; count >= 4; buf += 4, count -= 4)
 		if (buf[0] == 0x66 && buf[1] == 0x55 && buf[2] == 0x99 &&
-- 
2.25.1

