Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F219350CC81
	for <lists+linux-fpga@lfdr.de>; Sat, 23 Apr 2022 19:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236220AbiDWRFt (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 23 Apr 2022 13:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbiDWRFs (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 23 Apr 2022 13:05:48 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2073.outbound.protection.outlook.com [40.107.101.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B786D82D00;
        Sat, 23 Apr 2022 10:02:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPv4z1RBpn22i2K20e7fCLNpfk8A3UAR1Sl3gF4xDVc00FMlgJLGBm0WBB34fVQgS5q2scWQUQBilXt6o3Pa5ahGiwv9Dq84jLuQBq5s2VmkyvBr1wTTa94zOHsJQoiaZuHm/VPTj+yWwkHk5l+SEzDZpcwsxCroS0o0n/4fbdJQwWWb22kJKhbadD98FilN76+lUS4YXtHOWFodQK3TpB26pj5lrq6A8mat3+jcZo1MYZPJ8XBnO+Ww1mNGo7HZoMl0ddD66S6kyio7EPlexe5M9pD+K4VewyNCkrzWwQMawKfOYveH0ZQXHqr+IEqskyqH2aF39u4+4EWWeTHntQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56kFN+N7nuGs6iBPqoJ+3QLHN+R6qX+h7LVlr2NRi9A=;
 b=Qp4+cRKZroPuQjOB5QcnFKU85OWd+BKdRtvYnA9k3IRvbmdAGnyd8K9PlvXiJS5NyzAxv3jznJALq17fTXeqTjgkGyLa55W3WArbczdEDmHp4Q4UB23x2psCSpi3RBLbKc5u24Kpmr6ZBILy+xuA8i6h4xYaXP+/hTUxbcTMTQKRx4TJv92HHgdfa6ND+MAFHgLtaedqGt3hwfH2wlspVNdQGZkv8WBgi1jhrDT91ahrpuzkyq6ohMClb5MNhWlaDFJ4//UVtV7O00fBtyyWrIqgFhg/gL8PQXwMpFHkhq6Rfb9mqqm6thtDGrhKmkP0PQBu+83G7tLRqWq4IsUj8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56kFN+N7nuGs6iBPqoJ+3QLHN+R6qX+h7LVlr2NRi9A=;
 b=OKQ3Pn4q0pzHzR+Flk6fbsB6ZFqeyw39CDoqt7v3KDh1A9qseIw8ahRjE4D8IyXAktr0h7tCgSM5h3V+C0AAVTxmAYUpo95S0GC/BojdsY3jqvOk6JwodX25WJhg3xA+dAz1nmsHeXxzYYOL3ZbwNFDCQedUMTAk2z+dbQQcchg=
Received: from DM6PR03CA0021.namprd03.prod.outlook.com (2603:10b6:5:40::34) by
 SA0PR02MB7130.namprd02.prod.outlook.com (2603:10b6:806:ec::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Sat, 23 Apr 2022 17:02:49 +0000
Received: from DM3NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::96) by DM6PR03CA0021.outlook.office365.com
 (2603:10b6:5:40::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Sat, 23 Apr 2022 17:02:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT027.mail.protection.outlook.com (10.13.5.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Sat, 23 Apr 2022 17:02:49 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sat, 23 Apr 2022 10:02:47 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sat, 23 Apr 2022 10:02:47 -0700
Envelope-to: git@xilinx.com,
 mdf@kernel.org,
 hao.wu@intel.com,
 yilun.xu@intel.com,
 trix@redhat.com,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [10.140.6.60] (port=37114 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1niJ9j-000FkB-6t; Sat, 23 Apr 2022 10:02:47 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <michal.simek@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@xilinx.com>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v6 0/5]fpga: fix for coding style and kernel-doc issues
Date:   Sat, 23 Apr 2022 22:32:30 +0530
Message-ID: <20220423170235.2115479-1-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b8c7296-dddd-4e3e-70a3-08da254b18a3
X-MS-TrafficTypeDiagnostic: SA0PR02MB7130:EE_
X-Microsoft-Antispam-PRVS: <SA0PR02MB713072470AC6714E855D1441C2F69@SA0PR02MB7130.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 775qmwFt6CVzcv527XEb78WpifK9xtY09GPcRajWAPJ1tDYPDX7d4ROg6oEi91du6IfiTXm2x038a6Pu6IMmXsRwTmFI2Yp+jUfOIL3qnslNOK5bzjivaNq1NOQhgx9KOdqf7Vyi0MwNKZJPPlCw2kSy6vNxlrlRlQh6oNbyZtdKRjLsgeiM57B1H+71pggyPal8RE8bw4LeyD9Y9OP2tn27qjlZ/wyV2ae6F+RgYh3FZyRUFOjh00oH/5nA0+RleNSvIBPKd2tCPS/aT280XuUUc1EYLkG80ZOAzMvDNfg43W2ZOAc7nepHs4rRTVEJrM0v/iDPLnv9djDFN3SCoYt/WNBargVhvzMPRLusrrLClfnVFGSXW8z0jPOLuz2aAK9sZ6LGVW7W4yFujZDwUg+cz1DPXh6PL2ICqShGggUt5DTe6OAb2c/c5e9rqq0IqQZn32qB36JvO8fXdFKykP7D+MTPRBgHLuYLWhUUqmVNf7E8rJwK0PWm4U7/SAlGqwim79QmqrKAkOR/eH+gnMUJ9XiAWVzyWxyhQ+wv3o72aikUv1RvbEDdDeyYepiMgCCKkXD3wxQUD0taEH5aHzdyXuMjfTsHIuXmH74/tGqO9wwcbJCbvdblUvskvGlvFnEzP9zCbEpCTCga+VMGMhyMw7N+6H/rx9GAx1E53Ady7LVEkNk/wm2+I2+VC2+2jFwFEK1y9y1vIHiTqYmGDK0/dLEII2GmOY9kzZwXOhU=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(356005)(40460700003)(26005)(2906002)(7636003)(6666004)(83380400001)(36756003)(47076005)(4744005)(36860700001)(5660300002)(9786002)(82310400005)(7696005)(8936002)(186003)(426003)(336012)(70586007)(70206006)(2616005)(508600001)(107886003)(316002)(4326008)(8676002)(1076003)(6636002)(110136005)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2022 17:02:49.1548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b8c7296-dddd-4e3e-70a3-08da254b18a3
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT027.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7130
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
 drivers/fpga/fpga-mgr.c          | 13 +++++++++----
 drivers/fpga/fpga-region.c       |  6 +++---
 drivers/fpga/of-fpga-region.c    | 22 ++++++++++++----------
 drivers/fpga/zynq-fpga.c         |  2 +-
 include/linux/fpga/fpga-region.h |  6 +++---
 6 files changed, 31 insertions(+), 24 deletions(-)

-- 
2.25.1

