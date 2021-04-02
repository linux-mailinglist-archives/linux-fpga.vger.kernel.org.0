Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F353528B2
	for <lists+linux-fpga@lfdr.de>; Fri,  2 Apr 2021 11:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbhDBJ3C (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 2 Apr 2021 05:29:02 -0400
Received: from mail-dm6nam12on2055.outbound.protection.outlook.com ([40.107.243.55]:48865
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234389AbhDBJ27 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 2 Apr 2021 05:28:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nJxdjN2EESjkl2ZbRU0uXGOKI5RTqBTKKifhafkmLXJZ0gSXXE1329eqWhzEVoBT5XKwgEf1QiTP3tqhcw4ZxDWTFjdEfF/VJIdzXW+Ot09v6kCaN5xDqnXKB0QPzyY3pfk4WqLQqj1Zf6/WqLkyP8x/uYl+xLMrf+5ZeSLfBhN8687Ec8veSzPL2cc/dZteI08WMdzZmKSAFGgIQ+k6E//lXPnmi7aGnPkZ02ZInb6TBT95JbTGuZ2gOWqqjSiIuTuAIIOpOxIEcADmcDaUgtUSpp4R+WHL20MO3urGDPm3yL+9bXb7Bm4/13Wu7t/efm7pETHhiqg8gl3nOm89FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwG9CWrM9Yaw6V6Emogl/7Jl0KpP+POQQLwzB+XBKSo=;
 b=R49yAvusZxl3xzebwewCFqY5wpa1E61d6RijYwUGjHvovdIUd6fl8Q+nnYXlEs1+Ru/LxmuqQGiWZfGK38dAAhYEnBMA2gEp5ideBy3qTgksh41YxcK4euilvfo9go1IZz1gKJ2YFL+qCz5H+z7TnPML0RZM0HNRUVj29iJaf+Xlbh4pSHk2kWZqvyqI2TFM0qIPJH3A++2kkhCRhB52fxApeUU0DL2Rm1sovUJ8ZZN93VMq+ovcaST/HL0cntEFN8iT/bBk1ty8whgSdHmX+2rd+/+gn2u/fQCERtOU+xfZ6KD++SaIo/1j7eYHEWiiZLxZ4ilVc24kcqv+HYZQ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwG9CWrM9Yaw6V6Emogl/7Jl0KpP+POQQLwzB+XBKSo=;
 b=KQ0kbd22DG5fvM01TPLjmE0SW0LGEN6aeR2Y5eCG6d2IOneSSatzvj4A69xm+YRPn6U2I9RnA9E1sQMsd5qLYcGPKU4apIOr0Zm6/edeiOvPU8CtorACcMkpe00/CO0REDEUsMdwv2mGAQilQWYHChjbuFIc8qif+fcUwVJpJFE=
Received: from SN7PR04CA0024.namprd04.prod.outlook.com (2603:10b6:806:f2::29)
 by SN6PR02MB5341.namprd02.prod.outlook.com (2603:10b6:805:67::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Fri, 2 Apr
 2021 09:28:57 +0000
Received: from SN1NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:f2:cafe::23) by SN7PR04CA0024.outlook.office365.com
 (2603:10b6:806:f2::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28 via Frontend
 Transport; Fri, 2 Apr 2021 09:28:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT006.mail.protection.outlook.com (10.152.72.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3999.28 via Frontend Transport; Fri, 2 Apr 2021 09:28:57 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 2 Apr 2021 02:28:51 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Fri, 2 Apr 2021 02:28:51 -0700
Envelope-to: git@xilinx.com,
 mdf@kernel.org,
 trix@redhat.com,
 robh+dt@kernel.org,
 linux-fpga@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [10.140.6.60] (port=58326 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1lSG6j-0005gX-To; Fri, 02 Apr 2021 02:28:50 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <trix@redhat.com>, <robh+dt@kernel.org>,
        <michal.simek@xilinx.com>, <nava.manne@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@xilinx.com>
Subject: [PATCH 2/3] fpga: region: Add fpga-region property 'power-domains'
Date:   Fri, 2 Apr 2021 14:50:48 +0530
Message-ID: <20210402092049.479-3-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210402092049.479-1-nava.manne@xilinx.com>
References: <20210402092049.479-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f78da796-3174-4eec-e3ac-08d8f5b9bd8d
X-MS-TrafficTypeDiagnostic: SN6PR02MB5341:
X-Microsoft-Antispam-PRVS: <SN6PR02MB53415F8F16F7101B6522FF18C27A9@SN6PR02MB5341.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HylBxwrF8ACviXGWrhO5qVo6Rvuzmb465frPYKaCHgimaztuEWniPZKpoq+3JXSJwdgGvShf2ieVQ4ArrkYGr1CH4jFEhQCkcwDunkRyZwHDobhNExYqpHpRO0RQ2MR5oExAlOiMHIHkVZqn6UvU8yeyDDHrmBpSdPQxA9zxJjOpB7XN2TUZLlniu+TxAlCJez7BnWTSS2us9MZAx31j3HFgnhpeo4N4GY+cYii92DqrlSLN3PL15Vx5ZKbMx5sYu56filxc5y7lT0bNeva6AhfT/QyBHu+CiO1hnQXf0KkJh5PLKjrpKBAoNa3QnZOKMVMe15OUiXOFTQnSD3HZOxKQt9n8HbCouqkSZMy6DBUSWs7Bj1lR+DFJ2Q+8d2qwYKKu+O9+gOaYU+GS6EjJDkgtk6xXUW7AeB1DOxvd+Y9PGqOt3XJyPQ8ffru/Qv/hvw+QCg67JQWkdbWxWaNqomKV+yH8S2WxJGL4VYlD/7idt2mX2AHwlIXuzS+NMMykA5ljnTl3LP8OGuQ/S6OIwMzGOg6eC0950TFUzV1FgOPKzQ/NScjx8BaoddpyLUj/YQjVl0MBr74RDKGyrYBj5qoT5g5XuPLkz6WFRTjGu5DVhtUFHnK2vVqP46fjeTRqZQU2vYBnvwDDgkowMYyYKUZEANArTp1I5E6YbLBzTOXd4lCeaqcHWEvLATEVpZdkT6tBJLncserRWkS544v738JHcVFeOCvk+MMIoI2U8zie+OptLG0m4V715uzQyaI1
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(39860400002)(396003)(46966006)(36840700001)(7696005)(47076005)(7636003)(356005)(8676002)(5660300002)(110136005)(426003)(8936002)(921005)(1076003)(186003)(9786002)(36860700001)(82740400003)(26005)(36756003)(478600001)(82310400003)(2616005)(70206006)(6636002)(316002)(2906002)(336012)(36906005)(70586007)(102446001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 09:28:57.0063
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f78da796-3174-4eec-e3ac-08d8f5b9bd8d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT006.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5341
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add fpga-region property 'power-domains' to allow to handle
the FPGA/PL power domins.

dt-bindings: fpga: Enable PM generic domain support

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
 .../devicetree/bindings/fpga/fpga-region.txt       | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt b/Documentation/devicetree/bindings/fpga/fpga-region.txt
index e811cf825019..969ca53bb65e 100644
--- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
+++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
@@ -196,6 +196,20 @@ Optional properties:
 - config-complete-timeout-us : The maximum time in microseconds time for the
 	FPGA to go to operating mode after the region has been programmed.
 - child nodes : devices in the FPGA after programming.
+- power-domains : A phandle and PM domain specifier as defined by bindings of
+	the power controller specified by phandle.
+Example:
+	fpga_full: fpga-full {
+                compatible = "fpga-region";
+                fpga-mgr = <&zynqmp_pcap>;
+                #address-cells = <2>;
+                #size-cells = <2>;
+                ranges;
+                power-domains = <&zynqmp_firmware PL_PD>;
+        };
+
+	The PL_PD power domain will be turned on before loading the bitstream
+and turned off while removing/unloading the bitstream using overlays.
 
 In the example below, when an overlay is applied targeting fpga-region0,
 fpga_mgr is used to program the FPGA.  Two bridges are controlled during
-- 
2.18.0

