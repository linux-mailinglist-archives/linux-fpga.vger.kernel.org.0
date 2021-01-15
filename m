Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42CEE2F7010
	for <lists+linux-fpga@lfdr.de>; Fri, 15 Jan 2021 02:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731543AbhAOBlb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 14 Jan 2021 20:41:31 -0500
Received: from mail-eopbgr750080.outbound.protection.outlook.com ([40.107.75.80]:12997
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726795AbhAOBla (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 14 Jan 2021 20:41:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QABn+/+bC+ZVzIpAyCwaE0mfdlc+hWkyNDvNr1TYuDowamo3ML6h+KoWYTHgyWJlh4NIbYxeOs4CpL2Fzh/r1a33/9GXZxjt8L1klIbxK3DzUMXGo9yNQrohvT/uZlPb/uHeOMa16IQvYn+OZfNXTTaM/4AsgsDIb7ggrEtrQOa9qgsmZf/pq4UEpjdhkxUsaWq3Mqr/UA9VYUTgCb717OTMtvnFjLjabBhVerTkHk7syqL6PfRJch/ofvv2Z/JJB6Cq9VDHrIkfyfenNnfVSYegp7bZYXfndIwwHsEmDo9mZ55bdyGzr8YBcEF5PycNj0cVL3UF+YvQgb3ufxG63g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPrlajXEJGeTLnI4MdDZqjlwlhqKsr+Y1vYLi73cAaQ=;
 b=dtxgtbpEsgpZfoznwGo0v9lwFtXVWSQuArzBDfs2pWSAc6B47zezQYjpko+8tGl9n8kc9sonYxEaX2RmHQuq+2Tlwt/BC38mPbVa+YSTATd60D5xiQl2n339LEFyO46xC6rvCnSg6AEI01mS/v2tOiZMJ9lia/BUFiYdUpzIYHTgrb7NXWgWlnJuUtjvQl1uOqGhd4Tp4opKRDEAXBk8Rg8mjZ5t3vlpWRLwljqnSejG+b7UO9uMfcaLd2VW12EpxWEfciAwYnX1kn9KyxdvKgBAqFvoMXGJbgDQjHakFH5RT8MYLBnokq6Hx/0jJyb5Mfd97AfvwEOmedEFLLq+8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPrlajXEJGeTLnI4MdDZqjlwlhqKsr+Y1vYLi73cAaQ=;
 b=URGW18r0PQxDMv9jTcoWWfF9IDvXYkKhsgs8mFqKga+9V5zA/z44bSUwwfoRiNbj8h6eMQt3UwoHToAezqjjYWHaGLsOYG06cEDl712zVHXYTZKpIhzlmehd46sM6mm+Bc+ZLs5x1s3cqWw/wr3B6REnWIQ/d5XWooJKUYLPN4Y=
Received: from SA9PR13CA0172.namprd13.prod.outlook.com (2603:10b6:806:28::27)
 by CH2PR02MB6152.namprd02.prod.outlook.com (2603:10b6:610:f::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Fri, 15 Jan
 2021 01:40:41 +0000
Received: from SN1NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:28:cafe::ec) by SA9PR13CA0172.outlook.office365.com
 (2603:10b6:806:28::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.6 via Frontend
 Transport; Fri, 15 Jan 2021 01:40:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT007.mail.protection.outlook.com (10.152.72.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3742.6 via Frontend Transport; Fri, 15 Jan 2021 01:40:41 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 14 Jan 2021 17:40:24 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Thu, 14 Jan 2021 17:40:24 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 mdf@kernel.org,
 trix@redhat.com,
 robh+dt@kernel.org,
 linux-fpga@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 chinnikishore369@gmail.com
Received: from [10.140.6.60] (port=56178 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1l0E6A-0007vy-Tc; Thu, 14 Jan 2021 17:40:23 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <trix@redhat.com>, <robh+dt@kernel.org>,
        <michal.simek@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <git@xilinx.com>, <chinnikishore369@gmail.com>,
        Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH 1/2] dt-bindings: fpga: Add compatible value for Xilinx DFX AXI shutdown manger
Date:   Fri, 15 Jan 2021 07:04:30 +0530
Message-ID: <20210115013431.27667-1-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecad5ed8-84c3-4580-7fa4-08d8b8f6917d
X-MS-TrafficTypeDiagnostic: CH2PR02MB6152:
X-Microsoft-Antispam-PRVS: <CH2PR02MB6152814DEA6192260D566F78C2A70@CH2PR02MB6152.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OIAlUDJj33tdjxgJciHv1u1n1tLrsofra9u/L/vL9FKGhA4KFsDQoONyYt+XvfTlgkLgnXkV3978m8si9k9yPLntheFcL1c1PmU38EIjS1TBH38rf16ASzmUCGoBxXuNwXJKRoMdUOVqxOzLYhOt9RuYWEhWWEPcvGL+dVuEiYjm/1EuE97SNrjongn/Nc1gJhoXjSZvPSK+c02SbeuHVVnxLvCS/V5PkIgPF0EL9zhNVpUJF9QUnFI9Cic0JV24MudPIZ7fnI5+PiKKJRQDHUYf3Q1j+sTOrBJwccuQYaEvCq+bqJHr7avebCeixJtSdvbIV4k/mqxJRNILUEvFyUN6O3tGvo0I1YSQGTRHWk8uW+AxXZoljfuds03O5EbdkyayMtdDA3d6nbx8bfpk7RHkLMCSdEC0VI5advSd1pH4agsbbhDcNWvmQQTst3lHNz+rwMHg0nsXM/64Xcr/JjsOaKjuCxGs/SZ0VmPbxWHbmc1WNjquyCCW3J1CJkZp9PvXuJViYzzH2swILWgHGNlKiA/SIvOvtvzZgiwHcUA=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(396003)(39860400002)(46966006)(83380400001)(8936002)(7696005)(316002)(336012)(70586007)(36906005)(26005)(82740400003)(47076005)(34020700004)(7636003)(426003)(82310400003)(54906003)(186003)(36756003)(107886003)(5660300002)(9786002)(6666004)(4326008)(70206006)(8676002)(2906002)(2616005)(110136005)(1076003)(356005)(478600001)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2021 01:40:41.4502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecad5ed8-84c3-4580-7fa4-08d8b8f6917d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT007.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6152
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch Adds compatible value for Xilinx Dynamic Function eXchnage(DFX)
AXI Shutdown manager IP.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
 .../bindings/fpga/xilinx-pr-decoupler.txt     | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt b/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
index 4284d293fa61..42fca058a5f4 100644
--- a/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
+++ b/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
@@ -7,13 +7,26 @@ changes from passing through the bridge.  The controller can also
 couple / enable the bridges which allows traffic to pass through the
 bridge normally.
 
+Xilinx LogiCORE Dynamic Function eXchange(DFX) AXI shutdown manager
+Softcore
+
+The Xilinx LogiCORE Dynamic Function eXchange(DFX) AXI shutdown manager
+manages one or more shutdown managers / fpga bridges.
+The controller can shutdown/passthrough the bridges which prevents
+AXI traffic from passing through the bridge. The controller safely
+handles AXI4MM and AXI4-Lite interfaces on a Reconfigurable Partition
+when it is undergoing dynamic reconfiguration (DFX), preventing system
+deadlock that can occur if AXI transactions are interrupted by DFX
+
 The Driver supports only MMIO handling. A PR region can have multiple
-PR Decouplers which can be handled independently or chained via decouple/
-decouple_status signals.
+PR Decouplers/AXI shutdown manager which can be handled independently
+or chained via decouple/ decouple_status signals.
 
 Required properties:
 - compatible		: Should contain "xlnx,pr-decoupler-1.00" followed by
-                          "xlnx,pr-decoupler"
+                          "xlnx,pr-decoupler" or
+			  "xlnx,dfx-axi-shutdown-manager-1.00" followed by
+			  "xlnx,dfx-axi-shutdown-manager"
 - regs			: base address and size for decoupler module
 - clocks		: input clock to IP
 - clock-names		: should contain "aclk"
-- 
2.18.0

