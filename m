Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB3A5036C8
	for <lists+linux-fpga@lfdr.de>; Sat, 16 Apr 2022 15:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbiDPNkH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 16 Apr 2022 09:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiDPNkF (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 16 Apr 2022 09:40:05 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7A7D3735;
        Sat, 16 Apr 2022 06:37:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXwNafpwgr3f1XLhHSsrqIE8ISFhponspqqPm6YgL6AuKzWhlqAxYuvc+u5TUo2hnvsqZBu6B01riV89ZZmEuCC5szT1aUHOH6tndt7WUW4tk6GpunpiOcadl2siMN9b/KqScHgvku7tuDmZpok1c4e4/8UHXQLplGyRtHrlUncBuraNWSFSYkZ7pkimqJjtnZ62siB4ZiBu2GfNVN1890JcCT6+NtWEqbc8cR7s7EVPDJAaG+oJsnVKQGYYjsqjPZTNNlAZ7jxWvVBo6LxPb006jRhQMk6mYYYX9g/0ur5KWVzoD50xsyc19uNTEqGDXMcDHjmHfS4P64H1aRU2OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbapbAQPuliRD55azOWxfe/ylN5XHHBIl884snZizfE=;
 b=Opo7viTu7/NvrOYHZfKE1TDw2V7oCpI0ByX/OkR6xfjLxZHn2y+5PxIeHtXvacCuUJmq36y7L1vr5WKKIw6OrRZkZIdiYltF05QpWg/Dvm7xViLBbo4+AWz/fnYq11jL0XkECc0efR/uHgg+Dq7RoAB6IBOFPp4PLf9Di89CeYpjzqPyo99u+2OROgL/XqjtwM9dpmspWB4Iu1upukjF3k0UoHYBMm4WweFsA+nkZP0Jm+nQbHzuaFLGjcngcQh9Ivxo7jgk0gnBmQwn5K1m2YlYOFTgCCjZrD3jChx3FAmfF+LkWC2cPvEYji1VCHHYdkpQs3ZFO+jkuo0qtXl1QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbapbAQPuliRD55azOWxfe/ylN5XHHBIl884snZizfE=;
 b=WVasc076yHEXz4UwJpJ3lCIFrUb872zD4NPUQkaf3yHwZUXyj7CSNROdhQYtZREbIaXZ0pHwVc9MgRVyCqLmUFzuVKpvDIif/V+8hwmFN5yrXrP8vFnQ+b6F1yV5+uyiSkPcB9MYEMlo35ZUe7Vl/+pWoZnqmaUlBbdIUN8CxNs=
Received: from BN8PR15CA0057.namprd15.prod.outlook.com (2603:10b6:408:80::34)
 by DM6PR02MB5370.namprd02.prod.outlook.com (2603:10b6:5:51::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Sat, 16 Apr
 2022 13:37:29 +0000
Received: from BN1NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::be) by BN8PR15CA0057.outlook.office365.com
 (2603:10b6:408:80::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20 via Frontend
 Transport; Sat, 16 Apr 2022 13:37:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT064.mail.protection.outlook.com (10.13.2.170) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Sat, 16 Apr 2022 13:37:29 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sat, 16 Apr 2022 06:37:25 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sat, 16 Apr 2022 06:37:25 -0700
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
        id 1nfic9-00088I-C7; Sat, 16 Apr 2022 06:37:25 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <michal.simek@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@xilinx.com>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v4 0/5]fpga: fix for coding style and kernel-doc issues
Date:   Sat, 16 Apr 2022 19:07:14 +0530
Message-ID: <20220416133719.3382895-1-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0a5797d-9d1e-4258-66c6-08da1fae4068
X-MS-TrafficTypeDiagnostic: DM6PR02MB5370:EE_
X-Microsoft-Antispam-PRVS: <DM6PR02MB5370EEA66423A9766B5C9001C2F19@DM6PR02MB5370.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZJbO8GraJgkwiG7MXHQk1Z94F8nzn/ZdhOetsboVLTVjK+hgNYXkvUimNxGyIseIAgTQjUpNJ36qU8ddemVOxAL1LuiODvqhIUIyPiXc2GC/WqtchZVJ3HOtIlKhKyWxn42QbX7D4A/tSRCFWAQir6uEYNFgbCE2Zj6e1eblxxQpdAjukALkeK8Rymaim64y4z2JsJMfoAUuW13uiJamOzc8HormGRq7Jp5KZ7fW0cmNU0Sb3dErA9rCarVXskpYHeIptqfdvr1B6G63GuF0d+0ZQ26n5b57G6AAj2ioTYgmvgcyGnpnmqvVAvTSIU1OxcXFewQTNuEYXZLPIC82KrJ7zr6y7TPpiPZhSc5fPohmKfXu+n2LPKMEeT3YUpBp05ObnYUkJ8U4VCZzapYu0oTNji55t6Xp0PlwLy+pd66LBdE5RNqQWAe06xtF4dxs6LVkUmWFmhU43mC5JXB57rnIGuMvj8vsCNqoascCVJorv2gEQJPyOkgi/MisEY8yEqUxd9yozNH8YNhSq0qhAvwMdAk+GodiMplXIcNY0YwJPr70s1CDC+X4ZJT3LiEo+xG6sonehtQtXtvpnZqTzd++vqEoYU2Ee0giyIjkvIZX26QDCqP/uPiMQgHjBD0JNDyJp757bulfqhE6+f1BOC3RRy42T3q9jNYBLLmgzci9KU+btJkQ7S/kUmNMFvvVkiIyBYQqmA6p0BS4VyLJ8wpAHSDow4rxFhQ7144yBaI=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(110136005)(6636002)(6666004)(82310400005)(4744005)(7696005)(2906002)(5660300002)(8676002)(70586007)(70206006)(316002)(4326008)(8936002)(9786002)(336012)(36860700001)(508600001)(40460700003)(36756003)(356005)(7636003)(107886003)(2616005)(1076003)(186003)(47076005)(26005)(426003)(83380400001)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2022 13:37:29.0451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a5797d-9d1e-4258-66c6-08da1fae4068
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT064.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5370
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
  fpga: fix for coding style issues
  fpga: fpga-mgr: fix kernel-doc warnings
  fpga: Use tab instead of space indentation
  fpga: fpga-region: fix kernel-doc formatting issues

 drivers/fpga/Makefile         |  6 +++---
 drivers/fpga/fpga-mgr.c       |  8 ++++++--
 drivers/fpga/fpga-region.c    |  7 ++++---
 drivers/fpga/of-fpga-region.c | 16 +++++++++-------
 drivers/fpga/zynq-fpga.c      |  8 ++++----
 5 files changed, 26 insertions(+), 19 deletions(-)

-- 
2.25.1

