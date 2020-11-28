Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9042C76A6
	for <lists+linux-fpga@lfdr.de>; Sun, 29 Nov 2020 00:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbgK1X70 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 28 Nov 2020 18:59:26 -0500
Received: from mail-bn7nam10on2041.outbound.protection.outlook.com ([40.107.92.41]:12256
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725839AbgK1X7Z (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 28 Nov 2020 18:59:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdmnaxheaPO85dvdOv+61SYM3C94SNTPxbddV6QB8C+VmSqkf5stQi3uHzijOZ594hYrkJq8VEc93GhniZqgop7ggLCO7QBJWVAAE7YGjd6frgFVGqBj6YWNe2qdKpQE/J4AjsYUkmH6J0gNYf/jw0Mpz9hXjR4RSjjMoEnjpplmPqsr/Uu1784meJaExHf2CCOLYNsikg75kyjzq4oGtG4YQkVdJt2evYG2AccmLiPrJvMvrbLPqt8McA344IvQ3JJ1+yo2yoq7dmJm3HdGNK1mgr4fecQLxjr2t1bZWc5lVnYqYYvDZRzF2g4nqj4VFP9mvgd2HLq0y9r6nKY2Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYre+S/xmjNEQDh5NviP1JHeBjetdhNSAxTUo6dlpXc=;
 b=Dm7pDX7APgvI64lR4KbxN8UnvoVoqnE4VJ3X+WhcimzUnns4/se/6DNzRoIJO+bxG5kgtS5ZC3E7L6vOLq/jJ8ndOjvhx1yj4p4HfVyhSakgtK2a9Z+NPABYHQc84vFBiKYfAWoQd517jRhsxI/kg4d6Ub6GmN3b8kIUslzSanWq+8QIElGLgjIMWjePfWejm87i2yDtGAya4gQti4LbQNIsYS0p4k/Z3xrUZ5ypV/qEJbmgE2EMO3ae1/ozeCRAcVbIEMBXrq+w232J9vBQG3gTIuBkvJM4/xChllAumBI2mUQnoCXugYbhUGUk16AunZKY00ckmRztPh/q7QN0TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYre+S/xmjNEQDh5NviP1JHeBjetdhNSAxTUo6dlpXc=;
 b=OlsztzzK8al5me/pcSZ9hmbeLx2RKMBsapUHTeSjExRNKJt5uHFXj+U0DNZW5Kpa0Z7onI32jksukuoO+AZiN9DtU9yA2LYOzSdwKzZ0FhnfzAnxcHr6UV21HYG0IW2MT9tiECRQGJ9Cp1BWN87njcBWioOLTxI+p7smFrtT3xE=
Received: from MN2PR03CA0030.namprd03.prod.outlook.com (2603:10b6:208:23a::35)
 by BYAPR02MB6006.namprd02.prod.outlook.com (2603:10b6:a03:120::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Sat, 28 Nov
 2020 23:58:32 +0000
Received: from BL2NAM02FT044.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:23a:cafe::5d) by MN2PR03CA0030.outlook.office365.com
 (2603:10b6:208:23a::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Sat, 28 Nov 2020 23:58:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT044.mail.protection.outlook.com (10.152.77.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3611.27 via Frontend Transport; Sat, 28 Nov 2020 23:58:32 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Sat, 28 Nov 2020 15:58:29 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Sat, 28 Nov 2020 15:58:29 -0800
Envelope-to: michal.simek@xilinx.com,
 lizhih@xilinx.com,
 maxz@xilinx.com,
 sonals@xilinx.com,
 stefanos@xilinx.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=45038 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <sonal.santan@xilinx.com>)
        id 1kjA6n-0003Rn-G4; Sat, 28 Nov 2020 15:58:29 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 6354)
        id 2517760010C; Sat, 28 Nov 2020 15:57:35 -0800 (PST)
From:   Sonal Santan <sonal.santan@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Sonal Santan <sonals@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <lizhih@xilinx.com>, <michal.simek@xilinx.com>,
        <stefanos@xilinx.com>, <devicetree@vger.kernel.org>
Subject: [PATCH Xilinx Alveo libfdt prep 0/1] Expose libfdt for use by Alveo/XRT
Date:   Sat, 28 Nov 2020 15:56:58 -0800
Message-ID: <20201128235659.24679-1-sonals@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6bb234a-c002-4c84-19c6-08d893f982da
X-MS-TrafficTypeDiagnostic: BYAPR02MB6006:
X-Microsoft-Antispam-PRVS: <BYAPR02MB6006647107A56F16B48C6793BBF70@BYAPR02MB6006.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DUZRWGJdWDjI3jAt9nNBIzn4fHuzS6vQq8EsbnPXDoDoWkXSfKS2JEkxJz0q9GQUQel9xmZR6YZmmIWRLxP4xey0Rqv1UbuxwQmsRo/o/uYANnN6nPOdwTyEp/KXqu+p1MeEchLs8iGvqvMAD15EJ+35UbCjCPy9uSDJVUe8ME5vTvb/Qzr2CKl9wx2IbfxMi7vFNOgXBb6HONh6yZQ8O7M/nuHH1l+STUiG33Vn90SmxiawcrhVoFEpbQbQjtP9owzNr45bljEVoykIaCp8Mdpuv5EXIDdGArfJ8HDuuJxbt9A7D813EBi/qid5nkaUKh7p+DzmQJnOTIUVBbafyU/xyQOgvjXJiK7AXAC4HzZMLfDe5kwBfxRI286bOThraQ+8+JjCnpSXkicpZvpxWA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(39850400004)(46966005)(336012)(4326008)(5660300002)(6916009)(8676002)(8936002)(2906002)(83380400001)(6266002)(82310400003)(47076004)(36756003)(450100002)(1076003)(2616005)(186003)(356005)(82740400003)(7636003)(70206006)(426003)(26005)(478600001)(70586007)(316002)(6666004)(42186006)(36906005)(54906003)(4744005)(44832011);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2020 23:58:32.2977
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6bb234a-c002-4c84-19c6-08d893f982da
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT044.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB6006
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hello,

This patch series adds support for exporting limited set of libfdt symbols from
Linux kernel. It enables drivers and other kernel modules to use libfdt for
working with device trees. This may be used by platform vendors to describe HW
features inside a PCIe device to its driver in a data driven manner.


"Xilinx Alveo" PCIe accelerator card driver patch series which follows this patch
makes use of device tree to advertise HW subsystems sitting behind PCIe BARs.
The use of device trees makes the driver data driven and overall solution more
scalable.

Thanks,
-Sonal

Sonal Santan (1):
  Export subset of libfdt symbols for use by other drivers.

 lib/fdt.c            |  6 ++++++
 lib/fdt_empty_tree.c |  3 +++
 lib/fdt_ro.c         | 11 +++++++++++
 lib/fdt_rw.c         |  6 ++++++
 4 files changed, 26 insertions(+)

-- 
2.17.1

