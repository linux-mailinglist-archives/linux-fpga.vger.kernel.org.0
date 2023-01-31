Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3009682976
	for <lists+linux-fpga@lfdr.de>; Tue, 31 Jan 2023 10:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjAaJsh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 31 Jan 2023 04:48:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbjAaJsX (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 31 Jan 2023 04:48:23 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2080.outbound.protection.outlook.com [40.107.212.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B62B8D;
        Tue, 31 Jan 2023 01:48:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S11ZSr+uw/UvcLo+4OTlHANdZRXO1vUUKvoj0Pkve/1sHRnmimB6+fmxcBZeyPc4OijEsaC1L0Jddydh5AqIrHeOQexm/60VYtkCa7T/F5aHkgcj7hFxpl9F/FddP4qILZujDuM+UHWPiojZv7NhwdMaO33q6ogZKda58ksOZxcU7tahu+fGedvjYtBeQ1TwNUvWg7uGyLyH5TGhOxM4WDel950t4ONigwfkZULXe1nHUadvVUQyOw178RIzr/669zN5/j6kSdIn1IZCCirhM5i32OtmV1fc9kinDDcfVACEisJ0SlOF+8cobNyO6vTX3rmPbAyUuserbezD5MiRJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3h7A/ppj3hFp23yi1sNcytB9Xw/xMpyQ7aESTjzKdK8=;
 b=KPmzDzm4kL2m6ffeMPGNAUvYourmyh9fFWrkgWCj87tf4f9Es1T9U5LvN5pEs8WXtsD05DBJf2UxYyggRH0G1rhmGse9GM/7PbckhklRNAHA8PzyWnpBPBXuNH4t81APNwWkT9qWLTJFlwxIbH/2Y9TDZ6gS1fxappUgJEN3kdZhw24TNVuCt/4fT4Ocj3zfOnUYu0mBTmcT79KgrTHMdoZtJLml0gqlhCOM97+Hzi3p5dniTfHtulhhnWFFJYPi6M2/BSnyTsUIZ+vLn9YEMYGpDuLIWJjPAjYa+d4G8wvOlPhFjfhnq46DP9YStgmyTOWkp7AoE5eTRi2+RT1eug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=xilinx.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3h7A/ppj3hFp23yi1sNcytB9Xw/xMpyQ7aESTjzKdK8=;
 b=0NQ40SBdZJ3VM3fuyYx8gJs/j0kccJlWLXgrsY/JIsVprwPXOhm3kC0uKLxeW5oRFJklhBEFY1/7qk6kAt68CalW82u3xpJOY2XxpbImV0WqMUfMQlPj+TcK6FuDYnz9i7DOCl5CCbIfjeTZeMS++cvPOaOsMf5gk1V7oAwB3QE=
Received: from MW4PR02CA0013.namprd02.prod.outlook.com (2603:10b6:303:16d::13)
 by BL1PR12MB5238.namprd12.prod.outlook.com (2603:10b6:208:31e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 09:48:15 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::45) by MW4PR02CA0013.outlook.office365.com
 (2603:10b6:303:16d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36 via Frontend
 Transport; Tue, 31 Jan 2023 09:48:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.17 via Frontend Transport; Tue, 31 Jan 2023 09:48:15 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 31 Jan
 2023 03:48:13 -0600
From:   Nava kishore Manne <nava.kishore.manne@amd.com>
To:     <michal.simek@xilinx.com>, <mdf@kernel.org>, <hao.wu@intel.com>,
        <yilun.xu@intel.com>, <trix@redhat.com>,
        <nava.kishore.manne@amd.com>, <ronak.jain@xilinx.com>,
        <gregkh@linuxfoundation.org>, <tanmay.shah@xilinx.com>,
        <ben.levinsky@amd.com>, <rajan.vaja@xilinx.com>,
        <harsha.harsha@xilinx.com>, <mathieu.poirier@linaro.org>,
        <lakshmi.sai.krishna.potthuri@xilinx.com>, <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>
Subject: [PATCH v5 0/2]Adds status interface for zynqmp-fpga
Date:   Tue, 31 Jan 2023 15:18:08 +0530
Message-ID: <20230131094810.1945541-1-nava.kishore.manne@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT065:EE_|BL1PR12MB5238:EE_
X-MS-Office365-Filtering-Correlation-Id: 95c0fd56-44e3-4a6a-58d9-08db03704636
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Aho+ntIXA+X3id3q+FF0S4ZmPmmf77aRufLdC1AYyne5FcfCo32CUn7ts4/C3W1+S97HcIAe5Lv2wF8VKiAiqVGFR1gF15CIT92Z9RWEf6NJ2Wx/7YR/OjRpuQaT/c1rp69oWqckcPWnOzVrHKVKc0E3FI4qK78W1y+Ql88xsv7k60KiTkaoFlXylInXzHRJIfkKJOxUxuX4oukQ1Jm8fRwZLoIdHw/ZEq5kHijRvC3ElWsJKUdsEWQB/AE3cx1IH+dFDDoiVhf1VRWfU3Zfmg0O08WOjEzrw935yVckuLOyUqRpgHrMHH+g/anGskRZHx0wP5sLmW8ELTYR3rm+ugwyotcpGr3NoTCU16hgSKDyFOEtiltgIK33q/RM/BwlvrZse95GWcl/Q8+CjL0BTZncCTqHR+t1p5qdDvkDG7p7gPfZt0iuX6jE//HArwV9jMHtKK+D2e/wJ/m6zOV9npVo+7Wmn+6+F1+FAu2fMp55udtSn/XC7kGRldjvxsbLL5RpI2GxlTOEFu7aU6ty1/RCwBatIozQjofFtRoawf9r1Xi6BVlVyFbo/hUadPJS9YfV6UFc68cC781RVIvvJTSiHvY3FHUmsttmTErFjJBgK3Pox2CISNvK6raLubfJPgkZaX1WCGJhyPVmBdBvllj2eL6evGSE1EBOnRmGuw96uJDXw8WXuxqq3XCK9NgVTtPGmR5T24UgioZQS98laeM5M95Xg2FCkSgKtFuOJGxXYyGzBD5fGbFlBkS9NJe5hRaQMQS0cjMes0jbmWk6tvfcBf950vYXFygrUFUGyZpDe6rxP+pwVzPWSaQQKptX+s1YW2FBdS/Tzl7kj6BSRg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199018)(40470700004)(46966006)(36840700001)(36756003)(70206006)(316002)(110136005)(82310400005)(8676002)(7416002)(5660300002)(70586007)(41300700001)(8936002)(103116003)(86362001)(921005)(81166007)(356005)(82740400003)(36860700001)(6666004)(16526019)(186003)(966005)(26005)(1076003)(336012)(426003)(40480700001)(40460700003)(4744005)(2906002)(47076005)(478600001)(2616005)(2101003)(83996005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 09:48:15.0682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c0fd56-44e3-4a6a-58d9-08db03704636
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5238
X-Spam-Status: No, score=0.7 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
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

 .../ABI/testing/sysfs-driver-zynqmp-fpga      | 18 ++++
 drivers/firmware/xilinx/zynqmp.c              | 33 +++++++
 drivers/fpga/zynqmp-fpga.c                    | 87 +++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h          | 11 +++
 4 files changed, 149 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-zynqmp-fpga

-- 
2.25.1

