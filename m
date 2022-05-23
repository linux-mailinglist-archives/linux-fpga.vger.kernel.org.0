Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4529F531264
	for <lists+linux-fpga@lfdr.de>; Mon, 23 May 2022 18:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236568AbiEWNqW (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 23 May 2022 09:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236513AbiEWNpu (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 23 May 2022 09:45:50 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04FE5521D;
        Mon, 23 May 2022 06:45:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xfr+91tRYauocLA1LvNF9xTlVw9VLjuHyTZ+mgrbwPORhUJwADAgQH91j5gtZnTxx4GiDEP7odpkDySUw2kF5qdMy9HJpCvTiBjSLqOfIp7GjG/SzOKDUizy1TA5Ll5+sVnWrQadBIyLBxy4gsEoggqCM5RX0qnqjANN/sZlcAFqxb0ZC2o/iYvNVgtO2rAJG8glndV6kFNBI8898C0kxupqhM6tDfwh7cWOYB4o+Qmup1d52m7926Jyd4eXIugrEiWGwHr1wFEntNX2Vakuuz2FdptuHoeP1+0gTlcQ/EsEUJ5c6o4MKe6BUA5GIEejQpKhdstJbja0mquDq8GLXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOqcwuEswQM+8f/f/L7NB61pc9L6si9Q1erZUi/w7W0=;
 b=m9Wz174MezA2oHWywF8x0kjv+QnXIrm5plsbicObd885bGEeGcY6QFWyQE31mxzHPw6Ak9fawqjy3WV3OZq08wWbckNy0ybCPcYzUuTMEE5tEw8SZTVQk5zNjr8CehcC8nbQC9voKhBvExxeceQtsjmRX/VwK7soyEMKKoW+TCL21GnScQRmbpwXiHjZ3G2OY6N7/A+sORdqHyc/9BYZDWFPl8kc0ns6phQ6UFo46GcbHY8jQ+Crz9ljWqvIrZo6sLI/VlfB0QX5k0Jy94i4o9veQJXvHe7SlR004dLO/QbgsamWIjuBOtGno6uiCY3vj+Gy8jiuLDN5r9wrnH95mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOqcwuEswQM+8f/f/L7NB61pc9L6si9Q1erZUi/w7W0=;
 b=C3uc+IA5fKbd2e6r+R1eEM1Bg7I5xua00L851J52lUyH0PGe4gmV6oHgr8oq2rHjweHqhwWx8DoazGs52jSuTlXtWSPzcBgDtEcYFzMyM81lEurn4FGtmeXYmOjH/AdlqpAcMypuHQ9WVHtuneiCyWqQmPtvtS5TcO5wUABnYlI=
Received: from SN6PR16CA0043.namprd16.prod.outlook.com (2603:10b6:805:ca::20)
 by CO6PR02MB7508.namprd02.prod.outlook.com (2603:10b6:303:a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Mon, 23 May
 2022 13:45:44 +0000
Received: from SN1NAM02FT0033.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:ca:cafe::74) by SN6PR16CA0043.outlook.office365.com
 (2603:10b6:805:ca::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22 via Frontend
 Transport; Mon, 23 May 2022 13:45:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0033.mail.protection.outlook.com (10.97.5.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Mon, 23 May 2022 13:45:44 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 23 May 2022 06:45:40 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 23 May 2022 06:45:40 -0700
Envelope-to: git@xilinx.com,
 mdf@kernel.org,
 hao.wu@intel.com,
 yilun.xu@intel.com,
 trix@redhat.com,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 linux-fpga@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 robh@kernel.org
Received: from [10.140.6.60] (port=57798 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1nt8NQ-000GwK-4Q; Mon, 23 May 2022 06:45:40 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <michal.simek@xilinx.com>,
        <nava.manne@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@xilinx.com>
CC:     Rob Herring <robh@kernel.org>
Subject: [PATCH v2 2/3] fpga: region: Add fpga-region 'power-domains' property
Date:   Mon, 23 May 2022 19:15:16 +0530
Message-ID: <20220523134517.4056873-3-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220523134517.4056873-1-nava.manne@xilinx.com>
References: <20220523134517.4056873-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8a696ac-533b-47b4-3f80-08da3cc288eb
X-MS-TrafficTypeDiagnostic: CO6PR02MB7508:EE_
X-Microsoft-Antispam-PRVS: <CO6PR02MB750862EA046D4AF6FCA866BAC2D49@CO6PR02MB7508.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Gg9bY6QPxRoJKhsWmwcDeEOjBXVuIUfs7Gac31f1nudr+/weIoi0HdfKxV7VtIRkbSlL3yXVx1qyNKRYPl29iDsbsH/2a9ooAwk83KD644ncgvXbTerUE0SKWZc4glhBEmMIPyV/XkXT3kBNwgIybqlof/QBlIt4gwo3ZcFkcUgPWyYbhEvArWHOeWV63uWTmY+/KxJJFL7oea+VtzrKmocH7nmfU1UPraKtlWGd634u++f/c2o0p4jPzxmWx2IKirv3zvkVWsm3JlvLPM234xdKGjYHbxTbrr/8A8dc8ETJ2x50a4qVTC4UMOAP+1rSX+3b52lvg+qcgXCGE7OMbaLaiAGfgjJ9q71QqnO74ocOYt/YyfxdXe1oPqp+zdtOIH630YcIWGAUYRiAQNqaPUwwpIpQ4InkXQZ59g8NOKG/sxTmwtd+Vw0N+mSTwP8Jz+hm6ysaDbMRrvAwt2K1MoapmrJz0IMjyUBY4VXjalXvnQe4GS9dJ5kdc2BvfrVfbhyoHA8lRcfeFdRQg5RzQRPwpkQM+wjDKB3hnVVdhnNUuBTovrE11OACyLAzb9Fjis8mzrVI4qc84IJNSVXoaeLzPYlELRF2LUFZviGSaTP0u7PbfZFhVirNCLd5e0Yns8o5d5AD2epCLD+6cHDuoC2FY/TViUQKpnRlz11KJhMjA2r0QevCBc5thlJwAxlGDrS2STCWf48wbQMofJNBMPEG7Hi5iZANLZU49B7I2j1fl4NrGpQ87w1Cy5VbnIBgslqRfum3BohISL6/MKjeQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(7636003)(921005)(356005)(7416002)(5660300002)(8936002)(83380400001)(7696005)(6666004)(9786002)(26005)(40460700003)(2616005)(508600001)(1076003)(2906002)(336012)(186003)(47076005)(316002)(426003)(70586007)(8676002)(4326008)(6636002)(36756003)(36860700001)(70206006)(110136005)(82310400005)(102446001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 13:45:44.4005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a696ac-533b-47b4-3f80-08da3cc288eb
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0033.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7508
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add fpga-region 'power-domains' property to allow to handle
the FPGA/PL power domains.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes for v2:
              - Updated power-domains description.

 .../devicetree/bindings/fpga/fpga-region.txt       | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt b/Documentation/devicetree/bindings/fpga/fpga-region.txt
index 7d3515264838..f299c3749505 100644
--- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
+++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
@@ -196,6 +196,20 @@ Optional properties:
 - config-complete-timeout-us : The maximum time in microseconds time for the
 	FPGA to go to operating mode after the region has been programmed.
 - child nodes : devices in the FPGA after programming.
+- power-domains : A phandle and power domain specifier pair to the power domain
+	which is responsible for turning on/off the power to the FPGA/PL region.
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
2.25.1

