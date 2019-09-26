Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C09CBEFC8
	for <lists+linux-fpga@lfdr.de>; Thu, 26 Sep 2019 12:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbfIZKji (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 26 Sep 2019 06:39:38 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:40424 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725820AbfIZKji (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 26 Sep 2019 06:39:38 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8QAc36J010420;
        Thu, 26 Sep 2019 06:39:09 -0400
Received: from nam05-by2-obe.outbound.protection.outlook.com (mail-by2nam05lp2057.outbound.protection.outlook.com [104.47.50.57])
        by mx0b-00128a01.pphosted.com with ESMTP id 2v6hku7bfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 26 Sep 2019 06:39:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqBCL+Aa8iSddddbG+l9bmiBWxrGPqcP/wjiX80AB24HEEKXyIavtHZrdmtTmplsyKaqeZ9ETA4g+L27nFeAy/tsYIi9k3m5omvdpXmsL/hq7AQUoEsW6KjbiviIK2/i/3AndaH90e+TQtbOn3Mh7cqZu1NH0BCM8VO3r4RSnLOFm61529M2M+nb4V0p2dk5HPmSPR5tvx9MxyoHacwzAc2ayxbU/4FHK1soVpn7Veul40/X2O+9LwXFKz5UdSF5V07cZC/WnPDGbFl3gux0QEcaqC2WYdkbG1DitdFoJSkhfaOhb3j7PxrpxMhTw6cgkKF5DOQpH3ETFbVeG6O33w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mpsBKRURGx6dxwNcEUXK50qwNStkQzmeYQbpyezIiE=;
 b=GoJsacJcKqVXPD/iE1rRApG59f6BdJiVS7STp+k3x6nStnubzXLz3+66WdMK9wlJyQNHJ6JxzSug2Dd0hsYco82Tdw6vs39JQDP6uhax04hxb3nUf93XaYsOc4bTHNSP/Y+NRdUMblBln0HXAkeuiDx2FLeb08nD/rp79Qx8p67MZfiSJok6uvxrII8NLLEx1XFr6PCABohq4H6KAarXMltgbRPpGlhi9XzwT6SgQHRbH79adt1cgJ5Vo9qLxrvfGSDTLYMSXARNcbVSJNcBFYpUxinlvUwp0sNEjjGW+VbMMwUsLMQBjC0ebrfgAaSqzXTT9IOWzDQl7CqaNYwwOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mpsBKRURGx6dxwNcEUXK50qwNStkQzmeYQbpyezIiE=;
 b=gYrejJkzcOt0a9lppPgg/KC+euoSXmq8/HSaYhOH66zbvBCpaGHu75cEmRYgbyps4w2OiF62FAhCbHo3Y9LzhbfjE12yC2KZrVQnJ/ktgMbtaR+3OEi+XaR2PwMCs4aGdc4MxeTgpmPVtjm7vqBdT1KiUO7q2fcnhFDsKM99BMM=
Received: from BL0PR03CA0018.namprd03.prod.outlook.com (2603:10b6:208:2d::31)
 by BL0PR03MB4148.namprd03.prod.outlook.com (2603:10b6:208:65::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20; Thu, 26 Sep
 2019 10:39:07 +0000
Received: from BL2NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by BL0PR03CA0018.outlook.office365.com
 (2603:10b6:208:2d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2284.20 via Frontend
 Transport; Thu, 26 Sep 2019 10:39:07 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT011.mail.protection.outlook.com (10.152.77.5) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2284.20
 via Frontend Transport; Thu, 26 Sep 2019 10:39:06 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x8QAd100026156
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 26 Sep 2019 03:39:01 -0700
Received: from nsa.sphairon.box (10.44.3.90) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 26 Sep
 2019 06:39:06 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <devicetree@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <linux-hwmon@vger.kernel.org>
CC:     Moritz Fischer <mdf@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 1/3] include: fpga: adi-axi-common: Define version macros
Date:   Thu, 26 Sep 2019 12:39:23 +0200
Message-ID: <20190926103925.194973-2-nuno.sa@analog.com>
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
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(376002)(39860400002)(189003)(199004)(106002)(70206006)(1076003)(4326008)(6116002)(86362001)(36756003)(478600001)(47776003)(2906002)(2870700001)(6666004)(486006)(316002)(246002)(23676004)(50466002)(50226002)(8676002)(186003)(53416004)(26005)(5820100001)(2616005)(476003)(336012)(126002)(446003)(426003)(2201001)(11346002)(110136005)(3846002)(356004)(7736002)(8936002)(7636002)(54906003)(16526019)(305945005)(76176011)(5660300002)(45776006)(4744005)(70586007);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR03MB4148;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6838b04-d295-42c2-3d20-08d7426dc209
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BL0PR03MB4148;
X-MS-TrafficTypeDiagnostic: BL0PR03MB4148:
X-Microsoft-Antispam-PRVS: <BL0PR03MB4148F0443809CE185B6574AD99860@BL0PR03MB4148.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-Forefront-PRVS: 0172F0EF77
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: UOj6psu002vKjMBmY7TFQvDqo232MYTDIofn68eVe3iskCnlKPbK9o2mBGIVm9qP2aZ3TxQEo8b3G9yGiUqPH0yNfiGM448jnDPu+2mpwhFdWVns3S0Ajt1IqYhQZmp0aIyzkp3keUgUp4m2ntOnsq8iIobBrvZ7Sc64lpJYzQ/XBXHWyr+0gsrph0vCoJy5NoQ2/OnasfL4H/AJkYQl4S0SAglOaM1Oy1T+21Jcrs4hz9ATcWSrO42ceskDe8JwemQbbXKf1vAyj3Hz9VMaCWoCIstmXlunI0R57kP+3vONdM2a8s1pLh4Pf1UxE+Agj6EoVK/q6YM1Tum6JhdZamGgybTUznKNQUdOU3nVyqIFLpxnGGpqsRNhWPyPAM9ZIvpFhMdajdykGY3nNzJGfZWInmGVSQuyBc3cp9I0eaA=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2019 10:39:06.9967
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6838b04-d295-42c2-3d20-08d7426dc209
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR03MB4148
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-26_05:2019-09-25,2019-09-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 adultscore=0 spamscore=0 mlxlogscore=871 mlxscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909260100
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add commom macros to "parse" ADI HDL cores version, in terms of
major, minor and patch.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 include/linux/fpga/adi-axi-common.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/fpga/adi-axi-common.h b/include/linux/fpga/adi-axi-common.h
index 7fc95d5c95bb..5bc5603e6bc8 100644
--- a/include/linux/fpga/adi-axi-common.h
+++ b/include/linux/fpga/adi-axi-common.h
@@ -16,4 +16,8 @@
 #define ADI_AXI_PCORE_VER(major, minor, patch)	\
 	(((major) << 16) | ((minor) << 8) | (patch))
 
+#define ADI_AXI_PCORE_VER_MAJOR(version)	(((version) >> 16) & 0xff)
+#define ADI_AXI_PCORE_VER_MINOR(version)	(((version) >> 8) & 0xff)
+#define ADI_AXI_PCORE_VER_PATCH(version)	((version) & 0xff)
+
 #endif /* ADI_AXI_COMMON_H_ */
-- 
2.23.0

