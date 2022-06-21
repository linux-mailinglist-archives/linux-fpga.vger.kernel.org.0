Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C527F552E58
	for <lists+linux-fpga@lfdr.de>; Tue, 21 Jun 2022 11:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348938AbiFUJ3F (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 21 Jun 2022 05:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348953AbiFUJ3D (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 21 Jun 2022 05:29:03 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC82D10A;
        Tue, 21 Jun 2022 02:28:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YrpGaeF7KBCohxgPuxxETiYBRnRkwvFozGW04u1mDwahIq0PbeH5ymJTRmb2LOcQHbIyGPihHzdSkMXdzETGqVRwpadtF7CLD19T5N/ac6E/3lOMoeWaOMw73uRf0z3QCYDwzMIRSBo+eT1sRPmiheOAdfZTlyfHc0mCbtoACoOXyUg+oxgVz/yl2SSyM6bDrqNmurAnmt8g4FjtBC6QTpRPr5hWjkLXYfT3qCNd/yKP5vgtXMqA9I+pmwJ6u1fi6MdX/3p32FqaLkwP5UORscMt6uF9fNEyhtCMnM4PvyVPFf+t0zHDVXPuQmJY/Uw3zREmBc8aLqTb42Pyv4BGBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7K0ILwbCgICfMtH8hwDNrdO38tn2hjPqx673jRl/rg=;
 b=QQv29e7RqEjDPXztNkgAdFH8lyn1l7u1SIbaalGTg/vfY/Auy4BJRdVdfpZRNQkZ/j/9sMgyXuosMrYnfW1dQrBdiy+9pWulxqkzVQyJb3Pc4BEAwv3rE7p9F7bQq5R5tA8r3PesSCPejvYxP7qLq8xrGQEKsWEwtq/hg5+RgJKn0juNK9xD9XXILiya0a6GKLreQT/s8rwEedYMH6DtUHISoWWBGfUF0ftspygMTwzpQIeCr7DRSEbGRgdEFuDRv9lDXVnyJLUD9s5vh5Qb0sS68+sxB32rN4Xy0+y/Ylj+xelLFyJXwe7YfN6xyGM6doekDF9hEPmy7ntn7eH+hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=intel.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7K0ILwbCgICfMtH8hwDNrdO38tn2hjPqx673jRl/rg=;
 b=bvb0RSO57PIS91z7UOtJWPmvbg1vmI8S/PLV3sQmM1GSs7/Teng8VtBScSs/w5NAnaE1Svhtcl5ePGlwadlDMK/IFk1AaLillua2oWG2uPzO8W3hRCKXf+/0HB7kotL203FNGg53dyukTJZMKL5ovVeNiKtUPIPMDVp0YNpQX0M=
Received: from SN6PR05CA0004.namprd05.prod.outlook.com (2603:10b6:805:de::17)
 by DM8PR02MB7991.namprd02.prod.outlook.com (2603:10b6:8:14::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Tue, 21 Jun
 2022 09:28:55 +0000
Received: from SN1NAM02FT0048.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:de:cafe::85) by SN6PR05CA0004.outlook.office365.com
 (2603:10b6:805:de::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.9 via Frontend
 Transport; Tue, 21 Jun 2022 09:28:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0048.mail.protection.outlook.com (10.97.4.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Tue, 21 Jun 2022 09:28:54 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 21 Jun 2022 02:28:53 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 21 Jun 2022 02:28:53 -0700
Envelope-to: git@xilinx.com,
 hao.wu@intel.com,
 trix@redhat.com,
 mdf@kernel.org,
 yilun.xu@intel.com,
 gregkh@linuxfoundation.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-fpga@vger.kernel.org
Received: from [10.140.6.60] (port=45120 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1o3aBp-000DOt-16; Tue, 21 Jun 2022 02:28:53 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <michal.simek@xilinx.com>, <hao.wu@intel.com>, <trix@redhat.com>,
        <mdf@kernel.org>, <yilun.xu@intel.com>,
        <gregkh@linuxfoundation.org>, <ronak.jain@xilinx.com>,
        <rajan.vaja@xilinx.com>, <abhyuday.godhasara@xilinx.com>,
        <nava.manne@xilinx.com>, <piyush.mehta@xilinx.com>,
        <harsha.harsha@xilinx.com>,
        <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <git@xilinx.com>
Subject: [PATCH v2 2/3] firmware: xilinx: Add pm api function for PL readback
Date:   Tue, 21 Jun 2022 14:58:32 +0530
Message-ID: <20220621092833.1057408-3-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220621092833.1057408-1-nava.manne@xilinx.com>
References: <20220621092833.1057408-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34fef55a-902d-4ca3-5cbf-08da53687628
X-MS-TrafficTypeDiagnostic: DM8PR02MB7991:EE_
X-Microsoft-Antispam-PRVS: <DM8PR02MB799149DB4CCE40AD64FFD05CC2B39@DM8PR02MB7991.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fhKp4Att0VOw1AeK2WMldLgIc/8lLblbOpamG2a33awrJhk+oj8WymdQJqVesj+O2Z6BLT7I6WiXYFL1hEcYPpvoD1UgO6w5q+veMYHobjV9Re9zuO8KH4mBwy7JrdgsQ/Y8bkEreZ0wGp2PYkRdwW7ijZ18rqDbYJ5f61WOeP+k8PK7H3OKElm0W6hs12PHB4mE22eKKYCqN/QHkBinoCKXTlwTTzlYpHb5NuGH7ijFMisrzP5BBLa4zwT3YEqshqNyitW71x3Nn+em0cIj7d2uGtnqEZVaevBbzQKn5XEMzZUoIb0iCs/v0kuald4c468vvSn1RxSN3OKGw261+Y4o0HXADFT+q8cogZGl/R6mWbkHxy1QutPPx283x3SoG611yma+fXFVjd+xWc9808ehqlhBJKawuq7KFeJk6WVo+HXDviaYcR2WfI3md/wGGnAsTVRNeo/KzbUwjOPQYf9gzgc1EtgYU6m0r8sCFgWM02k/ZrzDHUYv8Gklkb0HIwzSjSKYwyCiPP3GBxnwuYhRs2fuTPVuMw5CnYznkIEZ8H2xDFVQezjyMWQx3q3GjCb/+deaxO6pFFzTOQMJydEevkSjb6aoF/P//9xZKOXnLECdYk/c25ttrMtq8yjK41evNnsK1GvnTkpzgkYYUqSo71+QCQxiygIDZamYjF9U6rxlxm9KI2tYXCbayNBiIh3OH7Q/Iy3x1TvgM0kwf1SUx7sX6lUE+8AaZ/tgV576ze9kPS2XMdE4gOb+9EumGHc/7lh3iBASen5pu9NFq4+aORwxxsTT0S25H7o5aa7wcwIxHH6iZeJqw7S9T05Z
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(39860400002)(396003)(376002)(46966006)(36840700001)(40470700004)(478600001)(6636002)(110136005)(2906002)(316002)(26005)(921005)(8676002)(5660300002)(36756003)(2616005)(41300700001)(70206006)(9786002)(70586007)(8936002)(47076005)(336012)(426003)(186003)(40460700003)(7636003)(82740400003)(6666004)(7696005)(356005)(36860700001)(40480700001)(82310400005)(83380400001)(1076003)(102446001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 09:28:54.9626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34fef55a-902d-4ca3-5cbf-08da53687628
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0048.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB7991
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Adds PM API for performing PL configuration readback.
It provides an interface to the pmufw to readback the
FPGA configuration registers as well as configuration
data.

For more detailed info related to the configuration
registers and configuration data refer ug570.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v2:
              - None.

 drivers/firmware/xilinx/zynqmp.c     | 33 ++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 14 ++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 7977a494a651..40b99299b662 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -927,6 +927,39 @@ int zynqmp_pm_fpga_get_status(u32 *value)
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_fpga_get_status);
 
+/**
+ * zynqmp_pm_fpga_read - Perform the fpga configuration readback
+ * @reg_numframes: Configuration register offset (or) Number of frames to read
+ * @phys_address: Physical Address of the buffer
+ * @readback_type: Type of fpga readback operation
+ *                 0 - FPGA configuration register readback
+ *                 1 - FPGA configuration data readback
+ * @value: Value to read
+ *
+ * This function provides access to xilfpga library to perform
+ * fpga configuration readback.
+ *
+ * Return:	Returns status, either success or error+reason
+ */
+int zynqmp_pm_fpga_read(const u32 reg_numframes, const phys_addr_t phys_address,
+			bool readback_type, u32 *value)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!value)
+		return -EINVAL;
+
+	ret = zynqmp_pm_invoke_fn(PM_FPGA_READ, reg_numframes,
+				  lower_32_bits(phys_address),
+				  upper_32_bits(phys_address), readback_type,
+				  ret_payload);
+	*value = ret_payload[1];
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_fpga_read);
+
 /**
  * zynqmp_pm_pinctrl_request - Request Pin from firmware
  * @pin: Pin number to request
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 1ec73d5352c3..7dc4981345dc 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -61,6 +61,10 @@
 #define PM_LOAD_PDI	0x701
 #define PDI_SRC_DDR	0xF
 
+/* FPGA readback type */
+#define PM_FPGA_READ_CONFIG_REG		0x0U
+#define PM_FPGA_READ_CONFIG_DATA	0x1U
+
 /*
  * Firmware FPGA Manager flags
  * XILINX_ZYNQMP_PM_FPGA_FULL:	FPGA full reconfiguration
@@ -116,6 +120,7 @@ enum pm_api_id {
 	PM_CLOCK_GETRATE = 42,
 	PM_CLOCK_SETPARENT = 43,
 	PM_CLOCK_GETPARENT = 44,
+	PM_FPGA_READ = 46,
 	PM_SECURE_AES = 47,
 	PM_FEATURE_CHECK = 63,
 };
@@ -468,6 +473,8 @@ int zynqmp_pm_feature(const u32 api_id);
 int zynqmp_pm_is_function_supported(const u32 api_id, const u32 id);
 int zynqmp_pm_set_feature_config(enum pm_feature_config_id id, u32 value);
 int zynqmp_pm_get_feature_config(enum pm_feature_config_id id, u32 *payload);
+int zynqmp_pm_fpga_read(const u32 reg_numframes, const phys_addr_t phys_address,
+			bool readback_type, u32 *value);
 #else
 static inline int zynqmp_pm_get_api_version(u32 *version)
 {
@@ -733,6 +740,13 @@ static inline int zynqmp_pm_get_feature_config(enum pm_feature_config_id id,
 {
 	return -ENODEV;
 }
+
+static int zynqmp_pm_fpga_read(const u32 reg_numframes,
+			       const phys_addr_t phys_address,
+			       bool readback_type, u32 *value);
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.25.1

