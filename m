Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C926A355F8E
	for <lists+linux-fpga@lfdr.de>; Wed,  7 Apr 2021 01:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237804AbhDFXj4 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 6 Apr 2021 19:39:56 -0400
Received: from mail-dm6nam12on2062.outbound.protection.outlook.com ([40.107.243.62]:18161
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232767AbhDFXjz (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 6 Apr 2021 19:39:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9nx11LQypE2nj4aZ9qvYg32Y0V7SDsMWRhD6Re11QAvRrriQKpJUrMDkUibj4dvBqGkpbuR8EJ86xSc6xAc3oIAl6PKof0VFTQ5leUv4WoColLGeZmnWaKjhFpX+8VVlOrOmOotbLa9k+fySafZN3HKK8w41ku6LIEu+Sa6s7aettuB9Ajaelm7H/R2hve8ISWE2f2axxTHqsFXqZJaJGlkIv6gCtin79C1YrxqXH+rgMxSAzaucPL5en84l8ghXMN+S6xo5J/jOqjAGR6ptE9IWJcgLar2VkeXFAMoLVxyfdkHLdZg8u3BNRTsHP0aj4K6njqEfdOHglirGSH9tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehx06mgSZ817tlZFtgVzHQ3nIbEnCN21wjoO4N6qjeI=;
 b=JbbWauCr/KTv+2P5DhAQKjIPFHXltlZfEQzQY7UTk87rjVjTxga2G/Y80Ipmzgv/tsoDbo/QLIRA3OaiHoWhNqI//8HbMio7E1w9lIa1oSc8z+6s6KgUtXJ2IlKNkzpNxNp74Ofpqf6qhRQX7Miu8HNPjpW1lqwvn/y5qPrk5hethDFlCsfOhKhCsc4RTptAkGxfbilwm7bTmNYiUnnIJVKuLTVs+9B+c8aqHRwzAEaUdZMk8lR848T9B1hJWyAE42QRLyVDGexJXu+ywDgTM7w0lhH0q6oeMmXzGw2zwxxaPKTbBNVoLdMP1RUJY4ZlWSl8R3Zxv90pDXiQAQnxSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehx06mgSZ817tlZFtgVzHQ3nIbEnCN21wjoO4N6qjeI=;
 b=d38OsSOUbbrQdcmD5/Efbbl72EVDC2ihuvy39xd/W+5S/DI9HiGH/9RI7cMv7pAZg4Ljjurak/+x3JyLFTtGxBE0jV4T81LYVb1wRGnpukYfX6XJw8qSH/GhfbmrulqsdsOgszM5+NDCTEyx1qfEc5Mx95OwPDgtP0Ez63UnzuY=
Received: from MN2PR05CA0048.namprd05.prod.outlook.com (2603:10b6:208:236::17)
 by MN2PR02MB5823.namprd02.prod.outlook.com (2603:10b6:208:110::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Tue, 6 Apr
 2021 23:39:43 +0000
Received: from BL2NAM02FT042.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:236:cafe::92) by MN2PR05CA0048.outlook.office365.com
 (2603:10b6:208:236::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.8 via Frontend
 Transport; Tue, 6 Apr 2021 23:39:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT042.mail.protection.outlook.com (10.152.76.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3999.28 via Frontend Transport; Tue, 6 Apr 2021 23:39:43 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 6 Apr 2021 16:39:40 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Tue, 6 Apr 2021 16:39:40 -0700
Envelope-to: robh@kernel.org,
 mdf@kernel.org,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 trix@redhat.com
Received: from [10.17.2.60] (port=41408)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lTvIK-00066B-9x; Tue, 06 Apr 2021 16:39:40 -0700
Subject: Re: [PATCH V4 XRT Alveo 20/20] fpga: xrt: Kconfig and Makefile
 updates for XRT drivers
To:     Tom Rix <trix@redhat.com>, Lizhi Hou <lizhi.hou@xilinx.com>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-fpga@vger.kernel.org>, <maxz@xilinx.com>,
        <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <mdf@kernel.org>, <robh@kernel.org>,
        Max Zhen <max.zhen@xilinx.com>
References: <20210324052947.27889-1-lizhi.hou@xilinx.com>
 <20210324052947.27889-21-lizhi.hou@xilinx.com>
 <26dd81ca-60f7-3ac8-c6a4-69bca4620e8e@redhat.com>
From:   Lizhi Hou <lizhi.hou@xilinx.com>
Message-ID: <1fa31f90-3ad8-3770-51cc-242e80619d16@xilinx.com>
Date:   Tue, 6 Apr 2021 16:39:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <26dd81ca-60f7-3ac8-c6a4-69bca4620e8e@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76ac52d2-8efd-4c7a-89f9-08d8f9554115
X-MS-TrafficTypeDiagnostic: MN2PR02MB5823:
X-Microsoft-Antispam-PRVS: <MN2PR02MB5823052406E567DD22EDDA96A1769@MN2PR02MB5823.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YypAbotVCG7/VllOcFEGDPM9Nt5ILHXFag8XJz1uPH5Letb1cfIhHBhm3vlaTn3W/IExa07KzJBuTGsK4xAVJ6mV54g2ePu7eGOAEbDXtE9gQDiZt1aObZEH4FWj45ff0hVwYj8B7lo9TVMJgzDCRV7rTEYl3ysdJhkVXMHr7aOg1pjhykYeouwjefiDEUgd/LEZjkuftVbR5aSMaXAXmTllzBocds/hU3PG75Wt/qtLAZl1HhMFh8Lszeg1PBSLm+UOdsFiZRw8CGWCPJkAj3NrDP1ckCTFPXkL3EEBh1qkUHp3r7LlbgK6f2IZyqcRF+kRuLmvRnY9cceB/s874WWBsFtgXFQtGB+kCFICZaOVAuf/y7xi/iSA/0SkOjcXoFAsKcVUcJU4h5MvzvMlaUsJt4u1tfQ9wMexnNJa+PaNae0naL9fZHmF7JrFb9Deobn576/HBVanPx0EsVqA6UWfsAm3PaY4bTgsvY3cFletT2pN/PtJU4UtXTwnq5VhzJs0RLndgTpfJdq+emGMa0q2G+70AJFnU74L7jT4KNr89/Qgm/r54ASWOnTXe/BkvZagEOaGwXWUfIQUXZsVCx7BXgjWxjztmvmjLMDPom+4b54qo5PHATInItEdG5Wgdnh022I435CvMzzLyK+xL2E0BIqWNiHOsDYkcqvpon6R4/0eds48TYADAUXxwTJzS9vllg/XxbCsU/+eH4bAFRsNnK/Zo1Vu0mf3c3EGZi4qL8sWy5OXunN6HNhrPtwCQGZ9Pgso2dilUkvu5HaT9QuqzqBWRBBjoiYXtluPFhkKCeZkLngtAIQMucL3VWhM
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(2906002)(186003)(5660300002)(31686004)(2616005)(8676002)(426003)(110136005)(36906005)(54906003)(31696002)(82310400003)(53546011)(107886003)(26005)(8936002)(15650500001)(498600001)(336012)(7636003)(47076005)(4326008)(83380400001)(9786002)(36756003)(44832011)(70206006)(70586007)(966005)(356005)(36860700001)(50156003)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 23:39:43.1044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ac52d2-8efd-4c7a-89f9-08d8f9554115
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT042.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB5823
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Tom,


On 04/06/2021 02:00 PM, Tom Rix wrote:
>
> On 3/23/21 10:29 PM, Lizhi Hou wrote:
>> Update fpga Kconfig/Makefile and add Kconfig/Makefile for new drivers.
>>
>> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
>> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
>> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
>> ---
>>   MAINTAINERS                        | 11 +++++++++++
>>   drivers/Makefile                   |  1 +
>>   drivers/fpga/Kconfig               |  2 ++
>>   drivers/fpga/Makefile              |  5 +++++
>>   drivers/fpga/xrt/Kconfig           |  8 ++++++++
>>   drivers/fpga/xrt/lib/Kconfig       | 17 +++++++++++++++++
>>   drivers/fpga/xrt/lib/Makefile      | 30 ++++++++++++++++++++++++++++++
>>   drivers/fpga/xrt/metadata/Kconfig  | 12 ++++++++++++
>>   drivers/fpga/xrt/metadata/Makefile | 16 ++++++++++++++++
>>   drivers/fpga/xrt/mgmt/Kconfig      | 15 +++++++++++++++
>>   drivers/fpga/xrt/mgmt/Makefile     | 19 +++++++++++++++++++
>>   11 files changed, 136 insertions(+)
>>   create mode 100644 drivers/fpga/xrt/Kconfig
>>   create mode 100644 drivers/fpga/xrt/lib/Kconfig
>>   create mode 100644 drivers/fpga/xrt/lib/Makefile
>>   create mode 100644 drivers/fpga/xrt/metadata/Kconfig
>>   create mode 100644 drivers/fpga/xrt/metadata/Makefile
>>   create mode 100644 drivers/fpga/xrt/mgmt/Kconfig
>>   create mode 100644 drivers/fpga/xrt/mgmt/Makefile
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index aa84121c5611..44ccc52987ac 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -7009,6 +7009,17 @@ F:     Documentation/fpga/
>>   F:  drivers/fpga/
>>   F:  include/linux/fpga/
>>
>> +FPGA XRT DRIVERS
>> +M:   Lizhi Hou <lizhi.hou@xilinx.com>
>> +R:   Max Zhen <max.zhen@xilinx.com>
>> +R:   Sonal Santan <sonal.santan@xilinx.com>
>> +L:   linux-fpga@vger.kernel.org
>> +S:   Maintained
> Should this be 'Supported' ?
Sure.
>> +W:   https://github.com/Xilinx/XRT
>> +F:   Documentation/fpga/xrt.rst
>> +F:   drivers/fpga/xrt/
>> +F:   include/uapi/linux/xrt/
>> +
>>   FPU EMULATOR
>>   M:  Bill Metzenthen <billm@melbpc.org.au>
>>   S:  Maintained
>> diff --git a/drivers/Makefile b/drivers/Makefile
>> index 6fba7daba591..dbb3b727fc7a 100644
>> --- a/drivers/Makefile
>> +++ b/drivers/Makefile
>> @@ -179,6 +179,7 @@ obj-$(CONFIG_STM)         += hwtracing/stm/
>>   obj-$(CONFIG_ANDROID)               += android/
>>   obj-$(CONFIG_NVMEM)         += nvmem/
>>   obj-$(CONFIG_FPGA)          += fpga/
>> +obj-$(CONFIG_FPGA_XRT_METADATA) += fpga/
> CONFIG_FPGA_XRT_METADATA is only defined when CONFIG_FPGA is, so i don't
> think this line is needed.
CONFIG_FPGA could be 'm'.
And as we discussed before, CONFIG_FPGA_XRT_METADATA extending fdt_* can 
be only build in kernel ('y'). Maybe it can not rely on CONFIG_FPGA?
>>   obj-$(CONFIG_FSI)           += fsi/
>>   obj-$(CONFIG_TEE)           += tee/
>>   obj-$(CONFIG_MULTIPLEXER)   += mux/
>> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
>> index 5ff9438b7b46..01410ff000b9 100644
>> --- a/drivers/fpga/Kconfig
>> +++ b/drivers/fpga/Kconfig
>> @@ -227,4 +227,6 @@ config FPGA_MGR_ZYNQMP_FPGA
>>         to configure the programmable logic(PL) through PS
>>         on ZynqMP SoC.
>>
>> +source "drivers/fpga/xrt/Kconfig"
>> +
>>   endif # FPGA
> This is where it is defined..
>> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
>> index 18dc9885883a..4b887bf95cb3 100644
>> --- a/drivers/fpga/Makefile
>> +++ b/drivers/fpga/Makefile
>> @@ -48,3 +48,8 @@ obj-$(CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000) += 
>> dfl-n3000-nios.o
>>
>>   # Drivers for FPGAs which implement DFL
>>   obj-$(CONFIG_FPGA_DFL_PCI)          += dfl-pci.o
>> +
>> +# XRT drivers for Alveo
>> +obj-$(CONFIG_FPGA_XRT_METADATA)              += xrt/metadata/
>> +obj-$(CONFIG_FPGA_XRT_LIB)           += xrt/lib/
>> +obj-$(CONFIG_FPGA_XRT_XMGMT)         += xrt/mgmt/
>> diff --git a/drivers/fpga/xrt/Kconfig b/drivers/fpga/xrt/Kconfig
>> new file mode 100644
>> index 000000000000..0e2c59589ddd
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/Kconfig
>> @@ -0,0 +1,8 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +#
>> +# Xilinx Alveo FPGA device configuration
>> +#
>> +
>> +source "drivers/fpga/xrt/metadata/Kconfig"
>> +source "drivers/fpga/xrt/lib/Kconfig"
>> +source "drivers/fpga/xrt/mgmt/Kconfig"
>> diff --git a/drivers/fpga/xrt/lib/Kconfig b/drivers/fpga/xrt/lib/Kconfig
>> new file mode 100644
>> index 000000000000..935369fad570
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/lib/Kconfig
>> @@ -0,0 +1,17 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +#
>> +# XRT Alveo FPGA device configuration
>> +#
>> +
>> +config FPGA_XRT_LIB
>> +     tristate "XRT Alveo Driver Library"
>> +     depends on HWMON && PCI && HAS_IOMEM
>> +     select FPGA_XRT_METADATA
>> +     select REGMAP_MMIO
>> +     help
>> +       Select this option to enable Xilinx XRT Alveo driver library. 
>> This
>> +       library is core infrastructure of XRT Alveo FPGA drivers which
>> +       provides functions for working with device nodes, iteration and
>> +       lookup of platform devices, common interfaces for platform 
>> devices,
>> +       plumbing of function call and ioctls between platform devices 
>> and
>> +       parent partitions.
>> diff --git a/drivers/fpga/xrt/lib/Makefile 
>> b/drivers/fpga/xrt/lib/Makefile
>> new file mode 100644
>> index 000000000000..58563416efbf
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/lib/Makefile
>> @@ -0,0 +1,30 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +#
>> +# Copyright (C) 2020-2021 Xilinx, Inc. All rights reserved.
>> +#
>> +# Authors: Sonal.Santan@xilinx.com
>> +#
>> +
>> +FULL_XRT_PATH=$(srctree)/$(src)/..
>> +FULL_DTC_PATH=$(srctree)/scripts/dtc/libfdt
>> +
>> +obj-$(CONFIG_FPGA_XRT_LIB) += xrt-lib.o
>> +
>> +xrt-lib-objs :=                      \
>> +     lib-drv.o               \
>> +     xroot.o                 \
>> +     xclbin.o                \
>> +     subdev.o                \
>> +     cdev.o                  \
>> +     group.o                 \
>> +     xleaf/vsec.o            \
>> +     xleaf/axigate.o         \
>> +     xleaf/devctl.o          \
>> +     xleaf/icap.o            \
>> +     xleaf/clock.o           \
>> +     xleaf/clkfreq.o         \
>> +     xleaf/ucs.o             \
>> +     xleaf/ddr_calibration.o
>> +
>> +ccflags-y := -I$(FULL_XRT_PATH)/include       \
>> +     -I$(FULL_DTC_PATH)
>> diff --git a/drivers/fpga/xrt/metadata/Kconfig 
>> b/drivers/fpga/xrt/metadata/Kconfig
>> new file mode 100644
>> index 000000000000..129adda47e94
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/metadata/Kconfig
>> @@ -0,0 +1,12 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +#
>> +# XRT Alveo FPGA device configuration
>> +#
>> +
>> +config FPGA_XRT_METADATA
>> +     bool "XRT Alveo Driver Metadata Parser"
>> +     select LIBFDT
>> +     help
>> +       This option provides helper functions to parse Xilinx Alveo FPGA
>> +       firmware metadata. The metadata is in device tree format and the
>> +       XRT driver uses it to discover the HW subsystems behind PCIe 
>> BAR.
>> diff --git a/drivers/fpga/xrt/metadata/Makefile 
>> b/drivers/fpga/xrt/metadata/Makefile
>> new file mode 100644
>> index 000000000000..14f65ef1595c
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/metadata/Makefile
>> @@ -0,0 +1,16 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +#
>> +# Copyright (C) 2020-2021 Xilinx, Inc. All rights reserved.
>> +#
>> +# Authors: Sonal.Santan@xilinx.com
>> +#
>> +
>> +FULL_XRT_PATH=$(srctree)/$(src)/..
>> +FULL_DTC_PATH=$(srctree)/scripts/dtc/libfdt
>> +
>> +obj-$(CONFIG_FPGA_XRT_METADATA) += xrt-md.o
>> +
>> +xrt-md-objs := metadata.o
>> +
>> +ccflags-y := -I$(FULL_XRT_PATH)/include      \
>> +     -I$(FULL_DTC_PATH)
>> diff --git a/drivers/fpga/xrt/mgmt/Kconfig 
>> b/drivers/fpga/xrt/mgmt/Kconfig
>> new file mode 100644
>> index 000000000000..31e9e19fffb8
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/mgmt/Kconfig
>> @@ -0,0 +1,15 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +#
>> +# Xilinx XRT FPGA device configuration
>> +#
>> +
>> +config FPGA_XRT_XMGMT
>> +     tristate "Xilinx Alveo Management Driver"
>> +     depends on FPGA_XRT_LIB
>> +     select FPGA_XRT_METADATA
>
> If the XRT driver depends on these other two configs and it does not
> make sense to build these two seperately, could you remove these configs
> and just use something like FPGA_XRT ?
This is similar reason with above. CONFIG_FPGA_XRT_METADATA can be only 
built in. And FPGA_XRT_LIB can be built as module.  They might not be 
built together.

Thanks,
Lizhi
>
> Tom
>
>> +     select FPGA_BRIDGE
>> +     select FPGA_REGION
>> +     help
>> +       Select this option to enable XRT PCIe driver for Xilinx Alveo 
>> FPGA.
>> +       This driver provides interfaces for userspace application to 
>> access
>> +       Alveo FPGA device.
>> diff --git a/drivers/fpga/xrt/mgmt/Makefile 
>> b/drivers/fpga/xrt/mgmt/Makefile
>> new file mode 100644
>> index 000000000000..acabd811f3fd
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/mgmt/Makefile
>> @@ -0,0 +1,19 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +#
>> +# Copyright (C) 2020-2021 Xilinx, Inc. All rights reserved.
>> +#
>> +# Authors: Sonal.Santan@xilinx.com
>> +#
>> +
>> +FULL_XRT_PATH=$(srctree)/$(src)/..
>> +FULL_DTC_PATH=$(srctree)/scripts/dtc/libfdt
>> +
>> +obj-$(CONFIG_FPGA_XRT_XMGMT) += xrt-mgmt.o
>> +
>> +xrt-mgmt-objs := root.o              \
>> +        main.o               \
>> +        fmgr-drv.o           \
>> +        main-region.o
>> +
>> +ccflags-y := -I$(FULL_XRT_PATH)/include              \
>> +     -I$(FULL_DTC_PATH)
>

