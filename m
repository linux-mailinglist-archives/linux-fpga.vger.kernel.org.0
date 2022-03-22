Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAF64E3A80
	for <lists+linux-fpga@lfdr.de>; Tue, 22 Mar 2022 09:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiCVIYE (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 22 Mar 2022 04:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbiCVIYB (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 22 Mar 2022 04:24:01 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6BE5EDF8;
        Tue, 22 Mar 2022 01:22:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWuNL4sOvgDLJJSB3ex+Wpu4+HLpHYhbz7f7A+MA9m+EvMdOxh18IZq6rUUpQM8mLyEZppL+ztUpejmiFITEBqxCKFUD+/0QGXr5mUthAfibM26wzHGor/mSKr0uo75v0ZcWR2ns0sd8x6U3MmAKQ5KJF9tU9nr0B3e/v3jr6TbZhy6yA1wGZdBhCF2oQsqc4QZpS313g7R/R2TvFvtIsV2x3VaVkSHEt5l3Fs0l/n4ssago63WsukbN53TwpuU4o/oVBr9ycL6Grakx3k/gni48zD25d4vaqHAG85TRZocQgsiCwFy93S5qNwmUfFtrkIuFxoCgwdLLq6n9ZCrQpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DsLDte5w6tEArJ2YNq46jSa9QD5hsgCG2UmdQcN+tz8=;
 b=Gl2Pcs4T7o3+6pVdlrlHjXAy9MHbbc1CWrNOcxH/Ocx37I0fivq2Y7+jBmbr1Bi3pMV9b6/b7U5XFQkJRsHQ/IBOgIJ5clkQic3VYfoxfx/wN6d3ljLByxdqUzEqUEr25zoSDsHLVFyxKLNs7JYSMzftRbL0xruvnImZovMUwZie/+ZUfrz4LcKiEDakHnkISXXL9GJmWwvZjaBn84WZXWSgq97rRRsYMVKcnEbxpyrKpB64ycBM1w9Mbkq8S7imwTvOXnT3smDvFIl580xvdczjzxtL+ceVkLOl5/DqIOHgKdRyKmT8SHvp5RUqigdGbOBsXkPR6pdpnkBe5JUg7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsLDte5w6tEArJ2YNq46jSa9QD5hsgCG2UmdQcN+tz8=;
 b=qYOJh0MCNwx99RUwlyGYOjggOenKTnbAjmaSTu/QkIn2MDq0loAMRdY/vLvwNmo/lRqmlsDR+Lu3G8/CnfenKoaXCfoVFp3gbflWvf1KObGUBwvFOlhAypa+yjESAtykL+1GxnTQWrVdBah0Lx8JLKMDD45yiecUnSHmcdhQxLA=
Received: from SA9PR13CA0087.namprd13.prod.outlook.com (2603:10b6:806:23::32)
 by BN8PR02MB5938.namprd02.prod.outlook.com (2603:10b6:408:ad::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 22 Mar
 2022 08:22:31 +0000
Received: from SN1NAM02FT0029.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:23:cafe::3f) by SA9PR13CA0087.outlook.office365.com
 (2603:10b6:806:23::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.8 via Frontend
 Transport; Tue, 22 Mar 2022 08:22:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0029.mail.protection.outlook.com (10.97.4.175) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Tue, 22 Mar 2022 08:22:31 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 22 Mar 2022 01:22:24 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 22 Mar 2022 01:22:24 -0700
Envelope-to: git@xilinx.com,
 mdf@kernel.org,
 hao.wu@intel.com,
 yilun.xu@intel.com,
 trix@redhat.com,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [10.140.6.60] (port=48200 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1nWZmM-000Ei2-VZ; Tue, 22 Mar 2022 01:22:11 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <michal.simek@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@xilinx.com>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v2 0/5] fpga: fix for coding style and kernel-doc issues
Date:   Tue, 22 Mar 2022 13:51:57 +0530
Message-ID: <20220322082202.2007321-1-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f56f88de-c876-4eaa-ea96-08da0bdd1c21
X-MS-TrafficTypeDiagnostic: BN8PR02MB5938:EE_
X-Microsoft-Antispam-PRVS: <BN8PR02MB59380403FC660DF3287F9CE1C2179@BN8PR02MB5938.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +pJBm4xsbIY+9cgT0xRJCKz8468PZ0CIQEAVnC7dcbTFhgB/aNitbIbhfk2oJDRAJenx6XzSubnprWcXsFyywEQgYtWIhPLY80xyoExQUV2sl1BVZeZln3m9sNvtb2YLXKeJZ0Mj0c8dhZqMnJk08WqfigfTFrrP6L7LIwjCqWYBZn2SwpZpwZmw4G/xYbuNo9UGBQDHPrnd+1yqsHSkwF6Cij22jqVcm7w/X++sc550UVdl9BIkidskOL/y38bSzxVSS0qB8WOm0atATi/1sFq+XARxfPBMVwOFKeoGeGDeFt6fd+Lo9SnjNrDqIUGpbQL5gTcjsGfpCKB4HZzhH4x9dOOGED8YalAPTPkjBEKCFaa4kOhUKLPXmOe1uEAmqeKrHPkWe3Z6JjMqDMlT1cwUWhd7AfB0j5ee9vScdoDBI0ZNHzR0oBtvx59psKET0jm3KpbvZz7WBHSEGWSSUNg3xVbN0FZ8jCNlkglenbkD79dpCd2DUbn/I7ll2xluZQ/8hioH0As3N3/HW378sxoCSOzlG6OplAvN0jALCWpi+yVLLFUeGxIwm/UMaj4ferCO+zeT0ELuGsFGsE4XH53gvpqzRiLar1ZX+AbrsSqqjMFPHKfN+milauQF+x1Ah3W98W1NVMX1Y7rIebRFjzdTk/KfMASU7BUihZg3RVqLIQsC8tKpwv3F6PSmbVhqYKyWpT+qSNG1CKuSeQPRAXcjXcah8ZgM4TWxN7ekidE=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(4744005)(47076005)(70586007)(336012)(4326008)(36860700001)(70206006)(316002)(83380400001)(36756003)(186003)(2906002)(6636002)(426003)(8676002)(110136005)(2616005)(26005)(107886003)(1076003)(7696005)(40460700003)(6666004)(508600001)(8936002)(82310400004)(7636003)(356005)(9786002)(5660300002)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 08:22:31.2446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f56f88de-c876-4eaa-ea96-08da0bdd1c21
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0029.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR02MB5938
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch series fixes the coding style and kernel-doc issues
exists in the fpga framework, zynq and ZynqMP drivers.

Nava kishore Manne (5):
  fpga: zynq: Fix incorrect variable type
  fpga: fpga-mgr: fix for coding style issues
  fpga: fpga-mgr: Add missing kernel-doc description
  fpga: Use tab instead of spaces for indentation
  fpga: fpga-region: Add missing kernel-doc description

 drivers/fpga/Makefile         |  6 +++---
 drivers/fpga/fpga-mgr.c       |  8 ++++++--
 drivers/fpga/of-fpga-region.c | 16 +++++++++-------
 drivers/fpga/zynq-fpga.c      |  2 +-
 4 files changed, 19 insertions(+), 13 deletions(-)

-- 
2.25.1

