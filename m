Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0ED6A1BF4
	for <lists+linux-fpga@lfdr.de>; Fri, 24 Feb 2023 13:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjBXMJ0 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 24 Feb 2023 07:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjBXMJZ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 24 Feb 2023 07:09:25 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D3D3CE27;
        Fri, 24 Feb 2023 04:08:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDKeZAhKKvDCvx7l1DxZ6Gf5ndWvVuhWSeXEfk1hmiQncBkCaPiO1RbbCQsUos6Y9NG2a6ms/Ghz2t3X3WwCfFCo3NYcP7iQkq6R1FAXl4cgUX5GREud57FIU8XV57xeUkanblnpUzeNYweL5wiyvkpel9PnqYZmmq40siQsR0ixcIuT4R19K/HM9Ub9yk3SAWbYIuSQY7+mWf9rnGewLivpIKDnLLM2RsEQ/pNC8DyT8q4C3GZSrS+Oa1okX5XY09zRGjfaPHJILasykDVqfNFKa4fkS7JHbYpEx/5YUG4+Mcx7fcjNqV7wELx+FMbuoTmrNfvolMbhmpeU4UGZlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AoizO9eci6dcpXEEUNLH8cgwfZfC3SKmptBLI1Zrz4w=;
 b=J3z502IBoseQEqWtZFe8h28EsA2XVq72Y/Aqvy0BbiUWuRnOPb2Wnu+XKXbapQPmJ2JmftLxa3aaK+f7xiiVqN9iIEgeR/eK4z4R1aUuHLXK7k82ie7vxpx/LPvBPd+esagK9xecJxd16WJyTNonov2ISwMZ6DLgjDazCaMJVb+5s0LYw/+8m3winoj2lly1Jo/X8xiyqutInqUdsPxAw4hKl3sScasxzwmw9IyrUxHdCBJ43kjR9r+Ri/Zga4J05MI0bfztE79ghnaOj158zSu+iMAfKuXCQB6/P11E2sq+NwynNQc748L0/jlTsGteq77ZqP7huIuD+zi5fwbqTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=xilinx.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AoizO9eci6dcpXEEUNLH8cgwfZfC3SKmptBLI1Zrz4w=;
 b=eoiltb5qLe6qPduJqZTO+SAfvtLzwoAL8Z4mFfYTZeVXn5GxW39KY3aIxiVE0+raeEu+Q82vYY6yxzXFTXNXAKE1JIcCZnDV56IdEHS+xdPArPBGPawtEEQhti84cXwCj/JjxS5E4QuXG9aAvfPS3hIQY5sIjMXfnDgK7XLnQfQ=
Received: from BLAPR03CA0174.namprd03.prod.outlook.com (2603:10b6:208:32f::11)
 by PH7PR12MB6788.namprd12.prod.outlook.com (2603:10b6:510:1ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Fri, 24 Feb
 2023 12:07:43 +0000
Received: from BL02EPF000108E8.namprd05.prod.outlook.com
 (2603:10b6:208:32f:cafe::d4) by BLAPR03CA0174.outlook.office365.com
 (2603:10b6:208:32f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24 via Frontend
 Transport; Fri, 24 Feb 2023 12:07:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000108E8.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.16 via Frontend Transport; Fri, 24 Feb 2023 12:07:42 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 24 Feb
 2023 06:07:41 -0600
From:   Nava kishore Manne <nava.kishore.manne@amd.com>
To:     <michal.simek@xilinx.com>, <mdf@kernel.org>, <hao.wu@intel.com>,
        <yilun.xu@intel.com>, <trix@redhat.com>,
        <nava.kishore.manne@amd.com>, <ronak.jain@xilinx.com>,
        <gregkh@linuxfoundation.org>, <tanmay.shah@xilinx.com>,
        <mathieu.poirier@linaro.org>, <ben.levinsky@amd.com>,
        <rajan.vaja@xilinx.com>, <harsha.harsha@xilinx.com>,
        <arnd@arndb.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>
Subject: [PATCH v7 0/2]Adds status interface for zynqmp-fpga
Date:   Fri, 24 Feb 2023 17:37:36 +0530
Message-ID: <20230224120738.329416-1-nava.kishore.manne@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108E8:EE_|PH7PR12MB6788:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d82f2db-8b8f-464e-c710-08db165fbba5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fm4hcz4F0P/jE//eqVu1th1f+XUFndVBhCM7u08RithGkS2664Nhok9giyC2+XKDlvgjXUFlgBgPSQ5yA8ZAKzLY4gG4hpvBlnYdSDZOOFkWvm0FzNu/3NYgQCVvX6W5YqsCpd7r+TSpySpBANYEKG1qW4srfFh8CrdTkCAFPBCOQi0eyrvg0y7iGrfBQSxYKBYpcZ9Xdl3LDBESoP0xnZ/o80f3IdFhP41VJC2yDwJEp28RvP7pXbwQDD0i+FchKCpddq+AHzSg+xLKDfhFFUs1UB601shRjcWeX2uHriywKG+jrHaO5LsyPOzgnbfNFTHKTZ4OCfTIuKjpckd90ObuwQZZvr95mpX8aCqnDhx9aghSzP+JOJhAegQ9ZMPHfXLfjGyxqTcaqnEnk/IjiH0XP8CuX/OaU2jhxQZpKjSXOovQ3KnAbyvE3wrFFOlgFjKtXz+CtHBnuRkJ74QLo5rHSaO/nPy+oGOyZeA0HBxUDwQOrhf4QqBXhGV7/pgS8CKIXepWnZXM7jUYaeK2yzH70PIc6n8BmMDEnwPcLBtkc0bQI2Dgzi2PSBjoPQeEnOHIX9ud+z8fxjPUg0JNOqtlh+/3PAlKOV7XYYIaeEn9wLBwsIXRFvBcSXXfi3U0QpfVsGFcsBTiPPvxmlImeFjitInvx9lPeALFdrvug2OV1fmIGyOGHfwQLSidYHyjM5KKV7sV1iQVTzVZ1F9IlhHih60NdvSmhUGzwUeOMwu/mrw6hk2hDGpR/LLME8nDe8HAsEBGJjXI8MNOdwfqAktBRLCc4qOxVuia8pJaCu0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199018)(36840700001)(46966006)(40470700004)(82740400003)(81166007)(316002)(186003)(16526019)(41300700001)(336012)(26005)(40480700001)(36860700001)(4744005)(426003)(356005)(7416002)(8936002)(2616005)(103116003)(5660300002)(478600001)(8676002)(70586007)(1076003)(110136005)(47076005)(40460700003)(82310400005)(70206006)(36756003)(86362001)(966005)(6666004)(921005)(2906002)(2101003)(83996005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 12:07:42.8496
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d82f2db-8b8f-464e-c710-08db165fbba5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6788
X-Spam-Status: No, score=0.4 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

 .../ABI/testing/sysfs-driver-zynqmp-fpga      | 73 +++++++++++++++++++
 drivers/firmware/xilinx/zynqmp.c              | 33 +++++++++
 drivers/fpga/zynqmp-fpga.c                    | 21 ++++++
 include/linux/firmware/xlnx-zynqmp.h          | 11 +++
 4 files changed, 138 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-zynqmp-fpga

-- 
2.25.1

