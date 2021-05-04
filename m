Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 980AF3728C2
	for <lists+linux-fpga@lfdr.de>; Tue,  4 May 2021 12:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhEDKX7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 4 May 2021 06:23:59 -0400
Received: from mail-mw2nam10on2051.outbound.protection.outlook.com ([40.107.94.51]:38517
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230218AbhEDKXz (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 4 May 2021 06:23:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+VC2cRYKzQv9oSKNBdGUlrvZ+DM9oNPxNFYoPUwCWExiHtzcmta+eFPbwgm78XJxhqAOQHRGR2Chg62OvVhvLu1Sx4jFmiIUYBY22hi2LMlSQh3dfrZ0OI/MszffV4Er/M5ip8/hzf6JUV1GxZYHHvhSumX4SKElNeN1g1p1X8fRwV1xfjc0maQRfVjFg2KTcievdXZSXgIR9dSFFrbuJ9jLUkfsOTKJrrb0sEscqpIoTFcMP678byA8dblzaE15sHfdkQb+xlV6wBFu9wCTrDehWepDDpOerH1vC/3U616UMqQrWbrlo7b4yslqq52BRBwPMmKlzSfbtHjXE9iLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lK7ltAR+odXS+1lyHwU2R7vWKUZKsrUOnSZGTMytPwE=;
 b=Q1WfnOLlOADeTavupquEml+VKJ+QoNUW3wm6WlArcWrX6ZuJGsJ2t9VjkUQOXy+w/26UCsQXF0hTbB1HbEEHBGj30LQl/ppaj0TEn1mbt4y78ElvIEj6BUuHPZN0h3yqxmOzoNRv3JNUHHQpU8wcJFAPqOlR09AeXJB7OB4DK7pFy5ZlajvNAKChrAf0APIwKIUMOdHkMLRJ5qlKmgnv+3BopD/rR/kB/igbjl2VaVvWxQDsJ28JR9nZQGEqRGc4+smvk6kACNTQfvopCs2N/4u+uZStTITmxuLaA81H+6xmFVNB4pY7FOnt8rK3wGLY8MrG+RC5PF/stJLDUd8BCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lK7ltAR+odXS+1lyHwU2R7vWKUZKsrUOnSZGTMytPwE=;
 b=GpF3FF1H7WtYd3dLyaLZVDIhRhMlkiPEESydBlV1BzRM+H4S0Tja/hmD5ioBcYNJdCfWy+r/JluiM3ONSNV5HOqvP4m550rTLLgdw3EtzjirBs4nFhy8vSpzuyQoBH/E2OZNZs0nfGiEBSrdjswMLaZ9zZnogRNASnyXBnJlf8o=
Received: from SN4PR0201CA0020.namprd02.prod.outlook.com
 (2603:10b6:803:2b::30) by MWHPR02MB2399.namprd02.prod.outlook.com
 (2603:10b6:300:5c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.38; Tue, 4 May
 2021 10:22:59 +0000
Received: from SN1NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2b:cafe::9e) by SN4PR0201CA0020.outlook.office365.com
 (2603:10b6:803:2b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend
 Transport; Tue, 4 May 2021 10:22:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT040.mail.protection.outlook.com (10.152.72.195) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Tue, 4 May 2021 10:22:58 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 4 May 2021 03:22:52 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 4 May 2021 03:22:52 -0700
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
        id 1ldsCZ-000192-Ej; Tue, 04 May 2021 03:22:51 -0700
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
Subject: [RFC PATCH 3/4] drivers: fpga: Add user-key encrypted FPGA Image loading support
Date:   Tue, 4 May 2021 15:52:26 +0530
Message-ID: <20210504102227.15475-4-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210504102227.15475-1-nava.manne@xilinx.com>
References: <20210504102227.15475-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c189947-b1e2-4d56-56a5-08d90ee69706
X-MS-TrafficTypeDiagnostic: MWHPR02MB2399:
X-Microsoft-Antispam-PRVS: <MWHPR02MB23992DFA31A2BAD1FB6A6215C25A9@MWHPR02MB2399.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zTDlbVOat4JjzNMWDt4FZzDHCtB83jaK/AS9IREOxQB7AltmEx4J4YTa9boaNrvQO4LqU3cZIidmHb+E8oFyQtmRnPkyjY28OOtMHuS/34v15cjP6PhyyNBP2LQMO9aLe5lJ3FPX+lil8ax7+lQjT1pXFjAtLVAWyF5EDy+GU/D1Jnd3nu2LXUf+pfo4Yc8U7SU/5xhYxUEvx1xNWHIk0fpckKFE0jDOAHwqoxlH03d5zXHL1+rV7rCFH0QhIQAZIf9F0uxDy/Psy2arbtlrwPMoYyrCU80GHlM52VXmeonSnfuSb1oNjhqFpoAU7vOaUjYW7BaHWYzQm6TVKI2H+MnZh1n/yl+OUz3O7/Px0ntQwuAt0dYnLlJqZjuTe+ADSvCEzNx6INaGuQNiLkreGlitZ0njYwmpZxvbAz2WEMkmrnKWIovDmbu7zNnQ3s2hxBiNvko6W/38v3PRlZe/GaQQUonZ1UVGuN0lcPLQcJLGHUD/p5zaabeUxk8F5xTdo38hAdr6dayC1KYDZAO9rAChUZz3osKMXYUqZovzPiKFYhgDtOLjBp4aVD8mDDPU6txDri0GziQUNvouCImU2FG8tu3s668Wd0hxTXu8F+GtXev3FPZopww05ffSGIJBPUSutiR6HzIoJKjQwP0OubB73Xxjh581P1oKdu2ZVmzCF07zlEUXtGZa/ToKQ3AIxV+QfywBRNNCQyPz5Ka0cyyqQZVhbvx3hlCClTvqsxmxXSDbTWBkfuJCVtwyjkdJ
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(36840700001)(46966006)(7696005)(6666004)(316002)(478600001)(8676002)(82310400003)(8936002)(1076003)(356005)(7416002)(36756003)(110136005)(2616005)(921005)(186003)(2906002)(36906005)(5660300002)(336012)(7636003)(82740400003)(70586007)(83380400001)(47076005)(426003)(26005)(70206006)(36860700001)(9786002)(102446001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 10:22:58.7868
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c189947-b1e2-4d56-56a5-08d90ee69706
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT040.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2399
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch adds user-key encrypted FPGA Image loading support
to the framework.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
 drivers/fpga/fpga-mgr.c       | 15 +++++++++++++++
 drivers/fpga/of-fpga-region.c | 13 +++++++++++++
 include/linux/fpga/fpga-mgr.h |  7 +++++++
 3 files changed, 35 insertions(+)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index b85bc47c91a9..3e79ab8cc86f 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -325,6 +325,7 @@ static int fpga_mgr_firmware_load(struct fpga_manager *mgr,
 				  const char *image_name)
 {
 	struct device *dev = &mgr->dev;
+	const struct firmware *enc_fw;
 	const struct firmware *fw;
 	int ret;
 
@@ -339,8 +340,22 @@ static int fpga_mgr_firmware_load(struct fpga_manager *mgr,
 		return ret;
 	}
 
+	if (info->encrypted_key_name) {
+		ret = request_firmware(&enc_fw, info->encrypted_key_name, dev);
+		if (ret) {
+			mgr->state = FPGA_MGR_STATE_FIRMWARE_REQ_ERR;
+			dev_err(dev, "Error requesting firmware %s\n",
+				info->encrypted_key_name);
+			return ret;
+		}
+		info->enc_key_buf = enc_fw->data;
+		info->enc_key_buf_size = enc_fw->size;
+	}
+
 	ret = fpga_mgr_buf_load(mgr, info, fw->data, fw->size);
 
+	if (info->encrypted_key_name)
+		release_firmware(enc_fw);
 	release_firmware(fw);
 
 	return ret;
diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index e405309baadc..19faa463d96e 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -195,6 +195,7 @@ static struct fpga_image_info *of_fpga_region_parse_ov(
 {
 	struct device *dev = &region->dev;
 	struct fpga_image_info *info;
+	const char *encrypted_key_name;
 	const char *firmware_name;
 	int ret;
 
@@ -228,6 +229,18 @@ static struct fpga_image_info *of_fpga_region_parse_ov(
 	if (of_property_read_bool(overlay, "encrypted-fpga-config"))
 		info->flags |= FPGA_MGR_ENCRYPTED_BITSTREAM;
 
+	if (of_property_read_bool(overlay, "encrypted-user-key-fpga-config")) {
+		if (!of_property_read_string(overlay, "encrypted-key-name",
+					     &encrypted_key_name)) {
+			info->encrypted_key_name =
+			devm_kstrdup(dev, encrypted_key_name, GFP_KERNEL);
+			if (!info->encrypted_key_name)
+				return ERR_PTR(-ENOMEM);
+		}
+
+		info->flags |= FPGA_MGR_ENCRYPTED_USER_KEY_BITSTREAM;
+	}
+
 	if (!of_property_read_string(overlay, "firmware-name",
 				     &firmware_name)) {
 		info->firmware_name = devm_kstrdup(dev, firmware_name,
diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 2bc3030a69e5..ac86f4398c3c 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -67,12 +67,15 @@ enum fpga_mgr_states {
  * %FPGA_MGR_BITSTREAM_LSB_FIRST: SPI bitstream bit order is LSB first
  *
  * %FPGA_MGR_COMPRESSED_BITSTREAM: FPGA bitstream is compressed
+ * %FPGA_MGR_ENCRYPTED_USER_KEY_BITSTREAM: indicates bitstream is encrypted
+ *					   with user-key
  */
 #define FPGA_MGR_PARTIAL_RECONFIG	BIT(0)
 #define FPGA_MGR_EXTERNAL_CONFIG	BIT(1)
 #define FPGA_MGR_ENCRYPTED_BITSTREAM	BIT(2)
 #define FPGA_MGR_BITSTREAM_LSB_FIRST	BIT(3)
 #define FPGA_MGR_COMPRESSED_BITSTREAM	BIT(4)
+#define FPGA_MGR_ENCRYPTED_USER_KEY_BITSTREAM	BIT(5)
 
 /**
  * struct fpga_image_info - information specific to a FPGA image
@@ -82,6 +85,7 @@ enum fpga_mgr_states {
  * @config_complete_timeout_us: maximum time for FPGA to switch to operating
  *	   status in the write_complete op.
  * @firmware_name: name of FPGA image firmware file
+ * @encrypted_key_name: name of the FPGA image encrypted user-key file
  * @sgt: scatter/gather table containing FPGA image
  * @buf: contiguous buffer containing FPGA image
  * @count: size of buf
@@ -95,8 +99,11 @@ struct fpga_image_info {
 	u32 disable_timeout_us;
 	u32 config_complete_timeout_us;
 	char *firmware_name;
+	char *encrypted_key_name;
 	struct sg_table *sgt;
+	const char *enc_key_buf;
 	const char *buf;
+	size_t enc_key_buf_size;
 	size_t count;
 	int region_id;
 	struct device *dev;
-- 
2.17.1

