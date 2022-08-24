Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0E659F242
	for <lists+linux-fpga@lfdr.de>; Wed, 24 Aug 2022 05:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbiHXD4c (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 23 Aug 2022 23:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234544AbiHXD4N (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 23 Aug 2022 23:56:13 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDC632EEB;
        Tue, 23 Aug 2022 20:56:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1qEBQF5y3KavKF8NFdumDCTE7luCoYFpQJ6ijrMtC7GfipXzRd/dmp/PbhFYDQTKfP9kBygqQv5B3TKQ97bzrXhO9+oG1LSnFzyTIaPtDrRO//Vh/Pw/o+mycGGRCSNFwqTAjjoC6PBIF9zbrNEbY05ZdOe2Wi4DtOUTLGQxxD5SsJ1uvqbGBmA6RFK78Php/miY8e/cLybeHXvQVMC5SfXPKau4Z7Mj6T1ffb6bUnrgFLigPBzprBkG1+bxllM24x1ePzzrFLXFp/gEqX+VLLu0DornbXJNVQcaVV/e+gHi6o2YmpFFVqe2MCr3yKlJo9bsPHYZHMzb7nJDI8Zdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aezOuCjGGPWyL5QnllVmuiOpsQZnBx3/dKjfvQacGDE=;
 b=VUjiPFbgt9Wvqjw+Sk+WC1Jo86khDwVanxcf/C+3x1VPZrup6iu4g1UvIEM9knH5ecDSk68xFCuoRhqBBPsdlFFMFvrJcGxv62jMJsfxqSy9le/K8jqLQCW+hFWUvM3BrryD7eDc2K72yInbbcUOrUCH/PZ0atqIjo9XBkge5U+krJoPC87LaLQJGOIAx4cS3ydgE4bSWaz1x84rbxQtv3wmMBVMBsbgrIWYg5TllokE/W+l0b2crfkos9gzVop9IHnjr4EJsjgUllH265NgRcHXKbXZpTm1jNilpdvpTjDKB1By+DJ3ibQpMDdCA1L+eAfL0VpFhv2E1KGjMnnUHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aezOuCjGGPWyL5QnllVmuiOpsQZnBx3/dKjfvQacGDE=;
 b=u3lCocbP3LkIxYLLuaC1Q088YorrN7cp7Rn4n7fWsL96crESedLPKYB4tDwVLggfgR+SQh56fzpWiypfPKIhhRr4rYV5NaU+dxpXZX0N+v3Td64nDeR1B3ZecLj5qiYZe2cs764omMAMkRs1VYMoSeLPWfmo4N5pv14sSrO8sZE=
Received: from MW4PR03CA0285.namprd03.prod.outlook.com (2603:10b6:303:b5::20)
 by BL1PR12MB5923.namprd12.prod.outlook.com (2603:10b6:208:39a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.24; Wed, 24 Aug
 2022 03:56:02 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::11) by MW4PR03CA0285.outlook.office365.com
 (2603:10b6:303:b5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21 via Frontend
 Transport; Wed, 24 Aug 2022 03:56:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Wed, 24 Aug 2022 03:56:01 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 23 Aug
 2022 22:55:59 -0500
From:   Nava kishore Manne <nava.kishore.manne@amd.com>
To:     <git@amd.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <michal.simek@xilinx.com>,
        <nava.kishore.manne@amd.com>, <mdf@kernel.org>, <hao.wu@intel.com>,
        <yilun.xu@intel.com>, <trix@redhat.com>, <p.zabel@pengutronix.de>,
        <gregkh@linuxfoundation.org>, <ronak.jain@xilinx.com>,
        <rajan.vaja@xilinx.com>, <abhyuday.godhasara@xilinx.com>,
        <piyush.mehta@xilinx.com>,
        <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <harsha.harsha@xilinx.com>, <linus.walleij@linaro.org>,
        <nava.manne@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>
Subject: [PATCH 3/4] bindings: firmware: Update binding doc for the zynqmp afi config node
Date:   Wed, 24 Aug 2022 09:25:41 +0530
Message-ID: <20220824035542.706433-4-nava.kishore.manne@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220824035542.706433-1-nava.kishore.manne@amd.com>
References: <20220824035542.706433-1-nava.kishore.manne@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2141f2f5-9c70-4201-9af2-08da85848fa3
X-MS-TrafficTypeDiagnostic: BL1PR12MB5923:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VUAlz0XUukGXY2hHs+leyY+zeqKanMeKeSdvXb9O9qZxFhG/1f7SEQqsJBOFLAzdwfQWt9vIpHekrtbMzSHaz7GAf/Ux9cf7RrAlzZZ2JoBKH2/OzIEBjzFruyz2UldN+01hdLQ04qxlUBvnXqkqn9KqNtLRDAa1OJx9upc1XDYSNx3NAQ+85GHUyuZ+qlgVkgsvRdO1lKXixD5DYB33/8of0O+MjU/YNvZfeOomHTxBVD87WPK+eFOHwBDbUL5UqIIpvhf/qYUFYh+tEsb+U4bUZQOuYqnP0Mdk6YVFzfc59pJW9DAnEJBG2ZXI5YB1hxv1Bhb8c0VRRXXq7yJerbIO0+riWL/ISfa8ECKxj4vs/DtexsA29LhlRCtBz+j/57F/GTpN/8WcznDo73a58OK9Ln6tfjPZpCslSvNJ+LWM+Ee+z5CSu+8Nup6e4Q4AhyQIP2CD/EYKurqmf1OFP0mXCxKHrcHC27yCJ+rG/K1F66ZROoTuUJfjvhUwgOZBaPXeAU8ygk3TG7kH9pjt9mgumH/UgrFjyl2KEem1P3rdQ3t9KynjKgNTtMshvrbOHWNgz8OD0EhLmSx7nCUztHu/4PoDSO5J+L7qnVfmB5k+LZEd6BlolnghsE/aq2VuBYZ11OtJJT2BJcrTsnrPO6iTgBVNqHqoYvAUmAE8zpUDhty1ohC5Xj+lqmPwEo6TRq0zx9eYsIS9xYnnpRPXwpaMmnAnD9TYwL8HYpt8WkpN1lz0GErAoJXfK9tqRa4KCokYZbPWdr2kQ4+q9X1JJ/2wQYW1EByoiDyaAGPPKiovHETMOnuY6YPQAPsoXp3lyPEYPU/snTjn6aHSnUuFeFbeBBeMeKJnP2b14G8OGZACw/yvn2Ybeju0sQ/kys3M
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(39860400002)(346002)(396003)(36840700001)(46966006)(40470700004)(40480700001)(15650500001)(2906002)(8676002)(70586007)(36756003)(82310400005)(70206006)(110136005)(5660300002)(103116003)(316002)(478600001)(6666004)(41300700001)(26005)(8936002)(356005)(86362001)(921005)(81166007)(83380400001)(4744005)(40460700003)(16526019)(2616005)(186003)(1076003)(36860700001)(426003)(47076005)(82740400003)(7416002)(336012)(36900700001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 03:56:01.6512
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2141f2f5-9c70-4201-9af2-08da85848fa3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5923
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Updates binding document for the zynqmp afi config node to handle the
PS_PL Bus-width and resets.

Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
---
 .../bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml     | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
index f14f7b454f07..9504665cad95 100644
--- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
+++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
@@ -59,6 +59,13 @@ properties:
       controller.
     type: object
 
+  zynqmp-fpga:
+    $ref: /schemas/fpga/xlnx,zynqmp-afi-fpga.yaml#
+    description: The Zynq UltraScale+ MPSoC Processing System core provides
+      access from PL masters to PS internal peripherals, and memory through
+      AXI FIFO interface(AFI)
+    type: object
+
 required:
   - compatible
 
-- 
2.25.1

