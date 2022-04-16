Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE93A5036CF
	for <lists+linux-fpga@lfdr.de>; Sat, 16 Apr 2022 15:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbiDPNkQ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 16 Apr 2022 09:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbiDPNkM (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 16 Apr 2022 09:40:12 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DF7D3737;
        Sat, 16 Apr 2022 06:37:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLhuJtGAJLYtxVcVzvp2N0A2Aq//GHBiyfXbBb9EUEX5yxgo5B81xZ7rNHKXxJ4DQSFPgKbf2AiPcFlKNdbnKFUoigdGvJ3AY+RFmvtZuIjOOQL8tS6tBR0pE1ZhsY58+xMLulv9ej61URsdk7RT6mbPRuMg7dSO0CvhCVbUY2tmkmCUXXBfJulZ0lDxIZv+eL9B3byTqFEF/J5X4kAlESinRfZX1psZ0SPaSD9okrH3huIaM6+53xC7KnJAVmh2EGm1kAwZElEOkI0I59Ru8EwSKRLXawz16ZUtxw9LZnJdcFnuE83Li5q1PEFEMyb/MkgT6Oh0yf73mZMMvbQHdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRsaVB95ZHuGq5Jua8kkJjsgbn8mhdHcOxo2GJV+QCk=;
 b=SpP7talo6migOePxOQ+Y0rIm0I9UJtWZhZPS0mPfQNPzXWrGYeuN9o9h7m9RPuptuo+t1fwJd4sn/jz/JafApFR1RJa6TJCkN8YVGwwRHZNJUzDBr2QhkEyNLlz3cANDMxFDBwXBNt/o1+Iyx8ob0Ncc6ukrL0GCagv/roStEC/eYbvk6Pxpy3J3P6dhbF8C5WMfl0kRO9lNn9AOsvk1jACybiB0zLx1mzPwUKB6zRH2MjesCyLGmqmOms8mHdYL6Po4iy+MB6VBPc1vd4ftu31CpvEROH/VgMlI26GkxMrSdx5OlT8xxycTuTVAnbf7fkwHnOk+HyPv9Zly4PcUOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRsaVB95ZHuGq5Jua8kkJjsgbn8mhdHcOxo2GJV+QCk=;
 b=tOLh5+tHSXj5ZnkIBMWg2d0uTP+nPT7mOFituBj4ElsdmGZgSlwOGOQzlk25xze9Rfms1FKxJK8lGc7FSqiunpOCFsXnafq07HHtpELuYZhE0KiGPVkevhkMP3PkEKeCcK5oAWUI3146Te33xVXN6JxkcB4qAhgo0UP3yLn3Cj0=
Received: from BN9PR03CA0391.namprd03.prod.outlook.com (2603:10b6:408:111::6)
 by DM6PR02MB5721.namprd02.prod.outlook.com (2603:10b6:5:152::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Sat, 16 Apr
 2022 13:37:38 +0000
Received: from BN1NAM02FT026.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::27) by BN9PR03CA0391.outlook.office365.com
 (2603:10b6:408:111::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18 via Frontend
 Transport; Sat, 16 Apr 2022 13:37:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT026.mail.protection.outlook.com (10.13.2.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Sat, 16 Apr 2022 13:37:37 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sat, 16 Apr 2022 06:37:34 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sat, 16 Apr 2022 06:37:34 -0700
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
        id 1nficI-00088I-Bn; Sat, 16 Apr 2022 06:37:34 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <michal.simek@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@xilinx.com>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v4 3/5] fpga: fpga-mgr: fix kernel-doc warnings
Date:   Sat, 16 Apr 2022 19:07:17 +0530
Message-ID: <20220416133719.3382895-4-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220416133719.3382895-1-nava.manne@xilinx.com>
References: <20220416133719.3382895-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 041ac202-fc6b-4577-0333-08da1fae4544
X-MS-TrafficTypeDiagnostic: DM6PR02MB5721:EE_
X-Microsoft-Antispam-PRVS: <DM6PR02MB5721C6B5849EA6490884ACE6C2F19@DM6PR02MB5721.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QyU86aDGDJgCuCh82DYLqesIZh4U9+CCvJzRSr7HwJ1e4fGnue6V4iev7pIXPfsg9aPwd0Wgc3zoFYIYeZeLqAX2yIH72DEXyLWjgc0xZfESAD0WwCqBDiSn9aDOOd4zLkFUQ7IX+XVUzpqz1r7YPRfJaQt2UfjUnXz2r4syxZp6SusGig8tFbX5NsI4EGQ7RFH69BAFDkc4DVuTlp6XW3sAVKZMvpH6PGb1rQeRAOtdQqmA8CuVcm7iytwZ4FEZ05O68HMsfoi5wXpbDhzBdBSudB87XWmSsgVl+G2dl4sHRt6kju9J9mjZocgIq78L8RnIP3anDJYG3jFGbdXPMvbpJ7QsujNU1c0yBjleXCszBg5cDHvqThRRE5Lkcc1FwmODdYCnG7iWgAmhtH3Xr3t3ny8fwlzF7UU7PDo6izYMVzzuL3SRH9jYbnGesULbO/qcn8uggKyRzA0WzqnnuxZEJVeL2VHZwxU1rBwi1mpcEW7TK4k40IpWXx1ku1mb6ZjknUOTviL/LojVzyuaelAlib2YVwZ/ZLZGNiTOaPVDrsUMUZ2LBkbO3v7nJLhUkcFBkq28JXFbrI2lXxGgS1lfOHOsKrzopIPAkmDjRq+emBnrvhegMWFk8F52vXh0/SaHdlsXT34vMQ80ubwszyxVQEt1uB9QIZsIrTdriwYlbyUXhsFfpDYDvmrKBDMXmO1zW4BA9UNUKVil5EfQ2/D3qU6fx3SjHai424cc3FS5Y/vfZbZF/PX1RdOeVtjj
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(82310400005)(316002)(110136005)(36860700001)(6636002)(36756003)(426003)(83380400001)(336012)(47076005)(356005)(7636003)(6666004)(9786002)(5660300002)(40460700003)(2906002)(8936002)(7696005)(70206006)(70586007)(8676002)(186003)(4326008)(508600001)(26005)(107886003)(1076003)(2616005)(102446001)(21314003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2022 13:37:37.1796
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 041ac202-fc6b-4577-0333-08da1fae4544
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT026.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5721
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

warnings: No description found for return value of 'xxx'

In-order to fix the above kernel-doc warnings added the
'Return' description for 'devm_fpga_mgr_register_full()'
and 'devm_fpga_mgr_register()' API's.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v2:
                -Replaced s/@return:/Return:/
Changes for v3:
               -Updated commit description.
Changes for v4:
               -Updated commit description.

 drivers/fpga/fpga-mgr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index a699cc8e2fa6..0f2b28538f17 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -730,6 +730,8 @@ static void devm_fpga_mgr_unregister(struct device *dev, void *res)
  * @parent:	fpga manager device from pdev
  * @info:	parameters for fpga manager
  *
+ * Return:  fpga manager pointer on success, negative error code otherwise.
+ *
  * This is the devres variant of fpga_mgr_register_full() for which the unregister
  * function will be called automatically when the managing device is detached.
  */
@@ -763,6 +765,8 @@ EXPORT_SYMBOL_GPL(devm_fpga_mgr_register_full);
  * @mops:	pointer to structure of fpga manager ops
  * @priv:	fpga manager private data
  *
+ * Return:  fpga manager pointer on success, negative error code otherwise.
+ *
  * This is the devres variant of fpga_mgr_register() for which the
  * unregister function will be called automatically when the managing
  * device is detached.
-- 
2.25.1

