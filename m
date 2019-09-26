Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8941CBEFCE
	for <lists+linux-fpga@lfdr.de>; Thu, 26 Sep 2019 12:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbfIZKjl (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 26 Sep 2019 06:39:41 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:42730 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725554AbfIZKjl (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 26 Sep 2019 06:39:41 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8QAc36L010420;
        Thu, 26 Sep 2019 06:39:17 -0400
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2050.outbound.protection.outlook.com [104.47.48.50])
        by mx0b-00128a01.pphosted.com with ESMTP id 2v6hku7bg7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Sep 2019 06:39:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+ORmUnesvnumZVUHbgkfe44sk+fHz6rCI2q0IWFV92v03+eS5KzILi/J9pnvTc9bIdW9cKQ7tODxY3WrMjRKuAuBU0kX0jxzLfDQKjw+2YaFegpG+I1NUz4Gcvtmrg1l4WiS1T/uqofEKHvq13RD6e1EUzY43w1o1+JzXuazGesPgROJ9tjUT1jjC5asRGdxkZ/ObLhHZBNeRGpjeFLPX8yj26gSSkl7TZHZkpa5Q/dNjCcj1E+7UMDyHO6TNhm88BPLJWSJdsCR7IL1OeZEyEOfu/t+KXxyKJ/qn2+kQgtSLiJuVDsoWr+TSiX+St1F/4iiTI1vX+xwst0N2q6Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDJlVEcSKRpW0HfxRhdxgOs3wBUQt0nx4MHK+w3dqgc=;
 b=HLFApR8Du5fbmF/CwWLmO4nkw30CxWpvlYRLByzQAlbEKkHaUpCwHtbVXd2T5gWdEppBkLd87asZWhhoV7g064zdyHz2d0s6kiAY9NGznoZfz6Nm0VJcbyEVla2rj6YlJZMy4H7Jc/qPWdCTPUnE+85wA6kRpcTS17Wb9XKQGTnOFiZPVpjcbpP9dzn8M1RA74eaMFit/+qVbOdOAxT5xIR3IEo+pAghu6nKQXQQAk5NY29tUQSjcio6Wq1qSOwGZAXJPGNGIKx6ozygPheZxD2ry3SyULWfinUT7BNXFMfxiwJj0+zzrSNkfywcOUy4HiPzdxyi1+7yB7lay5dHTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDJlVEcSKRpW0HfxRhdxgOs3wBUQt0nx4MHK+w3dqgc=;
 b=iH+Z/9hiyspezgXiwTG76V3WOEENZ52Lwis5z4xH+dM9hbvltjzJw4sXSoJGD4LAR+NsE0Xr5nMMicW006mfTcBMGQNOYeY+TkwBe/EMBnpyNq0rua9EvBNAKptiixxNsBRwhDnoUZyhxufntW25/AzVMjaOZf463uhH67G3SdA=
Received: from BN3PR03CA0069.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::29) by MWHPR03MB2910.namprd03.prod.outlook.com
 (2603:10b6:300:11a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20; Thu, 26 Sep
 2019 10:39:14 +0000
Received: from BL2NAM02FT048.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by BN3PR03CA0069.outlook.office365.com
 (2a01:111:e400:7a4d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.17 via Frontend
 Transport; Thu, 26 Sep 2019 10:39:14 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT048.mail.protection.outlook.com (10.152.76.109) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2284.25
 via Frontend Transport; Thu, 26 Sep 2019 10:39:14 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x8QAd8In026174
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 26 Sep 2019 03:39:08 -0700
Received: from nsa.sphairon.box (10.44.3.90) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 26 Sep
 2019 06:39:13 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <devicetree@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <linux-hwmon@vger.kernel.org>
CC:     Moritz Fischer <mdf@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 3/3] dt-bindings: hwmon: Add AXI FAN Control documentation
Date:   Thu, 26 Sep 2019 12:39:25 +0200
Message-ID: <20190926103925.194973-4-nuno.sa@analog.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190926103925.194973-1-nuno.sa@analog.com>
References: <20190926103925.194973-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.44.3.90]
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(396003)(346002)(199004)(189003)(186003)(7736002)(7636002)(106002)(54906003)(110136005)(70586007)(70206006)(966005)(36756003)(16526019)(305945005)(45776006)(8676002)(6306002)(47776003)(2906002)(1076003)(76176011)(26005)(246002)(2201001)(3846002)(6116002)(426003)(336012)(126002)(2616005)(476003)(8936002)(446003)(11346002)(53416004)(4326008)(316002)(23676004)(2870700001)(5660300002)(486006)(50466002)(356004)(478600001)(6666004)(5820100001)(50226002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB2910;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15d08355-3135-499a-1c35-08d7426dc66a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR03MB2910;
X-MS-TrafficTypeDiagnostic: MWHPR03MB2910:
X-MS-Exchange-PUrlCount: 4
X-Microsoft-Antispam-PRVS: <MWHPR03MB29107E46E1362649FC7EFC0999860@MWHPR03MB2910.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 0172F0EF77
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: hO65fI+e7HbnY1f/t7qZtW7I/coIedaeGMsKfIczCt79FaYhYJDQKTn2Jf2kgIpCL1Nz2NWrVxIJfYizVOUz6j7i7MN7VCDHMYNTvefv10WpJbh79WF1dBLQOT9a1tlC27dJm8ipCr2zDc39QgUZTxE0cwAE84FgAz21HoVus95ESLNZqd+VLuBfTWX3NLPGjcOjea9rBuwj92RN2sZU6A7Nsj8XQyTqL2X77G/Z3ZHTt/xRSI145p30bwwScAXU2WxN+Yi5b3lhlNo/SxrloaHaMDafWUvOWaadfXssSD4vVSVuYKrQWBV5mwiQzu58koOhMe4EH6XcZqln+UL9Xo/x8H/CgBzB1SOJ2p7sBJNKATba9oyWEaEUxq4gE+4V+6+ODD7/aL3fCHSP17HjwzAEOR19T4O49lIHh1htROHgBLdP7QFHAmrajqml8QWuLmGtgHW4SGnqj8wrlX1+DQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2019 10:39:14.3435
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15d08355-3135-499a-1c35-08d7426dc66a
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2910
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-26_05:2019-09-25,2019-09-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909260100
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Document the AXI FAN Control IP core devicetree bindings.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 .../bindings/hwmon/adi,axi-fan-control.yaml   | 58 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adi,axi-fan-control.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/adi,axi-fan-control.yaml b/Documentation/devicetree/bindings/hwmon/adi,axi-fan-control.yaml
new file mode 100644
index 000000000000..03948d09f600
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/adi,axi-fan-control.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright 2019 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/hwmon/adi,axi-fan-control.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AXI FAN Control Device Tree Bindings
+
+maintainers:
+  - Nuno Sá <nuno.sa@analog.com>
+
+description: |+
+  Bindings for the Analog Devices AXI FAN Control driver. Spefications of the
+  core can be found in:
+
+  https://wiki.analog.com/resources/fpga/docs/axi_fan_control
+
+properties:
+  compatible:
+    enum:
+        - adi,axi-fan-control-1.00.a
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  adi,pulses-per-revolution:
+    description: Value specifying the number of pulses per revolution of the controlled FAN.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+  - adi,pulses-per-revolution
+
+examples:
+  - |
+    fpga_axi: fpga-axi@0 {
+            #address-cells = <0x2>;
+            #size-cells = <0x1>;
+
+            axi_fan_control: axi-fan-control@80000000 {
+                    compatible = "adi,axi-pulse-capture-1.00.a";
+                    reg = <0x0 0x80000000 0x10000>;
+                    clocks = <&clk 71>;
+                    interrupts = <0 110 0>;
+                    adi,pulses-per-revolution = <2>;
+            };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index d775c923d23b..ecef8dc5f0b5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2859,6 +2859,7 @@ W:	http://ez.analog.com/community/linux-device-drivers
 L:	linux-hwmon@vger.kernel.org
 S:	Supported
 F:	drivers/hwmon/axi-fan-control.c
+F:	Documentation/devicetree/bindings/hwmon/adi,axi-fan-control.yaml
 
 AXXIA I2C CONTROLLER
 M:	Krzysztof Adamski <krzysztof.adamski@nokia.com>
-- 
2.23.0

