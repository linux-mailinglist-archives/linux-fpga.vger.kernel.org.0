Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A4D35A629
	for <lists+linux-fpga@lfdr.de>; Fri,  9 Apr 2021 20:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbhDISvG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 9 Apr 2021 14:51:06 -0400
Received: from mail-mw2nam08on2078.outbound.protection.outlook.com ([40.107.101.78]:28473
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233332AbhDISvG (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 9 Apr 2021 14:51:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ey1nEguCVvXhJRp29LsUJH8V4eFr15axTF6NNfVWcFeyoc9kAAuU0qiKfejKU5K4pqYJw93pe+ZS6lwMYBAQhAREoKYxzSYZLxmLOEdihedan5v0RfVzk7XmPn7TP5T6xRFKESozfcZm0pv5/rAwD5wzgzXyHmGX0Flw1KI6c5Rzdq+YfeOrN7egbAOkxzkS5+Wd6GyfG37OMvHPPFR38gBV7mFxWYjuLnRMiSP4Dym8HxdgTJatZFrOhggS3LcxxLTmni1AUoDk+9ieI5oHIo17xSq0/uUM95EdtsxCvhPmOCh1hvwoTmpA32KfRz1XdXTSKtMq/p5iwNbavH+Ftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PlwNRwXSYJQKwgygaN8SC4FgglXhXIrrQc6rzxOAnuE=;
 b=iFZvc24we974pAlAwCsirbCfX1AQFN0Sh56ZYfjDZwIL7NwtSrDfRT73Esf83jzKwlnoSAP+CZr9KKzHrWgsL4M7dqeBCf3n28J2POHuBa13GGjtVXwR2u3cWIyF8nLEI1K7BmiCS4AjQn3lxGYSg+E+HnlX3rO7Po5kVT1w4SHKF2nMHuW8/zolDKQ3QkI/AaB+EP/qV9FGP+KksYHfQAjhakfiya2zYi/IMYw+65X5MaVn8yZFRpJFdsdOSS+bMoTZIPEaM9mowd4RWxcHxP0d+cWsl46kwKWFVcwgLcedaIeLwtZobKbQoB6woyEJvCBmBkGAvAL+E1pu+12vtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PlwNRwXSYJQKwgygaN8SC4FgglXhXIrrQc6rzxOAnuE=;
 b=V+qwzd5u/qS+ghpBzSokuNfoRrZKTKaHIqr9P86fq2fGfjTh+TpA9SRwpLTSXLy3FtNkitsll0Se0TwAtjI4xIhP4FVdyKQzLmmGuWnOPWoL9qilQKLpwi/PYcYCeRagZdkB0HjvM4OLV0Jty8OM5svyS1SAOQD6wvcoEIh2fgw=
Received: from SN4PR0401CA0016.namprd04.prod.outlook.com
 (2603:10b6:803:21::26) by MWHPR0201MB3433.namprd02.prod.outlook.com
 (2603:10b6:301:7c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Fri, 9 Apr
 2021 18:50:51 +0000
Received: from SN1NAM02FT034.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:21:cafe::4d) by SN4PR0401CA0016.outlook.office365.com
 (2603:10b6:803:21::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Fri, 9 Apr 2021 18:50:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT034.mail.protection.outlook.com (10.152.72.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Fri, 9 Apr 2021 18:50:51 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 9 Apr 2021 11:50:50 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Fri, 9 Apr 2021 11:50:50 -0700
Envelope-to: robh@kernel.org,
 mdf@kernel.org,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 trix@redhat.com
Received: from [10.17.3.3] (port=35784)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <max.zhen@xilinx.com>)
        id 1lUwDS-0007YS-8r; Fri, 09 Apr 2021 11:50:50 -0700
From:   Max Zhen <max.zhen@xilinx.com>
Subject: Re: [PATCH V4 XRT Alveo 09/20] fpga: xrt: management physical
 function driver (root)
To:     Tom Rix <trix@redhat.com>, Lizhi Hou <lizhi.hou@xilinx.com>,
        <linux-kernel@vger.kernel.org>, Max Zhen <max.zhen@xilinx.com>
CC:     <linux-fpga@vger.kernel.org>, <sonal.santan@xilinx.com>,
        <yliu@xilinx.com>, <michal.simek@xilinx.com>,
        <stefanos@xilinx.com>, <devicetree@vger.kernel.org>,
        <mdf@kernel.org>, <robh@kernel.org>
References: <20210324052947.27889-1-lizhi.hou@xilinx.com>
 <20210324052947.27889-10-lizhi.hou@xilinx.com>
 <5ac8ef15-87b4-358b-0835-d41e3b88592b@redhat.com>
Message-ID: <f38c7210-85aa-09af-9a52-ebb13ca3442e@xilinx.com>
Date:   Fri, 9 Apr 2021 11:50:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <5ac8ef15-87b4-358b-0835-d41e3b88592b@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a62807bd-b24b-4a23-e155-08d8fb8865b6
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3433:
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3433823468854FE18B8BDAEAB9739@MWHPR0201MB3433.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:299;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7fYl2cQLikUAtPLNX8RA0LwXU3PsoysTgMcQ5n0LJqpYVScQ1AOKx16cxHg/lgIHhMyGRkd4qldJUH7F5p3Jh3ZDB1lJIVj6fmVBDDty83KByy6Ah2tybXQrZVoX/07mRWotBQIlXbqMLO3xZ8Q0aFLxyZ0ae2gCPfg/aq3MlgRymb4eYbhG9v4eoryQN5DEyAaHIU9HcCSEXbtn327MbdxTFUOYm13mHKz9ldlitQl7d3Qz2bATsC9APp6zJdyTyv45HtbrjUyxFCpaPTZJkEMB4qXGfL64wP1W30mRflXf5mMRthuLJ/78K2I3uQcjpsbipT3n+rABSxokUKpd6ahkYxcrbtd41V26pNEcw/9AAS7S6qUT8lTVIviJttOBcKYHsNwRRWcAUl0wGv0RCSlDi6/rtijmCDv6NUHoPYhoNwcGzfD2NuOUHKfnW07HbQvBOZEXjo3V0OeTYnKHaLxweVwA3A/cMN6Hh2tlIiBz2nL9M/b+nJ7jqKc2TkAxjT4gL1Dp4kKvhRemaX0kz8N3f0UStUgLx5l1fp5zt/6yEZouc+6uY3SdtNSPQOVQQUJb4vI8k13fr3da/nizJHZpV87VKwoJkcjuaf9ovC8Ygye7O91YNNpL0JERN+eAWWIe59W1G+rUU6E0Fa1GCFHt0hBdko42GbjA7OJMb7p++C88ggIWdlfsmF4tsnx/PUv/T+UZNw8+BJYzxwJ/UBvl3PSbJkUOYzVOOiXscEc=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(346002)(39850400004)(46966006)(36840700001)(44832011)(9786002)(53546011)(5660300002)(8676002)(8936002)(31686004)(47076005)(36860700001)(30864003)(82740400003)(82310400003)(2906002)(31696002)(4326008)(110136005)(316002)(36906005)(83380400001)(26005)(186003)(2616005)(426003)(336012)(7636003)(356005)(36756003)(54906003)(478600001)(70206006)(70586007)(50156003)(2101003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 18:50:51.2723
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a62807bd-b24b-4a23-e155-08d8fb8865b6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT034.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3433
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Tom,


On 3/31/21 6:03 AM, Tom Rix wrote:
> On 3/23/21 10:29 PM, Lizhi Hou wrote:
>> The PCIE device driver which attaches to management function on Alveo
>> devices. It instantiates one or more group drivers which, in turn,
>> instantiate platform drivers. The instantiation of group and platform
>> drivers is completely dtb driven.
>>
>> Signed-off-by: Sonal Santan<sonal.santan@xilinx.com>
>> Signed-off-by: Max Zhen<max.zhen@xilinx.com>
>> Signed-off-by: Lizhi Hou<lizhi.hou@xilinx.com>
>> ---
>>   drivers/fpga/xrt/mgmt/root.c | 333 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 333 insertions(+)
>>   create mode 100644 drivers/fpga/xrt/mgmt/root.c
>>
>> diff --git a/drivers/fpga/xrt/mgmt/root.c b/drivers/fpga/xrt/mgmt/root.c
>> new file mode 100644
>> index 000000000000..f97f92807c01
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/mgmt/root.c
>> @@ -0,0 +1,333 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Xilinx Alveo Management Function Driver
>> + *
>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>> + *
>> + * Authors:
>> + *   Cheng Zhen<maxz@xilinx.com>
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/pci.h>
>> +#include <linux/aer.h>
>> +#include <linux/vmalloc.h>
>> +#include <linux/delay.h>
>> +
>> +#include "xroot.h"
>> +#include "xmgnt.h"
>> +#include "metadata.h"
>> +
>> +#define XMGMT_MODULE_NAME    "xrt-mgmt"
> ok
>> +#define XMGMT_DRIVER_VERSION "4.0.0"
>> +
>> +#define XMGMT_PDEV(xm)               ((xm)->pdev)
>> +#define XMGMT_DEV(xm)                (&(XMGMT_PDEV(xm)->dev))
>> +#define xmgmt_err(xm, fmt, args...)  \
>> +     dev_err(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
>> +#define xmgmt_warn(xm, fmt, args...) \
>> +     dev_warn(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
>> +#define xmgmt_info(xm, fmt, args...) \
>> +     dev_info(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
>> +#define xmgmt_dbg(xm, fmt, args...)  \
>> +     dev_dbg(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
>> +#define XMGMT_DEV_ID(_pcidev)                        \
>> +     ({ typeof(_pcidev) (pcidev) = (_pcidev);        \
>> +     ((pci_domain_nr((pcidev)->bus) << 16) | \
>> +     PCI_DEVID((pcidev)->bus->number, 0)); })
>> +
>> +static struct class *xmgmt_class;
>> +
>> +/* PCI Device IDs */
> add a comment on what a golden image is here something like
>
> /*
>
> * Golden image is preloaded on the device when it is shipped to customer.
>
> * Then, customer can load other shells (from Xilinx or some other vendor).
>
> * If something goes wrong with the shell, customer can always go back to
>
> * golden and start over again.
>
> */
>

Will do.


>> +#define PCI_DEVICE_ID_U50_GOLDEN     0xD020
>> +#define PCI_DEVICE_ID_U50            0x5020
>> +static const struct pci_device_id xmgmt_pci_ids[] = {
>> +     { PCI_DEVICE(PCI_VENDOR_ID_XILINX, PCI_DEVICE_ID_U50_GOLDEN), }, /* Alveo U50 (golden) */
>> +     { PCI_DEVICE(PCI_VENDOR_ID_XILINX, PCI_DEVICE_ID_U50), }, /* Alveo U50 */
>> +     { 0, }
>> +};
>> +
>> +struct xmgmt {
>> +     struct pci_dev *pdev;
>> +     void *root;
>> +
>> +     bool ready;
>> +};
>> +
>> +static int xmgmt_config_pci(struct xmgmt *xm)
>> +{
>> +     struct pci_dev *pdev = XMGMT_PDEV(xm);
>> +     int rc;
>> +
>> +     rc = pcim_enable_device(pdev);
>> +     if (rc < 0) {
>> +             xmgmt_err(xm, "failed to enable device: %d", rc);
>> +             return rc;
>> +     }
>> +
>> +     rc = pci_enable_pcie_error_reporting(pdev);
>> +     if (rc)
> ok
>> +             xmgmt_warn(xm, "failed to enable AER: %d", rc);
>> +
>> +     pci_set_master(pdev);
>> +
>> +     rc = pcie_get_readrq(pdev);
>> +     if (rc > 512)
> 512 is magic number, change this to a #define


Will do.


>> +             pcie_set_readrq(pdev, 512);
>> +     return 0;
>> +}
>> +
>> +static int xmgmt_match_slot_and_save(struct device *dev, void *data)
>> +{
>> +     struct xmgmt *xm = data;
>> +     struct pci_dev *pdev = to_pci_dev(dev);
>> +
>> +     if (XMGMT_DEV_ID(pdev) == XMGMT_DEV_ID(xm->pdev)) {
>> +             pci_cfg_access_lock(pdev);
>> +             pci_save_state(pdev);
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static void xmgmt_pci_save_config_all(struct xmgmt *xm)
>> +{
>> +     bus_for_each_dev(&pci_bus_type, NULL, xm, xmgmt_match_slot_and_save);
> refactor expected in v5 when pseudo bus change happens.


There might be some mis-understanding here...

No matter how we reorganize our code (using platform_device bus type or 
defining our own bus type), it's a driver that drives a PCIE device 
after all. So, this mgmt/root.c must be a PCIE driver, which may 
interact with a whole bunch of IP drivers through a pseudo bus we are 
about to create.

What this code is doing here is completely of PCIE business (PCIE config 
space access). So, I think it is appropriate code in a PCIE driver.

The PCIE device we are driving is a multi-function device. The mgmt pf 
is of function 0, which, according to PCIE spec, can manage other 
functions on the same device. So, I think it's appropriate for mgmt pf 
driver (this root driver) to find it's peer function (through PCIE bus 
type) on the same device and do something about it in certain special cases.

Please let me know why you expect this code to be refactored and how you 
want it to be refactored. I might have missed something here...


>> +}
>> +
>> +static int xmgmt_match_slot_and_restore(struct device *dev, void *data)
>> +{
>> +     struct xmgmt *xm = data;
>> +     struct pci_dev *pdev = to_pci_dev(dev);
>> +
>> +     if (XMGMT_DEV_ID(pdev) == XMGMT_DEV_ID(xm->pdev)) {
>> +             pci_restore_state(pdev);
>> +             pci_cfg_access_unlock(pdev);
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static void xmgmt_pci_restore_config_all(struct xmgmt *xm)
>> +{
>> +     bus_for_each_dev(&pci_bus_type, NULL, xm, xmgmt_match_slot_and_restore);
>> +}
>> +
>> +static void xmgmt_root_hot_reset(struct pci_dev *pdev)
>> +{
>> +     struct xmgmt *xm = pci_get_drvdata(pdev);
>> +     struct pci_bus *bus;
>> +     u8 pci_bctl;
>> +     u16 pci_cmd, devctl;
>> +     int i, ret;
>> +
>> +     xmgmt_info(xm, "hot reset start");
>> +
>> +     xmgmt_pci_save_config_all(xm);
>> +
>> +     pci_disable_device(pdev);
>> +
>> +     bus = pdev->bus;
> whitespace, all these nl's are not needed


Will remove them.


>> +
>> +     /*
>> +      * When flipping the SBR bit, device can fall off the bus. This is
>> +      * usually no problem at all so long as drivers are working properly
>> +      * after SBR. However, some systems complain bitterly when the device
>> +      * falls off the bus.
>> +      * The quick solution is to temporarily disable the SERR reporting of
>> +      * switch port during SBR.
>> +      */
>> +
>> +     pci_read_config_word(bus->self, PCI_COMMAND, &pci_cmd);
>> +     pci_write_config_word(bus->self, PCI_COMMAND, (pci_cmd & ~PCI_COMMAND_SERR));
>> +     pcie_capability_read_word(bus->self, PCI_EXP_DEVCTL, &devctl);
>> +     pcie_capability_write_word(bus->self, PCI_EXP_DEVCTL, (devctl & ~PCI_EXP_DEVCTL_FERE));
>> +     pci_read_config_byte(bus->self, PCI_BRIDGE_CONTROL, &pci_bctl);
>> +     pci_write_config_byte(bus->self, PCI_BRIDGE_CONTROL, pci_bctl | PCI_BRIDGE_CTL_BUS_RESET);
> ok
>> +     msleep(100);
>> +     pci_write_config_byte(bus->self, PCI_BRIDGE_CONTROL, pci_bctl);
>> +     ssleep(1);
>> +
>> +     pcie_capability_write_word(bus->self, PCI_EXP_DEVCTL, devctl);
>> +     pci_write_config_word(bus->self, PCI_COMMAND, pci_cmd);
>> +
>> +     ret = pci_enable_device(pdev);
>> +     if (ret)
>> +             xmgmt_err(xm, "failed to enable device, ret %d", ret);
>> +
>> +     for (i = 0; i < 300; i++) {
>> +             pci_read_config_word(pdev, PCI_COMMAND, &pci_cmd);
>> +             if (pci_cmd != 0xffff)
>> +                     break;
>> +             msleep(20);
>> +     }
>> +     if (i == 300)
>> +             xmgmt_err(xm, "time'd out waiting for device to be online after reset");
> time'd -> timed


Will do.


Thanks,

Max

> Tom
>
>> +
>> +     xmgmt_info(xm, "waiting for %d ms", i * 20);
>> +     xmgmt_pci_restore_config_all(xm);
>> +     xmgmt_config_pci(xm);
>> +}
>> +
>> +static int xmgmt_create_root_metadata(struct xmgmt *xm, char **root_dtb)
>> +{
>> +     char *dtb = NULL;
>> +     int ret;
>> +
>> +     ret = xrt_md_create(XMGMT_DEV(xm), &dtb);
>> +     if (ret) {
>> +             xmgmt_err(xm, "create metadata failed, ret %d", ret);
>> +             goto failed;
>> +     }
>> +
>> +     ret = xroot_add_vsec_node(xm->root, dtb);
>> +     if (ret == -ENOENT) {
>> +             /*
>> +              * We may be dealing with a MFG board.
>> +              * Try vsec-golden which will bring up all hard-coded leaves
>> +              * at hard-coded offsets.
>> +              */
>> +             ret = xroot_add_simple_node(xm->root, dtb, XRT_MD_NODE_VSEC_GOLDEN);
>> +     } else if (ret == 0) {
>> +             ret = xroot_add_simple_node(xm->root, dtb, XRT_MD_NODE_MGMT_MAIN);
>> +     }
>> +     if (ret)
>> +             goto failed;
>> +
>> +     *root_dtb = dtb;
>> +     return 0;
>> +
>> +failed:
>> +     vfree(dtb);
>> +     return ret;
>> +}
>> +
>> +static ssize_t ready_show(struct device *dev,
>> +                       struct device_attribute *da,
>> +                       char *buf)
>> +{
>> +     struct pci_dev *pdev = to_pci_dev(dev);
>> +     struct xmgmt *xm = pci_get_drvdata(pdev);
>> +
>> +     return sprintf(buf, "%d\n", xm->ready);
>> +}
>> +static DEVICE_ATTR_RO(ready);
>> +
>> +static struct attribute *xmgmt_root_attrs[] = {
>> +     &dev_attr_ready.attr,
>> +     NULL
>> +};
>> +
>> +static struct attribute_group xmgmt_root_attr_group = {
>> +     .attrs = xmgmt_root_attrs,
>> +};
>> +
>> +static struct xroot_physical_function_callback xmgmt_xroot_pf_cb = {
>> +     .xpc_hot_reset = xmgmt_root_hot_reset,
>> +};
>> +
>> +static int xmgmt_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>> +{
>> +     int ret;
>> +     struct device *dev = &pdev->dev;
>> +     struct xmgmt *xm = devm_kzalloc(dev, sizeof(*xm), GFP_KERNEL);
>> +     char *dtb = NULL;
>> +
>> +     if (!xm)
>> +             return -ENOMEM;
>> +     xm->pdev = pdev;
>> +     pci_set_drvdata(pdev, xm);
>> +
>> +     ret = xmgmt_config_pci(xm);
>> +     if (ret)
>> +             goto failed;
>> +
>> +     ret = xroot_probe(pdev, &xmgmt_xroot_pf_cb, &xm->root);
>> +     if (ret)
>> +             goto failed;
>> +
>> +     ret = xmgmt_create_root_metadata(xm, &dtb);
>> +     if (ret)
>> +             goto failed_metadata;
>> +
>> +     ret = xroot_create_group(xm->root, dtb);
>> +     vfree(dtb);
>> +     if (ret)
>> +             xmgmt_err(xm, "failed to create root group: %d", ret);
>> +
>> +     if (!xroot_wait_for_bringup(xm->root))
>> +             xmgmt_err(xm, "failed to bringup all groups");
>> +     else
>> +             xm->ready = true;
>> +
>> +     ret = sysfs_create_group(&pdev->dev.kobj, &xmgmt_root_attr_group);
>> +     if (ret) {
>> +             /* Warning instead of failing the probe. */
>> +             xmgmt_warn(xm, "create xmgmt root attrs failed: %d", ret);
>> +     }
>> +
>> +     xroot_broadcast(xm->root, XRT_EVENT_POST_CREATION);
>> +     xmgmt_info(xm, "%s started successfully", XMGMT_MODULE_NAME);
>> +     return 0;
>> +
>> +failed_metadata:
>> +     xroot_remove(xm->root);
>> +failed:
>> +     pci_set_drvdata(pdev, NULL);
>> +     return ret;
>> +}
>> +
>> +static void xmgmt_remove(struct pci_dev *pdev)
>> +{
>> +     struct xmgmt *xm = pci_get_drvdata(pdev);
>> +
>> +     xroot_broadcast(xm->root, XRT_EVENT_PRE_REMOVAL);
>> +     sysfs_remove_group(&pdev->dev.kobj, &xmgmt_root_attr_group);
>> +     xroot_remove(xm->root);
>> +     pci_disable_pcie_error_reporting(xm->pdev);
>> +     xmgmt_info(xm, "%s cleaned up successfully", XMGMT_MODULE_NAME);
>> +}
>> +
>> +static struct pci_driver xmgmt_driver = {
>> +     .name = XMGMT_MODULE_NAME,
>> +     .id_table = xmgmt_pci_ids,
>> +     .probe = xmgmt_probe,
>> +     .remove = xmgmt_remove,
>> +};
>> +
>> +static int __init xmgmt_init(void)
>> +{
>> +     int res = 0;
>> +
>> +     res = xmgmt_register_leaf();
>> +     if (res)
>> +             return res;
>> +
>> +     xmgmt_class = class_create(THIS_MODULE, XMGMT_MODULE_NAME);
>> +     if (IS_ERR(xmgmt_class))
>> +             return PTR_ERR(xmgmt_class);
>> +
>> +     res = pci_register_driver(&xmgmt_driver);
>> +     if (res) {
>> +             class_destroy(xmgmt_class);
>> +             return res;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static __exit void xmgmt_exit(void)
>> +{
>> +     pci_unregister_driver(&xmgmt_driver);
>> +     class_destroy(xmgmt_class);
>> +     xmgmt_unregister_leaf();
>> +}
>> +
>> +module_init(xmgmt_init);
>> +module_exit(xmgmt_exit);
>> +
>> +MODULE_DEVICE_TABLE(pci, xmgmt_pci_ids);
>> +MODULE_VERSION(XMGMT_DRIVER_VERSION);
>> +MODULE_AUTHOR("XRT Team<runtime@xilinx.com>");
>> +MODULE_DESCRIPTION("Xilinx Alveo management function driver");
>> +MODULE_LICENSE("GPL v2");
