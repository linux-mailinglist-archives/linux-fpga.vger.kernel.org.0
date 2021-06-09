Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 765263A0C08
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Jun 2021 07:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235478AbhFIFy7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 9 Jun 2021 01:54:59 -0400
Received: from mail-dm6nam10on2066.outbound.protection.outlook.com ([40.107.93.66]:61889
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230176AbhFIFy5 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 9 Jun 2021 01:54:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9nX+t/+FGGdSBIsYdhnml6NhrJ7oTjSNU9I4TpJfPZZ2QiJqgeuI4Wq7MKqf+0hDQGBJGIsyAH02dl6IvQk0L+Xc3eCXIdwg2ord7xvhp3xDBQuRx96osAkN7sKvavg1A9p8DCn1e7odz9PMg70zvwBmK4ubxm4PHat7E5c0beW1QbJ1QlWyGAUuDxzL5x2KHWuAx3excZzbxs5c8wm28DH8zHyE1aukKYi0Vrr27Y06s+hR9VAHQm5wIna0cPsh2pxN0OpW3H1qjQ0BvDtoWRFqYTXa3kqqI067g0X2EI6vWOemyLplQPS3cs0eA2+yQQOiKQt8tiqx0hius+MNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sq/JxKqrv32H5GgSItoeJnVuKPWop3XKFNhpGPtzXjE=;
 b=IlvlyVKVnOlu1KI//yIfKLW5b2ASo2y2k/7u2Eqc3HndP2qNdt5OQzhDQMr0lm1TFgFlCd9EBWISmOHaumuDLxImM/wgYvlJpTF7mzRYEOUfPTZKUObLH4WKWD94r90i6ir4KAcHvB4rgJV5MQIH84b/r+TzQ6Xo4Ts74O8EOXQat29zwuxTihiRbZrksRMV4gfBNkFMDS42HtsrpTCRKjP8xO4xEr94NYohXd0nSYBq0IIq2tFzrXNoXfnfCopHxmabUjTUNUy93nsWZ6wpPiEgoAkRgrpdOlWJD0japbl7Z970bc5KuM315stHthjRRexVBEZY2mBL8yKT7ATHaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sq/JxKqrv32H5GgSItoeJnVuKPWop3XKFNhpGPtzXjE=;
 b=UsBo2ymSsU0G0aE24aLI/U/bGPb66hV17lSD/DuSkMiEwMdGt2EwPCFp1LWHFAdNh8aG1fZXVdiBH33HnZeLekvG5GraRjeXnq+sXJqfJzjc/MAnComgnojGe2c0dxs0c5i+UP1iw4XzmxoASfkyN89yetKW4M4QT0DMGm4Pi+E=
Received: from SN4PR0201CA0055.namprd02.prod.outlook.com
 (2603:10b6:803:20::17) by BYAPR02MB5255.namprd02.prod.outlook.com
 (2603:10b6:a03:66::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.29; Wed, 9 Jun
 2021 05:53:01 +0000
Received: from SN1NAM02FT0033.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:20:cafe::15) by SN4PR0201CA0055.outlook.office365.com
 (2603:10b6:803:20::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.25 via Frontend
 Transport; Wed, 9 Jun 2021 05:53:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0033.mail.protection.outlook.com (10.97.5.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Wed, 9 Jun 2021 05:53:01 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 22:52:58 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 8 Jun 2021 22:52:58 -0700
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
        id 1lqr96-0007H3-UP; Tue, 08 Jun 2021 22:52:57 -0700
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
Subject: [RFC v2 3/4] drivers: fpga: Add user-key encrypted FPGA Image loading support
Date:   Wed, 9 Jun 2021 11:22:31 +0530
Message-ID: <20210609055232.4501-4-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210609055232.4501-1-nava.manne@xilinx.com>
References: <20210609055232.4501-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a3b60f2-2f23-42b7-9495-08d92b0ad748
X-MS-TrafficTypeDiagnostic: BYAPR02MB5255:
X-Microsoft-Antispam-PRVS: <BYAPR02MB52559D26D5A3E7E1DB7E1308C2369@BYAPR02MB5255.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rSiGzximM566//aDyS5iihTAnrwFIMGc5ov1OqH/OxdK3UDDflkrNAPjvd28xg6O5Qt2QT7dMfLrTqYlylflPuAIK7/8sbvU9kSPg7/g5+VqbDSsndlo6hbH/Jcu1v74adXrV2U5ArtVzA6+wcQ+9omYWBjD6p2jwzflWlESvmdwPIjOdaCn49v2iaiSVKOMC1HuV/PbgAPStV2RjRYXe6l1owmAMeHd9cCcuQlKHMVyum9ToP10ma7GKGUbFHIEY+Bqd7SUH3fAlgFw7d3aOPEVwe4ebaC0OUD7k8jKHtxplVl38vNB0P+BiYPx7MhTbqF2ipJlXJuQGL9Es0glnCU4CGnYbemQK+ZkibYJT/qR5p8MDDRw1Tw8aztnF7MHm08ljih1YZxg/6+/bDhh3KTFLwkV2rNfqmSUuBE5xovFREqfOEYtMTBuekasiTsYVOIp+9EmkxDRijZHcVtiV1+MxSTYO8tBiGkBH3gGuRUSZrcOsOHycoZvgxQ+oKHWUIuhbeRUysKagXxPRPZ6uSg/cZc0cpDB9yly5naL2hBLVKHh8LxUB67t2Pshq3r1M3tmqP6OXvvGp5N3GVnpqQaR6hEAyH+Ac0YY3138zFdhA2+WZUJYy58d/GlEgV21MGw3cJbBf7sH8BD1hMM6vIHL8JUfp+LBQJud1U0bFRMkupiGMFQpxoZF3p3U3W67wd3xbI47HwVxsRQ5i8TOZnBTBLb0cuIrc+4lgoC0o0xtQfa2FYlponyRGEM5YK+X
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(396003)(376002)(36840700001)(46966006)(36906005)(82310400003)(82740400003)(7416002)(478600001)(2616005)(8936002)(1076003)(7696005)(316002)(186003)(26005)(70206006)(336012)(921005)(83380400001)(5660300002)(110136005)(2906002)(426003)(47076005)(356005)(36860700001)(36756003)(7636003)(6666004)(70586007)(8676002)(9786002)(102446001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 05:53:01.0361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a3b60f2-2f23-42b7-9495-08d92b0ad748
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0033.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5255
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch adds user-key encrypted FPGA Image loading support
to the framework.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v2:
                -Both DT properties ie; encrypted-key-name and encrypted-user-key-fpga-config
                 are targeted to use for the same use cases but ideally encrypted-key-name
                 is enough to serve the purpose so updated the code to remove the unwanted
                 encrypted-user-key-fpga-config property dependency as suggested by Rob

 drivers/fpga/fpga-mgr.c       | 15 +++++++++++++++
 drivers/fpga/of-fpga-region.c | 11 +++++++++++
 include/linux/fpga/fpga-mgr.h |  7 +++++++
 3 files changed, 33 insertions(+)

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
index e405309baadc..88d8c9049a2f 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -195,6 +195,7 @@ static struct fpga_image_info *of_fpga_region_parse_ov(
 {
 	struct device *dev = &region->dev;
 	struct fpga_image_info *info;
+	const char *encrypted_key_name;
 	const char *firmware_name;
 	int ret;
 
@@ -228,6 +229,16 @@ static struct fpga_image_info *of_fpga_region_parse_ov(
 	if (of_property_read_bool(overlay, "encrypted-fpga-config"))
 		info->flags |= FPGA_MGR_ENCRYPTED_BITSTREAM;
 
+	if (!of_property_read_string(overlay, "encrypted-key-name",
+				     &encrypted_key_name)) {
+		info->encrypted_key_name =
+			devm_kstrdup(dev, encrypted_key_name, GFP_KERNEL);
+		if (!info->encrypted_key_name)
+			return ERR_PTR(-ENOMEM);
+
+		info->flags |= FPGA_MGR_ENCRYPTED_USER_KEY_BITSTREAM;
+	}
+
 	if (!of_property_read_string(overlay, "firmware-name",
 				     &firmware_name)) {
 		info->firmware_name = devm_kstrdup(dev, firmware_name,
diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 3a32b8e20185..ff14bc51bdd3 100644
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

