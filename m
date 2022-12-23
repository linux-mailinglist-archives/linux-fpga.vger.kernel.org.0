Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F15654FF1
	for <lists+linux-fpga@lfdr.de>; Fri, 23 Dec 2022 13:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236190AbiLWL67 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 23 Dec 2022 06:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236196AbiLWL66 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 23 Dec 2022 06:58:58 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351D32A51A;
        Fri, 23 Dec 2022 03:58:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SEQ631FeYKYXY7B2Ec0Yio6DD0wxCluUXV2LF2Oz9aVPk/fOCGkEX/7MFG/dUHqi4wPLdaVoCge+1UTutSZlXO8hsD3knTC2BrKc8HP8GOXo1uty7MpsP+uvqtRM4eVMxR5baOvPPEC09/PVDz+GvZUsdpNUWSG7shzyKoD++RGrMwcZ1q3jfdNLM2s6+//a/qQnfviWiPKDY3kq1pjZy2984gyCUVZ8NxmkhVfnCAVJm328mti9yytcWIASgcmLq1HOdZVo029YWKcHK0xddqwdUdRG1c29ZIwia+0+pBkovK+mhnHTGclL4LL8A4VA9t85+NpoLUymMFaTHnwczg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFI0vTJgcbO0NK3OpvzH8+7HeFCmRCzwGBNiZMeGkGQ=;
 b=Gx5jELZr9+RFQVxwXY5XJ9h9QHHuTRnQHvqKvKL1jNjHdKFCIOeSx36qBfyvG0uQPWz+Yp2cp4XcKDPgTDU9978dYGqqk8U5P9FvdFa5pZ4T2XbKNw3KO2eg4+XrtUyAZhwk4JI4+rG6LBjDRTTrONRb3Ojh7bzNUAK/DCEZonbZIMqi68svln40yvVIZNhvTqy7Q6rfDAyXcwbBL0RJoJMzRhfe8zQB7ZLpQWUaYodT1DTAMDnLIugjFeF7V78yQBkiBzHBaEocq2b5omJw9wBQ8KRf9HM80g0H+weUo/9ETeCiIlio9THriQbokjzvmyoZ1gP9hE99ND3sK2LFXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=xilinx.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFI0vTJgcbO0NK3OpvzH8+7HeFCmRCzwGBNiZMeGkGQ=;
 b=St4GLlEIxoqs9bAUtsMj+sRX+SUiiO70BKYt2CAjpdp6FpizRfkFBUZEAPJAcXsHrBnikphCCwaZ1r3bRSGzeB/dxVLAiqDOiHk6EYQNifh1BWUP5C8aLM1/D4XsbLzmB3g00hI9M/7GS2+SB5Dhb/BqDD3ofLQPDPYVE9CgZE0=
Received: from DM6PR18CA0010.namprd18.prod.outlook.com (2603:10b6:5:15b::23)
 by BL1PR12MB5945.namprd12.prod.outlook.com (2603:10b6:208:398::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Fri, 23 Dec
 2022 11:58:55 +0000
Received: from CY4PEPF0000C970.namprd02.prod.outlook.com
 (2603:10b6:5:15b:cafe::ee) by DM6PR18CA0010.outlook.office365.com
 (2603:10b6:5:15b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.13 via Frontend
 Transport; Fri, 23 Dec 2022 11:58:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C970.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.8 via Frontend Transport; Fri, 23 Dec 2022 11:58:54 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 23 Dec
 2022 05:58:53 -0600
From:   Nava kishore Manne <nava.kishore.manne@amd.com>
To:     <michal.simek@xilinx.com>, <mdf@kernel.org>, <hao.wu@intel.com>,
        <yilun.xu@intel.com>, <trix@redhat.com>, <ronak.jain@xilinx.com>,
        <gregkh@linuxfoundation.org>, <tanmay.shah@xilinx.com>,
        <ben.levinsky@amd.com>, <harsha.harsha@xilinx.com>,
        <rajan.vaja@xilinx.com>, <nava.kishore.manne@amd.com>,
        <mathieu.poirier@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>
Subject: [PATCH v4 0/2]Adds status interface for zynqmp-fpga
Date:   Fri, 23 Dec 2022 17:28:48 +0530
Message-ID: <20221223115850.2572573-1-nava.kishore.manne@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C970:EE_|BL1PR12MB5945:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f763756-2494-4335-3582-08dae4dd1104
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l89YQ7MprlMeVB9TDvFzgZfxz/KBfajLDnBIpXwxBxVE6ZwXvZ2PaQ3GMz18H0nNtGx/I2WfLL6uoP9cyAAcXYqkYWaYkan0oxg0ErznJi+XYnUAi7PjoLvN2ghOklR+u2lJcIv+eLb31wA5sG6ibrwe7dP9QtGXFxVjPZSgTapr261Sb6X3hwYviIUu2204fFBnC5Ql+wVueIok9tS7btlek6haK/+N9ZMNPdCY/61wlQaFVWJgh4N876VAQXGMRgXjFSPy+MMQ20Q5J13+l3eZDlYbtGJa55tuoSo1pwxujqF5ke1MboBJXjrdqRdkTdRdEInQp/RPEzO5FZL03xFuXoa4bUAiFAndgvE+R/mt/SI01i2hd40AjWCAKtZ9GoQf6A5CdatvEAhs4N8s+CuFi0VZ5+3NZVWKMb4qqKHxko2BEU6zewFM8CFvA6ijVdyAUQblsv6v5IQhVDrIrI1uJFAOF6Yxpz2u371gwz8wZGN3btU7/QhySEPGjSZRwUTqycKann/fN2hqHnIux20NZgH2uLdn8kccJvafzrGgLXpNjOQEQ26552mSypxu83BZFhtYW44IfFeS81PF6VrvZa5yRIzxW0WSKJvdIei8TTGJwiM95oGWn1QLOV2jo6JlJHXyQeEFkkxBlCUzcby3T5cfRgt0loGY9zk3d4oobnrKzlwE1xNWLguqXjY4aBRKKK1+xpgGhPpsPZffjhqnHz5goi3tsonaDz3JBfs86z0wGKqtALw7zDKQm6WYz8W72JrHwFswwQ2RFFWy5eSDYEHFVQPmJEDNQ0/gQ6LZ1xGNIRsA+1GwO3IBTfmEsGGceEDnXFHr6lgMhPv6RA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199015)(36840700001)(40470700004)(46966006)(336012)(47076005)(186003)(41300700001)(316002)(40460700003)(8936002)(8676002)(2616005)(110136005)(16526019)(36756003)(70206006)(70586007)(1076003)(81166007)(82310400005)(356005)(921005)(36860700001)(86362001)(4744005)(5660300002)(40480700001)(82740400003)(103116003)(426003)(2906002)(966005)(478600001)(6666004)(26005)(2101003)(83996005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2022 11:58:54.9646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f763756-2494-4335-3582-08dae4dd1104
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C970.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5945
X-Spam-Status: No, score=0.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Adds status interface for zynqmp-fpga, It's a read only interface
which allows the user to get the Programmable Logic(PL) status.
 -Device Initialization error.
 -Device internal signal error.
 -All I/Os are placed in High-Z state.
 -Device start-up sequence error.
 -Firmware error.

For more details refer the ug570.
https://docs.xilinx.com/v/u/en-US/ug570-ultrascale-configuration

Nava kishore Manne (2):
  firmware: xilinx: Add pm api function for PL config reg readback
  fpga: zynqmp-fpga: Adds status interface

 drivers/firmware/xilinx/zynqmp.c     | 33 +++++++++++
 drivers/fpga/zynqmp-fpga.c           | 87 ++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 10 ++++
 3 files changed, 130 insertions(+)

-- 
2.25.1

