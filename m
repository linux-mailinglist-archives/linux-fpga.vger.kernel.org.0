Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACEA509616
	for <lists+linux-fpga@lfdr.de>; Thu, 21 Apr 2022 06:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384112AbiDUEuq (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 21 Apr 2022 00:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiDUEuo (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 21 Apr 2022 00:50:44 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D69B1C7;
        Wed, 20 Apr 2022 21:47:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UIhrnkjPybLUJxstuMNs0kOZ25RdOUdqCFJjS1m9/VxfxHy5/Z1rDMMgv4/azM7Gk0E7dI/9ODpc9tPubGLJvdI8qHIYHLeef+58YBq98lux9EsslkG3bqbCogU3rvsCpmZswk6DPdSI3KZaX2Do6HVRa0J081oO4R3pVnXqRiTYlj7sZJPPqMjR9Nefgs7bHdCh/EELlJUsRFMUFmxzys/Yw0T0BIsy1p9RTVRRxCicVRGU+i7HdzvIA3FUYsoBJ5kCO9OofvmXM1FbBfYSTdt507/FzbhaUKQv2FrFSQTroeJChdMq2fsHJZkJo0eFtKxg2SodZhFwDocpd9qzDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2i+SsGdgsccQ/uN8ZWDouvxeI3awoFGAk3jO+2GXae4=;
 b=TzaPTCT7KkOIRSSRkyp2P9MT5Tdn3NkQZncywPwg6r+EkI6waHC4/uWw0qRAeHkrSZdERBCY0FdCNuYPBqUxPLRJJRrAcxhpaRcj8wZZYE/NWPo9/G15FNJgObnnnf0RW5jnvW0mXw4uAiU5y733Y22K228soUtlSLgwREBjy3bJ4vY0+NBCV/4BCsC4/xhOacfRzr0u+buhK1aE3RdBY9K3CkHyRlzfl9prshmUYN/qwmI3Xewrpng96DoVf0YwTraEq689B0vuudhRYxBWY9E7MG0ltAkpE6Uuj/Wrcbqn2LR/gJu56HjoTVnpUU3KngLQtaFI/CgCeV7fU7f3kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2i+SsGdgsccQ/uN8ZWDouvxeI3awoFGAk3jO+2GXae4=;
 b=JLorzw2IrZZ7qHnnSdj8jb1F9eYZ3eiZ+82zT4ZYUN+P1QbcKe/VbbYqdPh8YJG7SfnXrUiBj5xjeobDzB0sSwAJE/yCztwE/7qTQCkw4ZhoZQo06MPqj2PdN1Xf4lTH392o1dIMMtqC2OxDP3r45HfAvrfhB4SV86GJ4FHQMpQ=
Received: from BN9PR03CA0442.namprd03.prod.outlook.com (2603:10b6:408:113::27)
 by CH2PR02MB6773.namprd02.prod.outlook.com (2603:10b6:610:7a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 04:47:53 +0000
Received: from BN1NAM02FT021.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::a) by BN9PR03CA0442.outlook.office365.com
 (2603:10b6:408:113::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Thu, 21 Apr 2022 04:47:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT021.mail.protection.outlook.com (10.13.2.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Thu, 21 Apr 2022 04:47:53 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 20 Apr 2022 21:47:50 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 20 Apr 2022 21:47:50 -0700
Envelope-to: git@xilinx.com,
 mdf@kernel.org,
 hao.wu@intel.com,
 yilun.xu@intel.com,
 trix@redhat.com,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [10.140.6.60] (port=35750 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1nhOjO-0002Sb-6t; Wed, 20 Apr 2022 21:47:50 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <michal.simek@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@xilinx.com>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v5 0/5]fpga: fix for coding style and kernel-doc issues
Date:   Thu, 21 Apr 2022 10:17:39 +0530
Message-ID: <20220421044744.3777983-1-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5813104b-d6bc-44cf-a3b3-08da2352187d
X-MS-TrafficTypeDiagnostic: CH2PR02MB6773:EE_
X-Microsoft-Antispam-PRVS: <CH2PR02MB6773758A17E10D01A37FECC1C2F49@CH2PR02MB6773.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iaf2Odqi4sj3zxr38QHr6CsxMYSLyfK97AxJesu7njRkZdr/B0Ul809Dq0pTySFQAsfCsTQq495qjMYsl9ZQRU9fmBQjDeAsRpgqL0p59DnNBMCGzNlqtIxGbQ68Ar3pq+Id60imG2gspO3GF4NScgq0eiasyadp8LesyVD35W9v0a02wcZSFQMo0Hv0dp4v3BGQye725k262t84HNWa7RmuJMovru/3D9V2n4/IM8ar++aHRTbb6wSiQtEl3vx3F2e09Oslon6EflIsKmmVpSCEeWVc9ChYeHRZFc8NbWyzLxfus6kOkGqeX6iXtSpjZseqt4Y2GFQDnhaXDEF6NA0JEykUvnjKROe6ZI6qOHwh0Ae9vHR73V1tworsXM5+A3Ja214CqYDOm4pl8VLLWfkt/wrWYrJzinqMyFoNJgOm/DX3XpK+mCo3TariE9NkIY7HBn3CTdx/uJichCxqjKuJ4/lZ14M23dheT50EP0ZOPCPZQZ6r1nrgNumjdA9YgkoN9nVYitjppW6Er8CTZoHwdRDJWcMFscU+dXDR+A0tBvNaWsiGOqDx6fHxbYNioMWTEZGEmTDkV8x4DmTRMYSsnctQ9jP+Zdr5TBrOTPc4Rr5CFDFAj/qrWcEVnvNzSSEPXhoDL4npILbjA7eHq5lknquhkProP4z2JwUYTI3kbquvs3SKcV6ekR4pQj6uYj5vuZgc4GOLX/0C/CbUk8bv3f9rvDO3H8u2kECJAx8=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(110136005)(82310400005)(6636002)(336012)(36860700001)(7636003)(426003)(356005)(316002)(36756003)(40460700003)(70206006)(83380400001)(70586007)(2906002)(508600001)(186003)(26005)(5660300002)(9786002)(47076005)(7696005)(6666004)(1076003)(4744005)(4326008)(8676002)(107886003)(8936002)(2616005)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 04:47:53.0117
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5813104b-d6bc-44cf-a3b3-08da2352187d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT021.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6773
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

 drivers/fpga/Makefile            |  6 +++---
 drivers/fpga/fpga-mgr.c          |  8 ++++++--
 drivers/fpga/fpga-region.c       |  7 ++++---
 drivers/fpga/of-fpga-region.c    | 22 ++++++++++++----------
 drivers/fpga/zynq-fpga.c         |  2 +-
 include/linux/fpga/fpga-region.h |  7 ++++---
 6 files changed, 30 insertions(+), 22 deletions(-)

-- 
2.25.1

