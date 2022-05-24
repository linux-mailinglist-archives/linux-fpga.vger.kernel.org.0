Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C795326E5
	for <lists+linux-fpga@lfdr.de>; Tue, 24 May 2022 11:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235940AbiEXJv2 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 24 May 2022 05:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235903AbiEXJv1 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 24 May 2022 05:51:27 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFF419F95;
        Tue, 24 May 2022 02:51:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AOHroLCLmEUeac9GXdk2SBJMTQ8w4W4KhyjXBKCxwUH/dZps4BMsidKB1c7igcg6+1DFyu8BziFNULDWxDH+9/jrAauQr04duO6KO5GuIqY9bVavpek8hRTgCIXjQLn0Kary3ToEVnMhW3Ps83FTajehbXeeoV9S0Sc3GD7HaRlgUcElMl7jGW6wwlvLaEluL+q06cmlxiZASy0KZQqqyBPNOhr970DcgrwQXgPYtHpaSLlCDJoGX69URk6SwBBZfEJn9QM4NRwOCnxbVqSqtYlBc20ycxjn4mmzCOXfOfYh8muyUFkqZhX/0ZGlzXKR24sfYEiwj+4jeswh4i/KFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvN2zfiIoDGL6ZikMfzyFtzOZejWwNrEE6cKzzhIlKc=;
 b=HMFtPVmtXNxi8WtIKFrHcvPFRASgvLHCsi2QScUGyhXujFqS+RxKQo80q6LO+BZ4vxQdjMmVNF9w0ibyALF6J9ZoLjLNJccgVhhd3p2LQQxdN1ghOfTgJyW3rh9HlHCwgL74hcX+WC6NAwp2zX7nEtVpQD0sItaTMxpj3k/ILHQ9K9PgybGKQZM4nyq4D8147TYS0LyP4ul87F6xkir7MWyoQjbQc2hpS4gHYurVvQRpMgCrxe/Oo0kI2xQ4DvzmuivpafVfLVFb7cKLaR/nt3F11nalrR06bsq/0Mswn+LE/d9OfYcaXkX5xdbvUOHhSu++yeWNzDJcI6JhEchUEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvN2zfiIoDGL6ZikMfzyFtzOZejWwNrEE6cKzzhIlKc=;
 b=frNUomNajYcilPJJb2/3718ar0Rvl2R0SEC67ozJwN3PinveT3ORvk5CDpfBzEoOJo7RAKiXPNDs/BJDyR5rQKxIz0wwYlyHEZCBqA7OYBmQdzKmkERjoPqRaskVuzwPTk9Juup1CLq2Z2exP59dN5CHovcPgM9+n0Tjq1dREdo=
Received: from BN8PR03CA0027.namprd03.prod.outlook.com (2603:10b6:408:94::40)
 by SN6PR02MB5440.namprd02.prod.outlook.com (2603:10b6:805:e2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Tue, 24 May
 2022 09:51:22 +0000
Received: from BN1NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::a1) by BN8PR03CA0027.outlook.office365.com
 (2603:10b6:408:94::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14 via Frontend
 Transport; Tue, 24 May 2022 09:51:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT055.mail.protection.outlook.com (10.13.2.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Tue, 24 May 2022 09:51:21 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 24 May 2022 02:51:03 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 24 May 2022 02:51:03 -0700
Envelope-to: git@xilinx.com,
 mdf@kernel.org,
 hao.wu@intel.com,
 yilun.xu@intel.com,
 trix@redhat.com,
 gregkh@linuxfoundation.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-fpga@vger.kernel.org
Received: from [10.140.6.60] (port=58200 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1ntR91-0005Sf-4x; Tue, 24 May 2022 02:48:03 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <michal.simek@xilinx.com>, <mdf@kernel.org>, <hao.wu@intel.com>,
        <yilun.xu@intel.com>, <trix@redhat.com>,
        <gregkh@linuxfoundation.org>, <ronak.jain@xilinx.com>,
        <abhyuday.godhasara@xilinx.com>, <rajan.vaja@xilinx.com>,
        <nava.manne@xilinx.com>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <piyush.mehta@xilinx.com>, <harsha.harsha@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <git@xilinx.com>
Subject: [PATCH 1/3] fpga: mgr: Update the status for fpga-manager
Date:   Tue, 24 May 2022 15:17:43 +0530
Message-ID: <20220524094745.287002-2-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220524094745.287002-1-nava.manne@xilinx.com>
References: <20220524094745.287002-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea1e04e4-d56b-4909-6194-08da3d6af568
X-MS-TrafficTypeDiagnostic: SN6PR02MB5440:EE_
X-Microsoft-Antispam-PRVS: <SN6PR02MB5440C3713048BB27E056196AC2D79@SN6PR02MB5440.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tyTKJXnVC9z0/MWU7xlNI8lrg+HFwEG2/fx1ZyXYH6QynlTBz+FoIVHf6PI1vMoE5HrZfD5kPJ3qLGvDcZaI2tokk9uAWUAmmvemptaipouTMNd4tOzWe0h+GKa0QF2HWu0l9lD7kBq1iggACkyxHCOl0B72ZjMdJ4ML+NoHuxD9xwn/oL/md5kS1nNXnfaMag1ULdW01zL3opa/emW3w1ZWXFpl/BktA002Rtmc70J5upJRhhY0ZbeDkMFRBMx3KOXb5h+Ym+MMqaw1hW1EqN+hvD5FdLvJchqILDtptzaGuzZfpBnz7q+xYJG/PM/vhzsW/bs7RbpZPbwZhuL3k8ehDxxopm50OZ1VOJC5gDgwYhCe1QcTHq7m1sM+wM5lkxuIxiVY+eltmiRWAdy+5boESv0kERJWZUmIb/42rq7Sefjng5uUW01bFIDUU2KM/IKNdFWCemVIwoijJRNBQN9WNVNlAa0DMJJAR3SaA/UoBUeOVWKWd0gFxNjvWXz9V56HqQyYtqigH9+ONCFg+DekumZtcuB7Jr8lfquLGSmELZ954OHHPgC1621G4TDFsZaDfZCHlOLP+5C9cJ3gtbrca13/WtVJXiFQ3qjmJxAJAxnfxzmeUDqeIIR+2O2nPG7bzXpkmxatfrrv/l3wZt0ABkAF9FRpzRn+uVV9b5yHY3p/1qds6MH73ScB7gKNZj+N80swHabWbZFCpSLg8aRCHIbSj9T0y4CHesWzRsH8Sly1i0hTS0nIHwgNgP+gjcDgocrMzg/ADH7UN4uCnA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(7696005)(336012)(426003)(15650500001)(70586007)(47076005)(6666004)(1076003)(9786002)(8936002)(82310400005)(8676002)(26005)(356005)(2906002)(7636003)(921005)(70206006)(5660300002)(186003)(36860700001)(36756003)(40460700003)(508600001)(83380400001)(110136005)(2616005)(316002)(6636002)(102446001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 09:51:21.8026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea1e04e4-d56b-4909-6194-08da3d6af568
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT055.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5440
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch update the below status values for
fpga-manager.
	-Device Initialization error.
	-Device internal signal error.
	-All I/Os are placed in High-Z state.
	-Device start-up sequence error.
	-Firmware error.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
 drivers/fpga/fpga-mgr.c       | 13 +++++++++++++
 include/linux/fpga/fpga-mgr.h |  6 ++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index a3595ecc3f79..be693fd531ea 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -475,6 +475,19 @@ static ssize_t status_show(struct device *dev,
 		len += sprintf(buf + len, "reconfig IP protocol error\n");
 	if (status & FPGA_MGR_STATUS_FIFO_OVERFLOW_ERR)
 		len += sprintf(buf + len, "reconfig fifo overflow error\n");
+	if (status & FPGA_MGR_STATUS_SECURITY_ERR)
+		len += sprintf(buf + len, "reconfig security error\n");
+	if (status & FPGA_MGR_STATUS_DEVICE_INIT_ERR)
+		len += sprintf(buf + len, "Device Initialization error\n");
+	if (status & FPGA_MGR_STATUS_SIGNAL_ERR)
+		len += sprintf(buf + len, "Device internal signal error\n");
+	if (status & FPGA_MGR_STATUS_HIGH_Z_STATE_ERR)
+		len += sprintf(buf + len,
+			       "All I/Os are placed in High-Z state\n");
+	if (status & FPGA_MGR_STATUS_EOS_ERR)
+		len += sprintf(buf + len, "Device start-up sequence error\n");
+	if (status & FPGA_MGR_STATUS_FIRMWARE_REQ_ERR)
+		len += sprintf(buf + len, "firmware error\n");
 
 	return len;
 }
diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 0f9468771bb9..91accba14ba2 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -172,6 +172,12 @@ struct fpga_manager_ops {
 #define FPGA_MGR_STATUS_INCOMPATIBLE_IMAGE_ERR	BIT(2)
 #define FPGA_MGR_STATUS_IP_PROTOCOL_ERR		BIT(3)
 #define FPGA_MGR_STATUS_FIFO_OVERFLOW_ERR	BIT(4)
+#define FPGA_MGR_STATUS_SECURITY_ERR		BIT(5)
+#define FPGA_MGR_STATUS_DEVICE_INIT_ERR		BIT(6)
+#define FPGA_MGR_STATUS_SIGNAL_ERR		BIT(7)
+#define FPGA_MGR_STATUS_HIGH_Z_STATE_ERR	BIT(8)
+#define FPGA_MGR_STATUS_EOS_ERR			BIT(9)
+#define FPGA_MGR_STATUS_FIRMWARE_REQ_ERR	BIT(10)
 
 /**
  * struct fpga_manager - fpga manager structure
-- 
2.25.1

