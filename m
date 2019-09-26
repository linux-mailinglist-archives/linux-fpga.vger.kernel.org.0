Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2944FBEFC4
	for <lists+linux-fpga@lfdr.de>; Thu, 26 Sep 2019 12:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbfIZKjf (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 26 Sep 2019 06:39:35 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:38464 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725554AbfIZKjf (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 26 Sep 2019 06:39:35 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8QAcAuO026181;
        Thu, 26 Sep 2019 06:39:07 -0400
Received: from nam03-by2-obe.outbound.protection.outlook.com (mail-by2nam03lp2055.outbound.protection.outlook.com [104.47.42.55])
        by mx0b-00128a01.pphosted.com with ESMTP id 2v6hkcq37d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 26 Sep 2019 06:39:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKdS/XHpUS31CEOxwRIwTncAps1sDcjG4yFWkk8Kn+72aVLLh99Nyfk45QgFy4vQ5d/WOI+0n2i6/6Bzdi6ReJW+0DDD9xY67DM+TF/beWJTQp9OVylfuKu+pNiOGerywgK1o73P+x959hZp44fqAfV5an8PcjBQWf426SVji87aP24ht+MXHTTShGQKp85CQA3zgdz+0TrqaBLdWqdG2KPH79trST+TmhOKEg4rD0v6nGxBrtORONigfIjppbenh6Kn0Mb5iBOLp0CPLeAbSHoU1/H7TcVJ3k9Lvd+wbiDoHkzvcTCDg2V1MC3FkFpMjLGEjuV32ukY7jkKtLOZ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiYxLA+bBlt8yjEFOjI+78KdG/2Pnv+4zlOn1iiRoIo=;
 b=aDXUcNpcyFjqQEY7TroaBEkkFHbCARo12rWTjN83u/0/o02Q4c2jvXXEFLSTFSs4svRgSKY+3Fk6m08PVNZFLDeA0zinyCJMVD9TvhzPcSm6sIaul4yDtMVt5iGKNEQfNkHon0YCgFHfhLyNjbP+9o12e9UC/X5gxKK35IqmA/yW6+B60pWTpZQFW5yWai1PpOMtx+7mEaA88hz4Idi6BTSdzUzUxRPMKAE4a/HN1LiTJUEs3wcegYYJQ6hhbdchiouaIT2Hc+sjKJpIMv65fvO2G3csP/3SRfTIlbDydbyBtnlwO1DUP+Xvm07+ZxX7JZNtdMGU7i1gp7FPFsEBGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiYxLA+bBlt8yjEFOjI+78KdG/2Pnv+4zlOn1iiRoIo=;
 b=bdSCvpbwK1X/G3PQR4EsQ6TnnlnUbNgLmTBgy50AdVMJOTMosLTC/T5Cjf+VhPsGBrHKXhoWdPMQYuq1sSD/xBDqJ9VnxpECGlfe8gobYadtGVgwtdo93BhKf8zvwT3j8hFC/zKuhut5ysLFX9ubhI8aNCjaX55jZ5TL3AlZxCU=
Received: from BN6PR03CA0024.namprd03.prod.outlook.com (2603:10b6:404:23::34)
 by BN8PR03MB4883.namprd03.prod.outlook.com (2603:10b6:408:98::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.17; Thu, 26 Sep
 2019 10:39:05 +0000
Received: from BL2NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by BN6PR03CA0024.outlook.office365.com
 (2603:10b6:404:23::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20 via Frontend
 Transport; Thu, 26 Sep 2019 10:39:05 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT018.mail.protection.outlook.com (10.152.77.170) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2284.25
 via Frontend Transport; Thu, 26 Sep 2019 10:39:05 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x8QAcx6o026150
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 26 Sep 2019 03:38:59 -0700
Received: from nsa.sphairon.box (10.44.3.90) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 26 Sep
 2019 06:39:04 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <devicetree@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <linux-hwmon@vger.kernel.org>
CC:     Moritz Fischer <mdf@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 0/3] Support AXI FAN Control IP core
Date:   Thu, 26 Sep 2019 12:39:22 +0200
Message-ID: <20190926103925.194973-1-nuno.sa@analog.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.44.3.90]
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(376002)(136003)(189003)(199004)(54906003)(86362001)(47776003)(2201001)(53416004)(23676004)(50466002)(2616005)(486006)(305945005)(336012)(126002)(426003)(476003)(2870700001)(7636002)(16526019)(186003)(26005)(2906002)(6116002)(3846002)(5660300002)(106002)(1076003)(4744005)(7736002)(50226002)(356004)(316002)(478600001)(45776006)(70586007)(70206006)(246002)(8676002)(6666004)(8936002)(36756003)(4326008)(5820100001)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR03MB4883;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2717887e-6bce-4b05-0792-08d7426dc0f9
X-MS-TrafficTypeDiagnostic: BN8PR03MB4883:
X-Microsoft-Antispam-PRVS: <BN8PR03MB48831F7C08CC2597227F0CA399860@BN8PR03MB4883.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0172F0EF77
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YF7ZpjXvN6VXh/iD2UqKgS7xuXY5NA10nmRIfKCr4z0PBFc2nsB+yrTqVo0etUWOlko+C+QHT7mZDzpgFRPiO8WPl7Uv/ldW3m0vO4jZcAIOIC1suUscnU4bl90CsyRcSu8xLqdtweOwaa0Bw36dAu8cOZxV3SOwABZr46h0LCI3/3cySP31UjQjUmLBOI2wG2BzInqQ+qo0d3EyNeSYjjHZakICH6Vp8y6MFz+YQA28GGDlVyg1LUvrgSxPgXjOpLLcURY4EQbIhldBrXur1jSajrFrZBl+IjRVCwNcG8AY6feVSo4ZtuyNSG368uJ2+H6yGYJgKyYh2OWhtO1DEOzCvkDjUJrViuO/lJwRUqw8ka5DKQko0TeWZWpxfED+fMBIbkKfmNbOTUH/hJWviUKZ59P8nGjD9VWkPhXUqIM=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2019 10:39:05.2128
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2717887e-6bce-4b05-0792-08d7426dc0f9
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB4883
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-26_05:2019-09-25,2019-09-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=694 clxscore=1011 mlxscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909260100
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This series adds support for the ADI AXI FAN Control IP core. The first
patch adds some new definitions to the adi-axi-common header file. This
new `#defines` will be then used by the new hwmon driver. The rest of the
series is the usual stuff for a new device driver.

Nuno Sá (3):
  include: fpga: adi-axi-common: Define version macros
  hwmon: Support ADI Fan Control IP
  dt-bindings: hwmon: Add AXI FAN Control documentation

 .../bindings/hwmon/adi,axi-fan-control.yaml   |  58 +++
 MAINTAINERS                                   |   8 +
 drivers/hwmon/Kconfig                         |   9 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/axi-fan-control.c               | 452 ++++++++++++++++++
 include/linux/fpga/adi-axi-common.h           |   4 +
 6 files changed, 532 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adi,axi-fan-control.yaml
 create mode 100644 drivers/hwmon/axi-fan-control.c

-- 
2.23.0

