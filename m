Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB413728CB
	for <lists+linux-fpga@lfdr.de>; Tue,  4 May 2021 12:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhEDKYX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 4 May 2021 06:24:23 -0400
Received: from mail-dm6nam12on2079.outbound.protection.outlook.com ([40.107.243.79]:39124
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230338AbhEDKYM (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 4 May 2021 06:24:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PkwCri5PqRDrxZMN0hlEb1IbtCoN0yu4Tvn2fw5cUbk+BXA55zFrTT0iki2gynoScpkGpfDouLpjCYBn7W26MGSape+p4SpxkkWXtB2TCoDSJtuLHjvNwceKHA+z++EzbMkFtXeOluCydqTHFydmvFW5iliHiNjwWLlB3szay1jtMECWVctSlvH2xoAHQEO6sw+eYyi7f36SWTcsDSgfwwXG2NVDl0nr36HXvckn3PkLdgla7u79eUPBIfRS9g+aLIR8hQrGDJu5NlPJJ7yqjwes47gnTRpDPhPn0NnFq92KQutgFgsFgxbP5Haqm8u6eNlKMpT/5Y2J87yZAjF+bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbSIYtBiWGmu7mZvmS/YkpSyVRIFytYBz9fMtp0Mn1Q=;
 b=FPOPYk3M/ubhsFQ4ZFJfEGB9Tm8oRz75BqIW3qE6HPChkIzp9bGvoo6PASXUpS5p16Y7D7Q4h5VWyj+e7MVxutnYDohwWMcXVATW8Ky2Vs02lout0mtqt/aI5WJAsyGeHgxCdBFNkbbqphR2iK50Zbq6DaR1a8yimlEojiN22SeOjNE0rZRmamXltqRZ6xXYrI/4eDE1NqiD2fmUwftXQBMp7kUB3NJplrC+Q+stp1vvYvi1D/Yn31X4Nd0WX+AK9G4hn8vfg4yf+hJNu/047HqETb7tVAqZonvyeJooU1vDYQt8uhZRMN1w2LDYW3GL1duoyHfKLeBky4WyXDf7Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbSIYtBiWGmu7mZvmS/YkpSyVRIFytYBz9fMtp0Mn1Q=;
 b=VO9QrQWavTW0HDHZapK8Q4qP3+8TCo4tptcZ17qQ4Mc9A1wadmIxPAjSte2WrvApC9eLuCxEdVgPPe0VeeCcU0vC7Xkv6TiP8jjyAs25D/tpz/2ZhROVS5yA5FyJuI2V0qrV0DKHpKjBn5LbuurFKw/dDRXqXOv50AIQK+Usm14=
Received: from BN8PR12CA0011.namprd12.prod.outlook.com (2603:10b6:408:60::24)
 by BN6PR02MB2417.namprd02.prod.outlook.com (2603:10b6:404:52::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.41; Tue, 4 May
 2021 10:23:12 +0000
Received: from BN1NAM02FT015.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::43) by BN8PR12CA0011.outlook.office365.com
 (2603:10b6:408:60::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend
 Transport; Tue, 4 May 2021 10:23:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT015.mail.protection.outlook.com (10.13.2.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Tue, 4 May 2021 10:23:12 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 4 May 2021 03:22:58 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 4 May 2021 03:22:58 -0700
Envelope-to: git@xilinx.com,
 mdf@kernel.org,
 trix@redhat.com,
 robh+dt@kernel.org,
 arnd@arndb.de,
 gregkh@linuxfoundation.org,
 linus.walleij@linaro.org,
 zou_wei@huawei.com,
 linux-fpga@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 chinnikishore369@gmail.com
Received: from [10.140.6.60] (port=35290 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1ldsCe-000192-OU; Tue, 04 May 2021 03:22:57 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <trix@redhat.com>, <robh+dt@kernel.org>,
        <michal.simek@xilinx.com>, <arnd@arndb.de>,
        <rajan.vaja@xilinx.com>, <gregkh@linuxfoundation.org>,
        <linus.walleij@linaro.org>, <amit.sunil.dhamne@xilinx.com>,
        <tejas.patel@xilinx.com>, <zou_wei@huawei.com>,
        <manish.narani@xilinx.com>,
        <lakshmi.sai.krishna.potthuri@xilinx.com>, <nava.manne@xilinx.com>,
        <wendy.liang@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@xilinx.com>,
        <chinnikishore369@gmail.com>
Subject: [RFC PATCH 4/4] fpga: zynqmp: Add user-key encrypted FPGA Image loading support
Date:   Tue, 4 May 2021 15:52:27 +0530
Message-ID: <20210504102227.15475-5-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210504102227.15475-1-nava.manne@xilinx.com>
References: <20210504102227.15475-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6502a95d-6585-4c42-f0d4-08d90ee69f6d
X-MS-TrafficTypeDiagnostic: BN6PR02MB2417:
X-Microsoft-Antispam-PRVS: <BN6PR02MB2417E900891B558AFAFB7095C25A9@BN6PR02MB2417.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:480;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BY2VTevOB0UE3h8aS0r32qgPMCvPm09pu3KBqCDERd0o8RKd6wVbMfpvqyf5uR1P3IvdysrHIklzCUkp4GkbDB6lbheSxkFydLHPF4pgAfjaPDnR6cVWdQTtEJ74CkRThSFjnuilV+W3IF1NsPd9+UEFivXoFatgwJrFlqN8TK7ZF2trUVGhhW9DDruFLA7svAp8H1rKjsA/ZWCCKNwzELBZdVHpWzEr+YxrpMp48cDMxztEarwnqQMAaS0PvnKR7D34Db9UJg3C8MtY07pVKv0frDbrMSeolTAGwhtIarPR8d/FeKanSCE7u7XhvKA7gmtRGrGNKBWMJgEzEOlNaUHOejoMUUcw1yP+XICrvPQ3ZaEadvVhdu5k8LweEHJBD2/O/OG81NI5s4pXt375jiMEU8cwFY2WFzMZYql4UTXO3qS9IiAFzVu27wGRPkT9xSEryEgzgZGynwx12u16uvEjneIJMMmNvO18kyheNy5XU12q5YrMwxuEiO7DO7fMU7ekrQaBBTLCF3HjxH438os4kTTznozQ/5J9RLcc0C7emznVkUuFIi6kY1UKGGWF3QZMiTOSE5J0AemMeUy8tCLtu5/ZsJBYvBuSjJ6Se2KB5taG68J9yLjNGcrbOVFccm4YKTF3Grsrb8hobNfEhkRqVpjA9QoxVzngQ7TYRiVHiAtcgUTmZNrGp5znl+e6pkHartMlCUeJcnT8oFAgPXaueeDWeWtGhE4z698dTqaz81RaCpPLtlO+iyFWAl94
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(39850400004)(136003)(376002)(346002)(46966006)(36840700001)(47076005)(921005)(7696005)(2616005)(316002)(82310400003)(6666004)(70586007)(8936002)(70206006)(82740400003)(7416002)(356005)(5660300002)(36906005)(26005)(478600001)(110136005)(36756003)(7636003)(83380400001)(1076003)(426003)(36860700001)(186003)(2906002)(9786002)(336012)(8676002)(102446001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 10:23:12.8275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6502a95d-6585-4c42-f0d4-08d90ee69f6d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT015.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2417
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch adds support to load the user-key encrypted FPGA
Image loading to the Xilinx ZynqMP Soc.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
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

