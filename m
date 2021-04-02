Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961883528B7
	for <lists+linux-fpga@lfdr.de>; Fri,  2 Apr 2021 11:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbhDBJ3N (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 2 Apr 2021 05:29:13 -0400
Received: from mail-eopbgr760075.outbound.protection.outlook.com ([40.107.76.75]:23106
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235031AbhDBJ3L (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 2 Apr 2021 05:29:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nC2mQ2cQ7a+rcJv6TNQ1BkjgztOsNJ3ogOAubw0SwrMSiNf7eoyd2P0NBjEsQ+f7ezSM2Zzw8XxyW95eZo6vAXkGN57NFjGx30vnx6g/HGay2H7T2P0L5bUWvAhIu8wc0+W1EToRabPOaI/xYJnqLUSEXPbFuH6snPU4hF1Zglp+ftwTV8BeNCn39LSMxu6Vb28WC42XaL1YuazWwlFVI5Ew0becQ2TMJd9er31/d0ZQdnt1Epq6FuTwCq+e/Cj78oipV0ytCn9hJyBLCo16MJXDQx6otEUFRKBgygl7nl2ckiX3qcFGMak6Y1h4sHTxz0yGTwQKYK5xet33/nGbpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dn4w9LbwUzQ02dSwlnRezQDn5qUhoDWsl02tvFl1cTk=;
 b=he7OVI6zQLIm6IPy7toWsR+yvkjBSf4QU4//MVDq0+3uSuzg6RYnVl5QDxY50wpY2SJcqWxcjAM31zmcKN+6IsHhnrNxHJWkDK4Nnhm0EpuzV9juKGZEnol3xdxk5+EYpdW8Or2wspdPzud6fctsuk3364pzeHI2YUEva4t9tFfT3qB18mUue5NODpoym9CQ2RRDVd45Kda4VtiJroUww4mR24wONCLBMjHjtttU4Xt+HqQk+5guz5qSJ1/ikQ7CxA+STMq9+111ypxSmizQJn7zNm3JUM7i3ELLoIx4+tP7sVxhtdU+5ghKf8DJXQugSmkxotE/Xdod8W8iF9rogw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dn4w9LbwUzQ02dSwlnRezQDn5qUhoDWsl02tvFl1cTk=;
 b=pTJ2bzzP4zEUiCzYkjhDcCIrcop584InIhFdt79e99O1k9GgToJJBCV7DFue2ywm542KSFvt2VHd/Kg9njrD3LkrOY0NYX2R9Yf0NrqJMkn4Rn6Wky8yPKBSMq4Y9Vu1KRudBqpjiLXFbRYPrCAGHDh7/d1/bXjsnI/I/s+48b8=
Received: from SN4PR0501CA0142.namprd05.prod.outlook.com
 (2603:10b6:803:2c::20) by MWHPR02MB2864.namprd02.prod.outlook.com
 (2603:10b6:300:108::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.32; Fri, 2 Apr
 2021 09:29:09 +0000
Received: from SN1NAM02FT063.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2c:cafe::b3) by SN4PR0501CA0142.outlook.office365.com
 (2603:10b6:803:2c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.8 via Frontend
 Transport; Fri, 2 Apr 2021 09:29:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT063.mail.protection.outlook.com (10.152.72.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3999.28 via Frontend Transport; Fri, 2 Apr 2021 09:29:09 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 2 Apr 2021 02:28:45 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Fri, 2 Apr 2021 02:28:45 -0700
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
        id 1lSG6d-0005gX-Vn; Fri, 02 Apr 2021 02:28:44 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <trix@redhat.com>, <robh+dt@kernel.org>,
        <michal.simek@xilinx.com>, <nava.manne@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@xilinx.com>
Subject: [PATCH 0/3]Enable PM generic domain support
Date:   Fri, 2 Apr 2021 14:50:46 +0530
Message-ID: <20210402092049.479-1-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7a707ab-e292-4d1a-a755-08d8f5b9c4dc
X-MS-TrafficTypeDiagnostic: MWHPR02MB2864:
X-Microsoft-Antispam-PRVS: <MWHPR02MB28645354D3EFB04391B207F8C27A9@MWHPR02MB2864.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dWgiWKtZfeT5bgEMb1hMmSZGE3v9bKM6MA7cuTu5UZOYi/iggmse+aP8ixVdrgCoDbyapo2bkx8ZnzpGkM8uFsbZGvPcj1QiPwYzfAeDi9DwTm/yk8gb02cKxPe+2CYg7+GalKg01dhrqNFaju/cxWJvbVpKi/eUEz0jLnr9K1pdhZo7hn9STJkEWs/V7erVFN7reeM043ufRtFRYKfX4HhCo31VeD7O/o5Xn7KDixNjheJesn4ccpUFmPShSreNSYpU1I0FO2LxUEVW/Sxl0MdWN0usIHHsx9mcywjsmnyUftM6l5VCXppM2F4OQUaCbt1mUCOjuxhjhVK1PkhIMgyx/jBR8CawEnn4xo9ZEv+8gSfrfaa0ys5YOf8WDCmwBzusN2GQjyv43wStV2VsTncGgF9lrboSZFbGZVJsTqjkG7vibZ529NZK2eOiD+x0VgEqWeFehAQw9uiqbIZBmJ5FFWux/Q47LjHfQX3wTrp+CYj25luRkmjc7RSsad6tB7Jc/jAFWDMv/rAO3hw6k1p/4iHl5J08ktX37I82cBwKw8tC64GlT/gRg2PGDHAdFYbpzSEt34XGi06wTPSZtQwz8L9cWXout+ybmcTD+9FjHiRuoGlL3mqPMSly0JNXm9z6hB7h8N1y/CYCDylguyQvrVkjCN+hgcVztTz+1106uu+4StQlsx869FLo8pE1LBmoR1K+rbm2aGUXVKpeUhkKQOfLyfJ5HSwIXEwtKRwXKf5fCkKlva6GSK7mvuIMQifhTFccGoHrdthQdVsn0Q==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(136003)(346002)(46966006)(36840700001)(26005)(186003)(426003)(70206006)(8936002)(70586007)(2906002)(921005)(82740400003)(8676002)(7636003)(478600001)(5660300002)(9786002)(110136005)(36860700001)(2616005)(82310400003)(83380400001)(4744005)(1076003)(36756003)(336012)(7696005)(316002)(356005)(47076005)(36906005)(6636002)(102446001)(41533002)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 09:29:09.2656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a707ab-e292-4d1a-a755-08d8f5b9c4dc
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT063.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2864
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Adds support to handle FPGA/PL power Domain to optimize the PL power
consumption.

Nava kishore Manne (3):
  dt-bindings: zynqmp: Add new PD_PL macro
  fpga: region: Add fpga-region property 'power-domains'
  fpga: region: Adds runtime PM support

 .../devicetree/bindings/fpga/fpga-region.txt   | 14 ++++++++++++++
 drivers/fpga/of-fpga-region.c                  | 18 +++++++++++++++++-
 include/dt-bindings/power/xlnx-zynqmp-power.h  |  1 +
 3 files changed, 32 insertions(+), 1 deletion(-)

-- 
2.18.0

