Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D2669AACD
	for <lists+linux-fpga@lfdr.de>; Fri, 17 Feb 2023 12:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjBQLuq (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 17 Feb 2023 06:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjBQLup (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 17 Feb 2023 06:50:45 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6900C66CD9;
        Fri, 17 Feb 2023 03:50:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VlcXEINpgoIIsTC+RIV0P2zAcbO4segkrFXbOy0CCBxsOD5QeAly3havZig1uimFnnXn4VURI6MJ9RoXiMclch9+a7aTj1CJDTSjDjMAZpqloc11Om0aNWNS518R+YNdS4J2rx0AT0AL5Qg+1kb9guWuMZyYej27y/+Gj5JTr5lqEQGsMi+UONGklagWl4HkuxO51kGcwE97MIP3aSFobQA+mKZ9oDJBY2iw/BblGO/Rt/Bx/u8B6vrhDRiVuE9brEVA+BziPVeJ7AOuMuuc+X7F1+xMwjZUh6HLk4O+m/DtJXlDo7vd9HtLweuR2VKJewgJBDrjVHt+znETtqaIBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLdNlju/VXDC5VOBg0oOoI+m2ga+yiCplVGNdJBY3QY=;
 b=n+6PhkYp+M4sqRvdq3GZ4cG8earb+WEABRxdJiaux8cUOgTjn+m8r7d/r+uKt1koaLUDvBw7ZVDi0OIMHirCuV5h5NGyZHNklSFpeMOCk5km6iEG5/gIkEkg/y5j2HD2ufD0wLMMUD44whv1ZaTO46tMKNGg+PiE42fsB+1Q/DOs/+jdQAtdz+XnoQnV28aId0gTVd6JjdS0a1lQtZPyF/hzP96eRX1Ry69t6+2XZ5OBFsviftMOu8nqwSzGMMcrF7V9ZnvSSys4wQ9PuFpn028QN1SyBWVk/FPCuG+ubCOsKDtnXhavzEj2mOKpgenYK/jmScjYSkUPliSgeWmQLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=xilinx.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLdNlju/VXDC5VOBg0oOoI+m2ga+yiCplVGNdJBY3QY=;
 b=llyDLxQKgyEpn03nmeyvvxQZyoKyviRsQ7xrc1lCMAf5GP+U/FbVUPFPMKW83E5P8hb0o9Z88QAr5QMBC7b4pJxOpQgx0pf/th4gdFQGTfiK2WjzGvdmM5+CizH1JifPxLeDaVxBlKZcd9UMgfv18eXbbugqmUMRVaHhMlWZ01E=
Received: from BN9PR03CA0973.namprd03.prod.outlook.com (2603:10b6:408:109::18)
 by SA1PR12MB7125.namprd12.prod.outlook.com (2603:10b6:806:29f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Fri, 17 Feb
 2023 11:50:40 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::eb) by BN9PR03CA0973.outlook.office365.com
 (2603:10b6:408:109::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.15 via Frontend
 Transport; Fri, 17 Feb 2023 11:50:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.17 via Frontend Transport; Fri, 17 Feb 2023 11:50:39 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 17 Feb
 2023 05:50:39 -0600
From:   Nava kishore Manne <nava.kishore.manne@amd.com>
To:     <michal.simek@xilinx.com>, <mdf@kernel.org>, <hao.wu@intel.com>,
        <yilun.xu@intel.com>, <trix@redhat.com>,
        <nava.kishore.manne@amd.com>, <ronak.jain@xilinx.com>,
        <gregkh@linuxfoundation.org>, <tanmay.shah@xilinx.com>,
        <mathieu.poirier@linaro.org>, <ben.levinsky@amd.com>,
        <rajan.vaja@xilinx.com>, <harsha.harsha@xilinx.com>,
        <arnd@arndb.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>
Subject: [PATCH v6 0/2]Adds status interface for zynqmp-fpga
Date:   Fri, 17 Feb 2023 17:20:34 +0530
Message-ID: <20230217115036.2617396-1-nava.kishore.manne@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT036:EE_|SA1PR12MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: c7cfb536-4855-45ae-78b0-08db10dd3119
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jNx422BpzxaMSuVEOGf8X+R6z+y1396JNAMqSGE5neq4IPRsLcOK5wvtMnwiT+kcmzlrBFIkEhQ6DQHYez5iiRTC8F09HbOBVYvQlVuxC1nPO+B6VApH7rNaBta3jCpncAGzRgwoeBIxsAzEQ+UjniNw5++Th8CcEX09Ylew4xjpVZqAVSWXCq91eKq4JBV5IzwlzKvYQ2Nt3kTKSU9FfJ2KzKPtSkgox0kQBsn2AbQAH1gp08msX+dd3UdJKtM/Co/+3a0ckry0MDfZh6q5ESBjFUjwbAfsk9t4H3/3j3kfUBMvoewKuYGdkek7N9uKaD/IGsMAP1yEvFgsoJpFMs/IqMfbrlwRiyhsX8jeG1Q13yEOj8rhGaBVJrv9l8fw+8ndpyh68Jhq87zhjaYYIw1gX5fWc8QqugVtULzY1LRVZOhvFTYDHWHQqx9EdcDvM8PjVBvPcFRGkx8dI7nsR8CIB2ak6P2kQQOTN+wUdotwMh2DeoulT+ntn/Y7AfGXOngPDXjA3rOyYpGmzYbhkyj8YmRA6gIsqKTKvZ4rwI71Gejo7tXgjifhG0J3taHmr8KD5wvJ09WuXkaOxzqpNgCD1WRpM5MwYqWH+1K0Kymf9PVt9NZNh9eVhrJrFMItXncL/nDXi8akRa1XIl3fkxlQLkvwrGl9GLOMeTjQmeF93Vj9JrZfkuZ2M7WoP3b+Bkw+XPcghikpWu5hs4tEYSimAalSLe9qPG4SFVYjD9F/ONDeCULalj5ZeR71+IqG2NznsZN5rd8oHm9nmE/F4sb+cv1O5wTz5rORF4y+2ak=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199018)(40470700004)(46966006)(36840700001)(186003)(16526019)(6666004)(966005)(26005)(8676002)(1076003)(478600001)(70586007)(2616005)(316002)(8936002)(41300700001)(47076005)(5660300002)(7416002)(426003)(2906002)(4744005)(336012)(70206006)(36860700001)(82740400003)(81166007)(110136005)(921005)(356005)(36756003)(82310400005)(103116003)(40480700001)(86362001)(40460700003)(36900700001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 11:50:39.8908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7cfb536-4855-45ae-78b0-08db10dd3119
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7125
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

 .../ABI/testing/sysfs-driver-zynqmp-fpga      | 72 +++++++++++++++++++
 drivers/firmware/xilinx/zynqmp.c              | 33 +++++++++
 drivers/fpga/zynqmp-fpga.c                    | 23 ++++++
 include/linux/firmware/xlnx-zynqmp.h          | 11 +++
 4 files changed, 139 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-zynqmp-fpga

-- 
2.25.1

