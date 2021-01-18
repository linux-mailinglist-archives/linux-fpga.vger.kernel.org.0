Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAF52F9800
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Jan 2021 03:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730897AbhARC5v (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 17 Jan 2021 21:57:51 -0500
Received: from mail-eopbgr750048.outbound.protection.outlook.com ([40.107.75.48]:6007
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730243AbhARC5t (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 17 Jan 2021 21:57:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KnpqQpob2tzgpG8Y7qJV2Uhf9ZpY6CwaDwD5xX2wJSJzzIDzv14NHT5X938jP79ttPNjgM1469Fv4u78Be7UXSC2eo9QcZ4B56YYkzRb4K5AYyRxTGkAenn9wownrmRd6I7K6MsNjTsnHLDjbhkZxQddGuUjmmuHxuhTMYRWvS3b26P3+szjqL2Klu74Wby4ppbKmYasqYTMUD7lH3rM5q6WeOWVOY7fX7I9ASN5fcrZnGqjf8el6mXrHz1FRaLF7z5uNDHNBe1ITO34OQjecubBhZJRAZtnS9tQmB0mA8OeyJEd7R3nXG4G8abQnalNpJx/abDdBoD/He85gfnwOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exHWXFQBR2HE2BILEoHb2FomJA51bb1SXvdhtbmKRRY=;
 b=S4v/PZOi5oXfA6hypAfmiGNJIqDDLWBZuDwYjjDPimh4Cu+GNK4RMMfx0YWh/7oHWbCwmi4zs+h0ByyzBtCl/rZqu5YbjWlzJlsrZYfmnAGTitjS2PxPJ1r/YcMD6EmQBCcFSMAnl1J5BIjf37LlPhiXPoWeSjIeBk96kAw/z/d7KzqLKimkw+J3yRkR6QI4Fyg9f5gNZqhoNZs3pWvCOr+AWYUGuTwcxiclSq6znyfjf26iqLYS19Tz9UGyDW+UQe5Fxvp8jM/6B7G0exaoFZF0Mi8A/of5tt4bp3TVIIgY6zmgzRr8Qt39P/FL3b3a8CkyjUVI+mJo+G7R6TlaxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exHWXFQBR2HE2BILEoHb2FomJA51bb1SXvdhtbmKRRY=;
 b=oC4QpJWK1iOxHTHHjeyPmJ8iuhjRXJHMnLD98o8E1IX3wSXkhv2syU/QacMd2FsHHj8gjqVcNR4ZD9OGEQe+c6j/3NJ1AbQvr0ibCluGjqXB2YjanUQR54wMxGdMzzCpVTMI8ZgYEErjJ4/1hLUUItVNK3hW5EktdyXY5bKRSJ4=
Received: from CY4PR13CA0008.namprd13.prod.outlook.com (2603:10b6:903:32::18)
 by SA2PR02MB7660.namprd02.prod.outlook.com (2603:10b6:806:14a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.12; Mon, 18 Jan
 2021 02:56:58 +0000
Received: from CY1NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:32:cafe::c2) by CY4PR13CA0008.outlook.office365.com
 (2603:10b6:903:32::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.6 via Frontend
 Transport; Mon, 18 Jan 2021 02:56:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT020.mail.protection.outlook.com (10.152.75.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3763.12 via Frontend Transport; Mon, 18 Jan 2021 02:56:58 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Sun, 17 Jan 2021 18:56:57 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Sun, 17 Jan 2021 18:56:57 -0800
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
        id 1l1Kit-0004GM-Q6; Sun, 17 Jan 2021 18:56:56 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <trix@redhat.com>, <robh+dt@kernel.org>,
        <michal.simek@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <git@xilinx.com>, <chinnikishore369@gmail.com>,
        Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH 1/2] fpga: mgr: Adds secure BitStream loading support
Date:   Mon, 18 Jan 2021 08:20:57 +0530
Message-ID: <20210118025058.10051-1-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00ccb55c-0fb1-4cb5-25a9-08d8bb5cb8dd
X-MS-TrafficTypeDiagnostic: SA2PR02MB7660:
X-Microsoft-Antispam-PRVS: <SA2PR02MB76600443E285B17B5CD04013C2A40@SA2PR02MB7660.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:169;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hjqLNxkGlnw0AgXd4Ev5kKlmOHd3LognReeSe+T1UKsf/T+zqlH4y12SpPI6MZUhh4uNrxZACYEdM8BWSZvVaV/cWMPO9OY2+ed9cvrQ3m2gXOgl4kchw3AQsVrfhXYfb6DDBWhO4CUOntM/wQzi/i0/aTUkwc7vmlMRQe79KZkuhyz5QR/H8paz+dzvLO72cHgDogOKYIeN+DUa7AwgNlsc778J17SDJO3zbljmbPOUhbkk/CCs1d/yfIEWn/gpFnQpAjAzNIvtovRh7e56k5fTZXku7hvZsSCxhBdEIeqZyIcZbsY6TDIIYfAT8ek2zCzzcYdv/4Kq59I6CNbYZzSeJ72IUtP8xhi/uNzu5kbdBj1OYYmGDkgJiryiz2Vgtwra+SjpcORvVAsuoyMucIl3gsY0wqvtGzs9Xgk7pclOKz3+duGpaLQZUfUxLOcgBUBiRyGhyQmHrvY+LfPAW3uDEzLIKIuS8gbs6aA330CO+HthLYDKSunyVjueCoYDfE3UlYgaGb+t+fY9P2ORQQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(39850400004)(346002)(46966006)(70206006)(70586007)(107886003)(83380400001)(82740400003)(82310400003)(356005)(26005)(8936002)(7636003)(9786002)(8676002)(2906002)(54906003)(186003)(7696005)(36906005)(110136005)(47076005)(478600001)(316002)(36756003)(1076003)(5660300002)(4326008)(336012)(2616005)(426003)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2021 02:56:58.5172
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ccb55c-0fb1-4cb5-25a9-08d8bb5cb8dd
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT020.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7660
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This commit adds secure flags to the framework to support
secure BitStream Loading.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
 drivers/fpga/of-fpga-region.c | 10 ++++++++++
 include/linux/fpga/fpga-mgr.h | 12 ++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index e405309baadc..3a5eb4808888 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -228,6 +228,16 @@ static struct fpga_image_info *of_fpga_region_parse_ov(
 	if (of_property_read_bool(overlay, "encrypted-fpga-config"))
 		info->flags |= FPGA_MGR_ENCRYPTED_BITSTREAM;
 
+	if (of_property_read_bool(overlay, "userkey-encrypted-fpga-config"))
+		info->flags |= FPGA_MGR_USERKEY_ENCRYPTED_BITSTREAM;
+
+	if (of_property_read_bool(overlay, "ddrmem-authenticated-fpga-config"))
+		info->flags |= FPGA_MGR_DDR_MEM_AUTH_BITSTREAM;
+
+	if (of_property_read_bool(overlay,
+				  "securemem-authenticated-fpga-config"))
+		info->flags |= FPGA_MGR_SECURE_MEM_AUTH_BITSTREAM;
+
 	if (!of_property_read_string(overlay, "firmware-name",
 				     &firmware_name)) {
 		info->firmware_name = devm_kstrdup(dev, firmware_name,
diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 2bc3030a69e5..2f7455a60666 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -67,12 +67,24 @@ enum fpga_mgr_states {
  * %FPGA_MGR_BITSTREAM_LSB_FIRST: SPI bitstream bit order is LSB first
  *
  * %FPGA_MGR_COMPRESSED_BITSTREAM: FPGA bitstream is compressed
+ *
+ * %FPGA_MGR_USERKEY_ENCRYPTED_BITSTREAM: indicates bitstream is encrypted with
+ *                                        user key
+ *
+ * %FPGA_MGR_DDR_MEM_AUTH_BITSTREAM: do bitstream authentication using DDR
+ *                                   memory if supported
+ *
+ * %FPGA_MGR_SECURE_MEM_AUTH_BITSTREAM: do bitstream authentication using secure
+ *                                      memory if supported
  */
 #define FPGA_MGR_PARTIAL_RECONFIG	BIT(0)
 #define FPGA_MGR_EXTERNAL_CONFIG	BIT(1)
 #define FPGA_MGR_ENCRYPTED_BITSTREAM	BIT(2)
 #define FPGA_MGR_BITSTREAM_LSB_FIRST	BIT(3)
 #define FPGA_MGR_COMPRESSED_BITSTREAM	BIT(4)
+#define FPGA_MGR_USERKEY_ENCRYPTED_BITSTREAM	BIT(5)
+#define FPGA_MGR_DDR_MEM_AUTH_BITSTREAM		BIT(6)
+#define FPGA_MGR_SECURE_MEM_AUTH_BITSTREAM	BIT(7)
 
 /**
  * struct fpga_image_info - information specific to a FPGA image
-- 
2.18.0

