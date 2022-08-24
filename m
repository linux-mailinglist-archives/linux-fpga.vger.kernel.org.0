Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12D559F244
	for <lists+linux-fpga@lfdr.de>; Wed, 24 Aug 2022 05:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbiHXD4J (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 23 Aug 2022 23:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbiHXD4H (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 23 Aug 2022 23:56:07 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A822B18D;
        Tue, 23 Aug 2022 20:56:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hz4fY7Wey0iTep57usoeu5GbfsBwgnnKPWpVWnNhn7PpYG5dTf5ugM5jHS3dXfm5phVJr7LdfWDVVY4gpThHSzxRK17jt0w5ljF5l/YvPosA7UZGyO9Tqs4oPEtfkGcFiaV3PLbzP2ul1zK4pJ6KkLngN46fKjRfWiGUidukhSSBEzri+LB2PN4gusf4eC/mI9S/Tbr+pkiq8Cv8Z1211au64q34ypGLeC6ip+wGYRK/AJ6PFgkme3cbGpNRrSdqh5OTYG/U518gA6l0/rPWh08m4UK6jjQvoqz/vwRU8WGRybjyAG6kajuN1e9lDMN+knLywCREqFb1QWZfZiL3TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2xqht7wLbThKdFSBdycgy1Bt3dIe66lnUe2B0kPQYY=;
 b=QDSq5NDLESwu/blzcV3ABA6SuZsEWBGv3rmt/T2YKYSnpr7CNmaXwB2+vJ/MhTKbmmZ6bqKM32EyxkTyBKQ2YxEocfhdNVvumeIKW5XzWvBOoRkCeyPckyGBAFFFtMYniVVb2RqClwJ9zEzS/efZTh8h9NGKHtHN1bLlNNs5hVN8jvjNrjL9QZ5RYur4rgtGqJ5YZMqXV+wJmYQ5m4A1pwJEPF1fyNvuhZxHSLbQQGSTh28+N3x/ghizlYUicB/AdrW7cGE11gMu5TVCkRoVazxwxnnqGuQwHlnjR9zavSOcOz9yPFlIBNsUknnWLTYXb/ZCTDz13Zn4v9aaHW3W/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2xqht7wLbThKdFSBdycgy1Bt3dIe66lnUe2B0kPQYY=;
 b=4a8JrkYApFRqXzCpxyUQ/B37OOAJx5lRE82pBgafqAOGLtA1c1XuEWxcF0XZnEF9+BFlkoMPLbxgXPKnFX2pD/lrmuEE/7hCiNdXGr7Li4xz3343Hiy9oyxBHWq8aouFPYErZuvo5ohIwKzCm7EYf/S6SMaHAEDCAA54RAzD0Nc=
Received: from MW4PR03CA0277.namprd03.prod.outlook.com (2603:10b6:303:b5::12)
 by IA1PR12MB6652.namprd12.prod.outlook.com (2603:10b6:208:38a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Wed, 24 Aug
 2022 03:55:54 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::72) by MW4PR03CA0277.outlook.office365.com
 (2603:10b6:303:b5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21 via Frontend
 Transport; Wed, 24 Aug 2022 03:55:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Wed, 24 Aug 2022 03:55:53 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 23 Aug
 2022 22:55:48 -0500
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
Subject: [PATCH 0/4]Add afi config drivers support
Date:   Wed, 24 Aug 2022 09:25:38 +0530
Message-ID: <20220824035542.706433-1-nava.kishore.manne@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a3feabc-86e8-415c-1447-08da85848ab4
X-MS-TrafficTypeDiagnostic: IA1PR12MB6652:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bLBFCxkc7D1p445wIthuCMVHM8VolVHxuTRneAXC5tJa4IqyccF+802oqf+j+2lJh7jqVogz/bptz3WuVBf70w1KqF3pBN3swcPPST/HAdqk4pCip1DmBUaRg3PxdYVROB35vPEMlozVjM4VpxEP7sIn3eLf+F4YJw87CeBdQnnEnI4UUEg4nyRr+7+i36SIwP3SGDUb+lBbBj1wmD1q4DPSAFrveb7/mYpgkwh0rDzNJB6C8Vq45TcOvRXCyT64EayZxM7ldbvixcobIfTQ18XGQCDGFEscck1Kj6ZRuZGVbD8EXUrwxbSARNUQVATCx2Qm6mjv74CvNcdWY2/yr/XeBIjRbxDVwsmD1BGMqc8/8ONCfeEUbGGNrGhBdjmisznlkrqP0u659d+52VRq++7oypmpKvqoHQ9KL2pCvoZc4cIrA1Q+7hhUE4mHJqcTXSjc8rDkah6ahIWusmeugHmRZv7tD+9xaBsMLWiJGe8PlesUYrPCKyszdnbPflwCQRGEJyLWFVC6bqj+6iQ+McPL3tGQsfHhjpaGd11TKv8MNi2JUO/JH4zWLnDPzrmbH2HaLcsI7cWhQp1GZi1Ylt0akPV9EHMwGHHX1aMP3UVVSQf23ubY7GJjbjLJ8cYcj0XWGWujWaztrNf6AJnAM1RbSi37Wz3vadsm1bh9csPSC0Z/lU/s9BKUVfs1p3LArnkLmHJFPaspysZVbD7VxzQ1bERYqFNkGFALlw3Czuh3Qu2CzirKgaP67+fjA8oNiGKYrhR8qnjvWSeBpnXyQpOJrWoAGkhnK2x5BDpU9jcpTlgINn7WUmK8GcOy5z6rbTZUbkx+yq3V8OnRf0MaFm6T+ZBmJqlg3SuLKwDEdbUJreMUx9aYnYkfWdwJiKXM
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(136003)(376002)(36840700001)(46966006)(40470700004)(336012)(426003)(6666004)(478600001)(41300700001)(47076005)(186003)(16526019)(83380400001)(26005)(1076003)(2906002)(5660300002)(2616005)(82310400005)(7416002)(40460700003)(316002)(40480700001)(110136005)(8676002)(8936002)(70206006)(70586007)(82740400003)(103116003)(86362001)(921005)(36860700001)(356005)(36756003)(81166007)(36900700001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 03:55:53.3706
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3feabc-86e8-415c-1447-08da85848ab4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6652
X-Spam-Status: No, score=0.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Xilinx SoC platforms (Zynq and ZynqMP) connect the PS to the programmable
logic (PL) through the AXI port.This AXI port helps to establish the data
path between the PS and PL. In-order to establish the proper communication
data path between PS and PL the AXI port data path should be configured
with the proper Bus-width values and it will also handle the PS-PL reset
signals to reset the PL domain.

This patch series adds afi config drivers support to handle the PS-PL
resets and AXI port bus-width configurations.

Nava kishore Manne (4):
  firmware: xilinx: Add afi ioctl support
  bindings: fpga: Add binding doc for the zynqmp afi config driver
  bindings: firmware: Update binding doc for the zynqmp afi config node
  fpga: zynqmp: Add afi config driver

 .../firmware/xilinx/xlnx,zynqmp-firmware.yaml |   7 +
 .../bindings/fpga/xlnx,zynqmp-afi-fpga.yaml   | 100 +++++++++
 MAINTAINERS                                   |   6 +
 drivers/firmware/xilinx/zynqmp.c              |  14 ++
 drivers/fpga/Kconfig                          |  13 ++
 drivers/fpga/Makefile                         |   1 +
 drivers/fpga/zynqmp-afi.c                     | 211 ++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h          |  36 +++
 8 files changed, 388 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-afi-fpga.yaml
 create mode 100644 drivers/fpga/zynqmp-afi.c

-- 
2.25.1

