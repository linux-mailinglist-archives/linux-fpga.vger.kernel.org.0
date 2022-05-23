Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B101C53146A
	for <lists+linux-fpga@lfdr.de>; Mon, 23 May 2022 18:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236489AbiEWNph (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 23 May 2022 09:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236464AbiEWNpg (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 23 May 2022 09:45:36 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB4955363;
        Mon, 23 May 2022 06:45:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEe+cxWulmnFxC8vYId8KKQFfEJ9HYG8i0LAJEZbc3HCmlwogw0XBC5IHs2p9LmO7bdTxGgpGIUFutqeLykxnl/afdakMApG2jEPSJymKoeRZSuwfy0TaMQkQiasCn1GVDbJCByPHi/0IxTX/OLq2M2HcdNkNd7EyBBaz/kUi/8yNIJdS8eiQLQ8gZZXN7W3ZWiPuAx7vzDDGeH4oMzlWYKChpqgRP88kGL10QQvGbUpK6PPo5ckml3UXavc+hs36QtKLOgyU43+alh9hMV3nDeO/q4h1lGMjYaC2crB5wqqMk977hIicUbVkMB53hvD4Q4pR7A44t5yJGSdDljNFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0SuB7HGd7fqPsSH+bLG7zb4karOvuz+JyBZtFtk/xE=;
 b=WMwkrVNNZIqf87/Q7mYNt16uEmXvKcLV8T+DYTKbZAH5/fau9z/Bx0yQTnEQ74tAeAZWrx5OHDsVLFBrT6UM3iXk5ABR8hE+JozI6YL2z1TAm45f9fPhyGbZ9ei/mQqyvk9NWRxsLbl6A1a+6FZVtcwpLyPfrfqiqXvXjIKn8eRr48RT9E3kZ4GsNWYbgB5V6u6Sl7JAIYMvpZv4ICz2WJDyPuzFSnkGkvYrvJQoytw0AoJiUxrwh330n5k/rzGfE4yeqimpmYJ0BQAksx7x9gixDNJVoXmdFSseZFi4EWor1MZVOKs4H0tGVBBfMGLqWbS8fCSWdofKvnp7vQ8Xxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0SuB7HGd7fqPsSH+bLG7zb4karOvuz+JyBZtFtk/xE=;
 b=DbPRr/7Pi2lQjMTjKcE1y2mZXhp7KHhZkugb2QHxZpC6dP6sP2p/AavXUqja37/EGTEyHLEv9Cp4iyOJk4arEBi2Y8oG3ccfMsjU9bDYsmORhSl6V9lfSja0zGZ5Rj93LqdeGaRWl0Ujq8rnVooozZB5OrqcVwvGHCSnwF1ApV4=
Received: from SN7PR04CA0163.namprd04.prod.outlook.com (2603:10b6:806:125::18)
 by MN2PR02MB5773.namprd02.prod.outlook.com (2603:10b6:208:11a::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Mon, 23 May
 2022 13:45:33 +0000
Received: from SN1NAM02FT0046.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:125:cafe::10) by SN7PR04CA0163.outlook.office365.com
 (2603:10b6:806:125::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14 via Frontend
 Transport; Mon, 23 May 2022 13:45:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0046.mail.protection.outlook.com (10.97.5.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Mon, 23 May 2022 13:45:33 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 23 May 2022 06:45:27 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 23 May 2022 06:45:27 -0700
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
 linux-arm-kernel@lists.infradead.org
Received: from [10.140.6.60] (port=57798 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1nt8NC-000GwK-OF; Mon, 23 May 2022 06:45:27 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <michal.simek@xilinx.com>,
        <nava.manne@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@xilinx.com>
Subject: [PATCH v2 0/3]Enable PM generic domain support
Date:   Mon, 23 May 2022 19:15:14 +0530
Message-ID: <20220523134517.4056873-1-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3954124e-7a71-40c4-5ede-08da3cc2823a
X-MS-TrafficTypeDiagnostic: MN2PR02MB5773:EE_
X-Microsoft-Antispam-PRVS: <MN2PR02MB57739CB46E054C16DA49F79DC2D49@MN2PR02MB5773.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sizSRSGWn8WbWEDh8rxmFLW4/+SS5sSBmPWlZwQ/REVN7fUK/Y/MQUtQrtSPMPcfCgMZ1Ic+iM3L/az0SZ7j3EjmAC4n0nT5P0s62GXeZWuirOD/1yq8jgHWmdOinNERnlbrovY//kYhEjRw6MjfRkZ9gaV85fpdCBauEAjQe/DJ6rKkE7TilWHxyvFpmsEgf2SZp3K8djEKe7u1dcocurik0vsnOuOtB3E38A20BDaTYfxBjICs9XWRIaQqX+RdNcEXn48XFhVuo11FvkNqcsV55GJj9F6P6eH/vZKImx1jz9O79YFyNpVh7bW960W1F4e5Y8GgJNgR3JkqHQglKk5L8PAs0UHaAkKv2K8YxBqjBYTJbm1i+pXBM3KUdyFeFvNRnatkUQc9Uf0PtzKLS6PQZDZWBqOy64ktH3Rab9O5Flohy6cPmv1CsEesc1EP6yOXsVbm98QQiQFbqbUDjMTo20DX9asttybGGZU59vvKy6mNu2f85BwCHpL9Q7alwDcuuYdk8OADjCKrUJT7ZZh1/DWykADz544C62py3+mgmMwdSO29p2b1B4jk1F4k4qX4dPdyIWD0PJL5J8LDIfUmV1o3/UQotSVdJRPq1wNm4zVhO7K16S2YBgRpcF3yDh6XTcMerdXTY+DQ4WsziX2GEsy5Y/GRj2DIuhrt5xElhaqJsjmm0TvBg7e18Hgn/H9/j3SAyIbdxiovt56LArRNqXGwE+FcUNaRZr86bO4WuCCd1X7KM+DU4LUTb9ywr574UfRz96DKFjvV/quX6BHdHuu6jBP9UJDQ2j5vJxM=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(9786002)(8676002)(26005)(8936002)(316002)(82310400005)(70586007)(70206006)(7636003)(186003)(336012)(36756003)(47076005)(426003)(40460700003)(7696005)(36860700001)(2906002)(6666004)(508600001)(356005)(921005)(1076003)(110136005)(7416002)(4744005)(2616005)(6636002)(5660300002)(102446001)(41533002)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 13:45:33.1750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3954124e-7a71-40c4-5ede-08da3cc2823a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0046.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB5773
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Adds support to handle FPGA/PL power Domain to optimize the PL power
consumption.

Changes for v2:
              -Rebased the patch series on 5.18v

Nava kishore Manne (3):
  dt-bindings: zynqmp: Add new PD_PL macro
  fpga: region: Add fpga-region 'power-domains' property
  fpga: region: Add runtime PM support

 .../devicetree/bindings/fpga/fpga-region.txt       | 14 ++++++++++++++
 drivers/fpga/of-fpga-region.c                      | 14 ++++++++++++++
 include/dt-bindings/power/xlnx-zynqmp-power.h      |  1 +
 3 files changed, 29 insertions(+)

-- 
2.25.1

