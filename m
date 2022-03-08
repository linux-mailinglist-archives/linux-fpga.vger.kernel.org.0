Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55024D13AF
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Mar 2022 10:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345424AbiCHJqj (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 8 Mar 2022 04:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345421AbiCHJqj (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 8 Mar 2022 04:46:39 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2042.outbound.protection.outlook.com [40.107.95.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A56A4160C;
        Tue,  8 Mar 2022 01:45:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WgP7/9JHYjcJ9DhfbH8MSI4dbz3bU0QHNraLDFCtW5ZT98qj98ZBrwqkVr5EUyrBxfeGT/kEZE1xfOPubDDl7kBGZ9i9eAu/9JVoiLb3+YjPcN5lI1iKV9Wnj8CwGGK96olZtNTK3NKqV1L2NgHccPBhK7plSE5VeEdqugE1MLVkq7KfEYA7prWguxdSrbkAF6dJ9d8kw2e3sO828wlWGLCH9evgM+oRmefr7SIf+SsnJy0/yDkexfJktNd4ie6jQWRhecx/lmP+pDf2HNwXJFqLGAoMzzhcMAmEA12oAtADOUCMq8WqxdKSdDlsEdv1Zg7XTldQh9eOtcMzIpmJkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Apq8ioZSsKiSRznHdI0ozIaLJ5yPubyX+g4ovTkOquI=;
 b=RPTzNWw2OZhpPLBMjt7ioql9LOqEvWUQANwUuF++G7cJwJCNvWqfTidHnhZY0JO8IO6xHYmha87RoxNoipM+RDfXei8gxzaHAXNNlkNUvIsPNbkS0/roLQzAEfpD9svdM1AWgIofzvP6AbQfu+VOkpEZObLAyEvrwAwebGDZfoOZGASzxOL80fdPfcajGGErY3hIKpzAkmH5Si8wwSFvtq2mh/CFW4j0bakHGDoZEbgtvHqAV0Fehbn7edF0SfFuq0PV7aLsE9O5ifkeji8n3u6joFub0L9tzOgTIPV/jqt/6ialHgFKAhz3xLVgQpGyUmJH9S2vwGbimicBhuAaig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Apq8ioZSsKiSRznHdI0ozIaLJ5yPubyX+g4ovTkOquI=;
 b=bMJTfD6Vx+o6WPhCNCaCaMO4oVvH8zh6WsG14/+dsLWPomQJv/0McP1rmaPvKnpaO50bNkLJxPN4qfNtiljxDFbM3RdC5d12eVcXwQmjMrXSqZS+1s7FrjWMal5d/630/N7ssVuVi82KQVajUgAbZOfOm9km4JzoL9rK6ridqnI=
Received: from DM3PR12CA0078.namprd12.prod.outlook.com (2603:10b6:0:57::22) by
 BYAPR02MB5461.namprd02.prod.outlook.com (2603:10b6:a03:a3::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.16; Tue, 8 Mar 2022 09:45:38 +0000
Received: from DM3NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2603:10b6:0:57:cafe::43) by DM3PR12CA0078.outlook.office365.com
 (2603:10b6:0:57::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Tue, 8 Mar 2022 09:45:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT057.mail.protection.outlook.com (10.13.5.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Tue, 8 Mar 2022 09:45:37 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 8 Mar 2022 01:45:36 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 8 Mar 2022 01:45:36 -0800
Envelope-to: mdf@kernel.org,
 hao.wu@intel.com,
 yilun.xu@intel.com,
 trix@redhat.com,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [10.140.6.60] (port=33304 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1nRWPQ-000G0A-9x; Tue, 08 Mar 2022 01:45:36 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <michal.simek@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH 0/6]fpga: fix for coding style and kernel-doc issues
Date:   Tue, 8 Mar 2022 15:15:13 +0530
Message-ID: <20220308094519.1816649-1-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a6c700b-8380-441b-d6c6-08da00e86649
X-MS-TrafficTypeDiagnostic: BYAPR02MB5461:EE_
X-Microsoft-Antispam-PRVS: <BYAPR02MB5461D09C2E3F73FEC481377AC2099@BYAPR02MB5461.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fLFPLwAUuzVokwrDcXJrCTmebaxskQR8cwiGROG9EqsNuUiJcZZ2LX7+lgwSNvX3WnDpMXb1OWOKBp0VO+D2nNOqMssu6SqB2RxcNQgozRX9eaa1/4r1qgJ8m7pGzvp04kenemjdteCHIX4it2q7xvEf2DMnjMaDrSnk3I0nxgKhUhCCIa/Qr0kdygzCjc5tkTY2FbQ4YAR2PrhQulxHxQYjrkJHFfY5nn+wJEjmXVKOa1FO4WNo0XmUu8MSRYis04LUPQCdxIF2gkFDmkv0ysz4dehaaJ955NUoO96T+l3/BTBOLtkakc8a4zdrrmyeLrXiXxnAyau+H7p8XfeInP1obXN/1zC86+bWERjsL1RwHSKXOWbq4SKBP+yvlI1L+3L2CASXnUkbBZYcXYrSfijlFoKWiVZk8+orbpadJoI7jIYmwtI4HTchx54cpqjXGwNVXTKO61PB3s9gLKCmzyOa+CMkrSq5voRXaZJ6bVhFpz7syPGfnaJd7X0nX2AidikRLRx0+RAAzY6TSuDUBq6pggmZg4/9NOC2ObwPNqQ2wbbqRb/DdbAyZXts2XRoOc+liuSeLwQXjKGVXcQ0cks2kDiqwYMYvxgJJ3wgDOMlh3RVs/Gs4k6mbWvFw8W2Va9B3NfrzOiEzI2QiY/LCGFQEdqdMSI1VUG0/tb1BYm0ttbkcTSS79jlkqI9iGvrvqFDW+WYctz7wuUCLOc1FQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(6666004)(9786002)(8936002)(82310400004)(5660300002)(2906002)(7636003)(356005)(83380400001)(36860700001)(7696005)(8676002)(70206006)(70586007)(4326008)(4744005)(36756003)(316002)(47076005)(508600001)(26005)(110136005)(186003)(1076003)(2616005)(336012)(426003)(107886003)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 09:45:37.4093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a6c700b-8380-441b-d6c6-08da00e86649
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT057.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5461
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

Nava kishore Manne (6):
  fpga: zynq: Fix incorrect variable type
  fpga: zynqmp: Initialized variables before using it
  fpga: fpga-mgr: fix for coding style issues
  fpga: fpga-mgr: Add missing kernel-doc description
  fpga: Use tab instead of spaces for indentation
  fpga: fpga-region: Add missing kernel-doc description

 drivers/fpga/Makefile         |  6 +++---
 drivers/fpga/fpga-mgr.c       |  8 ++++++--
 drivers/fpga/of-fpga-region.c | 18 ++++++++++--------
 drivers/fpga/zynq-fpga.c      |  2 +-
 drivers/fpga/zynqmp-fpga.c    |  2 +-
 5 files changed, 21 insertions(+), 15 deletions(-)

-- 
2.25.1

