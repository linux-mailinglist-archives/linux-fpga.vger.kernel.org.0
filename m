Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381233A0C11
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Jun 2021 07:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbhFIFzT (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 9 Jun 2021 01:55:19 -0400
Received: from mail-bn7nam10on2086.outbound.protection.outlook.com ([40.107.92.86]:34976
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234310AbhFIFzT (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 9 Jun 2021 01:55:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UP96XvF8Rs20fsQv5RspaCBrIeBode3LhuWhsYsc/CKRniMVbO9LbHF4R+jTWs/yvUYsmbTK4ZKiOlVR/aJxdRWNh4vbF7p8ij8wxuJ5pL1Q2RjvknILlxD6BlWpIHUp4J0/2ReOvWNqLWmhV4WQD3/Ttr1fIRqhVCdyvda7X8LGprk1J82XW4bHsv8WGu1DAHGhuu5twBGTEQV3TU44Wh54WT2hh2vlApEkFGgVZt2PGwwns4+2z0QObKapzd+rCkKyRbGvvfhPEQtSNeF15Nh8xYhucXflPWJ6GzAZ658aMVIZUh0Fi3PQWlUgntwQa6Au+HqwIHoPZrfgF5Trbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uj4WRI+w09FSDA+/xbkC4bNzySmVsfUayDO3ARO/zXM=;
 b=FI8sDk1GrUGtAez/r3DmXMQfjjuvP1LzIaKYzgsgwZaJCCkNzWAN1+m33uS2BuPsCt/B45Klu55ien2onXhKkSkk9fPKCE3YoOAaxUIZJPjmqUp1KK7MGoG1j3DfezGduYIUQAoV2LWr+m/KwqGMi5PGTT/bqbPn+hiV2ESXUqZUOe/S4sr3rcENEjN6VHeIrrE7r4O7OTZfqtZ8MNu8W40OW8rCrcIFl+SppAOb/snXi4MJL6GVTlcSL7uon65vIfo4CZYvT4jEJjWfkmqhu6Y9+YW/vbCAvafOVA+PAA4u/WRtMThCfp735KwrKk/OGjx0/d8h1qeBoc8mk16rMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uj4WRI+w09FSDA+/xbkC4bNzySmVsfUayDO3ARO/zXM=;
 b=nA5lSQeC24DVX5JBaGLu9cAs/lzYuFmxqw9Foaul/KnykM9gRCcTJtBAwVpGJVbDhW7SKJkI2UPUdDQREnGkytF/uSAo2CuA4PqwPrOEN/jwXg0P/osB7/mvgFmIWg1o994YRRO4uOEtxTJrbS0oDQGrEV474OUlF4/OhpMMpbw=
Received: from SN2PR01CA0083.prod.exchangelabs.com (2603:10b6:800::51) by
 DM6PR02MB4105.namprd02.prod.outlook.com (2603:10b6:5:97::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.23; Wed, 9 Jun 2021 05:53:22 +0000
Received: from SN1NAM02FT0047.eop-nam02.prod.protection.outlook.com
 (2603:10b6:800:0:cafe::6f) by SN2PR01CA0083.outlook.office365.com
 (2603:10b6:800::51) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Wed, 9 Jun 2021 05:53:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0047.mail.protection.outlook.com (10.97.5.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Wed, 9 Jun 2021 05:53:22 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 22:53:03 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 8 Jun 2021 22:53:03 -0700
Envelope-to: git@xilinx.com,
 robh+dt@kernel.org,
 mdf@kernel.org,
 trix@redhat.com,
 arnd@arndb.de,
 gregkh@linuxfoundation.org,
 zou_wei@huawei.com,
 iwamatsu@nigauri.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 chinnikishore369@gmail.com
Received: from [10.140.6.60] (port=51918 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1lqr9C-0007H3-8I; Tue, 08 Jun 2021 22:53:02 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <robh+dt@kernel.org>, <michal.simek@xilinx.com>, <mdf@kernel.org>,
        <trix@redhat.com>, <nava.manne@xilinx.com>, <arnd@arndb.de>,
        <rajan.vaja@xilinx.com>, <gregkh@linuxfoundation.org>,
        <amit.sunil.dhamne@xilinx.com>, <tejas.patel@xilinx.com>,
        <zou_wei@huawei.com>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <ravi.patel@xilinx.com>, <iwamatsu@nigauri.org>,
        <wendy.liang@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <git@xilinx.com>, <chinnikishore369@gmail.com>
Subject: [RFC v2 4/4] fpga: zynqmp: Add user-key encrypted FPGA Image loading support
Date:   Wed, 9 Jun 2021 11:22:32 +0530
Message-ID: <20210609055232.4501-5-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210609055232.4501-1-nava.manne@xilinx.com>
References: <20210609055232.4501-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38b8f281-2eeb-4726-c05d-08d92b0ae3f0
X-MS-TrafficTypeDiagnostic: DM6PR02MB4105:
X-Microsoft-Antispam-PRVS: <DM6PR02MB41055DD33B7EB537AD27F727C2369@DM6PR02MB4105.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TE6AKAjdICCNHomlg3G2S1DO2rF0RO70BEofXQ39MiDHr9oVgs/Qfma3Y+FnOKfCAzsAt1mTuZ8+WsKy932+lMXVIUlQVrr0xKxvVuKuNY0NSBW6CrvIBqcgJKohbun1WBfM9i/0SaOm+Ska+/W/VzBGL9/X2Ae9jOBnP0lC5DNrpeswqAi/igf85ccliL7hSkD9i1VqMskPyuNPI24NtYEkxKGbRubseZlrRjCTrfOPmyH8NlINrb3bLAz8fZ+yMXBJ8vyYk+e2ezyMmduQc/j/T3Weee7XKFHn2ZuTGaNnPI1KA+eYH9khaGHbncU3s+hryIJFz/6XAFxEAwszWgl40GjOY0ZWvfTV/1JYECa7cN9A2U6P/SoMBK79oXWXhs2KdQiEWfxsEeP+KBrLdhxFO3T9kGQZUHbpZZ7OrjNXv+7LyWX25aqNOyRqUD4e7Emfk1/Rz05Gc/NVlEgXo5Di+cilj1030OUFNwG/M63dCj1KM40Kinrb1tpgaPrF8DB19QxKYfpGglLgo271N/THCjFQ+9Qd/QyUdU7dm6+3Yb+wTIDHgkAQnwxanDO/HgfU4Y+xXXspjNwqYcwjm7UqEh96xPIZtgHew6FSRKg1U+1vaxsfH6MweEEpinsrlJNDKX/fkW9H6eEyQC+G5SFOsEusfjjT6NfvEdJafgzM6QGv7iCelu9Jht9ZbilUmuonz34aNjmHeVm2lJAF723h6zwIodM7/m8fVLognemF32eyeBX9Etq+sQX4yMJp
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39850400004)(396003)(346002)(376002)(136003)(36840700001)(46966006)(7416002)(921005)(7696005)(47076005)(478600001)(83380400001)(9786002)(5660300002)(2906002)(316002)(186003)(356005)(82310400003)(2616005)(336012)(70206006)(1076003)(36756003)(70586007)(82740400003)(8936002)(7636003)(36906005)(6666004)(26005)(36860700001)(8676002)(426003)(110136005)(102446001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 05:53:22.2709
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b8f281-2eeb-4726-c05d-08d92b0ae3f0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0047.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4105
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch adds support to load the user-key encrypted FPGA
Image loading to the Xilinx ZynqMP Soc.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v2:
		-None.

 drivers/fpga/zynqmp-fpga.c           | 24 ++++++++++++++++++++++--
 include/linux/firmware/xlnx-zynqmp.h |  2 ++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
index 125743c9797f..565ebe9e1610 100644
--- a/drivers/fpga/zynqmp-fpga.c
+++ b/drivers/fpga/zynqmp-fpga.c
@@ -22,6 +22,8 @@
  */
 struct zynqmp_fpga_priv {
 	struct device *dev;
+	const char *key_buf;
+	size_t key_size;
 	u32 flags;
 };
 
@@ -33,6 +35,8 @@ static int zynqmp_fpga_ops_write_init(struct fpga_manager *mgr,
 
 	priv = mgr->priv;
 	priv->flags = info->flags;
+	priv->key_buf = info->enc_key_buf;
+	priv->key_size = info->enc_key_buf_size;
 
 	return 0;
 }
@@ -41,9 +45,9 @@ static int zynqmp_fpga_ops_write(struct fpga_manager *mgr,
 				 const char *buf, size_t size)
 {
 	struct zynqmp_fpga_priv *priv;
-	dma_addr_t dma_addr;
+	dma_addr_t dma_addr, key_addr;
 	u32 eemi_flags = 0;
-	char *kbuf;
+	char *kbuf, *key_kbuf;
 	int ret;
 
 	priv = mgr->priv;
@@ -54,13 +58,29 @@ static int zynqmp_fpga_ops_write(struct fpga_manager *mgr,
 
 	memcpy(kbuf, buf, size);
 
+	if (priv->flags & FPGA_MGR_ENCRYPTED_USER_KEY_BITSTREAM) {
+		eemi_flags |= XILINX_ZYNQMP_PM_FPGA_ENC_USER_KEY;
+		key_kbuf = dma_alloc_coherent(priv->dev, size, &key_addr,
+					      GFP_KERNEL);
+		if (!key_kbuf)
+			return -ENOMEM;
+		memcpy(key_kbuf, priv->key_buf, priv->key_size);
+	}
+
 	wmb(); /* ensure all writes are done before initiate FW call */
 
 	if (priv->flags & FPGA_MGR_PARTIAL_RECONFIG)
 		eemi_flags |= XILINX_ZYNQMP_PM_FPGA_PARTIAL;
 
+	if (priv->flags & FPGA_MGR_ENCRYPTED_USER_KEY_BITSTREAM)
+		ret = zynqmp_pm_fpga_enc_key_load(key_addr, priv->key_size);
+
 	ret = zynqmp_pm_fpga_load(dma_addr, size, eemi_flags);
 
+	if (priv->flags & FPGA_MGR_ENCRYPTED_USER_KEY_BITSTREAM)
+		dma_free_coherent(priv->dev, priv->key_size,
+				  key_kbuf, key_addr);
+
 	dma_free_coherent(priv->dev, size, kbuf, dma_addr);
 
 	return ret;
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 7aa9ad40ff53..a767386d930a 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -56,9 +56,11 @@
  * Firmware FPGA Manager flags
  * XILINX_ZYNQMP_PM_FPGA_FULL:	FPGA full reconfiguration
  * XILINX_ZYNQMP_PM_FPGA_PARTIAL: FPGA partial reconfiguration
+ * XILINX_ZYNQMP_PM_FPGA_ENC_USER_KEY: User-key Encrypted FPGA reconfiguration
  */
 #define XILINX_ZYNQMP_PM_FPGA_FULL	0x0U
 #define XILINX_ZYNQMP_PM_FPGA_PARTIAL	BIT(0)
+#define XILINX_ZYNQMP_PM_FPGA_ENC_USER_KEY	BIT(3)
 
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
-- 
2.17.1

