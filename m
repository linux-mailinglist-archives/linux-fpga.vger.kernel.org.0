Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE968552E57
	for <lists+linux-fpga@lfdr.de>; Tue, 21 Jun 2022 11:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348920AbiFUJ3E (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 21 Jun 2022 05:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348907AbiFUJ24 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 21 Jun 2022 05:28:56 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4E4BE3;
        Tue, 21 Jun 2022 02:28:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SvKQzYeqQpXfbFYFxEPpyyCxGztpFJcmej6KfEobmnjMA7BC1dsO265mwiGzF+E5YBqGT0u22bweEBRh0lU9RTRHp1NUlqi67Yof2/NOOt3Dvfb/UrmU7CW+DqJxYDa4ZI/cTJhpHacWXc5C3n2hX61axLwOlpC0TACAbymURVRMh5mdmZ0rJRf9oWDajgPfUisYN1aSfkEfS4dxrzl4M/FTWZ4KfkLoOgGBJcnCAwbi2I24Agy6rz/lyuec047Opy9LN2dtic+FBny1HTz2RM5t4Kabbaegpz+GV6XqAhH+MeCd585K5QPU+OQ+XHdDRPu7mM6um7RqFMy+yCJHcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oG4ViLGS9a9Ayg33rEzZZFSG5BJ46TmXXTBdqwLAb/8=;
 b=RS/IUeUWlHdLzg76qfE99rTOI/6I/v6woc0CdGvgnZm1gJUmlHK1m9rdqR76imK3X57Jre3MRJAb82S0aK8iWALibZ/kVWQvcn5cvckviSGS+OHxHSbVVbj4OmB/he/QrmrDLM9PpVdCTdjMA06sVlF+iaXru6r7j12hifRLke/dc76MR9RkFDkG92cq9xukRFtnLeLaMbGNNUdhVjvAXeMu8TSH1IN1D9cWDf3pzKICd34oxVqDYEBRz3oOY0nPZjyNF+5eBjVVVQobQb+zoqm7feRqMy6yRdwVm/FrsxdHLivZpoenEvjsd2Xx1HOXSUWBuqpML7OaThr9zVJD6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=intel.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oG4ViLGS9a9Ayg33rEzZZFSG5BJ46TmXXTBdqwLAb/8=;
 b=lZC+6VeO/sPSw+mvpjNP+1qM3N/ULTKs7uWJGwbGO4OmYjEI2otFnYO5RR+zDlLPDpVFEHbo87buy+olGZ5NfE9lE1qbxAz1ctlnJQaTN9wt4EGQoeesIgnhuc/0nit70bb3GhdVWATbNC1IxDfQOwyBhBqH3bYxN5+39dIWe+4=
Received: from SN6PR05CA0013.namprd05.prod.outlook.com (2603:10b6:805:de::26)
 by SA0PR02MB7466.namprd02.prod.outlook.com (2603:10b6:806:ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.17; Tue, 21 Jun
 2022 09:28:51 +0000
Received: from SN1NAM02FT0053.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:de:cafe::ba) by SN6PR05CA0013.outlook.office365.com
 (2603:10b6:805:de::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.10 via Frontend
 Transport; Tue, 21 Jun 2022 09:28:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0053.mail.protection.outlook.com (10.97.4.115) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Tue, 21 Jun 2022 09:28:51 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 21 Jun 2022 02:28:47 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 21 Jun 2022 02:28:47 -0700
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
        id 1o3aBi-000DOt-IK; Tue, 21 Jun 2022 02:28:46 -0700
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
Subject: [PATCH v2 1/3] fpga: manager: change status api prototype, don't use older
Date:   Tue, 21 Jun 2022 14:58:31 +0530
Message-ID: <20220621092833.1057408-2-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220621092833.1057408-1-nava.manne@xilinx.com>
References: <20220621092833.1057408-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0ae5fbd-c8eb-4498-f099-08da5368744b
X-MS-TrafficTypeDiagnostic: SA0PR02MB7466:EE_
X-Microsoft-Antispam-PRVS: <SA0PR02MB746620E18446D1C051771FE2C2B39@SA0PR02MB7466.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q/yT3HpCKtFDi9RcoiXRsGSs2uKsyHJGYfC8fytLgdF5NG8d5uz5hQwVV/RG0I0htfd/SfOY0mCQTWPaJffZb06+1mvd5fAkSeGNNkdTMovuCIHAQA0YUA2+4kZg55h1Y3LOBXl3MW9GORdTLDxDRLRr76lRZNrbI58w/st5AwkjxO+4sdN91/uVc5KRXIwNc6Z76LZOGu0g+8g/CNuhHGCYEHofMcpckwm74/+wZlonwIcMKeGtgkYWoaxwCUiDYVx5jsRyJ9x3aJH+cZ6TP2jHVjFsKMwYkSLS4QHjsuK8JAkWGVFulhYW6YYnMYbNhHcrXGJzcaMsxFiWdyzOnC58qOsMv7wbQ7MqlM7Xv8587stlfJwsaBkJMte6Iu53zqS1KxpK/mna3qGgjRJsWEVH+VE6Us1/abbSrVL6Ey/9qZjailG0XsCkwr1lDzsM2EwKhpDjDokpWpbfNT0eQx6AHuioP4MLUcEYhadmfc7X+AHQTr9aoKF/9hJVVWigbew/5JCixOgiCcQGg+K3cyuE8pYeadsnz4UXTED17xYoJxSF2PImEsNcTq0yWzcplZzAXTWCCtCbrIlocca93ShG7FvZiGHo8TyhF9YckxqB+j4TqQO81yvHdX5HY1A4vYm3CMZVzKuGBGK7rpWaeuBJLkxXXE87Y4sXpyqZ1KjY5hGxfI/2vipzorrWilRZA/hrI/dkERGFTuN7fpWEQjp+aS36pL+J6MfETJHGmwgHX64gK9pn0h9goltW4DGkQA1+Dxrkz55JDCuLg2qONyWhm6SXx/AqTfvsEWsmk0v6lqY47JY+pagHlVrG0CD6
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(136003)(39860400002)(46966006)(36840700001)(40470700004)(8936002)(36756003)(9786002)(40480700001)(5660300002)(40460700003)(70586007)(82310400005)(2906002)(316002)(6636002)(70206006)(110136005)(186003)(83380400001)(426003)(2616005)(336012)(8676002)(921005)(7696005)(41300700001)(1076003)(478600001)(6666004)(47076005)(36860700001)(82740400003)(26005)(356005)(7636003)(102446001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 09:28:51.8403
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ae5fbd-c8eb-4498-f099-08da5368744b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0053.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7466
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Different vendors have different error sets defined by Hardware.
If we always define the new bits when we cannot find an exact 1:1
mapping in the core the 64 bits would soon be used out. Also, it's
hard to understand the mixture of different error sets.

To address these issues updated the status interface to handle the
vendor-specific messages in a generic way. With the updated status
interface the vendor-specific driver files can independently handle
the error messages.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v2:
              - New patch.

 drivers/fpga/dfl-fme-mgr.c    | 20 ++++++++++----------
 drivers/fpga/fpga-mgr.c       | 24 +++++-------------------
 include/linux/fpga/fpga-mgr.h |  2 +-
 3 files changed, 16 insertions(+), 30 deletions(-)

diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
index af0785783b52..5a8e6a41c85c 100644
--- a/drivers/fpga/dfl-fme-mgr.c
+++ b/drivers/fpga/dfl-fme-mgr.c
@@ -72,22 +72,22 @@ struct fme_mgr_priv {
 	u64 pr_error;
 };
 
-static u64 pr_error_to_mgr_status(u64 err)
+static ssize_t pr_error_to_mgr_status(u64 err, char *buf)
 {
-	u64 status = 0;
+	ssize_t len = 0;
 
 	if (err & FME_PR_ERR_OPERATION_ERR)
-		status |= FPGA_MGR_STATUS_OPERATION_ERR;
+		len += sprintf(buf + len, "reconfig operation error\n");
 	if (err & FME_PR_ERR_CRC_ERR)
-		status |= FPGA_MGR_STATUS_CRC_ERR;
+		len += sprintf(buf + len, "reconfig CRC error\n");
 	if (err & FME_PR_ERR_INCOMPATIBLE_BS)
-		status |= FPGA_MGR_STATUS_INCOMPATIBLE_IMAGE_ERR;
+		len += sprintf(buf + len, "reconfig incompatible image\n");
 	if (err & FME_PR_ERR_PROTOCOL_ERR)
-		status |= FPGA_MGR_STATUS_IP_PROTOCOL_ERR;
+		len += sprintf(buf + len, "reconfig IP protocol error\n");
 	if (err & FME_PR_ERR_FIFO_OVERFLOW)
-		status |= FPGA_MGR_STATUS_FIFO_OVERFLOW_ERR;
+		len += sprintf(buf + len, "reconfig fifo overflow error\n");
 
-	return status;
+	return len;
 }
 
 static u64 fme_mgr_pr_error_handle(void __iomem *fme_pr)
@@ -252,11 +252,11 @@ static int fme_mgr_write_complete(struct fpga_manager *mgr,
 	return 0;
 }
 
-static u64 fme_mgr_status(struct fpga_manager *mgr)
+static ssize_t fme_mgr_status(struct fpga_manager *mgr, char *buf)
 {
 	struct fme_mgr_priv *priv = mgr->priv;
 
-	return pr_error_to_mgr_status(priv->pr_error);
+	return pr_error_to_mgr_status(priv->pr_error, buf);
 }
 
 static const struct fpga_manager_ops fme_mgr_ops = {
diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 08dc85fcd511..ae8de13a482e 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -38,10 +38,11 @@ static inline enum fpga_mgr_states fpga_mgr_state(struct fpga_manager *mgr)
 	return FPGA_MGR_STATE_UNKNOWN;
 }
 
-static inline u64 fpga_mgr_status(struct fpga_manager *mgr)
+static inline ssize_t fpga_mgr_status(struct fpga_manager *mgr, char *buf)
 {
 	if (mgr->mops->status)
-		return mgr->mops->status(mgr);
+		return mgr->mops->status(mgr, buf);
+
 	return 0;
 }
 
@@ -460,23 +461,8 @@ static ssize_t status_show(struct device *dev,
 			   struct device_attribute *attr, char *buf)
 {
 	struct fpga_manager *mgr = to_fpga_manager(dev);
-	u64 status;
-	int len = 0;
-
-	status = fpga_mgr_status(mgr);
-
-	if (status & FPGA_MGR_STATUS_OPERATION_ERR)
-		len += sprintf(buf + len, "reconfig operation error\n");
-	if (status & FPGA_MGR_STATUS_CRC_ERR)
-		len += sprintf(buf + len, "reconfig CRC error\n");
-	if (status & FPGA_MGR_STATUS_INCOMPATIBLE_IMAGE_ERR)
-		len += sprintf(buf + len, "reconfig incompatible image\n");
-	if (status & FPGA_MGR_STATUS_IP_PROTOCOL_ERR)
-		len += sprintf(buf + len, "reconfig IP protocol error\n");
-	if (status & FPGA_MGR_STATUS_FIFO_OVERFLOW_ERR)
-		len += sprintf(buf + len, "reconfig fifo overflow error\n");
-
-	return len;
+
+	return fpga_mgr_status(mgr, buf);
 }
 
 static DEVICE_ATTR_RO(name);
diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 0f9468771bb9..42c24426fb7f 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -154,7 +154,7 @@ struct fpga_manager_info {
 struct fpga_manager_ops {
 	size_t initial_header_size;
 	enum fpga_mgr_states (*state)(struct fpga_manager *mgr);
-	u64 (*status)(struct fpga_manager *mgr);
+	ssize_t (*status)(struct fpga_manager *mgr, char *buf);
 	int (*write_init)(struct fpga_manager *mgr,
 			  struct fpga_image_info *info,
 			  const char *buf, size_t count);
-- 
2.25.1

